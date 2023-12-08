<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="comment.CommentDAO" %>
<%@ page import="comment.Comment" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>댓글 삭제</title>
</head>
<body>
    <%
    String userID = null;
    if (session.getAttribute("userID") != null){
        userID = (String) session.getAttribute("userID");
    }
    if (userID == null){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인 하신 후 이용 가능합니다.')");
        script.println("location.href = 'login.jsp'");
        script.println("</script>");
    }
    int cmtID = 0;
    if (request.getParameter("cmtID") != null) {
        cmtID = Integer.parseInt(request.getParameter("cmtID"));
    }
    if (cmtID == 0){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 댓글입니다.')");
        script.println("location.href='index.jsp'");
        script.println("</script>");
    }
    Comment comment = new CommentDAO().getComment(cmtID);
    if (!userID.equals(comment.getUserID())) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('권한이 없습니다.')");
        script.println("location.href='index.jsp'");
        script.println("</script>");
    } else {
        CommentDAO commentDAO = new CommentDAO();
        int result = commentDAO.delete(cmtID);
        if (result == -1){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('댓글 삭제에 실패했습니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href = 'bbsView.jsp?bbsID=" + comment.getBbsID() + "'");
            script.println("</script>");    
        }
    }
    %>
</body>
</html>