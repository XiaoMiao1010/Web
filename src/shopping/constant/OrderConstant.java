package shopping.constant;

public class OrderConstant {

    public static final String ORDER_INSERT = "INSERT INTO `order` (`uid`, `name`, `price`,`quantity`,`totle`, `img`,`status`, `address`, `phone`, `username`,tp) VALUES (?, ?, ?, ?, ?, ?, ?,?,?,?,?)";
    public static final String ORDER_SELECT_BY_USER_ID = "SELECT * FROM `order` WHERE uid = ?";
}
