package shopping.dao;

import shopping.constant.OrderConstant;
import shopping.entity.Order;
import shopping.util.BaseUtil;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;


public class OrderDao {

    public boolean insertBath(String sql, List<Order> orderList) {
        if (null == orderList || orderList.size() == 0) {
            return true;
            //如果 orderList 是 null 或者列表大小为 0，表示没有数据需要插入，方法直接返回 true。
        }
        orderList.stream().forEach(order -> {
            BaseUtil.execDMLSql(sql, order.getUid(), order.getName(),
                    order.getPrice(), order.getQuantity(), order.getTotlel(), order.getImg(), order.getStatus(),
                    order.getAddress(), order.getPhone(),
                    order.getUsername(),order.getTp());
        });
        return true;
    }

    public List<Order> selectByUserId(Integer uid) {
        List<Order> orderList = new CopyOnWriteArrayList<>();
        try {
            ResultSet resultSet = BaseUtil.execQuerySql(OrderConstant.ORDER_SELECT_BY_USER_ID, uid);
            while (resultSet.next()) {
                Order order = new Order(resultSet.getInt("id"), resultSet.getInt("uid"),
                        resultSet.getString("name"), resultSet.getBigDecimal("price"),
                        resultSet.getInt("quantity"), resultSet.getBigDecimal("totle"),
                        resultSet.getString("img"), resultSet.getInt("status"),
                        resultSet.getString("address"), resultSet.getString("phone"),
                        resultSet.getString("username"), resultSet.getString("create_time"),
                        resultSet.getString("tp"));
                orderList.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderList;
    }
}
