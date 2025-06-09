package shopping.controller;

import shopping.entity.User;
import shopping.service.UserService;
import shopping.util.Uri;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/*")
public class UserController extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String urlPath = Uri.geturi(req);
        if ("login".equals(urlPath)) {
            login(req, resp);
        } else if ("register".equals(urlPath)) {
            register(req, resp);
        } else if ("select".equals(urlPath)) {
            select(req, resp);
        } else if ("delete".equals(urlPath)) {
            delete(req, resp);
        } else if ("update".equals(urlPath)) {
            update(req, resp);
        } else if ("add".equals(urlPath)) {
            add(req, resp);
        }
    }
    private void add(HttpServletRequest req, HttpServletResponse resp) {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        userService.register(username, password);
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) {
        String id = req.getParameter("id");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        userService.updateUser(id, username, password);
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp) {
        String id = req.getParameter("id");
        userService.deleteById(id);
    }

    private void select(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // 获取数据库连接并查询所有用户
        List<User> users = userService.getAllUsers();

        // 手动拼接 JSON 数据
        StringBuilder jsonResponse = new StringBuilder();
        jsonResponse.append("{\n");
        jsonResponse.append("  \"users\": [\n");

        // 遍历 List<User> 拼接 JSON 数据
        for (int i = 0; i < users.size(); i++) {
            User user = users.get(i);
            jsonResponse.append("    {\n");
            jsonResponse.append("      \"id\": ").append(user.getId()).append(",\n");
            jsonResponse.append("      \"username\": \"").append(user.getUsername()).append("\",\n");
            jsonResponse.append("      \"password\": \"").append(user.getPassword()).append("\"\n");
            jsonResponse.append("    }");

            // 如果不是最后一个元素，添加逗号
            if (i < users.size() - 1) {
                jsonResponse.append(",");
            }

            jsonResponse.append("\n");
        }

        jsonResponse.append("  ]\n");
        jsonResponse.append("}");

        // 设置响应内容类型为 JSON
        resp.setContentType("application/json;charset=UTF-8");

        // 返回 JSON 数据
        resp.getWriter().write(jsonResponse.toString());
    }
    private void login(HttpServletRequest req, HttpServletResponse resp) {
        try {
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            User user = userService.login(username, password);
            req.setAttribute("succeed", "succeed");
            user.setPassword("********");
            req.getSession().setAttribute("user", user);
            resp.sendRedirect("/index");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            try {
                req.getRequestDispatcher("/log_in.jsp").forward(req, resp);
            } catch (ServletException ex) {
                ex.printStackTrace();
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }

    private void register(HttpServletRequest req, HttpServletResponse resp) {
        try {
            String username = req.getParameter("username");
            String password1 = req.getParameter("password1");
            String password2 = req.getParameter("password2");
            if (!password1.equals(password2)) {
                req.setAttribute("error", "俩次密码不一致");
                req.getRequestDispatcher("/log_in.jsp").forward(req, resp);
                return;
            }
            String success = userService.register(username, password1);
            req.setAttribute("succeed", success);
            req.getRequestDispatcher("/log_in.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            try {
                req.getRequestDispatcher("/log_in.jsp").forward(req, resp);
            } catch (ServletException ex) {
                ex.printStackTrace();
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }

}
