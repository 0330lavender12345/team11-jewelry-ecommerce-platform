<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import = "java.sql.*, java.util.*" %>
<%@include file="config.jsp" %>
<%
    // 從 session 中獲取購物車
    HttpSession sessionCart = request.getSession();
    List<String> cartItems = (List<String>) sessionCart.getAttribute("cart");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>購物車</title>
    <link rel="stylesheet" href="assets/Css/cart1.css">
    <link rel="stylesheet" href="assets/Css/nav.css">
    <link rel="stylesheet" href="assets/Css/body.css">
    <link rel="stylesheet" href="assets/Css/text.css">
    <link rel="stylesheet" href="assets/Css/footer.css">
    <link rel="stylesheet" href="assets/Css/slider.css">
    <link rel="stylesheet" href="assets/Css/background.css">
    <link rel="stylesheet" href="assets/Css/search.css">
    <!-- Boxicon css -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <script src="assets/Js/sidebar.js"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <style>
            .remove-btn {
        padding: 10px 20px;
        background: black;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        }
    </style>
</head>
<body>
    <nav>
        <div class="navtop">
            <div class="logo">
                <i class='bx bx-menu-alt-left menu-icon'></i>
            </div>
            <div class="storename">
                <div class="business-mark"><i class='bx bxl-sketch' ></i></div>
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
            </div>
            <div class="sidebar-content">
                <div class="lists">
                    <ul>
                        <li class="list">
                            <a href="index.jsp" class="nav-link">
                                <i class="bx bx-home-alt icon"></i>
                                <span class="link">Home</span>
                            </a>
                        </li>
                        <li class="list">
                            <a href="index.jsp" class="nav-link">
                                <i class="bx bx-home-alt icon"></i>
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

    <div class="main-content">
        <div class="container">
            <header>
                <h1>Shopping Cart</h1>
                <div class="shopping">
                    <img src="assets/Images/cart-regular-24.png" alt="購物車">
                    <% 
                    // 獲取購物車中的商品數量
                    int cartQuantity = (cartItems != null) ? cartItems.size() : 0;
                %>
                <span class="quantity"><%= cartQuantity %></span>
                </div>
            </header>
            <!-- 表單開始 -->
             <form action="checkpageformal.jsp" method="POST" accept-charset="UTF-8">
                <div class="product-info">
                    <table>
                        <thead>
                            <tr>
                                <td>商品資料</td>
                                <td>單件價格</td>
                                <td>數量</td>
                                <td>小計</td>
                                <td>刪除商品</td>
                            </tr>
                        </thead>
                        <tbody>
                            <%    
                                if (cartItems != null && !cartItems.isEmpty()) {
                                    for (String cartItemString : cartItems) {
                                        String[] parts = cartItemString.split(",");
                                        String productName = parts[0];
                                        String productPrice = parts[1];
                                        String productImg = parts[2];
                                        String quantity = parts[3];
                            %>
                            <tr>
                                <td>
                                    <img src="<%= productImg %>" alt="" width="50" height="50">
                                    <%= productName %>
                                </td>
                                <td>$<%= productPrice %></td>
                                <td>
                                    <input type="number" name="quantity_<%= URLEncoder.encode(productName, "UTF-8") %>" value="<%= quantity %>" min="1">
                                </td>
                                <td>$<%= productPrice %></td>
                                <td>
                                    <button type="button" class="remove-btn" data-product-name="<%= productName %>">刪除</button>
                                </td>
                            </tr>
                            <!--傳商品相關資訊到 checkpageformal.jsp，但是是隱藏起來-->
                            <input type="hidden" name="productName" value="<%= productName %>">
                            <input type="hidden" name="productPrice" value="<%= productPrice %>">
                            <input type="hidden" name="productImg" value="<%= productImg %>">
                            <% 
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="5">未選擇商品</td>
                            </tr>
                            <% 
                                }
                            %>
                        </tbody>
                    </table>
                </div>

                <div class="info-container">
                    <div class="information-section"> 
                        <h2>選擇送貨及付款方式</h2>
                        <div class="info-content">
                            <label for="payment-method">付款資訊:</label>
                            <select id="payment-method" name="payment">
                                <option value="貨到付款">貨到付款</option>
                                <option value="信用卡/金融卡">信用卡/金融卡</option>
                                <option value="ATM轉帳">ATM轉帳</option>
                            </select>
                            <label for="shipping-method">運送方式:</label>
                            <select id="shipping-method" name="shipping">
                                <option value="宅配到府">宅配到府</option>
                                <option value="來店自取">來店自取</option>
                            </select>
                        </div>
                    </div>
                   
                    <div class="order-info">
                        <h2>訂單資訊</h2>
                        <div class="order-details">    
                            <p>合計: <span id="total">NT$0</span></p>
                        </div>
                        <input type="submit" id="checkout-btn" value="結帳">
                    </div>
                </div>
            </form>
            <!-- 表單結束 -->
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
                        <i class='bx bxl-twitter'></i>
                    </div>
                    <span>Twitter</span>
                </div>
                <div class="footer-button">
                    <div class="social-icon">
                        <i class='bx bxl-instagram'></i>
                    </div>
                    <span>Instagram</span>
                </div>
                <div class="footer-button">
                    <div class="social-icon">
                        <i class='bx bxl-github'></i>
                    </div>
                    <span>Github</span>
                </div>
                <div class="footer-button">
                    <div class="social-icon">
                        <i class='bx bxl-youtube'></i>
                    </div>
                    <span>Youtube</span>
                </div>
            </div>
        </div>
        <div class="footerbottom">
            <p>Copyright &copy;2024</p>
        </div>
    </footer>
    <script src="assets/Js/cart1.js"></script>
<script>
	//計算並更新每個商品的小計。當數量的值改變時，會及時計算新的小計並顯示在上面。
    var quantityInputs = document.querySelectorAll("input[type='number']");
    quantityInputs.forEach(function(input) {
        input.addEventListener('input', function(event) {
            var newQuantity = parseInt(event.target.value);
            var productRow = event.target.parentElement.parentElement;
            var productPrice = parseFloat(productRow.querySelector('td:nth-child(2)').innerText.slice(1));
            var subtotalCell = productRow.querySelector('td:nth-child(4)');
            var subtotal = newQuantity * productPrice;
            subtotalCell.innerText = "$" + subtotal.toFixed(0);
            updateTotal();
        });
    });
	//把所有產品的小計加起來就是合計，並顯示合計價錢。
    function updateTotal() {
        var total = 0;
        var subtotalCells = document.querySelectorAll(".product-info tbody td:nth-child(4)");
        subtotalCells.forEach(function(cell) {
            total += parseFloat(cell.innerText.slice(1));
        });
        document.getElementById("total").innerText = "$" + total.toFixed(0);
    }
	
	
    document.addEventListener("DOMContentLoaded", function() {
        var quantity = document.querySelector(".quantity");
        var ItemCount = <%= cartItems != null ? cartItems.size() : 0 %>;
        quantity.textContent = ItemCount;
        var subtotalCells = document.querySelectorAll(".product-info tbody td:nth-child(4)");
        var total = 0;
        subtotalCells.forEach(function(cell) {
            total += parseFloat(cell.innerText.slice(1)); 
        });
        document.getElementById("total").innerText = "$" + total.toFixed(0);


		//點擊刪除按鈕時，會從購物車中刪除相應的產品。發送請求到 removeFromCart.jsp，並顯示總計和商品數量在上面
        document.querySelectorAll(".remove-btn").forEach(function(button) {
            button.addEventListener("click", function() {
                var productName = button.getAttribute("data-product-name");
                fetch("removeFromCart.jsp?product=" + encodeURIComponent(productName))
                    .then(function(response) {
                        return response.text();
                    })
                    .then(function(data) {
                        if (data.trim() === "success") {
                            button.closest("tr").remove();
                            updateTotal();
                            var newItemCount = parseInt(quantity.textContent) - 1;
                            quantity.textContent = newItemCount;
                        }
                    });
            });
        });
    });
</script>
</body>
</html>
