package shopping.controller;

import shopping.entity.Car;
import shopping.entity.Order;
import shopping.entity.User;
import shopping.service.CarService;
import shopping.service.OrderService;
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
import java.util.concurrent.CopyOnWriteArrayList;


@WebServlet("/order/*")
public class OrderController extends HttpServlet {

    private OrderService orderService = new OrderService();

    private CarService carService = new CarService();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String urlPath = Uri.geturi(req);
        if ("insert".equals(urlPath)) {
            insert(req, resp);
        } else if ("select".equals(urlPath)) {
            selectByUserId(req, resp);
        } else if ("select2".equals(urlPath)) {
            selectByUserId2(req, resp);
        }
    }

    private void selectByUserId2(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Order> orderList = orderService.selectAllOrders();
        req.getSession().setAttribute("orderList", orderList);
        req.getRequestDispatcher("/admin/orderManagement.jsp").forward(req, resp);
    }

    public void insert(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 设置编码
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (null == user) {
            req.setAttribute("error", "请登录");
            req.getRequestDispatcher("/log_in.jsp").forward(req, resp);
            return;
        }
        List<Car> carList = (List<Car>) session.getAttribute("carList");
        String address = req.getParameter("address");
        String phone = req.getParameter("phone");
        String username = req.getParameter("username");
        Integer status = Integer.parseInt(req.getParameter("status"));

        List<Order> orderList = new CopyOnWriteArrayList<>();
        if (null != carList && carList.size() != 0) {
            carList.stream().forEach(car -> {
                BigDecimal totle = car.getPrice().multiply(new BigDecimal(car.getQuantity()));
                Order order = new Order(null, user.getId(), car.getName(), car.getPrice(), car.getQuantity(),
                        totle, car.getImg(), status, address, phone, username, null,car.getTp());
                orderList.add(order);
            });
        }
        boolean b = orderService.insertBath(orderList);
        if (b) {
            if (null != carList && carList.size() != 0) {
                carList.stream().forEach(car -> {
                    carService.removeById(car.getId());
                });
                session.setAttribute("carList", null);
                session.setAttribute("totle", 0);
            }
            req.getSession().setAttribute("success", "购买成功");
            req.getRequestDispatcher("/payfor_success.jsp").forward(req, resp);
        } else {
            req.getSession().setAttribute("error", "购买失败");
            req.getRequestDispatcher("/payfor.jsp").forward(req, resp);
        }
    }

    public void selectByUserId(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (null == user) {
            req.setAttribute("error", "请登录");
            req.getRequestDispatcher("/log_in.jsp").forward(req, resp);
            return;
        }
        List<Order> orderList = orderService.selectByUserId(user.getId());
        req.getSession().setAttribute("orderList", orderList);
        req.getRequestDispatcher("/order.jsp").forward(req, resp);
    }
}
