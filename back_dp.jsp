<%@ page import="java.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>下架商品</title>
</head>
<body>
    <h1>下架商品</h1>
    <%
        String productId = request.getParameter("id");

        // 設置資料庫連接
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost/team11_silverwrb?serverTimezone=UTC";
        Connection con = DriverManager.getConnection(url, "root", "1234");

        // 更新商品狀態為下架
        String updateSql = "UPDATE `products` SET `isAvailable` = false WHERE `ProductID` = ?";
        PreparedStatement pstmt = con.prepareStatement(updateSql);
        pstmt.setString(1, productId);
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            response.sendRedirect("back_products.jsp");
        } else {
    %>
        <p>下架商品錯誤。</p>
    <%
        }
        pstmt.close();
        con.close();
    %>
</body>
</html>
