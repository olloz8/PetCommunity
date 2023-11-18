<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>글 삭제</title>
</head>
<body>
    <%
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인 하신 후 이용 가능합니다.')");
        script.println("location.href = 'login.jsp'");    // 메인 페이지로 이동
        script.println("</script>");
    }
    
    int bbsID = 0;
    if (request.getParameter("bbsID") != null) {
        bbsID = Integer.parseInt(request.getParameter("bbsID"));
    }
    if (bbsID == 0) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다.')");
        script.println("location.href='bbs.jsp'");
        script.println("</script>");
    }

    BbsDAO bbsDAO = new BbsDAO(); // BbsDAO 객체 생성
    Bbs bbs = bbsDAO.getBbs(bbsID);
    if (!userID.equals(bbs.getUserID())) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('권한이 없습니다.')");
        script.println("location.href='main.jsp'");
        script.println("</script>");
    } else {
        // 이미 생성한 BbsDAO 인스턴스를 사용
        int boardID = bbs.getBoardID(); // 삭제 후 이동할 게시판의 boardID
        int result = bbsDAO.delete(bbsID);
        if (result == -1) { // 글 삭제 실패시
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('글 삭제에 실패했습니다.')");
            script.println("history.back()");    // 이전 페이지로 사용자를 보냄
            script.println("</script>");
        } else { // 글 삭제 성공시
            PrintWriter script = response.getWriter();
            script.println("<script>");
            // 삭제 후 이동할 게시판의 boardID를 사용하여 이동
            script.println("location.href = 'bbsList.jsp?selectedBoardID=" + boardID + "'");
            script.println("</script>");
        }
    }
    %>
</body>
</html>
