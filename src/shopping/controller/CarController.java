package shopping.controller;

import shopping.entity.Car;
import shopping.entity.User;
import shopping.service.CarService;
import shopping.util.Uri;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;


@WebServlet("/car/*")
public class CarController extends HttpServlet {

    private CarService carService = new CarService();


    @Override//通过获取url来判断用户需要执行什么操作
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String urlPath = Uri.geturi(req);
        //Uri的工具类的geturi方法（这里假设存在这样一个方法）来获取请求的URI路径，并将其存储在变量urlPath中
        if ("add".equals(urlPath)) {
            addCar(req, resp);
        } else if ("select".equals(urlPath)) {
            selectByUserId(req, resp);
        } else if ("delete".equals(urlPath)) {
            removeById(req, resp);
        }
    }

//如果是加入购物车的操作，那么就要先判断购物车里面有没有该商品，如果没有就添加，如果有那么就只需要更新数量
    public void addCar(HttpServletRequest req, HttpServletResponse resp) {
        try {
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            String productName = req.getParameter("productName");
            String productPrice = req.getParameter("productPrice");
            String imgSrc = req.getParameter("imgSrc");
            String tp = req.getParameter("tp");
            HttpSession session = req.getSession();
            User user = (User) session.getAttribute("user");
            if (null == user) {
                resp.getWriter().write("{\"infoCode\": " + 300 + "}");
                return;
            }
            List<Car> carList = carService.selectByUserId(user.getId());
            if (null == carList || carList.size() == 0) {
                carService.addCar(user.getId(), productName, new BigDecimal(productPrice), imgSrc, 1,tp);
            } else {
                List<Car> collect = carList.stream().
                        filter(car -> car.getName().equals(productName)).
                        collect(Collectors.toList());
                if (null == collect || collect.size() == 0) {
                    carService.addCar(user.getId(), productName, new BigDecimal(productPrice), imgSrc, 1,tp);
                } else {
                    Car car = collect.get(0);
                    carService.updateCar(car.getId(), car.getUid(), car.getName());
                }
            }
            resp.getWriter().write("{\"infoCode\": " + 200 + "}");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
//搜索用户id 判断是否登录
    public void selectByUserId(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (null == user) {
            req.setAttribute("error", "请登录");
            req.getRequestDispatcher("/log_in.jsp").forward(req, resp);
            return;
        }
        List<Car> carList = carService.selectByUserId(user.getId());
        req.getSession().setAttribute("carList", carList);
        if (null != carList && carList.size() != 0) {
            AtomicInteger totle = new AtomicInteger(0);
            carList.stream().forEach(car -> {
                BigDecimal multiply = car.getPrice().multiply(new BigDecimal(car.getQuantity()));
                double v = Double.parseDouble(multiply.toString());
                totle.getAndAdd((int) v);
            });
            req.getSession().setAttribute("totle", totle);
        }
        req.getRequestDispatcher("/shopping_cart.jsp").forward(req, resp);
        //请求转发到购物车页面 /shopping_cart.jsp，将用户和汽车列表数据传递给JSP页面进行展示。
    }

    public void removeById(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (null == user) {
            req.setAttribute("error", "请登录");
            req.getRequestDispatcher("/log_in.jsp").forward(req, resp);
            return;
        }
        //
        Integer id = Integer.parseInt(req.getParameter("id"));
        carService.removeById(id);
        List<Car> carList = carService.selectByUserId(user.getId());
        //调用carService的selectByUserId方法，获取当前用户的所有汽车列表，以便更新页面显示。
        req.setAttribute("carList", carList);
        req.getRequestDispatcher("/shopping_cart.jsp").forward(req, resp);

    }
}
