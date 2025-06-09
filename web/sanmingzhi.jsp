<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="${pageContext.request.contextPath}/">
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>三明治网页</title>
    <link rel="stylesheet" href="styles.css"/>
    <script src="js/jquery-3.7.1.js"></script>
    <style>
        /* styles.css */
        .container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            background-color: white;
        }

        .product {
            flex: 0 0 200px;
            margin: 10px;
            text-align: center;
        }

        .smz{
            font-size: 20px;
            text-align: center;
            font-weight: bolder;
        }

        .product:hover {
            background-color: rgba(37, 53, 175, 0.329); /* 鼠标悬停时的背景色 */
        }

        .product img {
            width: 200px;
            height: 200px;
        }

        .product button {
            padding: 5px 10px;
            margin-top: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<header>
    <p class="smz">
        <a href="homepage.jsp">欢迎您购买本店三明治(点这里可以返回哦)</a>
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
</body>
</html>
