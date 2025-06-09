package shopping.util;

import shopping.entity.Category;
import shopping.entity.Product;
import shopping.entity.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class BaseUtil {
    private static Connection connection;
    private static PreparedStatement preparedStatement;
    private static ResultSet resultSet;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try {
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/shopping?allowPublicKeyRetrieval=true&allowPublicKeyRetrieval=true&serverTimezone=Hongkong&useUnicode=true&characterEncoding=utf8&useSSL=false",
                        "root", "M18219264769a");
                System.out.println("数据库驱动连接成功");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static ResultSet execQuerySql(String sql, Object... obj) {
        try {
            preparedStatement = connection.prepareStatement(sql);
            for (int i = 0; i < obj.length; i++) {
                preparedStatement.setObject(i + 1, obj[i]);
            }
            return preparedStatement.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static int execDMLSql(String sql, Object... obj) {
        try {
            preparedStatement = connection.prepareStatement(sql);
            for (int i = 0; i < obj.length; i++) {
                preparedStatement.setObject(i + 1, obj[i]);
            }
            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }


    //关闭数据库
    public static void close(Connection con, PreparedStatement ps, ResultSet rs) throws SQLException {
        if (rs != null) {
            rs.close();
        }
        if (ps != null) {
            ps.close();
        }
        if (con != null) {
            con.close();
        }
    }

    public static void main(String[] args) {
//        System.out.println(getAllCategory("select * from category"));
//        System.out.println(getallUser("select * from user"));
    }

    public static List<Category> getAllCategory(String sql) {
        List<Category> list = new ArrayList<>();
        try {
            resultSet = execQuerySql(sql);
            while (resultSet.next()) {
                list.add(new Category(resultSet.getInt("id"), resultSet.getString("name")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static List<User> getallUser(String sql) {
        List<User> list = new ArrayList<>();
        try {
            resultSet = execQuerySql(sql);
            while (resultSet.next()) {
                list.add(new User(resultSet.getInt("id"), resultSet.getString("username"), resultSet.getString("password")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static Product getProductById(String sql, int id) {
        Product product = null;
        try {
            resultSet = execQuerySql(sql, id);
            while (resultSet.next()) {
                product = new Product(resultSet.getInt("id"), resultSet.getString("name"), resultSet.getInt("price"), resultSet.getString("img"), resultSet.getInt("categoryId"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return product;

    }

    public static String getCategoryNameById(String sql) {
        String name = null;
        try {
            resultSet = execQuerySql(sql);
            while (resultSet.next()) {
                name = resultSet.getString("name");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return name;
    }

    public static List<Product> getAllProduct(String sql)  {
        // 获取新连接试试
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        List<Product> list = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/shopping?allowPublicKeyRetrieval=true&serverTimezone=Hongkong&useUnicode=true&characterEncoding=utf8&useSSL=false",
                    "root", "M18219264769a");
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Product product = new Product();
                product.setId(resultSet.getInt("id"));
                product.setName(resultSet.getString("name"));
                product.setPrice(resultSet.getInt("price"));
                product.setImg(resultSet.getString("img"));
                product.setCategoryId(resultSet.getInt("category_id"));
                product.setCategoryName(resultSet.getString("category_name"));
                product.setNumber(Integer.valueOf(resultSet.getString("number")));
                list.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
        }

}
