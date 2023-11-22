<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
</head>
<body>

	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	%>

	<div id="root">
		<%@include file="fix.jsp"%>



		<form method="post" enctype="multipart/form-data"
			action="galleryWriteAction.jsp">
			<section id="container">
				<div id="container_box">
					<div style="width: 60%; margin: auto;">

						<table class="table table-striped"
							style="text-align: center; border: 1px solid #dddddd">
							<thead>
								<tr>
									<th style="background-color: #eeeee; text-align: center;">글쓰기</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><input type="text" class="form-control"
										placeholder="글 제목" name="galleryTitle" maxlength="50"></td>
								</tr>
								<tr>
									<td><textarea class="form-control" placeholder="글 내용"
											name="galleryContent" maxlength="2048" style="height: 350px;"></textarea></td>
								</tr>
								<tr>
									<td><input type="file" name="file"></td>
								</tr>
							</tbody>
						</table>

						<br> <input type="submit" class="btn btn-info" value="글쓰기 완료" />
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