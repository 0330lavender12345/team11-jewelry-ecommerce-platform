<%@ page import="java.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>編輯商品</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
        }

        form {
            max-width: 400px;
            margin: auto;
            background: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        form input[type="text"],
        form input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        form input[type="submit"] {
            background-color: #4caf50;
            color: #fff;
            border: none;
            cursor: pointer;
        }

        form input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <%
        if (request.getMethod().equals("POST")) {
            String productId = request.getParameter("productId");
            String productName = request.getParameter("productName");
            String productClassification = request.getParameter("productClassification");
            String productPrice = request.getParameter("productPrice");
            String productInv = request.getParameter("productINV");
            
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String url="jdbc:mysql://localhost/?serverTimezone=UTC";
                Connection con=DriverManager.getConnection(url,"root","1234");
                String sql="USE `team11_silverwrb`";
                request.setCharacterEncoding("utf-8");
                con.createStatement().execute(sql);
                sql = "UPDATE `products` SET `ProductName`=?, `ProductClassification`=?, `ProductPrice`=?, `ProductINV` =? WHERE `ProductID`=?";
                PreparedStatement pstmt = con.prepareStatement(sql);
                pstmt.setString(1, productName);
                pstmt.setString(2, productClassification);
                pstmt.setString(3, productPrice);
                pstmt.setString(4, productInv);
                pstmt.setString(5, productId);
                pstmt.executeUpdate();
                pstmt.close();
                con.close();
                response.sendRedirect("back_products.jsp");
            } catch (Exception e) {
                out.println("修改失敗：" + e.getMessage());
            }
        } else {
            String productId = request.getParameter("id");
            Class.forName("com.mysql.jdbc.Driver");
            String url="jdbc:mysql://localhost/?serverTimezone=UTC";
            Connection con=DriverManager.getConnection(url,"root","1234");
            String sql="USE `team11_silverwrb`";
            request.setCharacterEncoding("utf-8");
            con.createStatement().execute(sql);
            sql="SELECT * FROM `products` WHERE ProductID='" + productId + "'";
            ResultSet rs=con.createStatement().executeQuery(sql);
            if(rs.next()){
    %>
    <form action="" method="post">
        <input type="hidden" name="productId" value="<%=rs.getString("ProductID")%>">
        商品名稱：<input type="text" name="productName" value="<%=rs.getString("ProductName")%>"><br>
        商品類別：<input type="text" name="productClassification" value="<%=rs.getString("ProductClassification")%>"><br>
        商品金額：<input type="text" name="productPrice" value="<%=rs.getString("ProductPrice")%>"><br>
        商品庫存：<input type="text" name="productINV" value="<%=rs.getString("ProductINV")%>"><br>
        <input type="submit" value="更新">
    </form>
    <%
            }
            rs.close();
            con.close();
        }
    %>
</body>
</html>
