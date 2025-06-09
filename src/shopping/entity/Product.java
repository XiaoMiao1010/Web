package shopping.entity;


public class Product {

    private int id;
    private String name;
    private int price;
    private String img;
    private int categoryId;
    private String categoryName;

    private Integer number;

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    // 无参构造方法
    public Product() {}

    public Product(String name, int price, String img, int categoryId, String categoryName) {
        this.name = name;
        this.price = price;
        this.img = img;
        this.categoryId = categoryId;
        this.categoryName = categoryName;
    }

    public Product(String name, int price, int number,String img, int categoryId, String categoryName) {
        this.name = name;
        this.price = price;
        this.number=number;
        this.img = img;
        this.categoryId = categoryId;
        this.categoryName = categoryName;
    }

    public Product(int id, String name, int price, String img, String categoryName) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.img = img;
        this.categoryName = categoryName;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", img='" + img + '\'' +
                ", categoryId=" + categoryId +
                ", categoryName='" + categoryName + '\'' +
                '}';
    }//这个方法用于返回一个 Product 类实例的字符串表示形式

    public Product(int id, String name, int price, String img, int categoryId, String categoryName) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.img = img;
        this.categoryId = categoryId;
        this.categoryName = categoryName;
    }
    public Product(int id, String name, int price,int number, String img, int categoryId, String categoryName) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.number=number;
        this.img = img;
        this.categoryId = categoryId;
        this.categoryName = categoryName;
    }

    // 带参数构造方法
    public Product(String name, int price, String img, int categoryId) {
        this.name = name;
        this.price = price;
        this.img = img;
        this.categoryId = categoryId;
    }

    public Product(String name, int price,int number, String img, int categoryId) {
        this.name = name;
        this.price = price;
        this.number=number;
        this.img = img;
        this.categoryId = categoryId;
    }

    public Product(int id, String name, int price, String img, int categoryId) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.img = img;
        this.categoryId = categoryId;
    }

    // Getter 和 Setter 方法
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

}

