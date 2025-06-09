package shopping.controller;

import shopping.entity.User;
import shopping.util.Uri;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/administrator/*")
public class AdminController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String urlPath = Uri.geturi(req);
        if ("login".equals(urlPath)) {
            login(req, resp);
        } else if ("logout".equals(urlPath)) {
            logout(req, resp);

        }
    }
//退出管理员的逻辑调用 HttpServletRequest 对象的 getSession() 方法来获取当前请求的会话（session）。
//removeAttribute("admin") 方法从会话中移除名为 "admin" 的属性。从而结束用户的登录状态。
    private void logout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.getSession().removeAttribute("admin");
        resp.sendRedirect("/admin/login.jsp");
    }//调用 HttpServletResponse 对象的 sendRedirect 方法，将浏览器重定向到 /admin/login.jsp 路径。

    public void login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        //这两行代码从请求中获取名为 "username" 和 "password" 的参数
        User user = new User();
        //创建了一个新的 User 对象，用于存储用户信息
        if ("admin".equals(username) && "admin".equals(password)) {
            user.setUsername(username);
            user.setPassword(password);
            req.getSession().setAttribute("admin", user);
            resp.sendRedirect("/admin/index.jsp");
            return;
        }
        req.setAttribute("msg", "用户名或密码错误");
        req.getRequestDispatcher("/admin/login.jsp").forward(req, resp);
    }
}
//如果用户名和密码不正确，将错误消息 "用户名或密码错误" 设置到请求属性 "msg" 中。
//然后，使用 req.getRequestDispatcher("/admin/login.jsp").forward(req, resp) 将请求转发回登录页面 /admin/login.jsp。
//转发请求意味着服务器端跳转，浏览器的地址栏不会改变，用户仍然停留在登录页面，并且可以看到错误消息。
