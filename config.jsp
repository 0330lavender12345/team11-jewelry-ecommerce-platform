
<%
Class.forName("com.mysql.jdbc.Driver");
String url="jdbc:mysql://localhost/?serverTimezone=UTC";
Connection con=DriverManager.getConnection(url,"root","1234");
String sql="USE `team11_silverwrb`";
con.createStatement().execute(sql);
%>
