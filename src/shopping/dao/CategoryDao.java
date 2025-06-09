package shopping.dao;

import shopping.entity.Category;
import shopping.util.BaseUtil;

import java.util.List;

public class CategoryDao {
    public List<Category> getAllCategory() {
        return BaseUtil.getAllCategory("SELECT * FROM category");
    }

    public void addCategory(String sql, String name) {
        BaseUtil.execDMLSql(sql, name);
    }
}//调用 BaseUtil 类的 execDMLSql 方法执行插入操作，传入SQL语句和分类名称。

//