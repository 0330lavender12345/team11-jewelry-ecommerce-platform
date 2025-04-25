<%@ page import="java.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>新增商品</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        h1, h2 {
            text-align: center;
            margin-top: 20px;
        }
        form {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="submit"], input[type="button"] {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            border: none;
            border-radius: 4px;
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
    </style>
    <script>
        function checkInventory() {
            var checkboxes = document.getElementsByName('productIds');
            var allValid = true;

            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked) {
                    var productInv = checkboxes[i].getAttribute('data-inv');
                    var productName = checkboxes[i].getAttribute('data-name');
                    if (productInv == 0) {
                        var newInv = prompt("品項: " + productName + " 庫存不足，請修改庫存量：", "");
                        if (newInv == null || newInv.trim() == "" || isNaN(newInv)) {
                            allValid = false;
                            alert("請輸入有效庫存量。");
                            break;
                        } else {
                            var newInvInput = document.createElement("input");
                            newInvInput.type = "hidden";
                            newInvInput.name = "newInv_" + checkboxes[i].value;
                            newInvInput.value = newInv;
                            document.getElementById('existingProductsForm').appendChild(newInvInput);
                        }
                    }
                }
            }

            if (allValid) {
                document.getElementById('existingProductsForm').submit();
            }
        }
    </script>
</head>
<body>
    <h1>新增商品</h1>
    <%
        if (request.getMethod().equals("POST")) {
            String action = request.getParameter("action");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost/team11_silverwrb?serverTimezone=UTC";
                Connection con = DriverManager.getConnection(url, "root", "1234");

                if ("newProduct".equals(action)) {
                    String productName = request.getParameter("productName");
                    String productIntro = request.getParameter("productIntro");
                    String productClassification = request.getParameter("productClassification");
                    String productPrice = request.getParameter("productPrice");
                    String productIMG = request.getParameter("productIMG");
                    String productINV = request.getParameter("productINV");

                    String sql = "INSERT INTO `products` (`ProductName`, `ProductIntro`, `ProductClassification`, `ProductPrice`, `ProductIMG`, `ProductINV`, `isAvailable`) VALUES (?, ?, ?, ?, ?, ?, FALSE)";
                    PreparedStatement pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, productName);
                    pstmt.setString(2, productIntro);
                    pstmt.setString(3, productClassification);
                    pstmt.setString(4, productPrice);
                    pstmt.setString(5, productIMG);
                    pstmt.setString(6, productINV);
                    pstmt.executeUpdate();
                    pstmt.close();
                } else if ("existingProducts".equals(action)) {
                    String[] productIds = request.getParameterValues("productIds");
                    if (productIds != null) {
                        for (String productId : productIds) {
                            String additionalInventory = request.getParameter("newInv_" + productId);
                            if (additionalInventory != null && !additionalInventory.isEmpty()) {
                                String sql = "UPDATE `products` SET `ProductINV` = ? WHERE `ProductID` = ?";
                                PreparedStatement pstmt = con.prepareStatement(sql);
                                pstmt.setInt(1, Integer.parseInt(additionalInventory));
                                pstmt.setInt(2, Integer.parseInt(productId));
                                pstmt.executeUpdate();
                                pstmt.close();
                            }

                            String sql = "UPDATE `products` SET `isAvailable` = TRUE WHERE `ProductID` = ?";
                            PreparedStatement pstmt = con.prepareStatement(sql);
                            pstmt.setInt(1, Integer.parseInt(productId));
                            pstmt.executeUpdate();
                            pstmt.close();
                        }
                    }
                }

                con.close();
                response.sendRedirect("back_products.jsp");
            } catch (Exception e) {
                out.println("操作失敗：" + e.getMessage());
            }
        }
    %>

    <form action="" method="post">
        <input type="hidden" name="action" value="newProduct">
        <h2>手動新增商品</h2>
        商品名稱：<input type="text" name="productName" required><br>
        商品介紹：<textarea name="productIntro" required></textarea><br>
        商品類別：<input type="text" name="productClassification" required><br>
        商品金額：<input type="text" name="productPrice" required><br>
        商品圖片：<input type="text" name="productIMG" required><br>
        商品庫存：<input type="text" name="productINV" required><br>
        <input type="submit" value="新增商品">
    </form>

    <form id="existingProductsForm" action="" method="post">
        <input type="hidden" name="action" value="existingProducts">
        <h2>從現有商品中選擇並上架</h2>
        <table border="1">
            <tr>
                <th></th>
                <th>商品名稱</th>
                <th>商品介紹</th>
                <th>商品類別</th>
                <th>商品金額</th>
                <th>商品圖片</th>
                <th>商品庫存</th>
            </tr>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String url = "jdbc:mysql://localhost/team11_silverwrb?serverTimezone=UTC";
                    Connection con = DriverManager.getConnection(url, "root", "1234");
                    String sql = "SELECT `ProductID`, `ProductName`, `ProductIntro`, `ProductClassification`, `ProductPrice`, `ProductIMG`, `ProductINV` FROM `products` WHERE `isAvailable` = FALSE OR `ProductINV` = 0";
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery(sql);

                    while (rs.next()) {
                        int productId = rs.getInt("ProductID");
                        String productName = rs.getString("ProductName");
                        String productIntro = rs.getString("ProductIntro");
                        String productClassification = rs.getString("ProductClassification");
                        int productPrice = rs.getInt("ProductPrice");
                        String productIMG = rs.getString("ProductIMG");
                        int productINV = rs.getInt("ProductINV");
            %>
            <tr>
                <td>
                    <input type="checkbox" name="productIds" value="<%= productId %>" data-inv="<%= productINV %>" data-name="<%= productName %>">
                </td>
                <td><%= productName %></td>
                <td><%= productIntro %></td>
                <td><%= productClassification %></td>
                <td><%= productPrice %></td>
                <td><%= productIMG %></td>
                <td><%= productINV %></td>
            </tr>
            <%
                    }

                    rs.close();
                    stmt.close();
                    con.close();
                } catch (Exception e) {
                    out.println("無法獲取商品列表：" + e.getMessage());
                }
            %>
        </table>
        <input type="button" value="上架" onclick="checkInventory()">
    </form>
</body>
</html>
