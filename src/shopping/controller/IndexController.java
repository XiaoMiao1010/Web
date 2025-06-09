package shopping.controller;

import shopping.entity.Category;
import shopping.entity.Product;
import shopping.util.BaseUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

//Servlet的主要作用是从数据库中查询商品种类的信息，并将这些信息传递到前端页面中显示
@WebServlet("/index")
public class IndexController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String sql = "SELECT id, name from category";
        List<Category> categories = new ArrayList<>();
        //创建一个 ArrayList 对象 categories，用于存储查询结果。
        ResultSet resultSet = BaseUtil.execQuerySql(sql);
        //调用 BaseUtil.execQuerySql 方法执行SQL查询，并获取结果集 resultSet。
        try {
            while (resultSet.next()) {
                Category category = new Category();
                category.setId(resultSet.getInt("id"));
                category.setName(resultSet.getString("name"));
                categories.add(category);
                //将每个 Category 对象添加到 categories 列表中。
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.getSession().setAttribute("categories", categories);
        request.getRequestDispatcher("/homepage.jsp").forward(request, response);
    }
}

//setAttribute 是一个在 Java Servlet API 中的方法，它属于 HttpServletRequest 和 HttpSession 接口。这个方法用于将属性（键值对）绑定到请求或会话对象上。这些属性可以在后续的请求处理或会话中被检索和使用。