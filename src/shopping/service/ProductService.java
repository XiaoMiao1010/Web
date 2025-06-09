package shopping.service;

import shopping.entity.Product;
import shopping.util.BaseUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class ProductService {
    public List<Product> getAllProducts(HttpServletRequest req, HttpServletResponse resp) {
        //如果名字为空或者null，就查询所有，否则模糊查询所有
        String name = req.getParameter("search");
        if (name == null || name.isEmpty()) {
            String sql = "select id, name,price,id, name, price, img, category_id, category_name,number from product;";
            return BaseUtil.getAllProduct(sql);
        } else {
            String sql = "select id, name,price,id, name, price, img, category_id, category_name,number from product WHERE name LIKE '%" + name + "%'";
            return BaseUtil.getAllProduct(sql);
        }
    }

    public boolean addProduct(Product product) {
        String sql = "INSERT INTO product(name,price,number,img,category_id,category_name) VALUES(?,?,?,?,?,?)";
        return BaseUtil.execDMLSql(sql, product.getName(), product.getPrice(),product.getNumber(), product.getImg(), product.getCategoryId(), product.getCategoryName()) > 0;
    }

    public boolean editProduct(Product product) {
        String sql = "UPDATE product SET name = ?, price = ?,number=?, img = ?, category_id = ?,category_name = ? WHERE id = ?";
        return BaseUtil.execDMLSql(sql, product.getName(), product.getPrice(),product.getNumber(),
                product.getImg(), product.getCategoryId(),product.getCategoryName(), product.getId()) > 0;

    }

    public boolean deleteProduct(int id) {
        return BaseUtil.execDMLSql("DELETE FROM product WHERE id = ?", id) > 0;
    }

    public Product getProductById(int id) {
        String sql = "SELECT * FROM product WHERE id = ?";
        return BaseUtil.getProductById(sql, id);
    }
}
