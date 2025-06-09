package shopping.controller;

import com.lowagie.text.*;
import com.lowagie.text.pdf.*;
import shopping.entity.Order;
import shopping.service.OrderService;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.List;

@WebServlet("/orderPdf")
public class OrderPdfServlet extends HttpServlet {
    private OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Order> orderList = orderService.selectAllOrders();

        // 设置响应类型为 PDF
        response.setContentType("application/pdf");
        // 设置响应头，指示浏览器下载文件
        response.setHeader("Content-Disposition", "inline; filename=\"orders.pdf\"");

        // 创建 PDF 文档对象
        Document document = new Document();
        // 获取 PDF 写入器，并绑定到输出流
        try {
            PdfWriter.getInstance(document, response.getOutputStream());
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 打开文档
        document.open();
        // 设置字体，避免中文乱码
        try {
            // 使用字体路径加载中文字体
            // 获取字体文件路径
            String fontPath = getServletContext().getRealPath("/WEB-INF/fonts/msyh.ttc");

// 创建 BaseFont，指定索引0代表 Microsoft YaHei 字体
            BaseFont baseFont = BaseFont.createFont(fontPath + ",0", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);

// 创建 Font 对象
            Font font = new Font(baseFont, 12);

// 之后可以用该 font 设置文本的字体


            // 添加标题
            document.add(new Paragraph("订单详情", font));
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 创建一个表格，设定列数为 5
        PdfPTable table = new PdfPTable(5);
        table.setWidthPercentage(100); // 设置表格宽度为100%
        table.setSpacingBefore(10f); // 设置表格上方间距
        Font font = null;
        // 设置表格标题行，使用支持中文的字体
        try {
             String fontPath = getServletContext().getRealPath("/WEB-INF/fonts/msyh.ttc");

// 创建 BaseFont，指定索引0代表 Microsoft YaHei 字体
            BaseFont baseFont = BaseFont.createFont(fontPath + ",0", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);

// 创建 Font 对象
            font = new Font(baseFont, 12);

            // 添加表格头部
            table.addCell(new Phrase("商品名称", font));
            table.addCell(new Phrase("价格", font));
            table.addCell(new Phrase("用户名", font));
            table.addCell(new Phrase("地址", font));
            table.addCell(new Phrase("联系电话", font));
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 填充表格内容
        for (Order order : orderList) {
            table.addCell(new Phrase(order.getName(), font)); // 商品名称
            table.addCell(new Phrase(String.format("%.2f", order.getPrice()), font)); // 价格
            table.addCell(new Phrase(order.getUsername(),font)); // 用户名
            table.addCell(new Phrase(order.getAddress(), font)); // 地址
            table.addCell(new Phrase(order.getPhone(), font)); // 电话号码
        }

        // 将表格添加到文档中
        try {
            document.add(table);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 关闭文档
        document.close();
    }
}
