<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Map" %>
<%@ page import="shopping.entity.Category" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <base href="${pageContext.request.contextPath}/">
    <meta charset="utf-8"/>
    <title>甜蜜约会(缪定钦)</title>
    <link href="css/homepage.css" rel="stylesheet" type="text/css"/>
    <script src="js/jquery-3.7.1.js"></script>
    <script type="text/javascript" src="js/lunbo.js"></script>
    <script src="js/homepage.js"></script>
    <style>

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
        <li><a href="shopping_cart.jsp" class="color_in">购物车</a></li>
        <li class="dropdown">
            <a href="javascript:;">商品分类查询</a>
            <div class="dropdown-menu">
                <ul class="list-unstyled">
                    <%
                        // 从 request 或 session 中获取商品分类列表
                        List<Category> categories = (List<Category>) request.getSession().getAttribute("categories");
                        if (categories != null) {
                            for (Category category : categories) {
                    %>
                    <!-- 使用 a 标签，附加参数 -->
                    <li>
                        <a class="dropdown-item" href="CategoryServlet?category=<%= category.getName() %>">
                            <%= category.getName() %>
                        </a>
                    </li>
                    <%
                            }
                        }
                    %>
                </ul>
            </div>
        </li>
        <li><a href="shangpingsousuo.jsp">商品搜索</a></li>
        <li><a href="/order/select">订单</a></li>
        <li><a href="/admin/index.jsp">去后台</a></li>


    </ul>
</div>
<div class="container cart">
    <h2>购物车</h2>
    <table>
        <thead>
        <tr>
            <th>
                <label
                ><input class="check-all check" type="checkbox"/> 全选</label
                >
            </th>
            <th>商品</th>
            <th>单价</th>
            <th>数量</th>
            <th>小计</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody id="cart-body">
        <c:forEach var="car" items="${carList}">
            <tr data-product="${car.name}">
                <td colspan="2">${car.name}</td>
                <td>￥<span class="product-price">${car.price}</span></td>
                <td>
                    <button onclick="decreaseQuantity('${car.name}')">-</button>
                    <span class="product-quantity">${car.quantity}</span>
                    <button onclick="increaseQuantity('${car.name}')">+</button>
                </td>
                <td>￥<span class="product-total-price">${car.price * car.quantity}</span></td>
                    <%--            <td><a href="/car/delect?id=${car.id}">删除</a></td>--%>
                <td>
                    <button onclick="removeFromCart('${car.id}')">删除</button>
                </td>
            </tr>
        </c:forEach>
        <tr>
            <td colspan="6">
                <button style="color: #1b6d85" onclick="settlement()">结算</button>
            </td>
        </tr>
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

    function removeFromCart(id) {
        window.location.href = "/car/delect?id=" + id
    }

    //点击结算
    function settlement() {
        const check = document.querySelector(".check-all")
        if (check.checked) {
            window.location.href = "/payfor.jsp"
        } else {
            alert("请先勾选")
        }


    }


    // Initial call to update the totals
    updateCartTotals();
</script>
</body>
</html>
