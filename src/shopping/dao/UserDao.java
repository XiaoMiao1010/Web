package shopping.dao;


import shopping.constant.UserConstant;
import shopping.entity.User;
import shopping.util.BaseUtil;

import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {
    /**
     * 用户登录
     *
     * @param sql
     * @param username
     * @return
     */
    public User login(String sql, String username) {
        ResultSet resultSet = BaseUtil.execQuerySql(sql, username);
        try {
            if (resultSet.next()) {
                User user = new User(resultSet.getInt("id"),
                        resultSet.getString("username"),
                        resultSet.getString("password"));

                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean register(String sql, String username, String password) {
        return BaseUtil.execDMLSql(sql, username, password) > 0 ? true : false;
    }


}
