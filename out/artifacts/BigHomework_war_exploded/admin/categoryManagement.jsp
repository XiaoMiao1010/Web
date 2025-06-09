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
  <title>商品种类管理</title>
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
    <h2 class="text-center mb-4">商品种类管理</h2>

    <!-- 搜索框 -->
    <div class="mb-4 text-center">
      <input type="text" id="searchCategory" class="form-control w-50 mx-auto" placeholder="搜索商品种类">
      <button class="btn btn-primary mt-2" onclick="loadCategories()">搜索</button>
    </div>

    <table class="table table-striped table-bordered">
      <thead>
      <tr>
        <th>种类ID</th>
        <th>种类名称</th>
        <th>操作</th>
      </tr>
      </thead>
      <tbody id="categoryList">
      <!-- 商品种类数据将通过 JavaScript 动态加载 -->
      </tbody>
    </table>
    <div class="text-center">
      <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCategoryModal">添加种类</button>
    </div>
  </main>
</div>

<!-- 添加商品种类弹窗 -->
<div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="addCategoryModalLabel">添加商品种类</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="addCategoryForm">
          <div class="mb-3">
            <label for="categoryName" class="form-label">种类名称</label>
            <input type="text" class="form-control" id="categoryName" required>
          </div>
          <button type="submit" class="btn btn-primary">添加</button>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- 编辑商品种类弹窗 -->
<div class="modal fade" id="editCategoryModal" tabindex="-1" aria-labelledby="editCategoryModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="editCategoryModalLabel">编辑商品种类</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="editCategoryForm">
          <div class="mb-3">
            <label for="editCategoryName" class="form-label">种类名称</label>
            <input type="text" class="form-control" id="editCategoryName" required>
          </div>
          <button type="submit" class="btn btn-primary">保存</button>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- 删除确认弹窗 -->
<div class="modal fade" id="deleteCategoryModal" tabindex="-1" aria-labelledby="deleteCategoryModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="deleteCategoryModalLabel">确认删除</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p>您确定要删除该商品种类吗？</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
        <button type="button" class="btn btn-danger" id="confirmDeleteCategory">删除</button>
      </div>
    </div>
  </div>
</div>

<!-- 引入 Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
  let selectedCategoryId = null;

  $(document).ready(function() {
    // 页面加载时请求Servlet加载商品种类列表
    loadCategories();

    // 添加商品种类表单提交
    $('#addCategoryForm').submit(function(event) {
      event.preventDefault();
      const categoryName = $('#categoryName').val();
      $.ajax({
        url: '/category/add',
        type: 'POST',
        data: { name: categoryName },
        success: function(response) {
          $('#addCategoryModal').modal('hide');
          loadCategories(); // 重新加载商品种类列表
        },
        error: function() {
          alert('添加商品种类失败！');
        }
      });
    });

    // 编辑商品种类表单提交
    $('#editCategoryForm').submit(function(event) {
      event.preventDefault();
      const categoryName = $('#editCategoryName').val();
      $.ajax({
        url: '/category/edit',
        type: 'POST',
        data: { id: selectedCategoryId, name: categoryName },
        success: function(response) {
          $('#editCategoryModal').modal('hide');
          loadCategories(); // 重新加载商品种类列表
        },
        error: function() {
          alert('编辑商品种类失败！');
        }
      });
    });

    // 删除商品种类
    $('#confirmDeleteCategory').click(function() {
      if (selectedCategoryId != null) {
        $.ajax({
          url: '/category/delete',
          type: 'POST',
          data: { id: selectedCategoryId },
          success: function(response) {
            $('#deleteCategoryModal').modal('hide');
            loadCategories(); // 重新加载商品种类列表
          },
          error: function() {
            alert('删除商品种类失败！');
          }
        });
      }
    });
  });

  // 加载商品种类列表
  function loadCategories() {
    const search = $('#searchCategory').val();  // 获取搜索框的值
    $.ajax({
      url: '/category/select',  // 请求商品种类列表的路径
      type: 'GET',
      data: { search: search },  // 将搜索值作为参数传递
      success: function(data) {
        console.log(data);  // 打印返回的商品种类数据
        if (data && data.categories) {
          $('#categoryList').empty(); // 清空现有数据
          data.categories.forEach(function(category) {
            var row = '<tr>';
            row += '<td>' + category.id + '</td>';
            row += '<td>' + category.name + '</td>';
            row += '<td>';
            row += '<button class="btn btn-warning btn-sm" onclick="editCategory(' + category.id + ')">编辑</button>';
            row += '<button class="btn btn-danger btn-sm" onclick="confirmDelete(' + category.id + ')">删除</button>';
            row += '</td>';
            row += '</tr>';
            $('#categoryList').append(row);
          });
        } else {
          alert('没有返回商品种类数据');
        }
      },
      error: function() {
        alert('加载商品种类数据失败！');
      }
    });
  }

  // 编辑商品种类
  function editCategory(id) {
    // 从当前行获取种类名称
    const row = $('#categoryList').find('tr').filter(function() {
      return $(this).find('td').eq(0).text() == id;
    });

    const categoryName = row.find('td').eq(1).text();  // 获取当前行的种类名称

    // 将数据填充到编辑模态框中
    $('#editCategoryName').val(categoryName);
    selectedCategoryId = id;  // 设置选中的种类ID
    $('#editCategoryModal').modal('show');  // 显示模态框
  }


  // 确认删除
  function confirmDelete(id) {
    selectedCategoryId = id;
    $('#deleteCategoryModal').modal('show');
  }
</script>

</body>
</html>
