package shopping.controller;

import shopping.dao.GonggaoDao;
import shopping.entity.Gonggao;
import shopping.util.Uri;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/gonggao/*")
public class GonggaoController extends HttpServlet {


    private GonggaoDao userService=new GonggaoDao();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String urlPath = Uri.geturi(req);
        if ("select".equals(urlPath)) {
            select(req, resp);
        } else if ("delete".equals(urlPath)) {
            delete(req, resp);
        } else if ("update".equals(urlPath)) {
            update(req, resp);
        } else if ("add".equals(urlPath)) {
            add(req, resp);
        }else if("/selectnew".equals(urlPath)) {
            selectnew(req, resp);
        }
    }

    private void selectnew(HttpServletRequest req, HttpServletResponse resp) {
        Gonggao gonggao = userService.selectnew("select * from gonggao order by createtime desc limit 1");
    }

    private void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        userService.addGonggao("INSERT INTO gonggao(title,content) values(?,?)",username, password);
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Integer id = Integer.valueOf(req.getParameter("id"));
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        userService.updateGonggao("update gonggao set title = ?,content = ? where id = ?",id, username, password);
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp) {
        Integer id = Integer.valueOf(req.getParameter("id"));
        userService.deleteGonggao("delete from gonggao where id = ?",id);
    }

//先查询所有的公告，再使用 PrintWriter 对象将构建好的JSON字符串写入响应流，从而发送给客户端。
   private void select(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // 获取数据库连接并查询所有用户
        List<Gonggao> users = userService.findAllGonggaos("select * from gonggao");
        // 手动拼接 JSON 数据
        StringBuilder jsonResponse = new StringBuilder();
        jsonResponse.append("{\n");
        jsonResponse.append("  \"users\": [\n");
        // 遍历 List<User> 拼接 JSON 数据
        for (int i = 0; i < users.size(); i++) {
            Gonggao user = users.get(i);
            jsonResponse.append("    {\n");
            jsonResponse.append("      \"id\": ").append(user.getId()).append(",\n");
            jsonResponse.append("      \"username\": \"").append(user.getTitle()).append("\",\n");
            jsonResponse.append("      \"password\": \"").append(user.getContent()).append("\"\n");
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


}
