<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="java.io.IOException" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!-- 글쓰기 액션 폼에서 request.getParameter("boardID")로 boardID를 얻고, bbs 객체에 설정 -->
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
<%
    // request.getParameter("boardID")를 가져와서 변수에 저장
    String boardID = request.getParameter("boardID");
    
    // bbs 객체에 직접 속성 설정
    bbs.setBoardID(Integer.parseInt(boardID));
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
    <%
        String userID = (String) session.getAttribute("userID");
        
        if (userID == null) {
            response.sendRedirect("login.jsp");
        } else {
            if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
                response.sendRedirect("bbsWrite.jsp");
            } else {
                BbsDAO bbsDAO = new BbsDAO();
                int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent(), bbs.getBoardID());
                if (result == -1) { // 글쓰기 실패시
                    response.sendRedirect("bbsWrite.jsp");
                } else { // 글쓰기 성공시
                    // 글쓰기 성공 시 선택한 게시판으로 이동
                    response.sendRedirect("bbsList.jsp?selectedBoardID=" + bbs.getBoardID());
                }
            }
        }
    %>
</body>
</html>