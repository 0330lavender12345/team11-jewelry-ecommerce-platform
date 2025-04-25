<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>後臺管理首頁</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            text-align: center;
        }
        .header {
            background-color: #4CAF50;
            color: white;
            padding: 10px 0;
        }
        .header h1 {
            margin: 0;
        }
        .nav {
            margin: 20px auto;
        }
        .nav a {
            margin: 0 15px;
            padding: 10px 20px;
            text-decoration: none;
            color: white;
            background-color: #007BFF;
            border-radius: 5px;
        }
        .nav a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>後臺管理首頁</h1>
        </div>
        <div class="nav">
            <a href="back_products.jsp">產品管理</a>
            <a href="back_order.jsp">訂單管理</a>
            <a href="back_members.jsp">用戶管理</a>
        </div>
    </div>
</body>
</html>
