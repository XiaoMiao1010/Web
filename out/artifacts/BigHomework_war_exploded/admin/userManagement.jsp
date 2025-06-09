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
    <title>用户管理</title>
    <!-- 引入 Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid">
    <header class="d-flex justify-content-between align-items-center py-3 bg-dark text-white">
        <div class="logo">
            <img src="../images/logo.png" alt="Logo" width="50" height="50"/>
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
        <h2 class="text-center mb-4">用户管理</h2>

        <!-- 添加用户按钮 -->
        <button class="btn btn-primary mb-3" id="addUserBtn" data-bs-toggle="modal" data-bs-target="#addUserModal">
            添加用户
        </button>

        <!-- 用户列表表格 -->
        <table class="table table-striped table-bordered">
            <thead>
            <tr>
                <th>用户ID</th>
                <th>用户名</th>
                <th>密码</th> <!-- 添加密码列 -->
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="userList">
            <!-- 用户数据将通过 JavaScript 动态加载 -->
            </tbody>
        </table>
    </main>
</div>

<!-- 添加用户弹窗 -->
<div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addUserModalLabel">添加用户</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="addUserForm">
                    <div class="mb-3">
                        <label for="addUsername" class="form-label">用户名</label>
                        <input type="text" class="form-control" id="addUsername" required>
                    </div>
                    <div class="mb-3">
                        <label for="addPassword" class="form-label">密码</label>
                        <input type="password" class="form-control" id="addPassword" required>
                    </div>
                    <button type="submit" class="btn btn-primary">添加</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 修改用户弹窗 -->
<div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editUserModalLabel">修改用户</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editUserForm">
                    <input type="hidden" id="editUserId">
                    <div class="mb-3">
                        <label for="editUsername" class="form-label">用户名</label>
                        <input type="text" class="form-control" id="editUsername" required>
                    </div>
                    <div class="mb-3">
                        <label for="editPassword" class="form-label">密码</label>
                        <input type="password" class="form-control" id="editPassword" required>
                    </div>
                    <button type="submit" class="btn btn-primary">修改</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 删除确认框 -->
<div class="modal fade" id="deleteUserModal" tabindex="-1" aria-labelledby="deleteUserModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteUserModalLabel">删除确认</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>确定要删除该用户吗？</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" id="confirmDeleteBtn">删除</button>
            </div>
        </div>
    </div>
</div>

<!-- 引入 jQuery 和 Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

<script>
    $(document).ready(function () {
        // 页面加载时请求Servlet加载用户列表
        loadUsers();

        // 添加用户提交表单
        $('#addUserForm').submit(function (event) {
            event.preventDefault();
            const username = $('#addUsername').val();
            const password = $('#addPassword').val();
            $.ajax({
                url: '/user/add',  // 添加用户的Servlet路径
                type: 'POST',
                data: {username: username, password: password},
                success: function (response) {
                    $('#addUserModal').modal('hide');
                    loadUsers(); // 重新加载用户列表
                },
                error: function () {
                    alert('添加用户失败！');
                }
            });
        });

        // 修改用户提交表单
        $('#editUserForm').submit(function (event) {
            event.preventDefault();
            const userId = $('#editUserId').val();
            const username = $('#editUsername').val();
            const password = $('#editPassword').val();
            $.ajax({
                url: '/user/update',  // 更新用户的Servlet路径
                type: 'POST',
                data: {id: userId, username: username, password: password},
                success: function (response) {
                    $('#editUserModal').modal('hide');
                    loadUsers(); // 重新加载用户列表
                },
                error: function () {
                    alert('修改用户失败！');
                }
            });
        });

        // 删除用户确认
        $('#confirmDeleteBtn').click(function () {
            if (selectedUserId != null) {
                $.ajax({
                    url: '/user/delete',  // 删除用户的Servlet路径
                    type: 'POST',
                    data: {id: selectedUserId},
                    success: function (response) {
                        $('#deleteUserModal').modal('hide');
                        loadUsers(); // 重新加载用户列表
                    },
                    error: function () {
                        alert('删除用户失败！');
                    }
                });
            }
        });
    });

    // 加载用户列表
    function loadUsers() {
        $.ajax({
            url: '/user/select',
            type: 'GET',
            success: function (data) {
                console.log(data);  // 输出返回的完整数据，确保数据返回正确

                if (data && data.users) {
                    $('#userList').empty();  // 清空现有的用户列表

                    // 如果返回的用户列表为空
                    if (data.users.length === 0) {
                        $('#userList').append('<tr><td colspan="4" class="text-center">暂无用户</td></tr>');
                    }

                    // 渲染用户列表
                    data.users.forEach(function (user) {
                        var row = '<tr>';
                        row += '<td>' + user.id + '</td>';
                        row += '<td>' + user.username + '</td>';
                        row += '<td>' + user.password + '</td>';  // 显示密码
                        row += '<td>';
                        row += '<button class="btn btn-warning btn-sm" onclick="editUser(' + user.id + ', \'' + user.username + '\', \'' + user.password + '\')">修改</button>';
                        row += '<button class="btn btn-danger btn-sm" onclick="confirmDelete(' + user.id + ')">删除</button>';
                        row += '</td>';
                        row += '</tr>';

                        $('#userList').append(row);
                    });
                } else {
                    alert('没有返回用户数据');
                }
            },
            error: function () {
                alert('加载用户数据失败！');
            }
        });
    }

    // 编辑用户
    function editUser(id, username, password) {
        $('#editUserId').val(id);
        $('#editUsername').val(username);
        $('#editPassword').val(password);
        $('#editUserModal').modal('show');
    }

    // 确认删除
    function confirmDelete(id) {
        selectedUserId = id;
        $('#deleteUserModal').modal('show');
    }
</script>

</body>
</html>
