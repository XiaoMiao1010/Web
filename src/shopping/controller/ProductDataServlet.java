package shopping.controller;

import shopping.entity.BarData;
import shopping.util.BaseUtil;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.ArrayList;

@WebServlet("/getProductData")
public class ProductDataServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        //表示响应的内容将是JSON格式的数据。
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        String sql = "SELECT category_name as categoryName, COUNT(*) AS productCount, GROUP_CONCAT(name) AS productNames\n" +
                "FROM product\n" +
                "GROUP BY category_name;\n";

        ResultSet resultSet = BaseUtil.execQuerySql(sql);
        //获取结果集 resultSet
        ArrayList<BarData> list = new ArrayList<>();
        //创建了一个名为 list 的变量，它是一个空的 ArrayList，专门用于存储 BarData 类型的对象。
        try {
            while (resultSet.next()) {
                String categoryName = resultSet.getString("categoryName");
                String productNames = resultSet.getString("productNames");
                Integer productCount = resultSet.getInt("productCount");
                BarData barData = new BarData(categoryName, productNames, productCount);
                list.add(barData);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 手动拼接 JSON 数据
        StringBuilder jsonBuilder = new StringBuilder();
        jsonBuilder.append("[");
        for (int i = 0; i < list.size(); i++) {
            BarData barData = list.get(i);
            jsonBuilder.append("{")
                .append("\"categoryName\":\"").append(barData.getCategoryName()).append("\",")
                .append("\"productNames\":\"").append(barData.getProductNames()).append("\",")
                .append("\"productCount\":").append(barData.getProductCount())
                .append("}");

            if (i < list.size() - 1) {
                jsonBuilder.append(",");
            }
        }
        jsonBuilder.append("]");

        // 输出 JSON 数据到前端
        out.print(jsonBuilder.toString());
        out.flush();
    }
}
