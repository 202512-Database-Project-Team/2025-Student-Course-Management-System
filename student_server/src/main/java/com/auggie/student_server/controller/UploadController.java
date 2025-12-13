package com.auggie.student_server.controller;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

@RestController
@CrossOrigin("*")
public class UploadController {

    // URL: http://localhost:10086/upload
    // 返回值改成 String，直接把图片的 URL 地址返回给前端
    @PostMapping("/upload")
    public String upload(MultipartFile file, HttpServletRequest request) throws IOException {
        // 1. 定义文件存储的文件夹 (在项目根目录下的 files 文件夹)
        String folder = System.getProperty("user.dir") + "/files/";
        File fileFolder = new File(folder);
        if (!fileFolder.exists()) {
            fileFolder.mkdirs(); // 没有就创建
        }

        // 2. 为了防止文件名冲突，生成一个新的文件名
        String originalFilename = file.getOriginalFilename();
        // 防止空指针
        if (originalFilename == null) {
            return "文件名为空";
        }
        String suffix = originalFilename.substring(originalFilename.lastIndexOf("."));
        // 新文件名: UUID + 后缀
        String newName = UUID.randomUUID().toString() + suffix;

        // 3. 保存文件到本地磁盘
        file.transferTo(new File(folder + newName));

        // 4. 生成文件的访问 URL
        // 例如: http://localhost:10086/files/abc-123.jpg
        String fileUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/files/" + newName;

        System.out.println("文件上传成功: " + fileUrl);

        // 直接返回这个地址字符串
        return fileUrl;
    }
}