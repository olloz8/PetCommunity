<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gallery.GalleryDAO" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.sql.SQLException" %>

<%
    request.setCharacterEncoding("UTF-8");
    String userID = (String) session.getAttribute("userID");

    if (userID == null) {
        response.sendRedirect("login.jsp");
    } else {
        // 파일 업로드 설정
        String uploadDir = "C:\\Users\\82103\\eclipse-workspace\\PetCommunity\\src\\main\\webapp\\uploded";
        int maxSize = 1024 * 1024 * 100;
        String encoding = "UTF-8";

        // 사용자가 전송한 파일정보 토대로 업로드 장소에 파일 업로드 수행할 수 있게 함
        MultipartRequest multipartRequest = new MultipartRequest(request, uploadDir, maxSize, encoding,
            new DefaultFileRenamePolicy());

        // 글의 정보 얻어오기
        int galleryID = Integer.parseInt(multipartRequest.getParameter("galleryID"));
        String galleryTitle = multipartRequest.getParameter("galleryTitle");
        String galleryContent = multipartRequest.getParameter("galleryContent");

        // 업로드된 파일의 정보 얻어오기
        String fileName = multipartRequest.getOriginalFileName("file");
        String fileRealName = multipartRequest.getFilesystemName("file");

        // GalleryDAO 객체 생성 및 글 수정
        GalleryDAO galleryDAO = new GalleryDAO();

        try {
            int result;
            
            // 파일을 선택한 경우에만 파일 업로드 수행
            if (fileName != null && fileRealName != null) {
                result = galleryDAO.updateWithFile(galleryID, galleryTitle, galleryContent, fileName, fileRealName);
            } else {
                result = galleryDAO.update(galleryID, galleryTitle, galleryContent);
            }

            if (result != -1) {
                // 글 수정 성공 시 해당 게시글로 이동
                response.sendRedirect("galleryView.jsp?galleryID=" + galleryID);
            } else {
                // 글 수정 실패 시
                response.sendRedirect("galleryEdit.jsp?galleryID=" + galleryID);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>