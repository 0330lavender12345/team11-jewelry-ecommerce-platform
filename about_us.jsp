<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>
<%@include file="config.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="assets/Css/nav_index.css">
    <!-- <link rel="stylesheet" href="../assets/Css/body.css"> -->
    <!-- <link rel="stylesheet" href="../assets/Css/article.css"> -->
    <link rel="stylesheet" href="assets/Css/footer_index.css">
    <link rel="stylesheet" href="assets/Css/slider.css">
    <link rel="stylesheet" href="assets/Css/bg2.css">
    <link rel="stylesheet" href="assets/Css/search-index.css">
    <link rel="stylesheet" href="assets/Css/about_us.css">
    <!-- Boxicon css -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <script src="assets/Js/sidebar.js"></script>
</head>
<body>
    <div class="body-background2">
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

        <article style="height: 100%;">
            <section>
                <div class="card_container">

                    <div class="flip-card">
                        <div class="flip-card-inner">
                            <div class="flip-card-front">
                                <div class="ig_outer_border">
                                    <div class="ig_inner_border">
                                        <img src="assets/Images/leo.png" alt="個人照">
                                    </div>
                                </div>
                                <p class="title" style="margin-top: 10px;">鍾昌宇</p>
                            </div>
                            <div class="flip-card-back">
                                <p class="title">心得</p>
                                <hr>
                                <p class="reflection">
                                    對於這次前後端期末，我負責的是前端的部分，不知道是否因為上學期的緣故，這學期的整合從感覺上變得沒那麼緊湊，有更多的空間去創造，也非常感謝其他組員們，對於前端的組員謝謝他們能在必要時給予我一些小建議，然後對於後端的組員也謝謝他們積極的提供意見，總體來說這次的專題我學到了很多。
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="flip-card">
                        <div class="flip-card-inner">
                            <div class="flip-card-front">
                                <div class="ig_outer_border">
                                    <div class="ig_inner_border">
                                        <img src="assets/Images/rickroll.jpg" alt="個人照">
                                    </div>
                                </div>
                                <p class="title" style="margin-top: 10px;">張維峰</p>
                            </div>
                            <div class="flip-card-back">
                                <p class="title">心得</p>
                                <hr>
                                <p class="reflection">
                                    對於這次前後端期末，我負責的是前端的部分，不知道是否因為上學期的緣故，這學期的整合從感覺上變得沒那麼緊湊，有更多的空間去創造，也非常感謝其他組員們，對於前端的組員謝謝他們能在必要時給予我一些小建議，然後對於後端的組員也謝謝他們積極的提供意見，總體來說這次的專題我學到了很多。
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="flip-card">
                        <div class="flip-card-inner">
                            <div class="flip-card-front">
                                <div class="ig_outer_border">
                                    <div class="ig_inner_border">
                                        <img src="assets/Images/leo.png" alt="個人照">
                                    </div>
                                </div>
                                <p class="title" style="margin-top: 10px;">劉千睿</p>
                            </div>
                            <div class="flip-card-back">
                                <p class="title">心得</p>
                                <hr>
                                <p class="reflection">
                                    這次的專題我們負責的是前端的部分，從使用Figma設計網頁UI一直到使用HTML、CSS、JS實際產出網頁架構都由我們一手包辦，完成後十分有成就感，從專題中我也學到了專案的協作與前後端整合技巧，最重要的是團隊之間的溝通，感謝我的組員們都很願意溝通討論，並給予彼此幫助，也感謝後端組員們盡力的配合我們修改專案內容，讓這次的專題逐漸接近我們理想的狀態。
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="flip-card">
                        <div class="flip-card-inner">
                            <div class="flip-card-front">
                                <div class="ig_outer_border">
                                    <div class="ig_inner_border">
                                        <img src="assets/Images/back1.jpg" alt="個人照">
                                    </div>
                                </div>
                                <p class="title" style="margin-top: 10px;">蔡佳昀</p>
                            </div>
                            <div class="flip-card-back">
                                <p class="title">心得</p>
                                <hr>
                                <p class="reflection">
                                    上學期做前端，這學期換成後端，兩者的差別很大。我認為後端對我來說挑戰性特別特別特別高，因為需要很多的程式邏輯來讓網站可以運作，而且不像前端可以寫一寫就直接跑出成果，所以在寫的過程挫折感很大。從頭到尾看最多的不是網頁，是500。但透過這次專題，也讓我學到了後端是如何運作及與團隊協調溝通的重要性。感謝前端的組員及同組的後端組員共同完成這個專案
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="flip-card">
                        <div class="flip-card-inner">
                            <div class="flip-card-front">
                                <div class="ig_outer_border">
                                    <div class="ig_inner_border">
                                        <img src="assets/Images/back2.jpg" alt="個人照">
                                    </div>
                                </div>
                                <p class="title" style="margin-top: 10px;">林于喬</p>
                            </div>
                            <div class="flip-card-back">
                                <p class="title">心得</p>
                                <hr>
                                <p class="reflection">
                                    學習過了前端與後端後，相較於之前也更有概念知道要如何去運作，後端所需運用到的程式邏輯比起前端相對複雜許多，同時要考慮到資料庫的設計還有安全性的問題，還要考慮到每個檔案之間的關聯性來設計流程，過程中需要多次的去嘗試與除錯，針對一個功能寫法也不只一種，以目前所學還有很多進步與可以自行涉略的空間。在這次的專題合作上前後端在學過的基礎之下也更加順利
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="flip-card">
                        <div class="flip-card-inner">
                            <div class="flip-card-front">
                                <div class="ig_outer_border">
                                    <div class="ig_inner_border">
                                        <img src="assets/Images/back3.jpg" alt="個人照">
                                    </div>
                                </div>
                                <p class="title" style="margin-top: 10px;">謝宜蓁</p>
                            </div>
                            <div class="flip-card-back">
                                <p class="title">心得</p>
                                <hr>
                                <p class="reflection">
                                    我本人是還蠻喜歡伍佰的啦，大概這學期之後就不會喜歡了：）原本以為後端應該是不會比前端難太多，事實證明我錯了，而且錯得蠻離譜，每天半夜都一邊哀嚎一邊認命改。感謝後端組員不嫌棄我也感謝前端同學瘋狂配合我們調整版面｡ °(°´ᯅ`°)° ｡<br><br><br><br><br>
                                </p>
                            </div>
                        </div>
                    </div>

                </div>
            </section>
            <!-- <script>
                window.onload = function(){
                    document.querySelector('.flip-card').addEventListener('click', function() {
                        this.classList.toggle('flip');
                    });
                }
            </script> -->
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
                <p>Copyright &copy;2024</p>
            </div>
        </footer>
    </div>
</body>
<script src="assets/Js/about_us.js"></script>
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
</html>