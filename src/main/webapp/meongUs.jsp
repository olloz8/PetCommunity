<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멍어스</title>
</head>
<body>

    <%
        String userID = null;
        if(session.getAttribute("userID") != null) {
            userID = (String) session.getAttribute("userID"); //로그인한 사람들은 해당아이디가 userID에 저장
        }
    %>
    
	<div id="root">
	<%@ include file = "fix.jsp" %>
		<section id="container">
			<div id="container_box">
				<table class=custom-table>
				<h3>안녕하세요, 어스 여러분!</h3>
				</table>
			</div>
		</section>

		<footer id="footer">
			<div id="footer_box">
				<%@ include file="footer.jsp"%>
			</div>
		</footer>
	</div>
</body>
</html>