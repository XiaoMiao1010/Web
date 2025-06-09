function addToCart(productName, productPrice, imgSrc,tp) {
    // 发送 AJAX 请求到后台的 registerFile.php 文件，传递用户名和密码
    $.ajax({
        type: 'post',
        url: '/car/add',
        dataType: 'json',
        data: {
            "productName": productName,
            "productPrice": productPrice,
            "imgSrc": imgSrc,
            "tp":tp
        },
        success: function (res) {
            if (res.infoCode === 200) {
                alert(`${productName} 已加入购物车`);
            } else {
                alert(`${productName} 加入失败`);
            }

        }
    });
    let cart = JSON.parse(localStorage.getItem("cart")) || {};
    if (cart[productName]) {
        cart[productName].quantity += 1;
    } else {
        cart[productName] = {price: parseFloat(productPrice), quantity: 1};
    }
    localStorage.setItem("cart", JSON.stringify(cart));
}

