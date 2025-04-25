<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>

<%
Connection con = null;
PreparedStatement pstmt = null;

try {
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/team11_silverwrb?serverTimezone=UTC";
    con = DriverManager.getConnection(url, "root", "1234");
    
    if (con.isClosed()) {
        out.println("連線建立失敗");
    } else {
        if (session.getAttribute("email") != null) {
            String updatesql = "UPDATE `members` SET `MembersName`=?, `MembersPWD`=?, `MembersPhone`=?, `MembersAddress`=? WHERE `MembersEmail`=?";
            pstmt = con.prepareStatement(updatesql);
            pstmt.setString(1, request.getParameter("name"));
            pstmt.setString(2, request.getParameter("password"));
            pstmt.setString(3, request.getParameter("phone"));
            pstmt.setString(4, request.getParameter("address"));
            pstmt.setString(5, session.getAttribute("email").toString());

            int rowsUpdated = pstmt.executeUpdate();

            if (rowsUpdated > 0) {
                out.println("更新成功！");
                response.sendRedirect("member_info.jsp?status=success");
            } else {
                out.println("更新失敗，沒有找到符合條件的記錄！");
                response.sendRedirect("member_info.jsp?status=error");
            }
        } else {
            out.println("未登錄，無法更新信息！");
            response.sendRedirect("login.jsp");
        }
    }
} catch (SQLException sExec) {
    out.println("SQL錯誤: " + sExec.toString());
} catch (ClassNotFoundException err) {
    out.println("class錯誤: " + err.toString());
} finally {
    try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
    try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
}
%>
