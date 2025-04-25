<%@ page import="java.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>編輯會員</title>
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
        form input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        form input[type="submit"] {
            width: 100%;
            background-color: #4caf50;
            color: #fff;
            padding: 10px 0;
            border: none;
            border-radius: 5px;
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
            String memberId = request.getParameter("MembersID");
            String memberName = request.getParameter("MembersName");
            String memberAddress = request.getParameter("MembersAddress");
            String memberPhone = request.getParameter("MembersPhone");
            String memberEmail = request.getParameter("MembersEmail");
            String memberPassword = request.getParameter("MembersPWD");
            
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String url="jdbc:mysql://localhost/?serverTimezone=UTC";
                Connection con=DriverManager.getConnection(url,"root","1234");
                String sql="USE `team11_silverwrb`";
                request.setCharacterEncoding("utf-8");
                con.createStatement().execute(sql);
                sql = "UPDATE `members` SET `MembersName`=?, `MembersAddress`=?, `MembersPhone`=?, `MembersEmail`=?, `MembersPWD`=? WHERE `MembersID`=?";
                PreparedStatement pstmt = con.prepareStatement(sql);
                pstmt.setString(1, memberName);
                pstmt.setString(2, memberAddress);
                pstmt.setString(3, memberPhone);
                pstmt.setString(4, memberEmail);
                pstmt.setString(5, memberPassword);
                pstmt.setString(6, memberId);
                pstmt.executeUpdate();
                pstmt.close();
                con.close();
                response.sendRedirect("back_members.jsp");
            } catch (Exception e) {
                out.println("修改失敗：" + e.getMessage());
            }
        } else {
            String memberId = request.getParameter("id");
            Class.forName("com.mysql.jdbc.Driver");
            String url="jdbc:mysql://localhost/?serverTimezone=UTC";
            Connection con=DriverManager.getConnection(url,"root","1234");
            String sql="USE `team11_silverwrb`";
            request.setCharacterEncoding("utf-8");
            con.createStatement().execute(sql);
            sql="SELECT * FROM `members` WHERE MembersID='" + memberId + "'";
            ResultSet rs=con.createStatement().executeQuery(sql);
            if(rs.next()){
    %>
    <form action="" method="post">
        <input type="hidden" name="memberId" value="<%=rs.getString("MembersID")%>">
        會員姓名：<input type="text" name="memberName" value="<%=rs.getString("MembersName")%>"><br>
        會員地址：<input type="text" name="memberAddress" value="<%=rs.getString("MembersAddress")%>"><br>
        會員電話：<input type="text" name="memberPhone" value="<%=rs.getString("MembersPhone")%>"><br>
        電子郵件：<input type="text" name="memberEmail" value="<%=rs.getString("MembersEmail")%>"><br>
        會員密碼：<input type="password" name="memberPassword" value="<%=rs.getString("MembersPWD")%>"><br>
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
