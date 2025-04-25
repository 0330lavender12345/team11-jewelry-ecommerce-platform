<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class='card'>
    <img src='<c:out value="${productImg}" />' alt=''>
    <a href='prdintro.jsp'><h4><c:out value="${productName}" /></h4></a>
    <h5>$<c:out value="${productPrice}" /></h5>
    <form id="addToCartForm" method="post" action="cart1.jsp">
        <input type="hidden" name="productName" value="<c:out value="${productName}" />">
        <input type="hidden" name="productPrice" value="<c:out value="${productPrice}" />">
        <input type="hidden" name="productImg" value="<c:out value="${productImg}" />">
    </form>
    <input type="button" class="card-button" onclick="addToCart('<c:out value="${productName}" />', '<c:out value="${productPrice}" />', '<c:out value="${productImg}" />')" value="Add to Cart">
</div>
