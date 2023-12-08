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
					<tr>
						<td rowspan='2'><img src="resources/images/2.jpg" width="400"
							height="610" alt="강아지" /></td>
						<td><img src="resources/images/1.jpg" width="500"
							height="300" alt="강아지" /></td>
					</tr>
					<tr>
						<!--<td>1</td>-->
						<td><img src="resources/images/3.jpg" width="500"
							height="300" alt="강아지" /></td>
					</tr>
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