<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="config.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <!--Nav 引入資訊-->
    <link rel="stylesheet" href="assets/Css/nav.css">
    <link rel="stylesheet" href="assets/Css/footer.css">
    <link rel="stylesheet" href="assets/Css/search.css">
    <!-- Boxicon css -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <script src="assets/Js/sidebar.js"></script>
    <!--Login 引入資訊-->
    <link rel="stylesheet" href="assets/Css/user.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<style>
        .text-container {
            min-height: 20px; 
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
                        <input type="text" placeholder="Type to search..">
                        <div class="search-button">
                            <i class='bx bx-search' ></i>
                        </div>
                        <div class="cancel-button">
                            <i class='bx bx-x'></i>
                        </div>
                    </div>
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

        <!--Login-->
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
                            <header>Log In</header>
                            <form action="logincheck.jsp" method="POST">  <!--後端傳值在這裡-->
                                <div class="input-field">
                                    <input type="text" class="input" id="email" required="" autocomplete="off" name="email">
                                    <label for="email">Email</label> 
									<div class="text-container">
										  <%
										
											String loginmsg = request.getParameter("error");
											//先檢查signupmsg是否為空值
											if(loginmsg!=null && !loginmsg.equals("")){
												if(loginmsg.equals("failed")){
												out.print("帳號密碼錯誤 請重新輸入!!!");
												}
											}
											
									
										%>
									</div>
                                </div> 
                                <div class="input-field">
                                    <input type="password" class="input" id="pass" required="" name="pwd">
                                    <label for="pass">Password</label>
									<div class="text-container"></div>
                                </div> 
                                <div class="remember-me">
                                    <!--<input type="checkbox" id="remember" name="">  
                                    <label for="remember">Remember me</label>-->   <!--remember功能可有可無-->
                                </div> 
                                <div class="input-field">
                                    <input type="submit" class="submit" value="Log In">
                                </div> 
                                <div class="signin">
                                    <span>Don't have an account ？<a href="signup.jsp"> Sign up</a></span>
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
</body>
</html>
