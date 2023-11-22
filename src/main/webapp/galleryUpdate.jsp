<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="gallery.Gallery"%>
<%@ page import="gallery.GalleryDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name=viewport content="width=device-width , intial-scale=1">
<title>멍어스</title>

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


<title>멍어스</title>
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
	int galleryID = 0;
	if (request.getParameter("galleryID") != null) {
		galleryID = Integer.parseInt(request.getParameter("galleryID"));
	}
	if (galleryID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href='gallery.jsp'");
		script.println("<script>");
	}
	Gallery gallery = new GalleryDAO().getGallery(galleryID);
	if (!userID.equals(gallery.getUserID())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href='gallery.jsp'");
		script.println("<script>");
	}
	%>


	<div id="root">
		<%@include file="fix.jsp"%>

		<form method="post" enctype="multipart/form-data" action="galleryUpdateAction.jsp?galleryID=<%=galleryID%>">
			<section id="container">
				<div id="container_box">
					<div style="width: 60%; margin: auto;">

						<table class="table table-striped"
							style="text-align: center; border: 1px solid #dddddd">
							<thead>
								<tr>
									<th style="background-color: #eeeee; text-align: center;">글수정</th>
								</tr>
								<tr>

									<%
									String newGalleryID = request.getParameter("galleryID");
									GalleryDAO galleryDAO = new GalleryDAO();
									Gallery newGallery = galleryDAO.getGallery(Integer.parseInt(newGalleryID));
									%>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><input type="text" class="form-control"
										placeholder="글 제목" name="galleryTitle" maxlength="50"
										value="<%=gallery.getGalleryTitle()%>"></td>
								</tr>
								<tr>
									<td><textarea class="form-control" placeholder="글 내용"
											name="galleryContent" maxlangth="2048" style="height: 350px;"><%=gallery.getGalleryContent()%></textarea></td>
								</tr>
								<tr>
									<td><input type="file" name="fileName"> <%-- 선택된 파일명을 출력하는 부분 추가 --%>
										<% if (gallery != null && gallery.getFileName() != null && !gallery.getFileName().isEmpty()) { %>
										<br> <span>현재 업로드된 파일: <%= gallery.getFileName() %></span>
									<% } %>
								</tr>
							</tbody>
						</table>

						<br> <input type="submit" class="btn btn-info" value="수정완료" />
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