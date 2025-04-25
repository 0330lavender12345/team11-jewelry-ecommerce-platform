<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>logout</title>
</head>
<body>
<%
  
if (session.getAttribute("email") != null){
session.invalidate();
}
else{
session.invalidate();	
}
response.sendRedirect("index.jsp");
%>
</body>
</html>