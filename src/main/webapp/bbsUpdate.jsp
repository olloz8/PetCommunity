<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<!-- include하면 summernote 적용이 안돼서 하지 않음!-->
<!-- include하면 summernote 적용이 안돼서 하지 않음!-->
<!-- include하면 summernote 적용이 안돼서 하지 않음!-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name=viewport content="width=device-width , intial-scale=1">

<link href="resources/css/bbsWrite.css" rel="stylesheet" type="text/css">
<link href="resources/css/profile.css" rel="stylesheet" type="text/css">
<link href="resources/css/fix.css" rel="stylesheet" type="text/css">

<link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>


<!-- include summernote css/js-->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css"
	rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>

<!-- include summernote-ko-KR -->
<script src="/resources/js/summernote-ko-KR.js"></script>

<title>멍어스</title>

<script>
	$(document).ready(function() {
		$('#summernote').summernote({
			placeholder : 'content',
			minHeight : 370,
			maxHeight : null,
			focus : true,
			lang : 'ko-KR'
		});
	});
</script>

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
			script.println("alert('로그인을 하세요.')");
			script.println("location.href='login.jsp'");
			script.println("<script>");
		}
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("<script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if (!userID.equals(bbs.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("<script>");
		}
	%>
	<div id="root">
		<header id="header">
			<div id="header_box">
				<%@ include file="header.jsp"%>
			</div>
		</header>

		<section>
			<aside>
				<br>
				<div id="custom-pro">
					<%@ include file="profile.jsp"%>
				</div>
				<br>
				<ul>
					<li><a href="bbsList.jsp">자유게시판</a></li>
					<li><a href="qabbs.jsp">질문게시판</a></li>
					<li><a href="gallery.jsp">멍갤러리</a></li>
					<li><a href="callendar.jsp">멍캘린더</a></li>
					<li><a href="map.jsp">동물병원찾기</a></li>
					<li><a href="https://www.youtube.com/@Bodeumofficial">강형욱
							유튜브</a></li>
				</ul>
			</aside>
		</section>
		<form method="post" action="bbsUpdateAction.jsp?bbsID=<%= bbsID%>">
			<section id="container">
				<div id="container_box">
					<h2>글 작성</h2>
					<div style="width: 60%; margin: auto;">
						<select name="boardID">
							<option value="">--게시판선택--</option>
							<option value="1">자유게시판</option>
							<option value="2">질문게시판</option>
						</select> <input type="text" name="bbsTitle" style="width: 100%;"
							placeholder="제목" />

						<textarea id="summernote" name="bbsContent"></textarea>
						<br> <input type="submit" class="btn btn-dark" value="글쓰기 완료" />
					</div>
				</div>
			</section>
		</form>

		<footer id="footer">
			<div id="footer_box">
				<%@ include file="footer.jsp"%>
			</div>
		</footer>
	</div>
</body>
</html>