<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gallery.GalleryDAO" %>
<%@ page import="java.io.File" %>

<%
    request.setCharacterEncoding("UTF-8");
    String userID = (String) session.getAttribute("userID");

    if (userID == null) {
        response.sendRedirect("login.jsp");
    } else {
        int galleryID = Integer.parseInt(request.getParameter("galleryID"));

        // GalleryDAO 객체 생성
        GalleryDAO galleryDAO = new GalleryDAO();

        // 게시글 및 파일 삭제 수행
        int result = galleryDAO.deleteGallery(galleryID);
        if (result != -1) {
            // 삭제 성공 시
            response.sendRedirect("galleryList.jsp");
        } else {
            // 삭제 실패 시
            response.sendRedirect("galleryView.jsp?galleryID=" + galleryID);
        }
    }
%>