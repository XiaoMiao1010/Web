<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="${pageContext.request.contextPath}/">
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>雪梅娘网页</title>
    <link rel="stylesheet" href="styles.css"/>
    <script src="js/jquery-3.7.1.js"></script>
    <style>
        /* styles.css */
        body {
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            background-color: rgba(255, 255, 255, 0.8); /* 添加透明背景以提高可读性 */
            padding: 20px;
            border-radius: 10px;
            margin: 20px;
        }

        .product {
            flex: 0 0 200px;
            margin: 10px;
            text-align: center;
            background-color: rgba(255, 255, 255, 0.9); /* 产品卡片背景 */
            padding: 10px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .xmn {
            font-size: 20px;
            text-align: center;
            font-weight: bolder;
            margin-top: 20px;
        }

        .product:hover {
            background-color: rgba(37, 53, 175, 0.329); /* 鼠标悬停时的背景色 */
        }

        .product img {
            width: 150px;
            height: 150px;
        }

        .product button {
            padding: 5px 10px;
            margin-top: 5px;
            cursor: pointer;
        }

        header {
            padding: 20px;
            text-align: center;
            background-color: rgba(255, 255, 255, 0.8); /* 添加透明背景 */
            margin-bottom: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
        }

        header a {
            text-decoration: none;
            color: #2535af;
        }
    </style>
</head>
<body>
<header>
    <p class="xmn">
        <a href="homepage.jsp">欢迎您购买本店雪梅娘(点这里可以返回哦)</a>
    </p>
</header>

<div class="container">
</div>
<script>
    document.querySelectorAll(".add-to-cart").forEach((button) => {
        button.addEventListener("click", () => {
            const currentUser = "${user}";
            if (null === currentUser ||
                undefined === currentUser ||
                '' === currentUser) {
                alert("请先登录")
                return
            }
            const name = button.getAttribute("data-name");
            const price = button.getAttribute("data-price");
            const imgElement = button.parentElement.querySelector("img")
            const imgSrc = imgElement.getAttribute("src");
            addToCart(name, price, imgSrc);
        });
    });
</script>
<script src="js/addCar.js"></script>
<!-- <script src="script.js"></script> -->
</body>
</html>
