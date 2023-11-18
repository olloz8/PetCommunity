<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
</head>
<body>
	<div class="wrapper">
		<div class="img-area">
			<div class="inner-area">
				<img src="resources/images/icon1.png">
			</div>
		</div>
		<div class="name"><%=request.getSession().getAttribute("userID")%>
			멍!
		</div>

		<div class="buttons">

			<%
			if (request.getSession().getAttribute("userID") == null) {
			%>
			<button>
				<a href="register.jsp">회원가입</a>
			</button>
			<button>
				<a href="login.jsp">로그인</a>
			</button>
			<%
			}
			%>

			<%
			if (request.getSession().getAttribute("userID") != null) {
			%>
			<button>
				<a href="logoutAction.jsp">로그아웃</a>
			</button>
			<button>
				<a href="bbsWrite.jsp">글쓰기</a>
			</button>
			<%
			}
			%>
		</div>
	</div>
</body>
</html>