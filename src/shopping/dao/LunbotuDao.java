package shopping.dao;

import shopping.entity.Lunbotu;
import shopping.util.BaseUtil;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

public class LunbotuDao {

    public boolean addLunbotu(String sql, String img, String name) {
        return BaseUtil.execDMLSql(sql, img, name) > 0 ? true : false;
    }

    public List<Lunbotu> selectAllLunbotus(String sql) {
        ResultSet resultSet = BaseUtil.execQuerySql(sql);
        try {
            List<Lunbotu> lunbotuList = new CopyOnWriteArrayList<>();
            while (resultSet.next()) {
                Lunbotu lunbotu = new Lunbotu();
                lunbotu.setId(resultSet.getInt("id"));
                lunbotu.setImg(resultSet.getString("img"));
                lunbotu.setName(resultSet.getString("name"));
                lunbotuList.add(lunbotu);
            }
            return lunbotuList;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }


    public boolean updateLunbotu(String sql, Integer id, String name, String img) {
        return BaseUtil.execDMLSql(sql, name, img,id) > 0 ? true : false;
    }

    public boolean deleteLunbotuById(String sql, Integer id) {
        return BaseUtil.execDMLSql(sql, id) > 0 ? true : false;
    }
}
