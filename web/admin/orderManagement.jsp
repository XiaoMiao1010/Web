<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  // 检查 session 中的 "admin" 属性是否存在
  Object admin = session.getAttribute("admin");
  if (admin == null) {
    // 如果不存在，跳转到登录页面
    response.sendRedirect("login.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户管理</title>
    <!-- 引入 Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
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
<body>
<div class="container-fluid">
    <header class="d-flex justify-content-between align-items-center py-3 bg-dark text-white">
        <div class="logo">
            <img src="../images/logo.png" alt="Logo" width="50" height="50"/>
        </div>
        <nav>
            <ul class="nav">
                <li class="nav-item"><a class="nav-link text-white" href="/admin/index.jsp">首页</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="lunbotu.jsp">轮播图管理</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="gonggao.jsp">公告管理</a></li>

                <li class="nav-item"><a class="nav-link text-white" href="/admin/userManagement.jsp">用户管理</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="/admin/categoryManagement.jsp">商品种类管理</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="/admin/productManagement.jsp">商品管理</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="/order/select2">订单管理</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="/index">去前台</a></li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="/administrator/logout" style="color: #f44336; font-weight: bold; text-transform: uppercase;">
                        退出
                    </a>
                </li>

            </ul>
        </nav>
    </header>

    <main class="container py-5">
        <div class="container cart">
    <h2 class="d-flex justify-content-between align-items-center">
        <span>订单</span>
        <button id="generateFile" class="btn btn-primary">生成文件</button>
    </h2>
    <table>
        <thead>
        <tr>
            <th>商品</th>
            <th>种类</th>
            <th>单价</th>
            <th>数量</th>
            <th>小计</th>
            <th>收货人</th>
            <th>收货电话</th>
            <th>收货地址</th>
            <th>支付方式</th>
            <th>状态</th>
        </tr>
        </thead>
        <tbody id="cart-body">
        <c:forEach var="order" items="${orderList}">
            <tr data-product="${car.name}">
                <td>${order.name}</td>
                <td>${order.tp}</td>
                <td>￥<span class="product-price">${order.price}</span></td>
                <td>
                    <span class="product-quantity">${order.quantity}</span>
                </td>
                <td>￥<span class="product-total-price">${order.totlel}</span></td>
                <td>${order.username}</td>
                <td>${order.phone}</td>
                <td>${order.address}</td>
                <td>
                    <c:if test="${order.status==1}">
                        <span>微信</span>
                    </c:if>
                    <c:if test="${order.status==2}">
                        <span>支付宝</span>
                    </c:if>
                    <c:if test="${order.status==3}">
                        <span>货到付款</span>
                    </c:if>
                </td>
                <td>
                    <c:if test="${order.ischeck==0}">
                        <button  type="button">
                            <a href="/fh?id=${order.id}">发货</a>
                            </button>
                    </c:if>
                    <c:if test="${order.ischeck==1}">
                        <button type="button">已发货</button>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
    </main>
</div>

<!-- 添加用户弹窗 -->


<!-- 引入 jQuery 和 Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

<script>






    document.getElementById("generateFile").addEventListener("click", function () {
        // 使用 fetch 发送请求
        fetch('/orderPdf', {
            method: 'GET'
        })
        .then(response => {
            if (response.ok) {
                return response.blob(); // 返回文件流
            }
            throw new Error('生成文件失败');
        })
        .then(blob => {
            // 创建下载链接
            const url = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = 'order_report.pdf'; // 下载文件名
            a.click();
            window.URL.revokeObjectURL(url);
        })
        .catch(error => {
            console.error(error);
            alert('文件生成失败，请稍后重试！');
        });
    });
</script>
</body>
</html>

