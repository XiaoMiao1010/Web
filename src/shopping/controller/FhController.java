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

//减少库存的操作
@WebServlet("/fh")
public class FhController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Integer id = Integer.valueOf(request.getParameter("id"));
        String sql1 = "select * from `order` where id=" + id;
        String sql2 = "update `order` set ischeck=1 where id=" + id;
        ResultSet resultSet = BaseUtil.execQuerySql(sql1);
        String name1="",name2="";
        Integer quantity1=0;
        try {
            while (resultSet.next()) {
                 name1 = resultSet.getString("name");
                 name2 = resultSet.getString("tp");
                quantity1 = Integer.valueOf(resultSet.getString("quantity"));
            }
        }catch (Exception e){

        }

        String sql3 = "select * from product where name='"+name1+"' and category_name='"+name2+"'";
        ResultSet resultSet2 = BaseUtil.execQuerySql(sql3);
        Integer id2=0;
        Integer quantity=0;

        try {
            while (resultSet2.next()) {
                id2 = Integer.valueOf(resultSet2.getString("id"));
                quantity = Integer.valueOf(resultSet2.getString("number"));
            }
        }catch (Exception e){

        }

        String sql4 = "update product set number="+(quantity-quantity1)+" where id="+id2;

        if (quantity-quantity1<0){
            return;
        }

        int i = BaseUtil.execDMLSql(sql2);
        int o = BaseUtil.execDMLSql(sql4);

        response.sendRedirect("/order/select2");
    }


}
