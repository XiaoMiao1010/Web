package shopping.dao;

import shopping.entity.Car;
import shopping.entity.User;
import shopping.util.BaseUtil;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

public class CarDao {

    public boolean addCar(String sql, Integer userId, String name,
                          BigDecimal price, String img, Integer quantity,String tp) {
        return BaseUtil.execDMLSql(sql, userId, name, price, img, quantity,tp) > 0 ? true : false;
    }//方法名 addCar 表示添加汽车的操作。
    //参数包括一个SQL语句字符串 sql 和一些汽车属性的参数。

    public List<Car> selectByUserId(String sql, Integer userId) {
        ResultSet resultSet = BaseUtil.execQuerySql(sql, userId);
        try {
            List<Car> carList = new CopyOnWriteArrayList<>();
            while (resultSet.next()) {
                Car car = new Car(resultSet.getInt("id"), resultSet.getInt("uid"),
                        resultSet.getString("name"),
                        resultSet.getBigDecimal("price"),
                        resultSet.getString("img"),
                        resultSet.getInt("quantity"),
                        resultSet.getString("tp"));
                carList.add(car);
            }
            return carList;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateCar(String sql, Integer id, Integer userId, String name) {
        return BaseUtil.execDMLSql(sql, id, userId, name) > 0 ? true : false;
    }

    public boolean deleteById(String sql, Integer id) {
        return BaseUtil.execDMLSql(sql, id) > 0 ? true : false;
    }
}

//数据访问对象（DAO）类