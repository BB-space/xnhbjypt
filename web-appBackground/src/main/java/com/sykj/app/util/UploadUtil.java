package com.sykj.app.util;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

public class UploadUtil {
	public static String handleImage(HttpServletRequest request, MultipartFile file)
			throws IOException {
		byte[] bytes = file.getBytes();
		String serverPath = "/resources/upload/goodsPicture";
		String uploadDir = request.getSession().getServletContext()
				.getRealPath(serverPath);
		String root = request.getSession().getServletContext().getRealPath("");
//		System.out.println(root+"UploadUtil----------------------");
		File dirPath = new File(uploadDir);
		if (!dirPath.exists()) {
			dirPath.mkdirs();
		}
		String sep = System.getProperty("file.separator");
		String _fileName = file.getOriginalFilename();
//		System.out.println(_fileName);
		if(_fileName==""){
			return null;
		}else{
			String suffix = _fileName.substring(_fileName.lastIndexOf("."));
			String uploadFileName =new Date().getTime() + suffix;
			File uploadedFile = new File(uploadDir + sep + uploadFileName);
			FileCopyUtils.copy(bytes, uploadedFile);
			String filePath = request.getContextPath() + serverPath + "/" + uploadFileName;
			return filePath;
		}
	}
}
