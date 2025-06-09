package shopping.constant;

public class CarConstant {
    public static final String CAR_INSERT = "INSERT INTO car(uid,name,price,img,quantity,tp) VALUES(?,?,?,?,?,?)";
    public static final String CAR_SELECT_BY_USER_ID = "SELECT * FROM car WHERE uid = ?";
    public static final String CAR_UPDATE_QUANTITY = "UPDATE car SET quantity = quantity+1 WHERE id = ? and uid = ? AND name = ?";

    public static final String CAR_DELETE_BY_ID = "DELETE FROM car WHERE `id` = ?";
}
