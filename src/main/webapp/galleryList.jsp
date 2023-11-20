<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="gallery.GalleryDAO"%>
<%@ page import="gallery.Gallery"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="file.fileDAO, java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="resources/css/bbsList.css" rel="stylesheet" type="text/css">
<link href="resources/css/fix.css" rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<title>멍어스</title>
<style>
        .gallery {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 10px;
        }

        .gallery img {
            width: 100%;
            height: auto;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 5px;
            box-sizing: border-box;
        }
    </style>
</head>
<body>
	<%
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    int pageNumber = 1;
    if (request.getParameter("pageNumber") != null) {
        pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
    }
    
    GalleryDAO galleryDAO = new GalleryDAO();

    %>

	<div id="root">
		<%@ include file="fix.jsp"%>

		<section id="container">
			<div id="container_box">
				<h3>멍갤러리</h3>

				<table class="board-table">
					<thead>
						<tr>
							<th scope="col" class="th-num">번호</th>
							<th scope="col" class="th-title">제목</th>
							<th scope="col" class="th-user">작성자</th>
							<th scope="col" class="th-date">날짜</th>
							<th scope="col" class="th-hit">조회수</th>
						</tr>
					</thead>
					<tbody>

						<%
                        // 선택한 게시판의 글 목록 가져오기
                        ArrayList<Gallery> list = galleryDAO.getList(pageNumber);
                        for (int i = 0; i < list.size(); i++) {
                        %>
						<tr>
							<td><%=list.get(i).getGalleryID()%></td>
							<td><a
								href="galleryView.jsp?galleryID=<%=list.get(i).getGalleryID()%>"><%=list.get(i).getGalleryTitle()%></a></td>
							<td><%=list.get(i).getUserID()%></td>
							<td><%=list.get(i).getGalleryDate()%></td>
							<td><%=list.get(i).getHit()%></td>
						</tr>
						<%
                        }
                        %>
					</tbody>
				</table>
				
<div class="gallery">
<%
    try {
        gallery.GalleryDAO galleryDao = new gallery.GalleryDAO();
        List<String> fileRealNames = galleryDao.getAllFileRealNames();
        for (String fileRealName : fileRealNames) {
            // 파일 이름으로 게시글의 galleryID를 가져오는 메서드 호출
            int galleryId = galleryDao.getGalleryIDByFileName(fileRealName);
%>
            <a href="galleryView.jsp?galleryID=<%=galleryId%>">
                <img src="uploded/<%=fileRealName %>" alt="업로드한 이미지">
            </a>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</div>
			
				<%
                if(pageNumber != 1) { //현재 페이지가 있는지, 버튼 생성
            %>
				<a href="gallery.jsp?pageNumber=<%=pageNumber - 1 %>"
					class="btn btn-success btn-arraw-left">이전</a>
				<%
                } if(galleryDAO.nextPage(pageNumber + 1)) { //다음 페이지가 존재하는지
            %>
				<a href="gallery.jsp?pageNumber=<%=pageNumber + 1 %>"
					class="btn btn-success btn-arraw-left">다음</a>
				<% 
                }
            %>
				<button>
					<a href="galleryWrite.jsp">글쓰기</a>
				</button>
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
