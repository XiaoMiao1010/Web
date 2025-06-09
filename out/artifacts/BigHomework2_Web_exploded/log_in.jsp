<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <base href="${pageContext.request.contextPath}/">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 引入css文件 -->
    <link rel="stylesheet" href="css/log_in.css">
    <!-- 引入jquery -->
    <script src="js/jquery-3.7.1.js"></script>
    <script src="js/log_in.js"></script>
    <title>登录</title>
</head>
<body>
<!-- 最外层的大盒子 -->
<div class="box">
    <!-- 滑动盒子 -->
    <div class="pre-box">
        <h1>WELCOME</h1>
        <p>JOIN US!</p>
        <div class="img-box">
            <img src="images/waoku.jpg" alt="">
        </div>
    </div>
    <!-- 注册盒子 -->
    <div class="register-form">
        <!-- 标题盒子 -->
        <div class="title-box">
            <h1>注册</h1>
        </div>
        <form action="/user/register" method="post">
            <!-- 输入框盒子 -->
            <div class="input-box">
                <input class="regusername" type="text" placeholder="用户名" name="username">
                <input class="regpassword" type="password" placeholder="密码" name="password1">
                <input class="regpwd" type="password" placeholder="确认密码" name="password2">


            </div>
            <!-- 按钮盒子 -->
            <div class="btn-box">
                <button class="regBtn" type="submit">注册</button>
                <!-- 绑定点击事件 -->
                <p onclick="mySwitch()">已有账号?去登录</p>
            </div>
        </form>
    </div>
    <!-- 登录盒子 -->
    <div class="login-form">
        <!-- 标题盒子 -->
        <div class="title-box">
            <h1>登录</h1>
        </div>
        <!-- 输入框盒子 -->
        <form action="/user/login" method="post">
            <div class="input-box">
                <input class="username" type="text" placeholder="用户名" name="username">
                <input class="password" type="password" placeholder="密码" name="password">
            </div>
            <!-- 按钮盒子 -->
            <div class="btn-box">
                <button class="loginBtn" type="submit">登录</button>
                <!-- 绑定点击事件 -->
                <p onclick="mySwitch()">没有账号?去注册</p>
            </div>
        </form>
    </div>
</div>
<script>
    var error = "${error}";
    if (null != error && undefined != error && '' != error) {
        alert(error)
    }

    var success = "${success}";
    if (null != success && undefined != success && '' != success) {
        alert(success)
    }
</script>
</body>
</html>