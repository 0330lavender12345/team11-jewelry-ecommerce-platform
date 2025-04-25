<%@ page import="java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="java.net.URLEncoder" %>

<!DOCTYPE html>
<html>
<% 
    Class.forName("com.mysql.cj.jdbc.Driver");
    String url = "jdbc:mysql://localhost/team11_silverwrb?serverTimezone=UTC";
    Connection con = DriverManager.getConnection(url, "root", "1234");

    String productId = request.getParameter("ProductID");
    PreparedStatement pst = con.prepareStatement("SELECT * FROM team11_silverwrb.products WHERE ProductID = ? AND isAvailable = TRUE");
    pst.setString(1, productId);
    ResultSet rs = pst.executeQuery();
    String productID = "";
    String productName = "";
    String productPrice = "";
    String productImage = "";
    String productPreorderInfo = "";
    String productInventory = "";
    
    
        
    if (rs.next()) {
        productID = rs.getString(1);
        productName = rs.getString(2);
        productPrice = rs.getString(3);
        productImage = rs.getString(6);
        productPreorderInfo = rs.getString(5);
        productInventory = rs.getString(7);
    }
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= productName %></title>
    <link rel="stylesheet" href="assets/Css/product1.css">
    <link rel="stylesheet" href="assets/Css/nav.css">
    <link rel="stylesheet" href="assets/Css/body.css">
    <link rel="stylesheet" href="assets/Css/text.css">
    <link rel="stylesheet" href="assets/Css/footer.css">
    <link rel="stylesheet" href="assets/Css/slider.css">
    <link rel="stylesheet" href="assets/Css/background.css">
    <link rel="stylesheet" href="assets/Css/search.css">
    
    <!-- Boxicon css -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <script src=" assets/Js/sidebar.js"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <script src="jquery.star-rating-svg.js"></script>
    <script src="jquery.star-rating-svg.min.js"></script>
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
		.submit-button {
    padding: 10px 20px;
    font-size: 16px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    background-color: #333;
    color: #fff;
    transition: background-color 0.3s ease;
}

.submit-button:hover {
    background-color: #555;
}

    </style>
</head>
<body>
    <div class="bodyy">
    <nav>
        <div class="navtop">
            <div class="logo">
                <i class='bx bx-menu-alt-left menu-icon'></i>              <!-- <div class="logo-name">MENU</div> -->
            </div>
            <div class="storename">
                <div class="business-mark"><i class='bx bxl-sketch' ></i></div>
                <span class="logo-name1">SwDW</span>
            </div>
            <div class="search-box">
                <form id="search-form" action="searchProducts.jsp" method="get">
                    <input type="text" id="productName" name="productName" placeholder="請輸入搜尋內容..">
                    <div id="suggestion"></div>
                    <div id="productInfo"></div>
                    <div class="search-button" onclick="submitSearchForm()">
                        <i class='bx bx-search'></i>
                    </div>
                    <div class="cancel-button">
                        <i class='bx bx-x'></i>
                    </div>
                </form>
                <script src="assets/Js/searchbox.js"></script>
            </div>
        </div>
        <div class="sidebar">
            <div class="logo">
                <i class='bx bx-menu-alt-left menu-icon'></i>
                <span class="logo-name">MENU</span>
                <!-- <div class="logo-name">MENU</div> -->
            </div>
            <div class="sidebar-content">
                <div class="lists">
                    <ul>
                        <li class="list">
                            <a href="index.jsp" class="nav-link">
                                <i class="bx bx-home-alt icon" ></i>
                                <span class="link">Home</span>
                            </a>
                        </li>
                        <li class="list">
							<!--判斷是否登入-->
							<%
							if (session.getAttribute("email") != null){
								String Usersql = "SELECT MembersName FROM `members` WHERE MembersEmail='" + session.getAttribute("email") + "';";
								ResultSet rs1 = con.createStatement().executeQuery(Usersql);
								String user_name ="";
								while (rs1.next()) {
								user_name = rs1.getString("MembersName");
		
        
								}
								con.close();
								%>
								<a href="member_info.jsp" class="nav-link">
                                    <i class='bx bx-user icon'></i>
                                    <span class="link"><%=user_name%></span>
                                </a>
							
							<%
							}
							else{
								%>
								<a href="login.jsp" class="nav-link">
                                    <i class='bx bx-user icon'></i>
                                    <span class="link">User</span>
                                </a>
							<%	
							}
							%>   
                            </li>
                        <li class="list">
                            <a href="#" class="nav-link categories-button">
                                <i class='bx bx-category icon'></i>
                                <span class="link">Catagories</span>
                                <span class='bx bx-chevron-down sub-icon'></span>
                            </a>
                            <ul class="show">
                                <a href="product.jsp" class="sub-nav-link">
                                    <li class="list">
                                        <span class="sub-list">All</span>
                                    </li>
                                </a>
                                <a href="product.jsp?type=bracelet" class="sub-nav-link">
                                    <li class="list">
                                        <span class="sub-list">Bracelet</span>
                                    </li>
                                </a>
                                <a href="product.jsp?type=necklace" class="sub-nav-link">
                                    <li class="list">
                                        <span class="sub-list">Necklace</span>
                                    </li>
                                </a>
                                <a href="product.jsp?type=ring" class="sub-nav-link">
                                    <li class="list">
                                        <span class="sub-list">Ring</span>
                                    </li>
                                </a>
                                <a href="product.jsp?type=earring" class="sub-nav-link">
                                    <li class="list">
                                        <span class="sub-list">Earring</span>
                                    </li>
                                </a>
                            </ul>
                        </li>
                        <!--判斷是否登入，有登入才可進入購物車-->
                        <%
                        boolean isLoggedIn = session.getAttribute("email") != null;
                        String cartLink = isLoggedIn ? "cart.jsp" : "#";
                        %>
                        <li class="list">
                            <a href="<%= cartLink %>" class="nav-link">
                                <i class='bx bx-cart icon' ></i>
                                <span class="link">Cart</span>
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="bottom-content">
                    <li class="list">
                        <a href="about_us.jsp" class="nav-link">
                            <i class='bx bx-happy icon'></i>
                            <span class="link">About Us</span>
                        </a>
                    </li>
                    <li class="list">
                        <a href="logout.jsp" class="nav-link">
                            <i class='bx bx-log-out icon' ></i>
                            <span class="link">Log Out</span>
                        </a>
                    </li>
                    <li class="list">
                        <a href="back_login.jsp" class="nav-link">
                            <i class='bx bx-happy icon'></i>
                            <span class="link">Back</span>
                        </a>
                    </li>
                </div>
            </div>
        </div>
    </nav>
    <section class="overlay"></section>

<div class="main-content">
    <div class="product-container">
        <div class="product-image">
            <img src="<%= productImage %>" alt="<%= productName %>">
        </div>
        <div class="product-details">
            <h1><%= productName %> </h1>
            <div class="introduction">
                <span class="information" style="color: #666;"><%=  productPreorderInfo %></span>
            </div>
            <div class="price-section">
                <span class="original-price">NT$<%= productPrice %></span>
            </div>
            <div class="rating">
            <% 
                // 計算平均評分
                double averageRating = 0;
                int totalReviews = 0;

                Statement stmt = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/team11_silverwrb", "root", "1234");
                    stmt = con.createStatement();

                    String ratingQuery = "SELECT AVG(star) AS avgRating FROM guestbook WHERE ProductID = ?";
                    PreparedStatement pstRating = con.prepareStatement(ratingQuery);
                    pstRating.setString(1, productId);
                    ResultSet rsRating = pstRating.executeQuery();
                    if (rsRating.next()) {
                        averageRating = rsRating.getDouble("avgRating");
                    }

                    String reviewCountQuery = "SELECT COUNT(*) AS reviewCount FROM guestbook WHERE ProductID = ?";
                    PreparedStatement pstReviewCount = con.prepareStatement(reviewCountQuery);
                    pstReviewCount.setString(1, productId);
                    ResultSet rsReviewCount = pstReviewCount.executeQuery();
                    if (rsReviewCount.next()) {
                    totalReviews = rsReviewCount.getInt("reviewCount");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
                // 平均評分取到小數點後一位
                out.print(String.format("%.1f", averageRating));%> 分 | <%= totalReviews %> 個評價
		        <span class="stars"><%= "★".repeat((int)averageRating) %></span>

            </div>
            <div class="preorder-info">
                <p>庫存:<%= productInventory %>&nbsp&nbsp&nbsp預購商品預計20-40天出貨，預計出貨日：2024/7月</p>
            </div>
            <div class="quantity-selector">
                <label for="quantity">數量</label>
                <input type="number" id="quantity" value="1" min="1" onchange="updateQuantity()">
            </div>

            <div class="purchase-buttons">
                <!-- Add to Cart Form -->
                <form action="addcart.jsp" method="POST" class="purchase-form" id="add-to-cart-form">
					<input type="hidden" name="productName" id="productName" value="<%= productName %>">
                    <input type="hidden" name="productID" value="<%= productID %>">
					<input type="hidden" name="productPrice" id="productPrice">
					<input type="hidden" name="productImg" id="productImg">
                    <input type="hidden" name="quantity" id="cart-quantity" value="1" onchange="updateQuantity()">
                    <input type="submit" class="add-to-cart" onclick="addToCart('<%= productName %>', '<%= productPrice %>', '<%= productImage %>', '<%= productID %>')" value="加入購物車">
                </form>

                <!-- Buy Now Form -->
                <form action="addcart.jsp" method="POST" class="purchase-form" id="buy-now-form">
                    <input type="hidden" name="productName" id="bnproductName" value="<%= productName %>">
                    <input type="hidden" name="productPrice" id="bnproductPrice" value="<%= productPrice %>">
                    <input type="hidden" name="productImg" id="bnproductImg" value="<%= productImage %>">
                    <input type="hidden" name="quantity" id="buy-quantity" value="1" onchange="updateQuantity()">
                    <input type="hidden" name="buyNow" value="true">
                    <input type="submit" class="buy-now" onclick="buyNow('<%= productName %>', '<%= productPrice %>', '<%= productImage %>')" value="立刻購買">
                </form>

                <!-- Show Reviews Button -->
                <input type="button" class="show-reviews" value="查看評論">
            </div>
        </div>
    </div>
</div>

<div class="main-reviews">
    <div class="reviews-section" id="reviews-section" style="display: none;">
        <h2>顧客評價</h2>
        <div class="individual-reviews" id="individual-reviews">
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/team11_silverwrb", "root", "1234");
                    stmt = con.createStatement();
                    PreparedStatement pstReviews = con.prepareStatement("SELECT * FROM team11_silverwrb.guestbook WHERE ProductID = ?");
                    pstReviews.setString(1, productId);
                    ResultSet rsReviews = pstReviews.executeQuery();

                    int count = 0; 
            
                    while (rsReviews.next()) {
                        count++;
                        String content = rsReviews.getString("Content");
                        String date = rsReviews.getString("Putdate");
                        int star = rsReviews.getInt("star");
                        %>
                        <div class="review">
                            <span>User</span>
                            <span><%= date %></span>
                            <span class="stars"><%= "★".repeat(star) %></span>
                            <p><%= content %></p>
                        </div>
                        <%
                    }
                    
                    if (count == 0) {
                        out.println("<p style='position: relative; top: 10px;'>尚無留言</p>");
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
            <form id="review-form" method="post" action="addcontent.jsp">
                <input type="hidden" name="ProductID" value="<%= productId %>">
                <input type="hidden" id="test" name="star">
                <div class="my-rating-6"></div>
                <label for="comment">評論:</label>
                <textarea id="comment" name="content" rows="4" required></textarea>
               <input type="submit" name="Submit" class="submit-button" value="提交">
            </form>
           
        </div>
    </div>
</div>

    <footer>
        <div class="footer-container">
            <div class="wrapper">
                <div class="footer-button">
                    <div class="social-icon">
                        <i class='bx bxl-facebook'></i>
                    </div>
                    <span>Facebook</span>
                </div>
                <div class="footer-button">
                    <div class="social-icon">
                        <i class='bx bxl-twitter' ></i>
                    </div>
                    <span>Twitter</span>
                </div>
                <div class="footer-button">
                    <div class="social-icon">
                        <i class='bx bxl-instagram' ></i>
                    </div>
                    <span>Instagram</span>
                </div>
                <div class="footer-button">
                    <div class="social-icon">
                        <i class='bx bxl-github' ></i>
                    </div>
                    <span>Github</span>
                </div>
                <div class="footer-button">
                    <div class="social-icon">
                        <i class='bx bxl-youtube' ></i>
                    </div>
                    <span>Youtube</span>
                </div>
            </div>
        </div>
        <div class="footerbottom">
            <p>Copyright &copy;2024</p>
        </div>
    </footer>
    <script src="assets/Js/product1.js"></script>
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
                    minRating: 0.5,
                    callback: function (currentRating, $el) {
                        console.log('DOM element ', $el);
                        $('#test').val(currentRating.toFixed(1));
                        array = currentRating;
                    }
                });

                $('.my-rating-6 .star-rating-svg svg').css({
                    width: '1em',
                    height: '1em',
                    transform: 'scale(1)',
                });

                $(document).ready(function() {
    
    loadComments();

    function loadComments() {
        $.ajax({
            type: 'GET',
            url: 'loadComments.jsp',
            success: function(response) {
                $('#individual-reviews').html(response);
            },
        });
    }
});
		$('#review-form').on('submit', function(event) {
			event.preventDefault();
			$.ajax({
				type: 'POST',
				url: 'addcontent.jsp',
				data: $(this).serialize(),
				success: function(response) {
					//重整網頁1秒
					setTimeout(function() {
						location.reload();
					}, 1000);
				},
				error: function() {
					alert('失敗');
				}
			});
		});
            </script>
    <script>
        function addToCart(productName, productPrice, productImg, quantity) {
    
            document.getElementById("productName").value = productName;
            document.getElementById("productPrice").value = productPrice;
            document.getElementById("productID").value = productID;
            document.getElementById("productImg").value = productImg;
            document.getElementById("quantity").value = 1;
     
            document.getElementById("add-to-cart-form").submit();
        }
    </script>
    <script>
        function buyNow(productName, productPrice, productImage) {
            document.getElementById("bnproductName").value = productName;
            document.getElementById("bnproductPrice").value = productPrice;
            document.getElementById("bnproductImg").value = productImage;
            document.getElementById("buy-quantity").value = document.getElementById("quantity").value; 
            document.getElementById("add-to-cart-form").submit();
}
    </script>
    <script>
        let searchFormVisible = false;
    
        // 按下放大鏡圖示會切換搜尋框的顯示狀態
        document.querySelector(".search-button").addEventListener("click", function() {
            if (!searchFormVisible) {
                // 第一次點擊顯示搜尋框
                document.getElementById("search-form").style.display = "block";
                searchFormVisible = true;
            } else {
                // 第二次點擊提交表單
                document.getElementById("search-form").submit();
            }
        });
    
        // 按下 Enter 會提交表單
        document.getElementById("productName").addEventListener("keyup", function(event) {
            if (event.key === "Enter") {
                document.getElementById("search-form").submit();
            }
        });
    
        // 點擊取消按鈕或其他地方隱藏搜尋框
        document.querySelector(".cancel-button").addEventListener("click", function() {
            document.getElementById("search-form").style.display = "none";
            searchFormVisible = false;
        });
    </script>
    <script>
        function updateQuantity() {
            var quantity = document.getElementById("quantity").value;
            document.getElementById("cart-quantity").value = quantity;
            document.getElementById("buy-quantity").value = quantity;
        }
    </script>
</body>
</html>