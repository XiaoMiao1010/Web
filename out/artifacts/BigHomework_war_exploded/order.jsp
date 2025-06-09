<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Map" %>
<html>
<head>
    <base href="${pageContext.request.contextPath}/">
    <meta charset="utf-8"/>
    <title>订单</title>
    <link href="css/homepage.css" rel="stylesheet" type="text/css"/>
    <script src="js/jquery-3.7.1.js"></script>
    <script type="text/javascript" src="js/lunbo.js"></script>
    <script src="js/homepage.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            width: 80%;
            margin: auto;
            overflow: hidden;
        }

        .cart {
            margin-top: 20px;
            background: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .cart table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .cart th,
        .cart td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        .cart th {
            background-color: #f4f4f4;
        }

        .cart .total {
            text-align: right;
            font-size: 1.2em;
            margin-top: 10px;
        }

        .checkout {
            display: block;
            margin: 20px auto;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .checkout:hover {
            background-color: #0056b3;
        }

        .empty-message {
            text-align: center;
            font-size: 1.2em;
            color: #555;
        }
    </style>
</head>
<body>
<!--head-->
<div class="head">
    <div class="left"><img src="images/logo.png"/></div>
    <div class="right"><img src="images/phone.jpg"/></div>
</div>
<!--nav-->
<div id="nav">
    <ul class="nav">
        <li><a href="homepage.jsp">首页</a></li>
        <c:if test="${user == null || user == ''}">
            <li><a href="log_in.jsp" class="ahidden">登录</a></li>
        </c:if>
        <li><a href="shopping_cart.jsp">购物车</a></li>
        <li class="dropdown">
            <a href="javascript:;">商品分类查询</a>
            <div class="dropdown-menu">
                <ul>
                    <li><a href="yinliao.jsp">饮品</a></li>
                    <li><a href="dangao.jsp">蛋糕</a></li>
                    <li><a href="xuemeiniang.jsp">雪梅娘</a></li>
                    <li><a href="tiantianquan.jsp">甜甜圈</a></li>
                    <li><a href="paofu.jsp">泡芙</a></li>
                    <li><a href="buding.jsp">布丁</a></li>
                    <li><a href="sanmingzhi.jsp">三明治</a></li>
                </ul>
            </div>
        </li>
        <li><a href="shangpingsousuo.jsp">商品搜索</a></li>
        <li><a href="/order/select" class="color_in">订单</a></li>
        <li><a href="/admin/index.jsp">后台管理</a></li>

    </ul>
</div>
<div class="container cart">
    <h2>订单</h2>
    <table>
        <thead>
        <tr>
            <th>商品</th>
            <th>单价</th>
            <th>数量</th>
            <th>小计</th>
            <th>收货人</th>
            <th>收货电话</th>
            <th>收货地址</th>
            <th>支付方式</th>
        </tr>
        </thead>
        <tbody id="cart-body">
        <c:forEach var="order" items="${orderList}">
            <tr data-product="${car.name}">
                <td>${order.name}</td>
                <td>￥<span class="product-price">${order.price}</span></td>
                <td>
                    <span class="product-quantity">${order.quantity}</span>
                </td>
                <td>￥<span class="product-total-price">${order.totlel}</span></td>
                    <%--            <td><a href="/car/delect?id=${car.id}">删除</a></td>--%>
                <td>${order.username}</td>
                <td>${order.phone}</td>
                <td>${order.address}</td>
                <td>
                    <c:if test="${order.status==1}">
                        <spa>微信</spa>
                    </c:if>
                    <c:if test="${order.status==2}">
                        <spa>支付宝</spa>
                    </c:if>
                    <c:if test="${order.status==3}">
                        <spa>货到付款</spa>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<script>
    function updateCartTotals() {
        document.querySelectorAll('tbody tr').forEach((row) => {
            const priceElement = row.querySelector('.product-price');
            const quantityElement = row.querySelector('.product-quantity');
            const totalElement = row.querySelector('.product-total-price');
            const price = parseFloat(priceElement.textContent);
            const quantity = parseInt(quantityElement.textContent);
            const total = (price * quantity).toFixed(2);
            totalElement.textContent = total;
        });
    }

    function increaseQuantity(product) {
        const row = document.querySelector(`tr[data-product="${product}"]`);
        const quantityElement = row.querySelector('.product-quantity');
        let quantity = parseInt(quantityElement.textContent);
        quantity += 1;
        quantityElement.textContent = quantity;
        updateCartTotals();
    }

    function decreaseQuantity(product) {
        const row = document.querySelector(`tr[data-product="${product}"]`);
        const quantityElement = row.querySelector('.product-quantity');
        let quantity = parseInt(quantityElement.textContent);
        if (quantity > 1) {
            quantity -= 1;
            quantityElement.textContent = quantity;
            updateCartTotals();
        }
    }


    // Initial call to update the totals
    updateCartTotals();
</script>
</body>
</html>
