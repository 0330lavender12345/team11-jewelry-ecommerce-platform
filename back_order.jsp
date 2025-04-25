<%@ page import="java.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>訂單總覽</title>
    <link rel="stylesheet" type="text/css" href="back.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
            margin: 0;
        }
        h1 {
            margin-top: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
			font-weight:bolder;
        }
		
    </style>
</head>

<body>
 <div class="header">
        <h1>訂單總覽</h1>
    </div>
    <div class="nav">
        <a href="back_products.jsp">產品管理</a>
        <a href="back_order.jsp">訂單管理</a>
        <a href="back_members.jsp">用戶管理</a>
    </div>
  <a style="color: blue; text-decoration: none;" href="back_index.jsp">回首頁</a>
    <table>
        <thead>
            <tr>
                <th>訂單ID</th>
                <th>訂單日期</th>
                <th>付款方式</th>
                <th>運送方式</th>
                <th>商品名稱</th>
                <th>商品單價</th>
                <th>商品數量</th>
                <th>小計</th>
            </tr>
        </thead>
        <tbody>
            <% 
            try {
                // Step 1: 載入資料庫驅動程式
                Class.forName("com.mysql.cj.jdbc.Driver");
                try {
                    // Step 2: 建立資料庫連線
                    String url = "jdbc:mysql://localhost/team11_silverwrb?serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8";
                   String sql = "SELECT * FROM orders ORDER BY OrderID DESC"; 
                    Connection con = DriverManager.getConnection(url, "root", "1234");
                    
                    // Step 3: 執行查詢
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery(sql);

                    // Step 4: 顯示查詢結果
                    String currentOrderID = "";
                    boolean firstRow = true;
                    while (rs.next()) {
                        String orderID = rs.getString("OrderID");
                        String orderDate = rs.getString("OrderDate");
                        String orderPay = rs.getString("OrderPay");
                        String orderShip = rs.getString("OrderShip");
                        String productName = rs.getString("ProductName");
                        int productPrice = rs.getInt("ProductPrice");
                        int productAmount = rs.getInt("ProductAmount");
                        int orderTPrice = rs.getInt("OrderTPrice");

                        // 若訂單id與上一行不一樣，關閉上一個訂單框架
                        if (!orderID.equals(currentOrderID)) {
                            if (!firstRow) {
                                out.println("</td></tr>");
                            }
                            out.println("<tr>");
                            out.println("<td>" + orderID + "</td>");
                            out.println("<td>" + orderDate + "</td>");
                            out.println("<td>" + orderPay + "</td>");
                            out.println("<td>" + orderShip + "</td>");
                            out.println("<td>" + productName + "</td>");
                            out.println("<td>$" + productPrice + "</td>");
                            out.println("<td>" + productAmount + "</td>");
                            out.println("<td>$" + orderTPrice + "</td>");
                            out.println("</tr>");
                            currentOrderID = orderID;
                            firstRow = false;
                        } else {
                            // 若訂單id與上一行一樣，繼續添加
                            out.println("<tr>");
                            out.println("<td></td>");
                            out.println("<td></td>");
                            out.println("<td></td>");
                            out.println("<td></td>");
                            out.println("<td>" + productName + "</td>");
                            out.println("<td>$" + productPrice + "</td>");
                            out.println("<td>" + productAmount + "</td>");
                            out.println("<td></td>");
                            out.println("</tr>");
                        }
                    }
                    // 關閉最後一個框架
                    if (!firstRow) {
                        out.println("</td></tr>");
                    }

                    // Step 5: 關閉連線
                    rs.close();
                    stmt.close();
                    con.close();
                } catch (SQLException sExec) {
                    out.println("SQL錯誤" + sExec.toString());
                }
            } catch (ClassNotFoundException err) {
                out.println("class錯誤" + err.toString());
            }
            %>
        </tbody>
    </table>
</body>
</html>
