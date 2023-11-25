<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gallery.GalleryDAO" %>
<%@ page import="gallery.Gallery" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<%
    request.setCharacterEncoding("UTF-8");
    String userID = (String) session.getAttribute("userID");

    if (userID == null) {
        response.sendRedirect("login.jsp");
    } else {
        String uploadDir = "C:\\Users\\82103\\eclipse-workspace\\PetCommunity\\src\\main\\webapp\\uploded";
        int maxSize = 1024 * 1024 * 100;
        String encoding = "UTF-8";

        MultipartRequest multipartRequest = new MultipartRequest(request, uploadDir, maxSize, encoding, new DefaultFileRenamePolicy());

        int galleryID = Integer.parseInt(multipartRequest.getParameter("galleryID"));
        String galleryTitle = multipartRequest.getParameter("galleryTitle");
        String galleryContent = multipartRequest.getParameter("galleryContent");

        String fileName = multipartRequest.getOriginalFileName("file");
        String fileRealName = multipartRequest.getFilesystemName("file");

        GalleryDAO galleryDAO = new GalleryDAO();
        int result;

        // 파일 업로드
        if (fileName != null && fileRealName != null) {
            File file = multipartRequest.getFile("file");
            if (file != null && file.exists()) {
                System.out.println("File uploaded: " + file.getAbsolutePath());
            }
        }

     // DB 업데이트
        if (fileName != null && fileRealName != null) {
            result = galleryDAO.updateGalleryWithFile(galleryID, galleryTitle, galleryContent, fileName, fileRealName);
        } else {
            // 사진이 업로드되지 않았을 때는 기존의 사진 정보를 가져옵니다.
            Gallery gallery = galleryDAO.getGallery(galleryID);
            result = galleryDAO.updateGalleryWithFile(galleryID, galleryTitle, galleryContent, gallery.getFileName(), gallery.getFileRealName());
        }

        if (result != -1) {
            response.sendRedirect("galleryView.jsp?galleryID=" + galleryID);
        } else {
            response.sendRedirect("galleryUpdate.jsp?galleryID=" + galleryID);
        }
    }
%>
