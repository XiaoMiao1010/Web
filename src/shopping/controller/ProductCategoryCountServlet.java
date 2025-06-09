package shopping.controller;

import shopping.util.BaseUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/ProductCategoryCountServlet")
public class ProductCategoryCountServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        // SQL 查询语句，获取每个商品种类的商品数量
        String sql = "SELECT category_name AS categoryName, COUNT(*) AS productCount FROM product GROUP BY category_name";
        ResultSet resultSet = BaseUtil.execQuerySql(sql);
//调用 BaseUtil.execQuerySql 方法执行SQL查询，并获取结果集 resultSet。
        // 开始拼接 JSON 字符串
        StringBuilder jsonResponse = new StringBuilder();
        jsonResponse.append("[");

        try {
            boolean first = true;
            while (resultSet.next()) {
                // 拼接每一项数据
                if (!first) {
                    jsonResponse.append(",");
                    //是否添加都好
                } else {
                    first = false;
                }

                String categoryName = resultSet.getString("categoryName");
                int productCount = resultSet.getInt("productCount");

                // 拼接当前条目的 JSON 对象
                jsonResponse.append("{")
                        .append("\"categoryName\":\"").append(categoryName).append("\",")
                        .append("\"productCount\":").append(productCount)
                        .append("}");
                //将提取的数据格式化为一个JSON对象，并追加到jsonResponse中。
                //每个键值对都被花括号{}包围，键和值之间用冒号:分隔，字符串值用双引号"包围。
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 结束拼接 JSON 数组
        jsonResponse.append("]");

        // 输出拼接好的 JSON 字符串
        out.print(jsonResponse.toString());
    }


}

