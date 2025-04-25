<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>
<%@include file="config.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>首頁</title>
    <link rel="stylesheet" href="assets/Css/nav_index.css">
    <link rel="stylesheet" href="assets/Css/body.css">
    <link rel="stylesheet" href="assets/Css/text.css">
    <link rel="stylesheet" href="assets/Css/footer_index.css">
    <link rel="stylesheet" href="assets/Css/slider.css">
    <link rel="stylesheet" href="assets/Css/background.css">
    <link rel="stylesheet" href="assets/Css/search-index.css">
    <!-- Boxicon css -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <script src="assets/Js/sidebar.js"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
    <div class="body-background">
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
                            <!--判斷是否登入，有登入才可進入購物車-->>
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
        <article>
            <div class="cool">
                <div class="slider">
                    <div class="list">
                        <div class="item">
                            <img src="assets/Images/girl5.jpg" alt="">
                        </div>
                        <div class="item">
                            <img src="assets/Images/man03.png" alt="">
                        </div>
                        <div class="item">
                            <img src="assets/Images/girl2.jpg" alt="">
                        </div>
                        <div class="item">
                            <img src="assets/Images/men01.png" alt="">
                        </div>
                        <div class="item">
                            <img src="assets/Images/girl4.jpg" alt="">
                        </div>
                    </div>
                    <div class="buttons">
                        <button id="prev"><</button>
                        <button id="next">></button>
                    </div>
                    <ul class="dots">
                        <li class="active"></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                    </ul>
                </div>
                
                <script src="assets/Js/slider.js"></script>
                <div class="part0">
                    <div class="part0-title">
                        <p>Weaving Silver<br/>Crafting Dreams</p>
                    </div>
                    <div class="part0-content">
                        <p>“At Silver Weave Dream Workshop, we transform dreams into silver art. Our passion and craftsmanship shine in every unique piece we create.”</p>
                    </div>
                </div>
            </div>
            <div class="part1">
                <div class="image">
                    <img src="assets/Images/store2.jpg" alt="">
                </div>
                <div class="introduction">     
                    <div class="part0-title">
                        <p>A Variety Of Silver Accessories</p>
                    </div>
                    <div class="part0-content">
                        <p>“Our diverse selection ensures that every customer can find that one-of-a-kind piece right here. Join us at Silver Weave Dream Workshop and let’s celebrate your distinctive style together.”</p>
                    </div>
                    <div class="shopping-button">
                        <a href="product.jsp">Go Shopping →</a>
                    </div>
                </div>
            </div>
            <div class="part1">
                <div class="image">
                    <img src="assets/Images/experience2.jpg" alt="">
                </div>
                <div class="introduction">
                    <div class="part0-title">
                        <p>Creativity at Your Fingertips</p>
                    </div>
                    <div class="part0-content">
                        <p>“We offer a platform where you can weave your innermost aspirations into reality through the art of metalwork. From basic metal processing to the creation of exquisite jewelry, our professional guidance will be with you every step of the way.“</p>
                    </div>
                </div>
            </div>
        </article>
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
                <!--訪客計數器-->
                <%
                    int counter = 1000;
                    String strNo ="";
                    
                    if(application.getAttribute("counter")==null){
                        application.setAttribute("counter", "1000");	 	  
                    }
                    else{
                        strNo=(String)application.getAttribute("counter");//讀application變數
                        counter = Integer.parseInt(strNo); //轉成整數
                        if (session.isNew()){
                        counter++;         //計數器+1
                        }	 
                        strNo = String.valueOf(counter);    //轉成字串
                        application.setAttribute("counter", strNo);//寫application變數
                    }    
                %>
                <p>Copyright &copy;2024</span></p>
                <p>您是第<%= counter %>位貴客！</p>
            </div>
        </footer>
    </div>
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