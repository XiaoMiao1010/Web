package shopping.dao;

import shopping.entity.Gonggao;
import shopping.util.BaseUtil;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

public class GonggaoDao {

    public boolean addGonggao(String sql, String title, String content) {
        return BaseUtil.execDMLSql(sql, title, content) > 0 ? true : false;
    }//返回一个布尔值

    public List<Gonggao> findAllGonggaos(String sql) {
        ResultSet resultSet = BaseUtil.execQuerySql(sql);
        //获取结果集 resultSet
        try {
            List<Gonggao> gonggaoList = new CopyOnWriteArrayList<>();
            while (resultSet.next()) {
                Gonggao gonggao = new Gonggao();
                //每条记录创建一个 Gonggao 对象
                gonggao.setId(resultSet.getInt("id"));
                gonggao.setTitle(resultSet.getString("title"));
                gonggao.setContent(resultSet.getString("content"));
                gonggaoList.add(gonggao);
            }
            return gonggaoList;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateGonggao(String sql, Integer id, String title, String content) {
        return BaseUtil.execDMLSql(sql, title, content,id) > 0 ? true : false;
    }

    public boolean deleteGonggao(String sql, Integer id) {
        return BaseUtil.execDMLSql(sql, id) > 0 ? true : false;
    }

    public Gonggao selectnew(String s) {
        ResultSet resultSet = BaseUtil.execQuerySql(s);
        try {
            Gonggao gonggao = new Gonggao();
            while (resultSet.next()) {
                gonggao.setId(resultSet.getInt("id"));
                gonggao.setTitle(resultSet.getString("title"));
                gonggao.setContent(resultSet.getString("content"));
            }
            return gonggao;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
