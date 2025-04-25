<%@ page import="java.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<html lang="zh-TW">
<head>
    <title>留言版</title>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
    <script src="jquery.star-rating-svg.js"></script>
    <script src="jquery.star-rating-svg.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/vue@2/dist/vue.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/vue@2"></script>
    <link rel="stylesheet" type="text/css" href="star-rating-svg.css">
    <style>
        .reviews-section {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
            max-width: 800px;
            width: 100%;
        }

        .detailed-ratings,
        .individual-reviews {
            margin-bottom: 10px;
        }

        .review {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 10px;
        }

        .review span {
            font-size: 14px;
            color: #666;
        }

        .review p {
            font-size: 14px;
            color: #333;
            margin: 0;
        }

        .review-form {
            margin-top: 20px;
        }

        .review-form h3 {
            margin-bottom: 10px;
        }

        .review-form label {
            display: block;
            margin-top: 10px;
            margin-bottom: 5px;
        }

        .review-form select,
        .review-form textarea {
            width: 100%;
            padding: 5px;
            font-size: 14px;
            box-sizing: border-box;
        }

        .review-form button {
            margin-top: 10px;
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            background-color: #333;
            color: #fff;
        }

        .review-form button:hover {
            opacity: 0.9;
        }

        .review-form a {
            text-decoration: none;
            color: inherit;
        }

        .my-rating-6 {
            margin-left: -600px;
            margin-bottom: 40px;
            display: flex;
            justify-content: space-between;
            transform: scale(0.1);
            gap: 280px;
        }
    </style>
</head>
<body>
    <div class="reviews-section" id="reviews-section">
        <h2>顧客評價</h2>
        <div class="individual-reviews" id="individual-reviews">
            <%
                Connection con = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/team11_silverwrb", "root", "1234");
                    stmt = con.createStatement();
                    String sql = "SELECT guestbook.Content, guestbook.Putdate, guestbook.star FROM guestbook";
                    rs = stmt.executeQuery(sql);
                    while (rs.next()) {
                        String content = rs.getString("Content");
                        String date = rs.getString("Putdate");
                        int star = rs.getInt("star");
                        String memberName = rs.getString("name");
                        %>
                        <div class="review">
                            <span>USER</span>
                            <span><%= date %></span>
                            <span class="stars"><%= "★".repeat(star) %></span>
                            <p><%= content %></p>
                        </div>
                        <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </div>
        <div class="review-form">
            <h3>撰寫評論</h3>
            <form id="review-form" method="post" action="add1.jsp">
                <input type="hidden" id="test" name="star">
                <div class="my-rating-6"></div>
                <label for="comment">評論:</label>
                <textarea id="comment" name="content" rows="4" required></textarea>
                <input type="submit" name="Submit">
            </form>
            <script>
                var array = '';

                $(".my-rating-6").starRating({
                    totalStars: 5,
                    emptyColor: 'lightgray',
                    hoverColor: 'orange',
                    activeColor: 'yellow',
                    initialRating: 4,
                    strokeWidth: 0,
                    useGradient: false,
                    minRating: 1,
                    callback: function (currentRating, $el) {
                        console.log('DOM element ', $el);
                        $('#test').attr("value", currentRating);
                        array = currentRating;
                    }
                });

                $('.my-rating-6 .star-rating-svg svg').css({
                    width: '1em',
                    height: '1em',
                    transform: 'scale(1)',
                });

                $('#review-form').on('submit', function(event) {
                    event.preventDefault();
                    $.ajax({
                        type: 'POST',
                        url: 'add1.jsp',
                        data: $(this).serialize(),
                        success: function(response) {
                            var memberName = 'USER'; // Replace with the logged-in user's name if available
                            var date = new Date().toISOString().split('T')[0]; // Current date
                            var content = $('#comment').val();
                            var star = $('#test').val();
                            var starsHtml = '★'.repeat(star);

                            var newReviewHtml = '<div class="review">' +
                                                '<span>' + memberName + '</span>' +
                                                '<span>' + date + '</span>' +
                                                '<span class="stars">' + starsHtml + '</span>' +
                                                '<p>' + content + '</p>' +
                                                '</div>';

                            $('#individual-reviews').prepend(newReviewHtml);
                            $('#comment').val(''); // Clear the comment field
                        },
                        error: function() {
                            alert('評論提交失敗');
                        }
                    });
                });
            </script>
        </div>
    </div>
</body>
</html>
