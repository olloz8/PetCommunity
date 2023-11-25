<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

<title>멍어스</title>


</head>
<body>

	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		int boardID = 0;
		if (request.getParameter("boardID") != null){
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}
	%>

	<div id="root">
		<%@include file="fix.jsp"%>
		<form method="post" action="bbsWriteAction.jsp">
			<section id="container">
				<div id="container_box">
					<div style="width: 60%; margin: auto;">

						<table class="table table-striped"
							style="text-align: center; border: 1px solid #dddddd">
							<thead>
								<p style="text-align : left;"> 📢멍갤러리는 멍갤러리 카테고리에 들어간 후 프로필 글쓰기 버튼을 눌러주세요.</p>
								<tr>
									<th style="background-color: #eeeee; text-align: center;">글쓰기</th>
								</tr>
								<tr>
									<td><select name="boardID">
											<option value="">--게시판선택--</option>
											<option value="1">자유게시판</option>
											<option value="2">질문게시판</option>
									</select>
									</td>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><input type="text" class="form-control"
										placeholder="글 제목" name="bbsTitle" maxlength="50"></td>
								</tr>
								<tr>
									<td><textarea class="form-control" placeholder="글 내용"
											name="bbsContent" maxlength="2048" style="height: 350px;"></textarea></td>
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