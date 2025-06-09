package shopping.entity;

import java.math.BigDecimal;

public class Car {
    private Integer id;
    private Integer uid;
    private String name;
    private BigDecimal price;
    private String img;
    private Integer quantity;

    private String tp;

    public String getTp() {
        return tp;
    }

    public void setTp(String tp) {
        this.tp = tp;
    }

    public Car(Integer id, Integer uid, String name, BigDecimal price, String img, Integer quantity, String tp) {
        this.id = id;
        this.uid = uid;
        this.name = name;
        this.price = price;
        this.img = img;
        this.quantity = quantity;
        this.tp = tp;
    }

    public Car() {
    }

    @Override
    public String toString() {
        return "Car{" +
                "id=" + id +
                ", uid=" + uid +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", img='" + img + '\'' +
                ", quantity=" + quantity +
                '}';
    }//方法重写

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

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }
}
