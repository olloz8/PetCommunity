<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="comment.CommentDAO"%>
<%@ page import="java.io.IOException" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="comment" class="comment.Comment" scope="page" />
<jsp:setProperty name="comment" property="userID" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    // 댓글 작성 시 필요한 정보 받아오기
    String bbsIDStr = request.getParameter("bbsID");
    String userID = (String) session.getAttribute("userID");

    // bbsID 유효성 검사
    if (bbsIDStr == null) {
        // bbsID가 없는 경우 처리 로직
        response.sendRedirect("error.jsp");
        return;
    }
    int bbsID = 0;
    try {
        bbsID = Integer.parseInt(bbsIDStr);
    } catch (NumberFormatException e) {
        // bbsID가 정수로 변환할 수 없는 경우 처리 로직
        response.sendRedirect("error.jsp");
        return;
    }
    comment.setBbsID(bbsID);

    // 댓글 내용 유효성 검사
    String cmtContent = request.getParameter("cmtContent");
    if (cmtContent == null || cmtContent.trim().isEmpty()) {
        // 댓글 내용이 없는 경우 처리 로직
        response.sendRedirect("bbsView.jsp?bbsID=" + bbsID);
        return;
    }
    comment.setCmtContent(cmtContent);

    if (userID == null) {
        // 로그인하지 않은 경우 로그인 페이지로 이동
        response.sendRedirect("login.jsp");
    } else {
        CommentDAO commentDAO = new CommentDAO();
        // 댓글 작성 메서드 호출
        int result = commentDAO.write(comment.getBbsID(),userID, comment.getCmtContent());
        if (result == -1) { // 댓글 작성 실패 시
            response.sendRedirect("bbsView.jsp?bbsID=" + bbsID);
        } else { // 댓글 작성 성공 시
            // 댓글이 작성된 게시글로 이동
            response.sendRedirect("bbsView.jsp?bbsID=" + bbsID);
        }
    }
%>

</body>
</html>