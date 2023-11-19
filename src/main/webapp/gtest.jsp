<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

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

</head>
<body>
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
		<form method="post" action="bbsWriteAction.jsp">
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
</body>
</html>