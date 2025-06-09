<%@ page import="java.util.List" %>
<%@ page import="shopping.entity.Category" %>
<%@ page import="shopping.entity.Lunbotu" %>
<%@ page import="shopping.dao.LunbotuDao" %>
<%@ page import="shopping.dao.GonggaoDao" %>
<%@ page import="shopping.entity.Gonggao" %><%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2024/6/9
  Time: 21:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <base href="${pageContext.request.contextPath}/">
    <meta charset="utf-8">
    <title>甜蜜约会(缪定钦)</title>
    <link href="css/homepage.css" rel="stylesheet" type="text/css">
    <script src="js/jquery-3.7.1.js"></script>
    <script type="text/javascript" src="js/lunbo.js"></script>
    <script src="js/homepage.js"></script>

    <style>

        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            z-index: 100;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            justify-content: center;
            align-items: center;
            display: none;
        }
        #announcementModal {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            animation: fadeIn 0.3s ease-in-out;
        }
        #announcementText {
            margin-bottom: 20px;
        }
        #announcementButtons {
            display: flex;
            justify-content: space-between;
        }
        #announcementButtons button {
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            background-color: #007bff;
            color: #fff;
        }
        #announcementButtons button:hover {
            background-color: #0056b3;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
    </style>

</head>
<body>

<%

    GonggaoDao gonggaoDao = new GonggaoDao();
    Gonggao selectnew = gonggaoDao.selectnew("select * from gonggao order by createtime desc limit 1");

%>

<%--<div id="announcementModal">--%>
<%--    <div id="title" style="font-weight: 300"><%=selectnew.getTitle()%></div>--%>
<%--    <div id="content"><%=selectnew.getContent()%></div>--%>
<%--    <div id="announcementButtons">--%>
<%--        <button id="confirmButton">确认</button>--%>
<%--        <button id="closeButton">×</button>--%>
<%--    </div>--%>
<%--</div>--%>


<div class="modal-overlay" id="modalOverlay" >
    <div id="announcementModal" style="display: flex;flex-direction: column;width: 300px">
        <div style="text-align: end">
            <button style="width: 20px;font-size: 25px" id="closeButton">×</button>
        </div>
        <div id="title" style="font-weight: 900"><%=selectnew.getTitle()%></div>
        <div id="content" style="margin: 10px"><%=selectnew.getContent()%></div>
        <div id="announcementButtons" style="display: flex;justify-content: center">
            <button id="confirmButton" style="line-height: 10px">确认</button>
        </div>
    </div>
</div>

<script>


    // 显示公告弹窗
    document.addEventListener('DOMContentLoaded', () => {
        document.getElementById('modalOverlay').style.display = 'flex';

        // 绑定按钮点击事件
        document.getElementById('confirmButton').addEventListener('click', () => {
            document.getElementById('modalOverlay').style.display = 'none';
        });
        document.getElementById('closeButton').addEventListener('click', () => {
            document.getElementById('modalOverlay').style.display = 'none';
        });
    });
</script>



<!--head-->
<div class="head">
    <div class="left"><img src="images/logo.png"></div>
    <div class="right"><img src="images/phone.jpg"></div>
</div><!--nav-->
<div id="nav">
    <ul class="nav">
        <li><a href="homepage.jsp" class="color_in">首页</a></li>
        <c:if test="${user == null || user == ''}">
            <li><a href="log_in.jsp" class="ahidden">登录</a></li>
        </c:if>
        <li><a href="/car/select">购物车</a></li>
        <li class="dropdown">
            <a href="javascript:;">商品分类查询</a>
            <div class="dropdown-menu">
                <ul>
                    <%--                                        <li><a href="yinliao.jsp">饮品</a></li>--%>
                    <%--                                        <li><a href="dangao.jsp">蛋糕</a></li>--%>
                    <%--                                        <li><a href="xuemeiniang.jsp">雪梅娘</a></li>--%>
                    <%--                                        <li><a href="tiantianquan.jsp">甜甜圈</a></li>--%>
                    <%--                                        <li><a href="paofu.jsp">泡芙</a></li>--%>
                    <%--                                        <li><a href="buding.jsp">布丁</a></li>--%>
                    <%--                                        <li><a href="sanmingzhi.jsp">三明治</a></li>--%>

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

                </ul>
            </div>
        </li>
        <li><a href="shangpingsousuo.jsp">商品搜索</a></li>
        <li><a href="/order/select">订单</a></li>
        <li><a href="/admin/index.jsp">去后台</a></li>

    </ul>
</div>
<!--banner-->
<div class="banner">
    <ul class="banner_pic" id="banner_pic">

        <%

            LunbotuDao lunbotuDao = new LunbotuDao();
            List<Lunbotu> lunbotus = lunbotuDao.selectAllLunbotus("select * from lunbotu");
        %>

        <%
            for (Lunbotu lunbotu : lunbotus) {
        %>
        <li class="" >
            <img class="one"  style="width: 1920px" src="<%= lunbotu.getImg() %>" alt="轮播图">
        </li>
        <%
            }
        %>


<%--        <li class="current"><img class="one" src="images/01.jpg"></li>--%>
<%--        <li class=""><img class="one" src="images/02.jpg"></li>--%>
<%--        <li class=""><img class="one" src="images/03.jpg"></li>--%>

    </ul>
    <ul class="dot">
        <li class="on"></li>
        <li></li>
        <li></li>
    </ul>
    <div class="arrow"><span class="prev">&lt;</span><span class="next">&gt;</span></div>
</div>
<!--learn-->
<div id="learn">
    <h2>甜蜜约会品牌简介</h2>
    <dl>
        <dt></dt>
        <dd class="txt1">想和甜蜜有个约会吗？</dd>
        <dd class="txt2">
            甜品不仅女孩子喜欢，很多男孩子也不例外，在人们越来越会享受生活的今天，甜品品牌发展的可谓风生水起，“甜蜜约会”就是其中一个。1995年，
            “甜蜜约会”的创始人在西贡区创办了首家港式甜品店、凭借着甜品细腻的口感和独特的风味，获得了很多消费者的青睐。以创新、配置、品质、
            价格作为营销系理念，“甜蜜约会”很快“俘获”了一大批忠实粉丝，并在2002年于新港中心开设了分店。到2020年，“甜蜜约会”更是在北京、
            上海、杭州、苏州、珠海、湖南、广州等地区开设了60多家特许经营店，这样的成绩着实耀眼。
        </dd>
    </dl>
    <div class="imgbox" id="imgbox">
        <span>
            <a href="#"><img src="images/1.jpg"></a>
            <a href="#"><img src="images/2.jpg"></a>
            <a href="#"><img src="images/3.jpg"></a>
            <a href="#"><img src="images/4.jpg"></a>
        </span>
    </div>
</div>
<!--features-->
<div id="features">
    <h2>甜蜜约会特色美食推荐</h2>
    <div class="list0">
        <div id="SwitchBigPic">
            <span class="sp"><a href="#"><img src="images/111.jpg"></a></span>
            <span><a href="#"><img src="images/222.jpg"></a></span>
            <span><a href="#"><img src="images/333.jpg"></a></span>
        </div>
        <ul id="SwitchNav">
            <li><a class="txt_img1" href="#"></a></li>
            <li><a class="txt_img2" href="#"></a></li>
            <li><a class="txt_img3" href="#"></a></li>
        </ul>
    </div>
    <div class="list1">
        <h3></h3>
        <form action="#" method="post" class="biaodan">
            <table class="content">
                <tr>
                    <td class="left">姓名</td>
                    <td><input type="text" class="txt01"></td>
                </tr>
                <tr>
                    <td class="left">手机</td>
                    <td><input type="text" class="txt01"></td>
                </tr>
                <tr>
                    <td class="left">邮箱</td>
                    <td><input type="text" class="txt01"></td>
                </tr>
                <tr>
                    <td class="left">地址</td>
                    <td><select class="course">
                        <option>请选择最近的店铺地址</option>
                        <option>北京三里屯12号</option>
                        <option>上海南京路3号</option>
                        <option>广州淮阳路12号</option>
                        <option>深圳大都会3号</option>
                    </select></td>
                </tr>
                <tr>
                    <td colspan="2"><input class="no_border" type="button"></td>
                </tr>
            </table>
        </form>
    </div>
</div>
<!--footer-->
<div class="footer">甜蜜约会版权所有2020-2036京ICP备2232333号 京公网安背2342434324343</div>
<script>
    //var user="${user}";
    //var success="${success}";
    // if(null !== user && undefined !== user && ''!=user){
    //   alert(user.username)
    //   alert(user.password)
    // }
    //if(null !== success && undefined !== success && ''!=success){
    //alert(success)
    // }
</script>
</body>
</html>
