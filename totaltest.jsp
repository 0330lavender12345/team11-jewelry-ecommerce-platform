<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>訂單確認</title>
</head>
<body>
    <h1>訂單確認</h1>
    
    <% if (request.getMethod().equals("POST")) { %>
        <%
        request.setCharacterEncoding("UTF-8");

        String[] productNames = request.getParameterValues("selectedProducts");
        if (productNames != null ) {
            String[] productPrices = new String[productNames.length];
            String[] productIMGs = new String[productNames.length];
            for (int i = 0; i < productNames.length; i++) {
                productPrices[i] = request.getParameter("productPrices_" + productNames[i]);
                productIMGs[i] = request.getParameter("productIMGs_" + productNames[i]);
            }
        %>
            <form action="submitorder.jsp" method="POST">
                <table border="1">
                    <tr>
                        <td>名稱</td>
                        <td>價格</td>
                        <td>圖片</td>
                        <td>數量</td>
                        <td>總價</td>
                    </tr>
                    <% 
                    int totalPrice = 0;
                    for (int i = 0; i < productNames.length; i++) {
                        String productName = productNames[i];
                        String quantities = request.getParameter("quantities_" + productName);
                        int quantity = Integer.parseInt(quantities);
                        if (quantity == 0) continue;
                        int productPrice = Integer.parseInt(productPrices[i]);
                        String productIMG = productIMGs[i];
                        int subtotal = productPrice * quantity;
                        totalPrice += subtotal;
                    %>
                        <tr>
                            <td><%= productName %></td>
                            <td>$<%= productPrice %></td>
                            <td><img src='<%= productIMG %>' height='50px' width='50px'></td>
                            <td><%= quantity %></td>
                            <td>$<%= subtotal %></td>
                        </tr>
                        <input type="hidden" name="productName_<%= i %>" value="<%= productName %>">
                        <input type="hidden" name="productPrice_<%= i %>" value="<%= productPrice %>">
                        <input type="hidden" name="productAmount_<%= i %>" value="<%= quantity %>">
                    <% } %>
                    <tr>
                        <td colspan="4" align="right"><b>Total:</b></td>
                        <td>$<%= totalPrice %></td>
                    </tr>
                </table>
                付款資訊:
                <input type="radio" id="payment1" name="payment" value="貨到付款" required>貨到付款
                <input type="radio" id="payment2" name="payment" value="信用卡/金融卡" required>信用卡/金融卡
                <input type="radio" id="payment3" name="payment" value="ATM轉帳" required>ATM轉帳
                <br><br>

                運送方式:
                <input type="radio" id="shipping1" name="shipping" value="宅配到府" required>宅配到府
                <input type="radio" id="shipping2" name="shipping" value="來店自取" required>來店自取
                <br><br>

                姓名:<input type="text" name="membersID" value="<%= session.getAttribute("membersID") %>">
                <input type="hidden" name="orderTPrice" value="<%= totalPrice %>">
                <input type="submit" value="送出訂單">
            </form>
			<!--若未選擇商品，則顯示請選擇商品!!-->
        <% 
        } else {
            out.println("請選擇商品!!");
        }
        %>
		<!--若下單成功，則顯示謝謝您的購買~-->
    <% } else { %>
        <p>謝謝您的購買~</p>
    <% }%>
	<a href="back_order.jsp">瀏覽訂單</a><p>
</body>
</html>
