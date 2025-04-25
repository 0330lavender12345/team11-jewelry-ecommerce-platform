<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>後臺管理/會員</title>
    <link rel="stylesheet" type="text/css" href="back.css">
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            border: 1px solid #555;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
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
    </style>
</head>
<body>
    <div class="header">
        <h1>會員管理</h1>
    </div>
    
    <div class="nav">
        <a href="back_products.jsp">產品管理</a>
        <a href="back_order.jsp">訂單管理</a>
        <a href="back_members.jsp">用戶管理</a>
    </div>
    <form>
        <a style="color: blue; text-decoration: none;" href="back_addproducts.jsp">新增用戶</a>
        <a style="color: blue; text-decoration: none;" href="back_index.jsp">回首頁</a>
        <div>
            <table border="1" style="border-collapse: collapse;">
                <tr>
                    <th>會員ID</th>
                    <th>用戶名</th>
                    <th>密碼</th>
                    <th>操作</th>
                </tr>
                <%
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String url="jdbc:mysql://localhost/?serverTimezone=UTC";
                    try (Connection con = DriverManager.getConnection(url, "root", "1234");
                         Statement stmt = con.createStatement()) {

                        String sql = "USE `team11_silverwrb`";
                        stmt.execute(sql);
                        request.setCharacterEncoding("utf-8");

                        sql = "SELECT * FROM `members`";
                        try (ResultSet rs = stmt.executeQuery(sql)) {
                            while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString("MembersID") %></td>
                    <td><%= rs.getString("MembersName") %></td>
                    <td><%= rs.getString("MembersPWD") %></td>
                    <td>
                        <a style="color: blue; text-decoration: none;" href="back_em.jsp?id=<%= rs.getString("MembersID") %>">修改</a>
                        <a style="color: red; text-decoration: none;" href="back_dm.jsp?id=<%= rs.getString("MembersID") %>">刪除</a>
                    </td>
                </tr>
                <%
                            }
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
            </table>
        </div>
    </form>
</body>
</html>
