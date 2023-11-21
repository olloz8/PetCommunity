<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="gcomment.GComment, gcomment.GCommentDAO"%>
<%@ page import="java.io.IOException" %>
<%
    request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="gcomment" class="gcomment.GComment" scope="page" />
<jsp:setProperty name="gcomment" property="userID" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
// 댓글 작성 시 필요한 정보 받아오기
    String galleryIDStr = request.getParameter("galleryID");
    String userID = (String) session.getAttribute("userID");

    // galleryID 유효성 검사
    if (galleryIDStr == null) {
        // galleryID가 없는 경우 처리 로직
        response.sendRedirect("error.jsp");
        return;
    }
    int galleryID = 0;
    try {
        galleryID = Integer.parseInt(galleryIDStr);
    } catch (NumberFormatException e) {
        // galleryID가 정수로 변환할 수 없는 경우 처리 로직
        response.sendRedirect("error.jsp");
        return;
    }
    gcomment.setGalleryID(galleryID);

    // 댓글 내용 유효성 검사
    String cmtContent = request.getParameter("cmtContent");
    if (cmtContent == null || cmtContent.trim().isEmpty()) {
        // 댓글 내용이 없는 경우 처리 로직
        response.sendRedirect("galleryView.jsp?galleryID=" + galleryID);
        return;
    }
    gcomment.setCmtContent(cmtContent);

    if (userID == null) {
        // 로그인하지 않은 경우 로그인 페이지로 이동
        response.sendRedirect("login.jsp");
    } else {
        GCommentDAO commentDAO = new GCommentDAO();
        // 댓글 작성 메서드 호출
        int result = commentDAO.write(gcomment.getGalleryID(),userID, gcomment.getCmtContent());
        if (result == -1) { // 댓글 작성 실패 시
            response.sendRedirect("galleryView.jsp?galleryID=" + galleryID);
        } else { // 댓글 작성 성공 시
            // 댓글이 작성된 게시글로 이동
            response.sendRedirect("galleryView.jsp?galleryID=" + galleryID);
        }
    }
%>

</body>
</html>