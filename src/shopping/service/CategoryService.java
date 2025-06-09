package shopping.service;

import shopping.dao.CategoryDao;
import shopping.entity.Category;
import shopping.util.BaseUtil;

import java.util.List;

public class CategoryService {
    private CategoryDao categoryDao = new CategoryDao();
    public CategoryService() {
    }

    public List<Category> getallCategory(String name) {
        //如果名字为空或者null，就查询所有，否则模糊查询所有
        if (name == null || name.isEmpty()) {
            return categoryDao.getAllCategory();
        } else {
            String sql = "SELECT * FROM category WHERE name LIKE '%" + name + "%'";
            return BaseUtil.getAllCategory(sql);
        }
    }

    public void addCategory(String name) {
        String sql = "INSERT INTO category(name) VALUES(?)";
        categoryDao.addCategory(sql, name);
    }

    public void deleteById(String id) {
        String sql = "DELETE FROM category WHERE id = ?";
        BaseUtil.execDMLSql(sql, id);
    }

    public void editCategory(String id, String name) {
        String sql = "UPDATE category SET name = ? WHERE id = ?";
        BaseUtil.execDMLSql(sql, name, id);
    }
}
