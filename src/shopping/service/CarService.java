package shopping.service;

import shopping.constant.CarConstant;
import shopping.dao.CarDao;
import shopping.entity.Car;
import shopping.util.BaseUtil;

import java.math.BigDecimal;
import java.util.List;

public class CarService {
    private CarDao carDao = new CarDao();
    //carDao 作为 CarDao 类的一个实例

    public boolean addCar(Integer userId, String name,
                          BigDecimal price, String img, Integer quantity,String tp) {
        return carDao.addCar(CarConstant.CAR_INSERT, userId, name, price, img, quantity,tp);
    }

    public List<Car> selectByUserId(Integer userId) {
        return carDao.selectByUserId(CarConstant.CAR_SELECT_BY_USER_ID, userId);
    }

    public boolean updateCar(Integer id, Integer userId, String name) {
        return carDao.updateCar(CarConstant.CAR_UPDATE_QUANTITY, id, userId, name);
    }

    public boolean removeById(Integer id) {
        return carDao.deleteById(CarConstant.CAR_DELETE_BY_ID, id);
    }
}
