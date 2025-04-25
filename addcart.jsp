<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.net.URLEncoder" %>


<%
    String productName = request.getParameter("productName");
    String productPrice = request.getParameter("productPrice");
    String productImg = request.getParameter("productImg");
    int quantity = Integer.parseInt(request.getParameter("quantity"));

    // 商品資訊轉成購物車項字串
    String cartItemString = productName + "," + productPrice + "," + productImg + "," + quantity;


    //獲取購物車列表
    List<String> cartItems = (List<String>) session.getAttribute("cart");

    // if購物車是空的，建一個新表
    if (cartItems == null) {
        cartItems = new ArrayList<>();
    }

    boolean found = false;
    for (int i = 0; i < cartItems.size(); i++) {
        String item = cartItems.get(i);
        String[] parts = item.split(",");
        String itemName = parts[0];  // 商品名稱在第一個位置

        if (itemName.equals(productName)) {
            // 更新現有商品的數量
            int currentQuantity = Integer.parseInt(parts[3]);  // 當前商品數量在第四個位置
            currentQuantity += quantity;
            cartItems.set(i, parts[0] + "," + parts[1] + "," + parts[2] + "," + currentQuantity);
            found = true;
            break;
        }
    }

    // 如果購物車中未找到相同商品，則新增該商品到購物車
    if (!found) {
        cartItems.add(cartItemString);
    }
    session.setAttribute("cart", cartItems);

    if ("true".equals(request.getParameter("buyNow"))) {

        response.sendRedirect("cart.jsp?buyNow=true&productName=" + URLEncoder.encode(productName, "UTF-8") + "&productPrice=" + URLEncoder.encode(productPrice, "UTF-8") + "&productImg=" + URLEncoder.encode(productImg, "UTF-8"));
    } else {
        // 重定向到商品頁面
        response.sendRedirect("product.jsp");
    }
%>