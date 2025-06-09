package shopping.controller;

import shopping.entity.BarData;
import shopping.util.BaseUtil;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/getPD")
public class getPD extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        String sql = "SELECT category_name as categoryName, COUNT(*) AS productCount, GROUP_CONCAT(name) AS productNames\n" +
                "FROM product\n" +
                "GROUP BY category_name;\n";
        String sql1 = "select sum(quantity) as quantity,tp from `order` group by tp";
        ResultSet resultSet = BaseUtil.execQuerySql(sql1);
        ArrayList<String> list1 = new ArrayList<>(); // 名称
        ArrayList<Integer> list2 = new ArrayList<>(); // 数量
        try {
            while (resultSet.next()) {
                String quantity = resultSet.getString("quantity");
                String tp = resultSet.getString("tp");
                list1.add(tp);
                list2.add(Integer.parseInt(quantity));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        HashMap<String, Object> hashMap = new HashMap<>();
        hashMap.put("names", list1);
        hashMap.put("counts", list2);

        String toJson = convertToJson(hashMap);

        // 输出 JSON 数据到前端
        out.print(toJson);
        out.flush();
    }





    public static String convertToJson(Map<String, Object> map) {
        StringBuilder json = new StringBuilder("{");
        boolean isFirst = true;

        for (Map.Entry<String, Object> entry : map.entrySet()) {
            if (!isFirst) {
                json.append(", ");
            }
            isFirst = false;

            String key = entry.getKey();
            Object value = entry.getValue();

            json.append("\"").append(key).append("\": ");

            if (value instanceof List) {
                json.append(convertToJsonArray((List<?>) value));
            } else {
                // 这里只处理了简单的类型，对于更复杂的类型需要扩展
                throw new IllegalArgumentException("Unsupported value type: " + value.getClass().getName());
            }
        }

        json.append("}");
        return json.toString();
    }

    private static String convertToJsonArray(List<?> list) {
        StringBuilder jsonArray = new StringBuilder("[");
        boolean isFirst = true;

        for (Object item : list) {
            if (!isFirst) {
                jsonArray.append(", ");
            }
            isFirst = false;

            if (item instanceof String) {
                jsonArray.append("\"").append(item).append("\"");
            } else if (item instanceof Number) {
                jsonArray.append(item);
            } else {
                // 对于非字符串和非数字类型，这里简单处理为null，或者您可以抛出异常
                jsonArray.append("null");
            }
        }

        jsonArray.append("]");
        return jsonArray.toString();
    }

}
