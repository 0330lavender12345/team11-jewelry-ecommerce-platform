<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException, java.sql.Statement" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map, java.util.HashMap, java.net.URLEncoder, java.sql.Connection, java.sql.DriverManager,  java.sql.SQLException, java.util.Date, java.text.SimpleDateFormat" %>

<%
    // 從session內獲取購物車內所有商品相關的資料
    List<String> cartItems = (List<String>) session.getAttribute("cart");

    Map<String, Map<String, String>> productsMap = new HashMap<>();
    if (cartItems != null && !cartItems.isEmpty()) {
        for (String cartItemString : cartItems) {
            String[] parts = cartItemString.split(",");
            String productName = parts[0];
            String productPrice = parts[1];
            String productImg = parts[2];
            String quantity = request.getParameter("quantity_" + URLEncoder.encode(productName, "UTF-8"));

            if (productsMap.containsKey(productName)) {
                Map<String, String> productDetails = productsMap.get(productName);
                int updatedQuantity = Integer.parseInt(productDetails.get("quantity")) + Integer.parseInt(quantity);
                productDetails.put("quantity", String.valueOf(updatedQuantity));
                int subtotal = updatedQuantity * Integer.parseInt(productPrice); // Calculate subtotal as integer
                productDetails.put("subtotal", String.valueOf(subtotal));
            } else {
                Map<String, String> productDetails = new HashMap<>();
                productDetails.put("price", productPrice);
                productDetails.put("quantity", quantity);
                int subtotal = Integer.parseInt(quantity) * Integer.parseInt(productPrice); // Calculate subtotal as integer
                productDetails.put("subtotal", String.valueOf(subtotal));
                productDetails.put("image", productImg);
                productsMap.put(productName, productDetails);
            }
        }
    }

    
    Connection conn = null;
    PreparedStatement ps = null;
    Statement stmt = null;
    ResultSet rs = null;
    int newOrderID = 1; 

    // Order variables declaration
    String orderDate = null;
    String payment = null;
    String shipping = null;
    int totalPrice = 0;
    
    String user_name ="";

    try {
		//建立資料庫連線
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost/team11_silverwrb?serverTimezone=UTC";
        conn = DriverManager.getConnection(url, "root", "1234");

        // 這裡我們是做在資料庫中抓最大的訂單編號
        String maxOrderIDQuery = "SELECT MAX(OrderID) AS maxOrdersID FROM orders ";
        ps = conn.prepareStatement(maxOrderIDQuery);
        rs = ps.executeQuery();

        if (rs.next()) {
			//把訂單資料表中最大的訂單編號+1後當成新的一筆訂單編號(這樣若購物車內有多個商品，他們也會有一樣的訂單編號，意思是被歸類在同一筆訂單)
            newOrderID = rs.getInt("maxOrdersID") + 1;
        }

        // 獲取訂單相關的資料
        payment = request.getParameter("payment");
        shipping = request.getParameter("shipping");
        totalPrice = productsMap != null ? productsMap.values().stream().mapToInt(p -> Integer.parseInt(p.get("subtotal"))).sum() : 0; 

        orderDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());

      
        int orderTotalPrice = 0; 
        if (productsMap != null && !productsMap.isEmpty()) {
            for (Map.Entry<String, Map<String, String>> entry : productsMap.entrySet()) {
                String productName = entry.getKey();
                Map<String, String> productDetails = entry.getValue();
                String productPrice = productDetails.get("price");
                String quantity = productDetails.get("quantity");
                String subtotal = productDetails.get("subtotal");

               //計算小計(每個商品的單價*下單數量)
                int productSubtotal = Integer.parseInt(subtotal);

                // 累計訂單總價(整個購物車中所有商品加起來的價格)
                orderTotalPrice += productSubtotal;

				//把資料寫入orders資料表
                String query = "INSERT INTO orders (OrderID, OrderDate, OrderPay, OrderShip, ProductName, ProductPrice, ProductAmount, OrderTPrice) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
                ps.setInt(1, newOrderID);
                ps.setString(2, orderDate);
                ps.setString(3, payment);
                ps.setString(4, shipping);
                ps.setString(5, productName);
                ps.setDouble(6, Double.parseDouble(productPrice));
                ps.setDouble(7, Double.parseDouble(quantity));
                ps.setDouble(8, productSubtotal); 
                ps.executeUpdate();


                String updateStockQuery = "UPDATE products SET ProductINV = ProductINV - ? WHERE ProductName = ?";
                PreparedStatement updatePs = conn.prepareStatement(updateStockQuery);
                updatePs.setInt(1, Integer.parseInt(quantity));
                updatePs.setString(2, productName);
                updatePs.executeUpdate();
                updatePs.close();
            }

            //插入訂單總價
            String totalOrderPriceQuery = "UPDATE orders SET OrderTPrice = ? WHERE OrderID = ?";
            ps = conn.prepareStatement(totalOrderPriceQuery);
            ps.setInt(1, orderTotalPrice);
            ps.setInt(2, newOrderID);
            ps.executeUpdate();
        }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    } finally {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (ps != null) {
            try {
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            stmt = conn.createStatement();
            if (session.getAttribute("email") != null){
                String Usersql = "SELECT MembersName FROM `members` WHERE MembersEmail='" + session.getAttribute("email") + "';";
                ResultSet rss = conn.createStatement().executeQuery(Usersql);
                while (rss.next()) {
                    user_name = rss.getString("MembersName");
                }
                conn.close();
            }
%>

<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>結帳頁面</title>
    <link rel="stylesheet" href="assets/Css/checkpage.css">
    <link rel="stylesheet" href="assets/Css/nav.css">
    <link rel="stylesheet" href="assets/Css/body.css">
    <link rel="stylesheet" href="assets/Css/article.css">
    <link rel="stylesheet" href="assets/Css/footer.css">
    <link rel="stylesheet" href="assets/Css/slider.css">
    <link rel="stylesheet" href="assets/Css/bg.css">
    <link rel="stylesheet" href="assets/Css/search.css">
    <!-- Boxicon css -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <script src="assets/Js/sidebar.js"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <style>
        thead td {
            font-weight: bold;
        }
        .order-info {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 10px;
            border-radius: 8px;
            margin-top: 20px;
            height: 180px;
            width: 40%;

            backdrop-filter: blur(3px);
            box-shadow: 0px 20px 50px rgba(0,0,0,0.05);
        
            border-radius: 10px 10px 10px 10px;
            border-right: solid 1px rgba(255,255,255,0.3) ;
            border-bottom: solid 1px rgba(255,255,255,0.3);
        }
        .order-info h2 {
            font-size: 1.5em;
            margin-bottom: 10px;
            margin-right: 20px;
            color: #343a40;
        }
        .order-details p {
            font-size: 1em;
            line-height: 1.5;
            margin-bottom: 5px;
            color: #495057;
        }
        .order-details p span {
            font-weight: bold;
            color: #212529;
        }
        .main-content {
            padding: 20px;
        }
    </style>
</head>
<body>
    <div class="page-container">
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
                </div>
                <div class="sidebar-content">
                    <div class="lists">
                        <ul>
                            <li class="list">
                                <a href="index.jsp" class="nav-link">
                                    <i class="bx bx-home-alt icon"></i>
                                    <span class="link">Home</span>
                                </a>
                                <li class="list">
                                    <!--判斷是否登入-->
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
                    </ul>
                </div>
            </div>
        </div>
        </nav>
        <section class="overlay"></section>

        <div class="main-content">
            <div class="main">
                <ul>
                    <li>
                        <i class='icon bx bx-fullscreen'></i>
                        <div class="active progress one">
                            <p>1</p>
                            <i class='ibx bx bx-check'></i>
                        </div>
                        <p class="text">加入購物車</p>
                    </li>
                </ul>

                <ul>
                    <li>
                        <i class='icon bx bx-clipboard'></i>
                        <div class="active progress two">
                            <p>2</p>
                            <i class='ibx bx bx-check'></i>
                        </div>
                        <p class="text">填寫資料</p>
                    </li>
                </ul>

                <ul>
                    <li>
                        <i class='icon bx bx-credit-card'></i>
                        <div class="active progress three">
                            <p>3</p>
                            <i class='ibx bx bx-check'></i>
                        </div>
                        <p class="text">進行付款</p>
                    </li>
                </ul>

                <ul>
                    <li>
                        <i class='icon bx bx-transfer-alt'></i>
                        <div class="active progress four">
                            <p>4</p>
                            <i class='ibx bx bx-check'></i>
                        </div>
                        <p class="text">訂單處理中</p>
                    </li>
                </ul>

                <ul>
                    <li>
                        <i class='icon bx bx-map'></i>
                        <div class="active progress five">
                            <p>5</p>
                            <i class='ibx bx bx-check'></i>
                        </div>
                        <p class="text">訂單已到達</p>
                    </li>
                </ul>
            </div>

            <div class="product-info">
                <table>
                    <thead>
                        <tr>
                            <th>商品資料</th>
                            <th>單件價格</th>
                            <th>數量</th>
                            <th>小計</th>
                        </tr>
                    </thead>
                    <tbody>
						<% if (productsMap != null && !productsMap.isEmpty()) {
							for (Map.Entry<String, Map<String, String>> entry : productsMap.entrySet()) {
								String productName = entry.getKey();
                                String productImg = entry.getKey();
								Map<String, String> productDetails = entry.getValue();
								String productPrice = productDetails.get("price");
								String quantity = productDetails.get("quantity");
								String productImgUrl = productDetails.get("image");
						%>
						<tr>
							<td><img src="<%= productImgUrl %>" class="product-image">
                                <div class="product-details">
                                    <p><%= productName %></p>
                                </div>
                            </td>
							<td>$<%= productPrice %></td>
							<td><%= quantity %></td>
							<td>$<%= Integer.parseInt(productDetails.get("subtotal")) %></td> <!-- Convert subtotal to integer -->
						</tr>
						<% }
						} else { %>
						<tr>
							<td colspan="4">未選擇商品</td>
						</tr>
						<% } %>
					</tbody>
                </table>
            </div>
            <div class="order-info">
                <h2>訂單資訊</h2>
                <div class="order-details">
                    <p><span>付款方式：</span> <%= request.getParameter("payment") %></p>
                    <p><span>運送方式：</span> <%= request.getParameter("shipping") %></p>
                    <p><span>合計:</span> NT$<%= productsMap != null ? productsMap.values().stream().mapToDouble(p -> Double.parseDouble(p.get("subtotal"))).sum() : 0 %></p>
                </div>
            </div>
            <div class="checkout-container">
                <input class="checkout-button" type="submit" value="完成結帳" onclick="submitOrder()">
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
    <script src="assets/Js/checkpage.js"></script>
	  <script>
        function submitOrder() {
            // 跳出視窗
            alert("感謝您的購買！");

            //回首頁 index.jsp
            window.location.href = "index.jsp";
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