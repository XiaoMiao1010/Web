package shopping.service;

import shopping.constant.UserConstant;
import shopping.dao.UserDao;
import shopping.entity.User;
import shopping.util.BaseUtil;

import java.util.List;

public class UserService {
    private UserDao userDao = new UserDao();

    public User login(String username, String password) {
        User user = userDao.login(UserConstant.LOGIN_SQL, username);
        if (null == user) {
            throw new RuntimeException("此用户不存在");
        }
        if (user.getPassword().equals(password)) {
            return user;
        }
        throw new RuntimeException("账号或者密码错误");
    }


    public String register(String username, String password) {
        User user = userDao.login(UserConstant.LOGIN_SQL, username);
        if (null != user) {
            throw new RuntimeException("用户名已存在");
        }
        boolean insert = userDao.register(UserConstant.REGISTER_SQL, username, password);
        if (insert) {
            return "注册成功";
        }
        throw new RuntimeException("注册失败");

    }

    public List<User> getAllUsers() {

        return BaseUtil.getallUser("select * from user");
    }

    public void deleteById(String id) {
        BaseUtil.execDMLSql("delete from user where id = ?", id);
    }

    public static void main(String[] args) {
        UserService userService = new UserService();
        userService.deleteById("12");
    }

    public void updateUser(String id, String username, String password) {
        BaseUtil.execDMLSql("update user set username = ?,password = ? where id = ?", username, password, id);
    }
}
