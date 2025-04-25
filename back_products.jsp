<%@ page import="java.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>後臺管理/產品</title>
    <link rel="stylesheet" type="text/css" href="back.css">
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            border: 1px solid #555;
        }

        th, td {
            border: 1px solid rgba(85, 85, 85, 0.504);
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #ddd;
        }

        a {
            color: blue;
            text-decoration: none;
            margin-right: 10px;
        }

        a:hover {
            color: darkblue;
        }

        .nav{
            position: relative;
            left: 8px;
        }

        h1{
            position: relative;
            left: 8px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>產品管理</h1>
    </div>
    <div class="nav">
        <a href="back_products.jsp">產品管理</a>
        <a href="back_order.jsp">訂單管理</a>
        <a href="back_members.jsp">用戶管理</a>
    </div>
    <form >
        <a style="color: blue; text-decoration: none;" href="back_ap.jsp">新增商品</a>
        <a style="color: blue; text-decoration: none;" href="back_index.jsp">回首頁</a>
        <div>
            <table border="1" style="border-collapse: collapse;">
                <tr>
                    <td>商品ID</td>
                    <td>商品圖片</td>
                    <td>商品名稱</td>
                    <td>商品介紹</td>
                    <td>商品類別</td>
                    <td>商品金額</td>
                    <td>商品庫存</td>
                    <td>操作</td>
                </tr>
                <%
                    Class.forName("com.mysql.jdbc.Driver");
                    String url="jdbc:mysql://localhost/?serverTimezone=UTC";
                    Connection con=DriverManager.getConnection(url,"root","1234");
                    String sql="USE `team11_silverwrb`";
                    request.setCharacterEncoding("utf-8");
                    con.createStatement().execute(sql);
                    sql="SELECT * FROM `products` WHERE `isAvailable` = TRUE AND `ProductINV` > 0";
                    ResultSet rs=con.createStatement().executeQuery(sql);
                    while(rs.next()){
                        int productInv = rs.getInt("ProductINV");
                        if (productInv > 0) {
                %>
                <tr>
                    <td><%=rs.getString("ProductID")%></td>
                    <td><img src='<%=rs.getString("ProductIMG")%>' width="60px" height="60px"></td>
                    <td><%=rs.getString("ProductName")%></td>
                    <td><%=rs.getString("ProductIntro")%></td>
                    <td><%=rs.getString("ProductClassification")%></td>
                    <td><%=rs.getString("ProductPrice")%></td>
                    <td><%=rs.getString("ProductINV")%></td>
                    <td>
                        <a style="color: blue; text-decoration: none;" href="back_ep.jsp?id=<%=rs.getString("ProductID")%>">編輯</a>
                        <a style="color: red; text-decoration: none;" href="back_dp.jsp?id=<%=rs.getString("ProductID")%>">下架</a>
                    </td>
                </tr>
                <% 
                        }
                    }
                    rs.close();
                    con.close();
                %>
            </table>
        </div>
    </form>
</body>
</html>
