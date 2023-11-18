<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<%
        session.invalidate(); //현재 이 페이지에 접속한 회원이 세션을 빼앗기게함
    %>
	<script>
        location.href = 'main.jsp'; //다시 메인페이지로 보냄
    </script>
</body>
</html>