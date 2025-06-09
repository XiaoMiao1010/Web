<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Objects" %>
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
  <title>后台管理系统</title>
  <!-- 引入 Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- 引入 ECharts -->
  <script src="https://cdn.jsdelivr.net/npm/echarts@5.3.2/dist/echarts.min.js"></script>

  <style>
    /* 使用 Flexbox 让两个图表横向排列 */
    .charts-container {
      display: flex;
      justify-content: center;
      gap: 50px;
      margin-top: 50px;
    }
    .chart {
      width: 600px;
      height: 400px;
    }
  </style>
</head>
<body>
<div class="container-fluid">
  <header class="d-flex justify-content-between align-items-center py-3 bg-dark text-white">
    <div class="logo">
      <img src="../images/logo.png" alt="Logo" width="50" height="50" />
    </div>
    <nav>
      <ul class="nav">
        <li class="nav-item"><a class="nav-link text-white" href="index.jsp">首页</a></li>
        <li class="nav-item"><a class="nav-link text-white" href="userManagement.jsp">用户管理</a></li>
        <li class="nav-item"><a class="nav-link text-white" href="categoryManagement.jsp">商品种类管理</a></li>
        <li class="nav-item"><a class="nav-link text-white" href="productManagement.jsp">商品管理</a></li>
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

  <main class="text-center py-5">
    <h1>欢迎来到后台管理系统</h1>
    <p class="lead">请选择操作模块进行管理。</p>

    <!-- 创建两个 ECharts 容器，使用 Flexbox 布局 -->
    <div class="charts-container">
      <!-- 第一个图表 -->
      <div id="categoryChart" class="chart"></div>
      <!-- 第二个图表 -->
      <div id="productCountChart" class="chart"></div>
    </div>
  </main>
</div>

<!-- 引入 Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

<!-- 在页面加载完成后，初始化并渲染 ECharts 图表 -->
<script type="text/javascript">
  // 获取从后台返回的商品数据
  fetch('/getProductData')  // 获取第一个图表数据的Servlet路径
    .then(response => response.json())
    .then(data => {
      // 从后台返回的数据格式：[{categoryName: '电子产品', productCount: 120}, {...}]

      // 准备第一个图表数据
      const categories = data.map(item => item.categoryName);  // 商品种类
      const productCounts = data.map(item => item.productCount);  // 商品数量

      // 创建第一个图表实例：商品种类分布图
      var categoryChart = echarts.init(document.getElementById('categoryChart'));

      var categoryOption = {
        title: {
          text: '商品种类分布'
        },
        tooltip: {},
        xAxis: {
          type: 'category',
          data: categories  // 商品分类
        },
        yAxis: {
          type: 'value'
        },
        series: [{
          name: '商品数量',
          type: 'bar',
          data: productCounts  // 商品数量
        }]
      };

      categoryChart.setOption(categoryOption);
    })
    .catch(error => console.error('Error:', error));

  // 获取从后台返回的商品种类占比数据
  fetch('/ProductCategoryCountServlet')  // 获取第二个图表数据的Servlet路径
    .then(response => response.json())
    .then(data => {
      // 从后台返回的数据格式：[ { categoryName: '电子产品', productCount: 120 }, {...} ]

      // 创建第二个图表实例：商品种类占比饼图
      var productCountChart = echarts.init(document.getElementById('productCountChart'));

      var productCountOption = {
        title: {
          text: '商品种类占比',
          left: 'center'
        },
        tooltip: {
          trigger: 'item',
          formatter: '{a} <br/>{b} : {c} ({d}%)'
        },
        series: [
          {
            name: '商品数量占比',
            type: 'pie',
            radius: '50%',
            data: data.map(item => ({
              name: item.categoryName,
              value: item.productCount
            })),
            emphasis: {
              itemStyle: {
                shadowBlur: 10,
                shadowOffsetX: 0,
                shadowColor: 'rgba(0, 0, 0, 0.5)'
              }
            }
          }
        ]
      };

      productCountChart.setOption(productCountOption);
    })
    .catch(error => console.error('Error:', error));
</script>

</body>
</html>
