<%@ page import="java.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/team11_silverwrb?serverTimezone=UTC";
        Connection con = DriverManager.getConnection(url, "root", "1234");
        if (con.isClosed()) {
            response.getWriter().write("連線建立失敗");
        } else {
            request.setCharacterEncoding("UTF-8");
            String new_content = request.getParameter("content");
            String x = request.getParameter("star");
            String productId = request.getParameter("ProductID");
            java.sql.Date new_date = new java.sql.Date(System.currentTimeMillis());


            String sql = "INSERT INTO guestbook (ProductID, Content, Putdate, star) VALUES (?, ?, ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, productId);
            pstmt.setString(2, new_content);
            pstmt.setDate(3, new_date);
            pstmt.setDouble(4, Double.parseDouble(x));

            pstmt.executeUpdate();

            pstmt.close();
            con.close();
            response.setContentType("text/plain");
            response.getWriter().write("Success");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.getWriter().write("Error");
    }
%>
