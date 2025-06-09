package shopping.controller;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import shopping.constant.LunbotuConstant;
import shopping.dao.LunbotuDao;
import shopping.entity.Lunbotu;
import shopping.entity.User;
import shopping.util.Uri;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet("/lunbotu/*")
public class LunbotuController extends HttpServlet {


    private LunbotuDao userService=new LunbotuDao();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String urlPath = Uri.geturi(req);
        if ("select".equals(urlPath)) {
            select(req, resp);
        } else if ("delete".equals(urlPath)) {
            delete(req, resp);
        } else if ("update".equals(urlPath)) {
            update(req, resp);
        } else if ("add".equals(urlPath)) {
            add(req, resp);
        }
    }

    private void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // 检查请求是否为multipart/form-data类型
        if (!ServletFileUpload.isMultipartContent(req)) {
            resp.getWriter().println("Error: Form must has enctype=multipart/form-data.");
            return;
        }

        String UPLOAD_DIRECTORY = LunbotuConstant.fileUpload;

        // 配置上传参数
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);

        try {
            String filePath="";
            String username="";
            String fileName="";
            // 解析请求的内容提取文件数据
            List<FileItem> formItems = upload.parseRequest(req);

            if (formItems != null && formItems.size() > 0) {
                // 迭代表单数据
                for (FileItem item : formItems) {
                    // 处理不在表单中的字段
                    if (!item.isFormField()) {
                         fileName = new File(item.getName()).getName();
                         fileName = UUID.randomUUID().toString() + "_" + fileName;
                        filePath = UPLOAD_DIRECTORY + File.separator + fileName;
                        File storeFile = new File(filePath);

                        // 在控制台输出文件的上传路径
                        System.out.println("文件上传路径:" + filePath);

                        // 保存文件到硬盘
                        item.write(storeFile);
                    }else {
                         username = item.getString();
                    }
                }
            }

            userService.addLunbotu("INSERT INTO lunbotu(name,img) values(?,?)",username, "/file/"+fileName);


        } catch (Exception ex) {
            resp.getWriter().println("文件上传失败: " + ex.getMessage());
        }


          }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {


        // 检查请求是否为multipart/form-data类型
        if (!ServletFileUpload.isMultipartContent(req)) {
            resp.getWriter().println("Error: Form must has enctype=multipart/form-data.");
            return;
        }

        String UPLOAD_DIRECTORY = LunbotuConstant.fileUpload;

        // 配置上传参数
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);

        try {
            String filePath="";
            String username="";
            String fileName="";
            Integer id=0;
            // 解析请求的内容提取文件数据
            List<FileItem> formItems = upload.parseRequest(req);

            if (formItems != null && formItems.size() > 0) {
                // 迭代表单数据
                for (FileItem item : formItems) {
                    // 处理不在表单中的字段
                    if (!item.isFormField()) {
                        fileName = new File(item.getName()).getName();
                        fileName = UUID.randomUUID().toString() + "_" + fileName;
                        filePath = UPLOAD_DIRECTORY + File.separator + fileName;
                        File storeFile = new File(filePath);

                        // 在控制台输出文件的上传路径
                        System.out.println("文件上传路径:" + filePath);

                        // 保存文件到硬盘
                        item.write(storeFile);
                    }else {
                        if (item.getFieldName().equals("id")){
                            id = Integer.valueOf(item.getString());
                        }
                        if (item.getFieldName().equals("username")){
                            username = item.getString();
                        }
                    }
                }
            }

//             id = Integer.valueOf(req.getParameter("id"));
//             username = req.getParameter("username");
            userService.updateLunbotu("update lunbotu set name = ?,img = ? where id = ?",id, username, "/file/"+fileName);


        } catch (Exception ex) {
            resp.getWriter().println("文件上传失败: " + ex.getMessage());
        }



  }

    private void delete(HttpServletRequest req, HttpServletResponse resp) {
        Integer id = Integer.valueOf(req.getParameter("id"));
        userService.deleteLunbotuById("delete from lunbotu where id = ?",id);
    }

    private void select(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // 获取数据库连接并查询所有用户
        List<Lunbotu> users = userService.selectAllLunbotus("select * from lunbotu");

        // 手动拼接 JSON 数据
        StringBuilder jsonResponse = new StringBuilder();
        jsonResponse.append("{\n");
        jsonResponse.append("  \"users\": [\n");

        // 遍历 List<User> 拼接 JSON 数据
        for (int i = 0; i < users.size(); i++) {
            Lunbotu user = users.get(i);
            jsonResponse.append("    {\n");
            jsonResponse.append("      \"id\": ").append(user.getId()).append(",\n");
            jsonResponse.append("      \"username\": \"").append(user.getName()).append("\",\n");
            jsonResponse.append("      \"password\": \"").append(user.getImg()).append("\"\n");
            jsonResponse.append("    }");

            // 如果不是最后一个元素，添加逗号
            if (i < users.size() - 1) {
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
