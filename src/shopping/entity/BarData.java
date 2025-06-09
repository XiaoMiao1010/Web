package shopping.entity;

public class BarData {
    private String categoryName;
    private String productNames;
    private Integer productCount;

    public BarData()
    {
    };

    @Override
    public String toString() {
        return "BarData{" +
                "categoryName='" + categoryName + '\'' +
                ", productNames='" + productNames + '\'' +
                ", productCount=" + productCount +
                '}';
    }

    public BarData(String categoryName, String productNames, Integer productCount) {
        this.categoryName = categoryName;
        this.productNames = productNames;
        this.productCount = productCount;
    }//重写了 Object 类的 toString 方法，用于返回 BarData 对象的字符串表示形式。

    public String getCategoryName() {
        return categoryName;
    }
    //提供了 getCategoryName 和 setCategoryName 方法来访问和修改 categoryName 的值。

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getProductNames() {
        return productNames;
    }

    public void setProductNames(String productNames) {
        this.productNames = productNames;
    }

    public Integer getProductCount() {
        return productCount;
    }

    public void setProductCount(Integer productCount) {
        this.productCount = productCount;
    }
}
