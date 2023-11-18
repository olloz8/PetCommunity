<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
%>


<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) { //user가 접속이 되어있다면 세션값이 할당되어 있다면
		userID = (String) session.getAttribute("userID");
	}
	if (userID != null) { //로그인 되어있는 사람이 재로그인 되지 않도록함
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어있습니다.')");
		script.println("location.href = 'main.jsp'"); // 메인페이지로 보냄
		script.println("</script>");
	}
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(user.getUserID(), user.getUserPassword());
	if (result == 1) {
		   session.setAttribute("userID", user.getUserID());//userID를 세션값할당
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인에 성공하셨습니다.')");
		script.println("location.href = 'main.jsp'"); // 로그인 되면 이동할페이지
		script.println("</script>");
	} else if (result == 0) { // 비밀번호 불일치시
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.')");
		script.println("history.back()"); //뒤로가기, 다시 로그인 페이지
		script.println("</script>");
	} else if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else if (result == -2) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	%>
</body>
</html>