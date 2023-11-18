<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="comment.Comment"%>
<%@ page import="comment.CommentDAO"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name=viewport content="width=device-width , initial-scale=1">

<link href="resources/css/bbsView.css" rel="stylesheet" type="text/css">
<link href="resources/css/fix.css" rel="stylesheet" type="text/css">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<title>멍어스</title>
</head>
<body>

	<%
String userID = null;
if (session.getAttribute("userID") != null) {
    userID = (String) session.getAttribute("userID");
}
int bbsID = 0;
if (request.getParameter("bbsID") != null) {
    bbsID = Integer.parseInt(request.getParameter("bbsID"));
}
if (bbsID == 0) {
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('유효하지 않는 글입니다.');");
    script.println("location.href='bbsList.jsp';");
    script.println("</script>");
}

Bbs bbs = new BbsDAO().getBbs(bbsID);

//조회수 증가 처리
if (session.getAttribute("readBbsList") == null) {
 // 세션에 readBbsList가 없으면 생성
 ArrayList<Integer> readBbsList = new ArrayList<>();
 session.setAttribute("readBbsList", readBbsList);

 // 조회수 증가 메서드 호출
 new BbsDAO().increaseHit(bbsID);
 
 // 현재 글의 ID를 세션에 추가
 readBbsList.add(bbsID);
} else {
 // 세션에 readBbsList가 이미 있을 때
 ArrayList<Integer> readBbsList = (ArrayList<Integer>) session.getAttribute("readBbsList");

 // 현재 글의 ID가 세션에 없으면 조회수 증가 메서드 호출
 if (!readBbsList.contains(bbsID)) {
     new BbsDAO().increaseHit(bbsID);
     
     // 현재 글의 ID를 세션에 추가
     readBbsList.add(bbsID);
 }
}

bbs = new BbsDAO().getBbs(bbsID); // 조회수를 갱신한 후, 갱신된 정보를 다시 가져옵니다.
%>
	<div id="root">
		<%@include file="fix.jsp"%>

		<section id="container">
			<div id="container_box">
				<table class="board-table" style="margin: 0 auto;">
					<thead>
						<tr>
							<th scope="col" class="th-title">제목</th>
							<td><%=bbs.getBbsTitle()%></td>
							<th scope="col" class="th-hit">조회수</th>
							<td><%=bbs.getHit()%></td>

						</tr>

						<tr>
							<th scope="col" class="th-user">작성자</th>
							<td><%=bbs.getUserID()%></td>
							<th scope="col" class="th-date">날짜</th>
							<td><%=bbs.getBbsDate()%></td>

						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="col" class="th-content">내용</th>
							<td colspan='2'><%=bbs.getBbsContent().replaceAll(" ", "&nbsp").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
						</tr>
					</tbody>
				</table>

				<%
            if (userID != null && userID.equals(bbs.getUserID())) {
            %>
				<a href="bbsUpdate.jsp?bbsID=<%=bbsID%>" class="btn btn-info">수정</a>
				<a onclick="return confirm('삭제하시겠습니까?')"
					href="bbsDeleteAction.jsp?bbsID=<%=bbsID%>" class="btn btn-info">삭제</a>
				<%
            }
            %>
				<a href="bbsList.jsp?selectedBoardID=<%=bbs.getBoardID()%>"
					class="btn btn-info">목록</a>
			</div>




			<!-- 댓글 작성 -->
			<% if (userID != null) { %>
			<h4 style="margin-left: 20%; font-weight: bold;">댓글</h4>
			<div style="width: 60%; margin: 0 auto;">
				<form action="cmtWriteAction.jsp" method="post">
					<input type="hidden" name="bbsID" value="<%=bbsID%>"> <input
						type="text" name="cmtContent" required placeholder="댓글을 남겨보세요."
						style="width: 90%; height: 5%;">
					<button type="submit" class="btn btn-info">완료</button>
				</form>
			</div>
			<% } %>

			<!-- 댓글 목록 -->
			<div style="width: 50%; margin-left: 20%">
				<%
    ArrayList<Comment> comments = new CommentDAO().getCommentList(bbsID);
    for (Comment comment : comments) {
    %>
				<div style="display: flex; align-items: start;">
					<!-- 댓글 리스트 -->
					<p><%=comment.getUserID()%>(<%=comment.getCmtDate()%>)
					</p>
					<p style="margin-left: 20px;" id="content_<%=comment.getCmtID()%>"><%=comment.getCmtContent()%></p>

					<!-- 댓글 수정 -->
					<% if (userID != null && userID.equals(comment.getUserID())) { %>
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
					<% } %>
				</div>
				<% } %>
			</div>

			<!-- 댓글 수정폼 -->
			<script>
    function showEditForm(cmtID) {
        document.getElementById('content_' + cmtID).style.display = 'none';
        document.getElementById('editForm_' + cmtID).style.display = 'block';
    }
</script>
		</section>

		<footer id="footer">
			<div id="footer_box">
				<%@ include file="footer.jsp"%>
			</div>
		</footer>
	</div>
</body>
</html>