<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gallery.Gallery, java.io.File" %>
<%@ page import="gallery.GalleryDAO" %>

<%
    String userID = (String) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("login.jsp");
    } else {
        int galleryID = Integer.parseInt(request.getParameter("galleryID"));
        GalleryDAO galleryDAO = new GalleryDAO();
        Gallery gallery = galleryDAO.getGallery(galleryID);

        // 해당 갤러리의 파일을 삭제
        if (gallery != null && gallery.getUserID().equals(userID) && gallery.getFileName() != null && !gallery.getFileName().isEmpty()) {
            String filePath = "C:\\Users\\82103\\eclipse-workspace\\PetCommunity\\src\\main\\webapp\\uploded\\" + gallery.getFileName();
            File file = new File(filePath);

            if (file.exists()) {
                if (file.delete()) {
                    // 파일 삭제 성공 시 DB에서 파일 정보 삭제
                    galleryDAO.deleteFile(galleryID);
                } else {
                    out.println("<script>alert('파일 삭제 실패');</script>");
                }
            }
        }
        response.sendRedirect("galleryUpdate.jsp?galleryID=" + galleryID);
    }
%>