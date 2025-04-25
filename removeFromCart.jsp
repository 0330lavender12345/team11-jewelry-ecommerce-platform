<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%
    String productName = request.getParameter("product");
    HttpSession sessionCart = request.getSession();
    List<String> cartItems = (List<String>) sessionCart.getAttribute("cart");

    if (cartItems != null && productName != null) {
        cartItems.removeIf(item -> item.startsWith(productName + ","));
        sessionCart.setAttribute("cart", cartItems);
        out.print("success");
    } else {
        out.print("error");
    }
%>
