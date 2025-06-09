<%@ page import="shopping.entity.Category" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="${pageContext.request.contextPath}/">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>商品搜索</title>
    <link rel="stylesheet" href="css/sousuo.css">
    <script src="js/jquery-3.7.1.js"></script>
</head>
<body>
<!--head-->
<div class="head">
    <div class="left"><img src="images/logo.png"></div>
    <div class="right"><img src="images/phone.jpg"></div>
</div>

<!--nav-->
<div id="nav">
    <ul class="nav">
        <li><a href="homepage.jsp">首页</a></li>
        <c:if test="${user == null || user == ''}">
            <li><a href="log_in.jsp" class="ahidden">登录</a></li>
        </c:if>
        <li><a href="log_in.jsp" class="bhidden">注销</a></li>
        <li><a href="/car/select">购物车</a></li>
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
        <li><a href="shangpingsousuo.jsp" class="color_in">商品搜索</a></li>
        <li><a href="/order/select">订单</a></li>
        <li><a href="/admin/index.jsp">去后台</a></li>
    </ul>
</div>

<br><br><br><br><br>

<!--banner-->
<section class="container">
    <form>
        <i class="fas fa-search"></i>
        <input type="text" id="search-item" placeholder="搜索产品">
        <button type="button" onclick="searchProducts()">搜索</button>
    </form>
    <div class="product-list" id="product-list"></div>
</section>

<script>
    // 动态加载商品数据
    $(document).ready(function () {
        fetch('/product/select')
            .then(function (response) {
                return response.json();
            })
            .then(function (data) {
                var productList = document.getElementById('product-list');
                var categoryList = document.getElementById('category-list');
                var categories = {};

                data.products.forEach(function (product) {
                    // 添加商品到列表
                    var productHtml = '<div class="product" data-name="' + product.name + '" data-category="' + product.categoryName + '">' +
                        '<img src="' + product.img + '" alt="">' +
                        '<div class="p-details">' +
                        '<h2>' + product.name + '</h2>' +
                        '<h3>￥' + product.price + '</h3>' +
                        '<button class="add-to-cart" data-cn="'+product.categoryName+'" data-name="' + product.name + '" data-price="' + product.price + '" data-img="' + product.img + '">加入购物车</button>' +
                        '</div>' +
                        '</div>';
                    productList.innerHTML += productHtml;
                    console.log(productList.innerHTML)
                    // 收集分类信息
                    // if (!categories[product.categoryName]) {
                    //     categories[product.categoryName] = true;
                    //     var categoryHtml = '<li><a class="dropdown-item" href="#" onclick="filterByCategory(\'' + product.categoryName + '\')">' + product.categoryName + '</a></li>';
                    //     categoryList.innerHTML += categoryHtml;
                    // }
                });

                // 绑定加入购物车事件
                bindAddToCart();
            })
            .catch(function (error) {
                console.error('Error loading products:', error);
            });
    });

    // 搜索功能
    function searchProducts() {
        var keyword = document.getElementById('search-item').value.toLowerCase();
        var products = document.getElementsByClassName('product');
        for (var i = 0; i < products.length; i++) {
            var productName = products[i].getAttribute('data-name').toLowerCase();
            if (productName.includes(keyword)) {
                products[i].style.display = 'block';
            } else {
                products[i].style.display = 'none';
            }
        }
    }

    // 按分类过滤商品
    function filterByCategory(category) {
        var products = document.getElementsByClassName('product');
        for (var i = 0; i < products.length; i++) {
            var productCategory = products[i].getAttribute('data-category');
            if (productCategory === category) {
                products[i].style.display = 'block';
            } else {
                products[i].style.display = 'none';
            }
        }
    }

    // 绑定加入购物车事件
    function bindAddToCart() {
        var buttons = document.getElementsByClassName('add-to-cart');
        for (var i = 0; i < buttons.length; i++) {
            buttons[i].addEventListener('click', function () {
                var currentUser = "${user}";
                if (!currentUser) {
                    alert("请先登录");
                    return;
                }

                var name = this.getAttribute('data-name');
                var price = this.getAttribute('data-price');
                var tp = this.getAttribute('data-cn');
                var imgSrc = this.getAttribute('data-img');
                addToCart(name, price, imgSrc,tp);
            });
        }
    }

    // 添加商品到购物车
    function addToCart(name, price, imgSrc,tp) {
        addToCart(name, price, imgSrc,tp);
        console.log('商品加入购物车: 名称=' + name + ', 价格=' + price + ', 图片=' + imgSrc);
        alert('商品 "' + name + '" 已加入购物车！');

    }
</script>
<script src="js/addCar.js"></script>
</body>
</html>
