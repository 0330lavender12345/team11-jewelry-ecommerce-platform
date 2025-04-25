<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <!--Nav 引入資訊-->
    <link rel="stylesheet" href="assets/Css/nav_index.css">
    <link rel="stylesheet" href="assets/Css/footer_index.css">
    <link rel="stylesheet" href="assets/Css/search-index.css">
    <!-- Boxicon css -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <script src="assets/Js/sidebar.js"></script>
    <!--Login 引入資訊-->
    <link rel="stylesheet" href="assets/Css/user.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<style>
        .text-container {
            min-height: 20px; /* 设置最小高度 */
            margin-bottom: 0;
            color: #FF0000;
            font-size: 12px;
			text-align: right;
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
                                <a href="login.jsp" class="nav-link">
                                    <i class='bx bx-user icon'></i>
                                    <span class="link">User</span>
                                </a>
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
                            <a href="#" class="nav-link">
                                <i class='bx bx-log-out icon' ></i>
                                <span class="link">Log Out</span>
                            </a>
                        </li>
                    </div>
                </div>
            </div>
        </nav>
        <section class="overlay"></section>

        <!--Signup-->
        <div class="wrapper">
            <div class="container main">
                <div class="row">
                    <div class="col-md-6 side-image">
                        <img src="image/logo.svg" alt="">
                        <div class="text">
                            <p><i>Trying To Be Better,<br>Building your dream.<br> - SwDW - </i></p>
                        </div>
                    </div>
                    <div class="col-md-6 right">
                        <div class="input-box">
                            <header>Create Account</header>
                            <form action="signupadd.jsp" method="POST">  <!--後端傳值在這裡-->
                                <div class="input-field">
                                    <input type="text" class="input" id="name" required="" autocomplete="off" name="username" value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
                                    <label for="name">Name</label> 
									<div class="text-container"></div>
                                </div> 
                                <div class="input-field">
                                    <input type="email" class="input" id="email" required="" autocomplete="off" name="email" value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>"><!--type改成email，做格式控制-->
                                    <label for="email">E-mail</label>
									<div class="text-container">
										  <%
											String signupmsg = request.getParameter("error");//先檢查signupmsg是否為空值
											if (signupmsg != null && !signupmsg.equals("")) {
												 if (signupmsg.equals("acduplicate")) {
													out.print("已被使用，請換一個!");
												} 
											}
										%>
									</div>
									
                                </div> 
                                <div class="input-field">
                                    <input type="text" class="input" id="phone" required="" autocomplete="off" name="phone" value="<%= request.getParameter("phone") != null ? request.getParameter("phone") : "" %>"><!-- 設為非必填所以不用 required=""-->
                                    <label for="phone">Phone</label> 
									<div class="text-container"></div>
                                </div> 
                                <div class="input-field">
                                    <input type="password" class="input" id="pass" required="" name="pwd" value="<%= request.getParameter("pwd") != null ? request.getParameter("pwd") : "" %>">
                                    <label for="pass">Password</label>
									<div class="text-container">
										  <%
											
											if (signupmsg != null && !signupmsg.equals("")) {
												if (signupmsg.equals("pwduplicate")) {
													out.print("密碼已被使用請換一個!");
												} 
											}
										%>
									</div>
                                </div> 
                                <div class="input-field">
                                    <input type="password" class="input" id="pass-confirm" required="" name="confirmpwd" >
                                    <label for="pass">Confirm Password</label>
									<div class="text-container">
										  <%
											
											if (signupmsg != null && !signupmsg.equals("")) {
												if (signupmsg.equals("pwdmismatch")) {
													out.print("密碼和確認密碼不匹配, 請重新輸入!");
												}
											}
										%>
									</div>
                                </div> 
                                <div class="input-field">
                                    <input type="submit" class="submit" value="Sign Up" > <!--onclick="window.location.href='login.html';" --><!--頁面跳轉到login.html 後端可以設計程式註冊後跳轉登入頁面  則onclick可刪除-->
                                </div> 
                                <div class="signin">
                                    <span>Already have an account？<a href="login.jsp"> Log in</a></span>
                                </div>
                            </form>
                        </div>  
                    </div>
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
    </div>
    <script src="assets/Js/placeholder.js"></script>
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