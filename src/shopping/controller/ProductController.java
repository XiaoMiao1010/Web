package shopping.controller;

import shopping.constant.LunbotuConstant;
import shopping.entity.Product;
import shopping.service.ProductService;
import shopping.util.BaseUtil;
import shopping.util.Uri;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

@WebServlet("/product/*")
@MultipartConfig
public class ProductController extends HttpServlet {

    private ProductService productService = new ProductService();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String urlPath = Uri.geturi(req);
        if ("add".equals(urlPath)) {
            addProduct(req, resp);
        } else if ("select".equals(urlPath)) {
            selectProduct(req, resp);
        } else if ("delete".equals(urlPath)) {
            String id = req.getParameter("id");
            productService.deleteProduct(Integer.parseInt(id));
        } else if ("update".equals(urlPath)) {
            addProduct(req, resp);
        }
    }


    private void addProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //设置编码
        req.setCharacterEncoding("UTF-8");
        //获取id
        String id = req.getParameter("id");

        String name = req.getParameter("name");
        //价格
        String price = req.getParameter("price");
        Integer number = Integer.valueOf(req.getParameter("number"));
        String categoryId = req.getParameter("categoryId");
        Part img = req.getPart("img");
        // 图片存储路径
//        String uploadDir = "D:\\java productivity\\BigHomework\\web\\images";
        //定义图片的存储路径，并检查该路径是否存在，如果不存在则创建。
        String uploadDir = LunbotuConstant.fileUpload+"/images";
        File uploadPath = new File(uploadDir);
        if (!uploadPath.exists()) {
            uploadPath.mkdirs(); // 如果目录不存在，则创建
        }
        // 保存文件并生成相对路径
        String fileName = Paths.get(img.getSubmittedFileName()).getFileName().toString(); // 获取文件名
        fileName = UUID.randomUUID().toString() + "_" + ".jpg"; // 生成唯一文件名以避免覆盖
        String relativePath = "/file/images/" + fileName; // 数据库存储的相对路径
        String absoluteFilePath = uploadDir + File.separator + fileName; // 图片的绝对路径
        img.write(absoluteFilePath);
//        System.out.println("Image saved to: " + absoluteFilePath);
//        System.out.println("Relative path for DB: " + relativePath);
        // 查种类
        String sql = "select name from category where id = " + categoryId;
        String categoryName = BaseUtil.getCategoryNameById(sql);
//        System.out.println(categoryName);
        if (!(id==null||id.isEmpty())) {//修改逻辑
            Product product = new Product();
            product.setId(Integer.parseInt(id));
            product.setName(name);
            product.setPrice(Integer.parseInt(price));
            product.setNumber(number);
            product.setImg(relativePath);
            product.setCategoryId(Integer.parseInt(categoryId));
            product.setCategoryName(categoryName);
            productService.editProduct(product);
            return;
            //如果 id 不为空，则更新商品信息；否则，添加新商品。
            //创建 Product 对象并设置其属性，然后调用 productService 的 addProduct 或 editProduct 方法来添加或更新商品。
        }
        Product product = new Product(name, Integer.parseInt(price),number, relativePath, Integer.parseInt(categoryId), categoryName);
        productService.addProduct(product);
        // 重定向到列表页
        resp.sendRedirect("/admin/productManagement.jsp");
    }

    private void selectProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // 获取数据库连接并查询所有产品
        List<Product> products = productService.getAllProducts(req, resp);

        // 手动拼接 JSON 数据
        StringBuilder jsonResponse = new StringBuilder();
        jsonResponse.append("{\n");
        jsonResponse.append("  \"products\": [\n");

        // 遍历 List<Product> 拼接 JSON 数据
        for (int i = 0; i < products.size(); i++) {
            Product product = products.get(i);
            //于构建和拼接JSON格式的字符串
            jsonResponse.append("    {\n");
            jsonResponse.append("      \"id\": ").append(product.getId()).append(",\n");
            jsonResponse.append("      \"name\": \"").append(product.getName()).append("\",\n");
            jsonResponse.append("      \"price\": ").append(product.getPrice()).append(",\n");
            jsonResponse.append("      \"img\": \"").append(product.getImg()).append("\",\n");
            jsonResponse.append("      \"categoryId\": ").append(product.getCategoryId()).append(",\n");
            jsonResponse.append("      \"number\": ").append(product.getNumber()).append(",\n");
            jsonResponse.append("      \"categoryName\": \"").append(product.getCategoryName()).append("\"\n");
            jsonResponse.append("    }");

            // 如果不是最后一个元素，添加逗号
            if (i < products.size() - 1) {
                jsonResponse.append(",");
            }

            jsonResponse.append("\n");
        }
        jsonResponse.append("  ]\n");
        jsonResponse.append("}");

        // 设置响应内容类型为 JSON
        resp.setContentType("application/json;charset=UTF-8");
        // 返回 JSON 数据
        resp.getWriter().write(jsonResponse.toString());
    }

}
