package shopping.controller;

import shopping.entity.Product;
import shopping.util.BaseUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/CategoryServlet")
public class CategoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取商品种类
        String categoryName = request.getParameter("category");

        // 根据商品种类加载相关商品
        String sql = "SELECT id, name,img, price, category_id,category_name,number FROM product";
        // mysql链接
        //filter 方法用于筛选出 categoryName 属性与请求中提供的商品种类名称相匹配的商品。
        //collect 方法将过滤后的结果收集到一个新的列表 list 中。
        List<Product> products = BaseUtil.getAllProduct(sql);
        List<Product> list = products.stream().filter(product -> product.getCategoryName().equals(categoryName)).collect(Collectors.toList());
        // 将商品数据传递到 JSP 页面
        request.setAttribute("products", list);
        request.getRequestDispatcher("/productList.jsp").forward(request, response);
    }
}
