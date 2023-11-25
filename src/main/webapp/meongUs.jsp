<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멍어스</title>
<style>
.highlight{
  display: inline;
  box-shadow: inset 0 35px 0 #FFE4E1; 
  /*-10px은 highlight의 두께*/
}
</style>
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
				<center>
				<br><br><br>
				<h1><span class="highlight"> 멍어스(MeongUs) </span></h1>
				<p>'어스'는 지구를 의미하며, 강아지 친구들이 모이는 공간을 상징합니다.</p>
				<br>
				<h4>훌륭한 견주가 되어<br>
					강아지에게 더 넓은 지구를 보여주세요.</h4>
				<br>
				<h5>각 게시판마다 설명이 있습니다.<br>
					꼭 숙지하시고, 멍어스를 즐겨주세요.</h5>
				</center>
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