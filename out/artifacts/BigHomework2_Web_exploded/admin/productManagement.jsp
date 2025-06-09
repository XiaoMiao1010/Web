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
  <title>商品管理</title>
  <!-- 引入 Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
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
        <li class="nav-item"><a class="nav-link text-white" href="lunbotu.jsp">轮播图管理</a></li>
        <li class="nav-item"><a class="nav-link text-white" href="gonggao.jsp">公告管理</a></li>
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

  <main class="container py-5">
    <h2 class="text-center mb-4">商品管理</h2>

    <!-- 搜索框 -->
    <div class="mb-4 text-center">
      <input type="text" id="searchProduct" class="form-control w-50 mx-auto" placeholder="搜索商品名称">
      <button class="btn btn-primary mt-2" onclick="loadProducts()">搜索</button>
      <!-- 这个按钮用于触发一个名为loadProducts的JavaScript函数，当用户点击这个按钮时，loadProducts函数会被执行。这个函数可能是用来从服务器加载产品数据并显示在页面上-->
    </div>

    <table class="table table-striped table-bordered">
      <thead>
      <tr>
        <th>商品ID</th>
        <th>商品名称</th>
        <th>商品种类</th>
        <th>价格</th>
        <th>库存数量</th>
        <th>图片</th>
        <th>操作</th>
      </tr>
      </thead>
      <tbody id="productList">
      <!-- 商品数据将通过 JavaScript 动态加载 -->
      </tbody>
    </table>

    <div class="text-center">
      <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addProductModal">添加商品</button>
    </div>
  </main>
</div>

<!-- 添加商品弹窗 -->
<div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="addProductModalLabel">添加商品</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="addProductForm" action="/product/add" enctype="multipart/form-data" method="post">
          <div class="mb-3">
            <label for="productName" class="form-label">商品名称</label>
            <input type="text" name="name" class="form-control" id="productName" required>
          </div>
          <div class="mb-3">
            <label for="productCategory" class="form-label">商品种类</label>
            <select id="productCategory" name="categoryId" class="form-control" required>
              <option value="">选择商品种类</option>
              <!-- 商品种类将通过 JavaScript 填充 -->
            </select>
          </div>
          <div class="mb-3">
            <label for="productPrice" class="form-label">价格</label>
            <input type="number" name="price" class="form-control" id="productPrice" required>
          </div>

          <div class="mb-3">
            <label for="productPrice" class="form-label">库存数量</label>
            <input type="number" name="number" class="form-control" id="productNumber" required>
          </div>


          <div class="mb-3">
            <label for="productImg" class="form-label">商品图片</label>
            <input type="file" name="img" class="form-control" id="productImg" accept="image/*" required>
          </div>
          <button type="submit" class="btn btn-primary">添加</button>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- 编辑商品弹窗 -->
<div class="modal fade" id="editProductModal" tabindex="-1" aria-labelledby="editProductModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="editProductModalLabel">编辑商品</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="editProductForm" enctype="multipart/form-data">
          <input type="hidden" id="editProductId">
          <div class="mb-3">
            <label for="editProductName" class="form-label">商品名称</label>
            <input type="text" class="form-control" id="editProductName" required>
          </div>
          <div class="mb-3">
            <label for="editProductCategory" class="form-label">商品种类</label>
            <select id="editProductCategory" class="form-control" required>
              <option value="">选择商品种类</option>
              <!-- 商品种类将通过 JavaScript 填充 -->
            </select>
          </div>
          <div class="mb-3">
            <label for="editProductPrice" class="form-label">价格</label>
            <input type="number" class="form-control" id="editProductPrice" required>
          </div>

          <div class="mb-3">
            <label for="editProductPrice" class="form-label">库存数量</label>
            <input type="number" class="form-control" id="editProductNumber" required>
          </div>


          <div class="mb-3">
            <label for="editProductImg" class="form-label">商品图片</label>
            <input type="file" class="form-control" id="editProductImg" accept="image/*">
          </div>
          <button type="submit" class="btn btn-primary">保存</button>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- 删除商品确认弹窗 -->
<div class="modal fade" id="deleteProductModal" tabindex="-1" aria-labelledby="deleteProductModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="deleteProductModalLabel">确认删除商品</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p>您确定要删除该商品吗？</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
        <button type="button" class="btn btn-danger" id="confirmDeleteProduct">删除</button>
      </div>
    </div>
  </div>
</div>

<!-- 引入 Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
  var selectedProductId = null;
  // 加载商品种类
  function loadCategories() {
    $.ajax({
      url: '/category/select',  // 获取所有商品种类的接口
      type: 'GET',
      success: function(data) {
        if (data && data.categories) {
          $('#productCategory').empty();  // 清空下拉框
          $('#editProductCategory').empty();
          $('#productCategory').append('<option value="">选择商品种类</option>');
          $('#editProductCategory').append('<option value="">选择商品种类</option>');
          data.categories.forEach(function(category) {
            $('#productCategory').append('<option value="' + category.id + '">' + category.name + '</option>');
            $('#editProductCategory').append('<option value="' + category.id + '">' + category.name + '</option>');
          });
        }
      },
      error: function() {
        alert('加载商品种类失败！');
      }
    });
  }

  // 加载商品数据
// 加载商品数据
function loadProducts() {
    var search = $('#searchProduct').val(); // 获取搜索框的值
    $.ajax({
        url: '/product/select', // 假设这个接口返回商品数据
        type: 'GET',
        data: { search: search }, // 传递搜索条件
        success: function (data) {
            if (data && data.products) {
                $('#productList').empty(); // 清空现有商品数据
                data.products.forEach(function (product) {
                    var row = '<tr>';
                    row += '<td>' + product.id + '</td>';
                    row += '<td>' + product.name + '</td>';
                    row += '<td>' + product.categoryName + '</td>'; // 仅显示种类名称
                    row += '<td>' + product.price + '</td>';
                    row += '<td>' + product.number + '</td>';
                    row += '<td><img src="' +'' +product.img + '" alt="' + product.name + '" width="50" height="50"></td>'; // 显示图片
                    row += '<td>';
                    row += '<button class="btn btn-warning btn-sm" onclick="editProduct(this)">编辑</button>'; // 传递当前行元素
                    row += '<button class="btn btn-danger btn-sm" onclick="deleteProduct(' + product.id + ')">删除</button>';
                    row += '</td>';
                    row += '</tr>';
                    $('#productList').append(row);
                });
            } else {
                alert('没有找到相关商品！');
            }
        },
        error: function () {
            alert('加载商品数据失败！');
        }
    });
}
// 编辑商品
function editProduct(button) {
    // 获取当前行的数据
    var row = $(button).closest('tr'); // 找到按钮所在的行
    var productId = row.find('td:nth-child(1)').text(); // 商品ID
    var productName = row.find('td:nth-child(2)').text(); // 商品名称
    var productCategoryName = row.find('td:nth-child(3)').text(); // 商品种类名称
    var productPrice = row.find('td:nth-child(4)').text(); // 商品价格

    var productNumber = row.find('td:nth-child(5)').text(); // 商品数量
    var productImgSrc = row.find('td:nth-child(6) img').attr('src'); // 商品图片路径

    // 填充模态框数据
    selectedProductId = productId; // 保存当前商品ID
    $('#editProductName').val(productName);
    $('#editProductCategory option').each(function () {
        if ($(this).text() === productCategoryName) {
            $(this).prop('selected', true);
        }
    });
    $('#editProductPrice').val(productPrice);
    $('#editProductNumber').val(productNumber);
    $('#editProductImg').val(''); // 清空文件输入框
    $('#editProductModal').modal('show');
}

// 保存编辑商品
$('#editProductForm').submit(function (e) {
    e.preventDefault();
    var formData = new FormData();
    formData.append('id', selectedProductId);
    formData.append('name', $('#editProductName').val());
    formData.append('categoryId', $('#editProductCategory').val());
    formData.append('price', $('#editProductPrice').val());
    formData.append('number', $('#editProductNumber').val());
    formData.append('img', $('#editProductImg')[0].files[0]);

    $.ajax({
        url: '/product/update',
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function () {
            alert('商品更新成功！');
            $('#editProductModal').modal('hide');
            loadProducts(); // 重新加载商品列表
        },
        error: function () {
            alert('更新商品失败！');
        }
    });
});



  // 删除商品
  function deleteProduct(id) {
    selectedProductId = id;
    $('#deleteProductModal').modal('show');
  }

  // 确认删除
  $('#confirmDeleteProduct').click(function() {
    $.ajax({
      url: '/product/delete',
      type: 'POST',
      data: { id: selectedProductId },
      success: function() {
        alert('商品删除成功！');
        $('#deleteProductModal').modal('hide');
        loadProducts();
      },
      error: function() {
        alert('删除商品失败！');
      }
    });
  });

  // 页面加载时，初始化商品列表和商品种类
  $(document).ready(function() {
    loadCategories();  // 加载商品种类
    loadProducts();  // 加载商品数据
  });
</script>

</body>
</html>
