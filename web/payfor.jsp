<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <base href="${pageContext.request.contextPath}/">
    <meta charset="utf-8"/>
    <title>结算页面</title>
    <link rel="stylesheet" href="styles.css">
</head>
<style>
    .yinliao {
        font-size: 20px;
        text-align: center;
        font-weight: bolder;
    }

    .container {
        text-align: center;
        background-color: #fff;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
</style>
<header>
    <p class="yinliao"><a href="shopping_cart.php">感谢您购买本店产品(点这里可以返回购物车)</a></p>
</header>

<div class="cart-items">
    <div class="container">

        <form action="/order/insert" method="post">
            <h2>确认收货信息</h2>
            <div class="container">
                <label class="control-label col-md-1">收货人</label>
                <div class="col-md-6">
                    <input
                            type="text"
                            class="form-control"
                            name="username"
                            value=""
                            style="height: auto; padding: 10px"
                            placeholder=""
                            required="required"
                    /><br/>
                </div>
            </div>
            <div class="container">
                <label class="control-label col-md-1">收货电话</label>
                <div class="col-md-6">
                    <input
                            type="text"
                            class="form-control"
                            name="phone"
                            value=""
                            style="height: auto; padding: 10px"
                            placeholder=""
                            required="required"
                    /><br/>
                </div>
            </div>
            <div class="container">
                <label class="control-label col-md-1">收货地址</label>
                <div class="col-md-6">
                    <input
                            type="text"
                            class="form-control"
                            name="address"
                            value=""
                            style="height: auto; padding: 10px"
                            placeholder=""
                            required="required"
                    /><br/>
                </div>
            </div>
            <br/>
            <hr/>
            <br/>
            <h2>选择支付方式</h2>
            <br/><br/>
            <div class="col-sm-6 col-md-4 col-lg-3">
                <label>
                    <div class="thumbnail">
                        <input type="radio" name="status" value="1" checked="checked"/>
                        <img src="images/wx.jpg" alt="微信支付" width="150px"/>
                        <input type="radio" name="status" value="2"/>
                        <img src="images/zfb.png" alt="支付宝支付" width="150px" height="100px"/>
                        <input type="radio" name="status" value="3"/>
                        <img src="images/hdfk.jpg" alt="货到付款" width="80px"/>
                    </div>
                </label>
                <div class="container">
                    <div class="amount">合计：￥${totle} <span id="totalAmount">${totle}</span></div>
                    <input type="submit" class="confirm" value="确认付款">
                    <%--          <a href="payfor_success.php" class="confirm">确认付款</a>--%>
                </div>
            </div>
        </form>
    </div>
</div>
<script>
    function getQueryParam(param) {
        const urlParams = new URLSearchParams(window.location.search);
        return urlParams.get(param);
    }

    document.getElementById('totalAmount').textContent = getQueryParam('total');
    var error = "${error}";
    if (null != error && undefined != error && '' != error) {
        alert(error)
    }
</script>
</div>
</body>
</html>