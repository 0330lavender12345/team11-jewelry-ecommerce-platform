<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>
<%@include file="config.jsp" %>


<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>會員中心</title>
    <!--Nav 引入資訊-->
    <link rel="stylesheet" href="assets/Css/nav.css">
    <link rel="stylesheet" href="assets/Css/footer.css">
    <link rel="stylesheet" href="assets/Css/search.css">
    <!-- Boxicon css -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <script src="assets/Js/sidebar.js"></script>
    <!--member info 引入資訊-->
    <link rel="stylesheet" href="assets/Css/member.css">
    <link rel="stylesheet" href="assets/Css/member_comment.css">
</head>
<script src="https://code.iconify.design/iconify-icon/2.1.0/iconify-icon.min.js"></script>
<body>
    <div class="bgcol">
        <nav>
            <div class="navtop">
                <div class="logo">
                    <i class='bx bx-menu-alt-left menu-icon'></i>              <!-- <div class="logo-name">MENU</div> -->
                </div>
                <div class="storename">
                    <div class="business-mark"><i class='bx bxl-gitlab menu-icon'></i></div>
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
                            <!--判斷是否登入-->
							<%
							if (session.getAttribute("email") != null){
								String Usersql = "SELECT MembersName FROM `members` WHERE MembersEmail='" + session.getAttribute("email") + "';";
								ResultSet rs = con.createStatement().executeQuery(Usersql);
								String user_name ="";
								while (rs.next()) {
								user_name = rs.getString("MembersName");
		
        
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
                            <li class="list">
                                <a href="#" class="nav-link categories-button">
                                    <i class='bx bx-category icon'></i>
                                    <span class="link">Catagories</span>
                                    <span class='bx bx-chevron-down sub-icon'></span>
                                </a>
                                <ul class="show">
                                    <a href="product.jsp" class="sub-nav-link">
                                        <li class="list">
                                            <span class="sub-list">所有商品</span>
                                        </li>
                                    </a>
                                    <a href="product.jsp?type=bracelet" class="sub-nav-link">
                                        <li class="list">
                                            <span class="sub-list">手環</span>
                                        </li>
                                    </a>
                                    <a href="product.jsp?type=necklace" class="sub-nav-link">
                                        <li class="list">
                                            <span class="sub-list">項鍊</span>
                                        </li>
                                    </a>
                                    <a href="product.jsp?type=ring" class="sub-nav-link">
                                        <li class="list">
                                            <span class="sub-list">戒指</span>
                                        </li>
                                    </a>
                                    <a href="earring.jsp?type=earring" class="sub-nav-link">
                                        <li class="list">
                                            <span class="sub-list">耳環</span>
                                        </li>
                                    </a>
                                </ul>
                            </li>
                            <li class="list">
                                <a href="cart1.jsp" class="nav-link">
                                    <i class='bx bx-cart icon' ></i>
                                    <span class="link">Cart</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div class="bottom-content">
                        <li class="list">
                            <a href="#" class="nav-link">
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
                    </div>
                </div>
            </div>
        </nav>
        <section class="overlay"></section>

        <div class="member">
            <div class="title-container">
                <h2 class="member-title">會員中心</h2>
            </div>
            <div class="member-container">
                <section>
                    <div class="radio-inputs">
                        <label class="radio">
                        <input type="radio" name="radio">
                        <span class="name" data-link="member_info.jsp">個人資訊</span>
                        </label>
                        <label class="radio">
                        <input type="radio" name="radio">
                        <span class="name" data-link="member_order.jsp">購物紀錄</span>
                        </label>
                            
                        <label class="radio">
                        <input type="radio" name="radio" checked="">
                        <span class="name" data-link="member_comment.jsp">歷史評論</span>
                        </label>
                    </div>

                    <div class="logout-container">
                        <a href="<%="logout.jsp" %>" class="logout-style">
                            <i class='bx bx-log-out icon'></i>&nbsp
                            <span class="logout">Log Out</span>
                        </a>
                    </div>

                    <div class="profile">
                        <div class="profile-picture">
                            <img src="assets/Images/comment.png" alt="Profile Picture">
                            <p>歷史評論</p>
                        </div>

                        <!--歷史評論-->
                        <div class="comment">
                            <div class="reviews-section" id="reviews-section">
                                <div class="individual-reviews" id="individual-reviews">
                                    <div class="review">
                                        <img src="assets/Images/bracelet01.jpg" alt="">
                                        <h5>銀線光影手鍊</h3>
                                        <span>May 16, 2024</span>
                                        <span class="stars">★★★★★</span>
                                        <p>這是一個很棒的產品！</p>
                                    </div>
                                    <div class="review">
                                        <img src="assets/Images/earring01.jpg" alt="">
                                        <h5>優雅幾何耳環</h3>
                                        <span>May 16, 2024</span>
                                        <span class="stars">★★★★★</span>
                                        <p>非常滿意，品質很好！</p>
                                    </div>
                                    <div class="review">
                                        <img src="assets/Images/necklace01.jpg" alt="">
                                        <h5>情繫心弦項鍊</h3>
                                        <span>May 16, 2024</span>
                                        <span class="stars">★★★★★</span>
                                        <p>非常滿意，品質很好！</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
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
    </div>
    <script src="assets/Js/datalink.js"></script>
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
</body>
</html>