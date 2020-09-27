package com.imcode.common.service;


import com.imcode.common.model.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

@Service
public class FileService {

    @Autowired(required = false)
    private HttpSession session;

    @Value("${file.location}")
    private String fileLocation;

    @Value("${file.server}")
    private String fileServer;


    /**
     * 上传文件到服务器
     *
     * @param uploadFile
     * @return
     */
    public R uplaod(MultipartFile uploadFile) throws IOException {

        String fileName = uploadFile.getOriginalFilename();
        String suffix = fileName.substring(fileName.lastIndexOf(".") - 1);
        String uuid = UUID.randomUUID().toString().toUpperCase().replace("-", "");
        fileName = uuid + suffix;

        String parent = session.getServletContext().getRealPath(fileLocation);
        File file = new File(parent, fileName);
        if (!file.exists()) {
            file.mkdirs();
        }
        uploadFile.transferTo(file);
        R r = R.ok()
                .put("url", fileServer + "/" + fileName)
                .put("name", fileName);
        return r;
    }
}
