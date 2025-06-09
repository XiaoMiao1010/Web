<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <base href="${pageContext.request.contextPath}/">
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>微信收款码</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f0f0f0;
            font-family: Arial, sans-serif;
        }

        .container {
            text-align: center;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .qrcode {
            width: 200px;
            height: 200px;
            margin-bottom: 20px;
        }

        .amount {
            font-size: 1.5em;
            margin-bottom: 10px;
        }

        .instructions {
            color: #888;
        }

        .return-button {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 1em;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }

        .return-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>收款码</h1>
    <img src="images/wxskm.jpg" alt="收款码" class="qrcode"/>
    <div class="instructions">请使用微信扫描二维码进行支付</div>
    <button class="return-button" onclick="goBack()">支付成功，返回</button>
</div>

<script>
    function goBack() {
        // 检查浏览器是否有历史记录
        if (window.history.length > 1) {
            alert("支付成功！")
            <%
            request.setAttribute("success",null);
            %>
            setTimeout(function () {
                window.location.href = "homepage.jsp";
            }, 1000);
            // 没有历史记录时，重定向到默认页面
        }
        var success = "${success}";
        if (null != success && undefined != success && '' != success) {
            alert(success)
            <%
            request.setAttribute("success",null);
            %>
        }
    }
</script>
</body>
</html>
