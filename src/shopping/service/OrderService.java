package shopping.service;

import shopping.constant.OrderConstant;
import shopping.dao.OrderDao;
import shopping.entity.Order;
import shopping.util.BaseUtil;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

public class OrderService {

    private OrderDao orderDao = new OrderDao();

    public boolean insertBath(List<Order> orderList) {
        return orderDao.insertBath(OrderConstant.ORDER_INSERT, orderList);
    }

    public List<Order> selectByUserId(Integer uid) {
        return orderDao.selectByUserId(uid);
    }

    public List<Order> selectAllOrders() {
        String sql = "select *  from `order`";
        List<Order> orderList = new CopyOnWriteArrayList<>();
        try {
            ResultSet resultSet = BaseUtil.execQuerySql(sql);
            while (resultSet.next()) {
                Order order = new Order(resultSet.getInt("id"), resultSet.getInt("uid"),
                        resultSet.getString("name"), resultSet.getBigDecimal("price"),
                        resultSet.getInt("quantity"), resultSet.getBigDecimal("totle"),
                        resultSet.getString("img"), resultSet.getInt("status"),
                        resultSet.getString("address"), resultSet.getString("phone"),
                        resultSet.getString("username"), resultSet.getString("create_time"),
                        resultSet.getString("tp"));
                order.setIscheck(resultSet.getInt("ischeck"));
                orderList.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderList;
    }

    public static void main(String[] args) {
        OrderService orderService = new OrderService();
        System.out.println(orderService.selectAllOrders());
    }
}
