<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="gallery.Gallery"%>
<%@ page import="gallery.GalleryDAO"%>
<%@ page import="comment.Comment"%>
<%@ page import="comment.CommentDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<link href="resources/css/bbsView.css" rel="stylesheet" type="text/css">
<link href="resources/css/fix.css" rel="stylesheet" type="text/css">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
.board-table .th-hit {
	width: 200px;
	text-align: center;
}
</style>
<head>
<meta charset="UTF-8">
<meta name=viewport content="width=device-width , initial-scale=1">

<link href="resources/css/galleryView.css" rel="stylesheet"
	type="text/css">
<link href="resources/css/fix.css" rel="stylesheet" type="text/css">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
.board-table .th-hit {
	width: 200px;
	text-align: center;
}
</style>
<title>멍어스</title>
</head>
<body>

	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	int galleryID = 0;
	if (request.getParameter("galleryID") != null) {
		galleryID = Integer.parseInt(request.getParameter("galleryID"));
	}
	if (galleryID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않는 글입니다.');");
		script.println("location.href='galleryList.jsp';");
		script.println("</script>");
	}

	Gallery gallery = new GalleryDAO().getGallery(galleryID);

	//조회수 증가 처리
	if (session.getAttribute("readGalleryList") == null) {
		// 세션에 readGalleryList가 없으면 생성
		ArrayList<Integer> readGalleryList = new ArrayList<>();
		session.setAttribute("readGalleryList", readGalleryList);

		// 조회수 증가 메서드 호출
		new GalleryDAO().increaseHit(galleryID);

		// 현재 글의 ID를 세션에 추가
		readGalleryList.add(galleryID);
	} else {
		// 세션에 readGalleryList가 이미 있을 때
		ArrayList<Integer> readGalleryList = (ArrayList<Integer>) session.getAttribute("readGalleryList");

		// 현재 글의 ID가 세션에 없으면 조회수 증가 메서드 호출
		if (!readGalleryList.contains(galleryID)) {
			new GalleryDAO().increaseHit(galleryID);

			// 현재 글의 ID를 세션에 추가
			readGalleryList.add(galleryID);
		}
	}

	gallery = new GalleryDAO().getGallery(galleryID); // 조회수를 갱신한 후, 갱신된 정보를 다시 가져옵니다.
	%>


	<div id="root">
		<%@include file="fix.jsp"%>

		<section id="container">
			<h3>멍갤러리</h3>
			<div id="container_box">
				<table class="board-table" style="margin: 0 auto;">
					<thead>
						<tr>
							<th scope="col" class="th-title">제목</th>
							<td><%=gallery.getGalleryTitle()%></td>
							<th scope="col" class="th-hit">조회수</th>
							<td><%=gallery.getHit()%></td>

						</tr>

						<tr>
							<th scope="col" class="th-user">작성자</th>
							<td><%=gallery.getUserID()%></td>
							<th scope="col" class="th-date">날짜</th>
							<td><%=gallery.getGalleryDate()%></td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="col" class="th-content">내용</th>
							<td colspan='4'>
								<%
    // 특정 게시글을 가져오는 GalleryDAO 메소드 호출 (galleryID는 적절한 방법으로 받아와야 합니다)
    int targetGalleryID = Integer.parseInt(request.getParameter("galleryID"));
    Gallery targetGallery = new GalleryDAO().getGallery(targetGalleryID);

    // 가져온 게시글의 이미지를 표시
    if (targetGallery != null && targetGallery.getFileName() != null && !targetGallery.getFileName().isEmpty()) {
%> <!-- 이미지 표시 --> 
<img src="uploded/<%= targetGallery.getFileName() %>" alt="게시글 이미지">
								<br> <%
    } else {
        // 해당 게시글이 존재하지 않거나 이미지가 첨부되지 않은 경우
%> <%
    }
%> <%=gallery.getGalleryContent().replaceAll(" ", "&nbsp").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n",
            "<br>")%>
							</td>
						</tr>
					</tbody>
					<tr>
						<td><a href="galleryList.jsp" class="btn btn-info">목록</a></td>
						<%
						if (userID != null && userID.equals(gallery.getUserID())) {
						%>
						<td></td>
						<td></td>
						<td><a href="galleryUpdate.jsp?galleryID=<%=galleryID%>"
							class="btn btn-info">수정</a> <a
							onclick="return confirm('삭제하시겠습니까?')"
							href="galleryDeleteAction.jsp?galleryID=<%=galleryID%>"
							class="btn btn-info">삭제</a></td>
						<%
						}
						%>

					</tr>
				</table>


				<!-- 댓글 작성 -->
				<h4 style="margin-left: 20%; font-weight: bold;">댓글</h4>
				<%
				if (userID != null) {
				%>

				<div style="width: 60%; margin: 0 auto;">
					<form action="cmtWriteAction.jsp" method="post">
						<input type="hidden" name="galleryID" value="<%=galleryID%>">
						<input type="text" name="cmtContent" required
							placeholder="댓글을 남겨보세요." style="width: 90%; height: 5%;">
						<button type="submit" class="btn btn-info">완료</button>
					</form>
				</div>
				<%
				}
				%>

				<!-- 댓글 목록 -->
				<div style="width: 50%; margin-left: 20%">
					<%
					ArrayList<Comment> comments = new CommentDAO().getCommentList(galleryID);
					for (Comment comment : comments) {
					%>
					<div style="display: flex; align-items: start;">
						<!-- 댓글 리스트 -->
						<p><%=comment.getUserID()%>(<%=comment.getCmtDate()%>)
						</p>
						<p style="margin-left: 20px;" id="content_<%=comment.getCmtID()%>"><%=comment.getCmtContent()%></p>

						<!-- 댓글 수정 -->
						<%
						if (userID != null && userID.equals(comment.getUserID())) {
						%>
						<button onclick="showEditForm('<%=comment.getCmtID()%>')"
							class="btn btn-default btn-xs">수정</button>
						<form id="editForm_<%=comment.getCmtID()%>" style="display: none;"
							action="cmtUpdateAction.jsp" method="post">
							<input type="hidden" name="cmtID" value="<%=comment.getCmtID()%>">
							<input type="text" name="cmtContent"
								value="<%=comment.getCmtContent()%>">
							<button type="submit" class="btn btn-default btn-xs">완료</button>
						</form>

						<!-- 댓글 삭제 -->
						<form action="cmtDeleteAction.jsp" method="post">
							<input type="hidden" name="cmtID" value="<%=comment.getCmtID()%>">
							<button type="submit" class="btn btn-default btn-xs">삭제</button>
						</form>
						<%
						}
						%>
					</div>
					<%
					}
					%>
				</div>

				<!-- 댓글 수정폼 -->
				<script>
					function showEditForm(cmtID) {
						document.getElementById('content_' + cmtID).style.display = 'none';
						document.getElementById('editForm_' + cmtID).style.display = 'block';
					}
				</script>
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