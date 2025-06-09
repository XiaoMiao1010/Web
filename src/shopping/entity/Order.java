package shopping.entity;

import java.math.BigDecimal;

public class Order {
    private Integer id;
    private Integer uid;
    private String name;
    private BigDecimal price;
    private Integer quantity;
    private BigDecimal totlel;
    private String img;
    private Integer status;
    private String address;
    private String phone;
    private String username;
    private String createTime;
    private String tp;
    private Integer ischeck;

    public Integer getIscheck() {
        return ischeck;
    }

    public void setIscheck(Integer ischeck) {
        this.ischeck = ischeck;
    }

    public String getTp() {
        return tp;
    }

    public void setTp(String tp) {
        this.tp = tp;
    }

    public Order(Integer id, Integer uid, String name, BigDecimal price, Integer quantity, BigDecimal totlel, String img, Integer status, String address, String phone, String username, String createTime,String tp) {
        this.id = id;
        this.uid = uid;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
        this.totlel = totlel;
        this.img = img;
        this.status = status;
        this.address = address;
        this.phone = phone;
        this.username = username;
        this.createTime = createTime;
        this.tp = tp;
    }//区分变量，并且将值准确的传输

    public Order() {
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", uid=" + uid +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", img='" + img + '\'' +
                ", status=" + status +
                ", address='" + address + '\'' +
                ", phone='" + phone + '\'' +
                ", username='" + username + '\'' +
                ", createTime='" + createTime + '\'' +
                '}';
    }
    //这个方法用于返回一个 Order 类实例的字符串表示形式

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getTotlel() {
        return totlel;
    }

    public void setTotlel(BigDecimal totlel) {
        this.totlel = totlel;
    }
}
