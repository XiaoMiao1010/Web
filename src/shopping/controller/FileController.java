package shopping.controller;

import shopping.constant.LunbotuConstant;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

@WebServlet("/file/*")
public class FileController extends HttpServlet {

    // 本地图片文件夹的路径
    private static final String IMAGE_FOLDER_PATH = LunbotuConstant.fileUpload;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, IOException {
        // 获取请求URI中图片的文件名部分
        String requestedFileName = request.getRequestURI().substring(request.getContextPath().length() + "/file/".length());

        // 构建本地图片文件的完整路径
        File imageFile = new File(IMAGE_FOLDER_PATH, requestedFileName);

        // 检查文件是否存在
        if (!imageFile.exists() || !imageFile.isFile()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found");
            return;
        }

        // 设置响应的内容类型为图片（这里假设所有图片都是JPEG格式，您可以根据需要修改）
        response.setContentType("image/jpeg");
        response.setContentLengthLong(imageFile.length());

        // 获取响应的输出流
        try (OutputStream out = response.getOutputStream();
             FileInputStream in = new FileInputStream(imageFile)) {

            // 将图片文件内容写入响应输出流
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
                //用于将服务器上的文件内容通过HTTP响应发送给客户端。
                //这里使用了Java的try-with-resources语句来自动管理资源，
                //确保文件输入流和输出流在使用后能够被正确关闭。
            }
        }
    }
}
//处理以 /file/ 开头的HTTP GET请求。
//提取请求的文件名，并构建本地文件的完整路径。
//检查文件是否存在，如果不存在则返回404 错误。
//设置响应的内容类型和长度。
//读取文件内容并将其发送给客户端。