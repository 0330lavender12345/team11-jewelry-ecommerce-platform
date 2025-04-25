<%@ page import="java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="config.jsp" %>
<!DOCTYPE html>
<html>
    <% 
        String productType = request.getParameter("type"); 
        String prosql = "SELECT * FROM team11_silverwrb.products WHERE `isAvailable` = TRUE";
        if (productType != null && !productType.isEmpty()) {
            prosql += " AND ProductClassification = ?";
        }
        PreparedStatement pstmt = con.prepareStatement(prosql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        if (productType != null && !productType.isEmpty()) {
            pstmt.setString(1, productType); 
        }
        ResultSet rs = pstmt.executeQuery();

    %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%
        String title = "全部商品 | ALL";  
        if (productType != null && !productType.isEmpty()) {
            switch (productType) {
                case "bracelet":
                    title = "手鍊 | BRACELET";
                    break;
                case "necklace":
                    title = "項鍊 | NECKLACE";
                    break;
                case "ring":
                    title = "戒指 | RING";
                    break;
                case "earring":
                    title = "耳環 | EARRING";
                    break;
            }
        }
        out.print("<title>"+title+"</title>");
    %>
    <!--Nav 引入資訊-->
    <link rel="stylesheet" href="assets/Css/nav.css">
    <link rel="stylesheet" href="assets/Css/footer.css">
    <link rel="stylesheet" href="assets/Css/search.css">
    <!-- Boxicon css -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <script src="assets/Js/sidebar.js"></script>
    <!--商品列表引入資訊-->
    <link rel="stylesheet" href="assets/Css/productlist.css">
    <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
    <style>
      .card-button {
        background: url('assets/Images/shopping-cart.png') no-repeat center black;
        background-position: center -1px;
}
    </style>
</head>
<body>
    <div class="bgcol">
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

        <!--商品列表-->
        <div class="wrapper">
            <section class="shop" id="shop">
                <div class="container">

                    <div class="product-navigation">
                        <ul>
                            <li><a href="product.jsp">全部商品 | ALL</a></li>
                            <li><a href="product.jsp?type=bracelet">手鍊 | BRACELET</a></li>
                            <li><a href="product.jsp?type=necklace">項鍊 | NECKLACE</a></li>
                            <li><a href="product.jsp?type=ring">戒指 | RING</a></li>
                            <li><a href="product.jsp?type=earring">耳環 | EARRING</a></li>
                        </ul>
                    </div>

                    <div class="title-container">
                        <h2><%= title %></h2>
                    </div>
                    <div class="grid-container">
                    <%
                    while (rs.next()) {
                        String productID = rs.getString(1);
                        String productName = rs.getString(2);
                        String productPrice = rs.getString(3);
                        String productImg = rs.getString(6);
                    %>
							<div class='card'>
								<img src='<%= productImg %>' alt=''>
								<a href='prdintro.jsp?ProductID=<%= productID %>'><h4><%= productName %></h4></a>
								<h5>$<%= productPrice %></h5>
									 <form id="addToCartForm" method="post" action="addcart.jsp">
                                       <input type="hidden" name="productID" value="<%= productID %>">
									<input type="hidden" name="productName" id="productName" value="<%= productName %>">
									<input type="hidden" name="productPrice" id="productPrice">
									<input type="hidden" name="productImg" id="productImg">
                                    <input type="hidden" name="quantity" id="quantity" value="1">
                                    <input type="button" class="card-button" onclick="addToCart('<%= productName %>', '<%= productPrice %>', '<%= productImg %>','quantity')">
								</form>
							</div>
						<%
						}
						rs.close();
						pstmt.close();
						con.close();
						%>
                    </div>
            </section>
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
    <script src="assets/Js/tocart.js"></script>
    <script>
        function addToCart(productName, productPrice, productImg, quantity) {

            document.getElementById("productName").value = productName;
            document.getElementById("productPrice").value = productPrice;
            document.getElementById("productImg").value = productImg;
            document.getElementById("quantity").value = 1;

            document.getElementById("addToCartForm").submit();
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
</body>
</html>


