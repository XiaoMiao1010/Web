package shopping.controller;

import shopping.entity.Category;
import shopping.entity.User;
import shopping.service.CategoryService;
import shopping.util.Uri;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/category/*")
public class CategoryController extends HttpServlet {
    private CategoryService categoryService = new CategoryService();

    @Override//逻辑是通过获取url来判断操作， req=请求 resp是响应
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String urlPath = Uri.geturi(req);
        if ("add".equals(urlPath)) {
            addCategory(req, resp);
        } else if ("select".equals(urlPath)) {
            selectCategory(req, resp);
        } else if ("delete".equals(urlPath)) {
            deleteCategory(req, resp);
        }  else if ("edit".equals(urlPath)) {
            editCategory(req, resp);
        }
    }

    private void editCategory(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        categoryService.editCategory(id, req.getParameter("name"));
    }//categoryService 的 editCategory 方法，传入分类的ID和新名称。

    private void deleteCategory(HttpServletRequest req, HttpServletResponse resp) {
        String id = req.getParameter("id");
        categoryService.deleteById(id);
    }//调用categoryService的deleteById方法，通过id删除
//
    //先通过查询获取输入的名字，然后通过遍历，最后再将数据输出客户端
    private void selectCategory(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        //获取名字
        String name = req.getParameter("search");
        List<Category> list = categoryService.getallCategory(name);
        // 设置响应内容类型为 JSON
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        // 开始拼接 JSON 字符串
        StringBuilder jsonResponse = new StringBuilder();
        jsonResponse.append("{ \"categories\": [");
        for (int i = 0; i < list.size(); i++) {
            Category category = list.get(i);
            jsonResponse.append("{");
            jsonResponse.append("\"id\": ").append(category.getId()).append(",");
            jsonResponse.append("\"name\": \"").append(category.getName()).append("\"");
            jsonResponse.append("}");
            // 如果不是最后一个元素，添加逗号
            if (i < list.size() - 1) {
                jsonResponse.append(",");
            }
        }

        jsonResponse.append("]}");

        // 将 JSON 数据写入响应流
        resp.getWriter().write(jsonResponse.toString());
    }

    private void addCategory(HttpServletRequest req, HttpServletResponse resp) {
        String name = req.getParameter("name");
        categoryService.addCategory(name);
    }//调用方法 加入商品
}
