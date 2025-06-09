<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录</title>
    <link rel="stylesheet" href="style.css">
</head>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: Arial, sans-serif;
        background: linear-gradient(135deg, #6f86d6, #48c6ef);
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .login-container {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100%;
    }

    .login-box {
        background: rgba(255, 255, 255, 0.9);
        border-radius: 10px;
        padding: 40px;
        width: 350px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        text-align: center;
    }

    h2 {
        font-size: 24px;
        margin-bottom: 20px;
        color: #333;
    }

    .input-group {
        margin-bottom: 20px;
        text-align: left;
    }

    .input-group label {
        font-size: 14px;
        color: #333;
        margin-bottom: 5px;
        display: block;
    }

    .input-group input {
        width: 100%;
        padding: 10px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 5px;
        outline: none;
    }

    .input-group input:focus {
        border-color: #48c6ef;
        box-shadow: 0 0 8px rgba(72, 198, 239, 0.6);
    }

    .btn-group {
        margin-top: 20px;
    }

    .login-btn {
        width: 100%;
        padding: 12px;
        background: #48c6ef;
        border: none;
        border-radius: 5px;
        color: white;
        font-size: 16px;
        cursor: pointer;
        transition: background 0.3s;
    }

    .login-btn:hover {
        background: #6f86d6;
    }

    .signup-link {
        margin-top: 15px;
        font-size: 14px;
        color: #333;
    }

    .signup-link a {
        color: #48c6ef;
        text-decoration: none;
    }

    .signup-link a:hover {
        text-decoration: underline;
    }

</style>
<body>
<div class="login-container">
    <div class="login-box">
        <h2>管理员登录</h2>

        <!-- 登录表单 -->
        <form action="/administrator/login" method="POST">
            <!-- 用户名输入框 -->
            <div class="input-group">
                <label for="username">用户名</label>
                <input type="text" id="username" name="username" placeholder="请输入用户名" required>
            </div>

            <!-- 密码输入框 -->
            <div class="input-group">
                <label for="password">密码</label>
                <input type="password" id="password" name="password" placeholder="请输入密码" required>
            </div>

            <!-- 错误信息提示 -->
            <div class="error-msg">
                <c:if test="${not empty msg}">
                    <p style="color:red;">${msg}</p>
                </c:if>
            </div>

            <!-- 登录按钮 -->
            <div class="btn-group">
                <button type="submit" class="login-btn">登录</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>

