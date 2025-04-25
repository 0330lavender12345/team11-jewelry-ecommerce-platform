<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>刪除會員</title>
</head>
<body>
    <h1>刪除會員</h1>
    
    <%
        String memberId = request.getParameter("id");
        
        // 如果 memberId 不為空，則執行刪除操作
        if(memberId != null && !memberId.isEmpty()) {
            try {
                // 設置資料庫連接
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost/team11_silverwrb?serverTimezone=UTC";
                Connection con = DriverManager.getConnection(url, "root", "1234");
                
                // 執行刪除會員的 SQL 查詢
                String sql = "DELETE FROM `members` WHERE MembersID = ?";
                try (PreparedStatement pstmt = con.prepareStatement(sql)) {
                    pstmt.setString(1, memberId);
                    int rowsAffected = pstmt.executeUpdate();
                    
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            }
        }
        
        response.sendRedirect("back_members.jsp");
    %>  

    <br>
</body>
</html>
