package shopping.constant;

public class UserConstant {

    public static final String LOGIN_SQL = "SELECT * FROM user WHERE username = ?";
    public static final String REGISTER_SQL = "INSERT INTO user(username,password) values(?,?)";
}
