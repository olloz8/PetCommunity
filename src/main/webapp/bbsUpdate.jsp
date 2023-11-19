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
	int bbsID = 0;
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if (bbsID == 0) {
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
		<%@include file="fix.jsp"%>

		<form method="post" action="bbsUpdateAction.jsp?bbsID=<%=bbsID%>">
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
									String newBbsID = request.getParameter("bbsID");
									BbsDAO bbsDAO = new BbsDAO();
									Bbs newBbs = bbsDAO.getBbs(Integer.parseInt(newBbsID));
									int boardID = newBbs.getBoardID();
									%>
									<td><select name="boardID">
											<option value="">--게시판 선택--</option>
											<option value="1" <%=boardID == 1 ? "selected" : ""%>>자유게시판</option>
											<option value="2" <%=boardID == 2 ? "selected" : ""%>>질문게시판</option>
									</select></td>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><input type="text" class="form-control"
										placeholder="글 제목" name="bbsTitle" maxlength="50"
										value="<%=bbs.getBbsTitle()%>"></td>
								</tr>
								<tr>
									<td><textarea class="form-control" placeholder="글 내용"
											name="bbsContent" maxlangth="2048" style="height: 350px;"><%=bbs.getBbsContent()%></textarea></td>
								</tr>
								<tr>
									<td><input type="file" name="fileName"></td>
								</tr>
							</tbody>
						</table>

						<br> <input type="submit" class="btn btn-dark" value="수정완료" />
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