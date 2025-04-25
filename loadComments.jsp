<%@ page import="java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>

<%
    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/team11_silverwrb", "root", "1234");
        
        String productId = request.getParameter("ProductID");


        String sql = "SELECT guestbook.Content, guestbook.Putdate, guestbook.star FROM guestbook WHERE guestbook.ProductID = ?";
        pst = con.prepareStatement(sql);
        pst.setString(1, productId);

        rs = pst.executeQuery();
        
        
        StringBuilder htmlBuilder = new StringBuilder();
        while (rs.next()) {
            String content = rs.getString("Content");
            String date = rs.getString("Putdate");
            int star = rs.getInt("star");
            
            htmlBuilder.append("<div class=\"review\">");
            htmlBuilder.append("<span>USER</span>");
            htmlBuilder.append("<span>").append(date).append("</span>");
            htmlBuilder.append("<span class=\"stars\">").append("★".repeat(star)).append("</span>");
            htmlBuilder.append("<p>").append(content).append("</p>");
            htmlBuilder.append("</div>");
        }
        
        
        out.print(htmlBuilder.toString());
        
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // 關閉連接
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
