<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="gallery.GalleryDAO"%>
<%@ page import="gallery.Gallery"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List" %>

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
                    📢 강아지 사진을 올려보세요! 게시글 작성 시 꼭 사진 첨부 바랍니다. <br>
                    💡 사진 클릭 시 상세 페이지로 넘어갑니다.
                    
                <br><br>
<div class="gallery">
    <%
        try {
            gallery.GalleryDAO galleryDao = new gallery.GalleryDAO();
            List<String> fileRealNames = galleryDao.getFileRealNamesByAvailability(1);
            
            for (String fileRealName : fileRealNames) {
                // 파일 이름으로 게시글의 galleryID를 가져오는 메서드 호출
                int galleryId = galleryDao.getGalleryIDByFileName(fileRealName);
                
                // galleryAvailable이 1인 경우에만 이미지를 표시
                if (galleryDao.isGalleryAvailable(galleryId)) {
                    // 게시글 정보 가져오기
                    gallery.Gallery gallery = galleryDao.getGallery(galleryId);
                    
                    // galleryTitle과 userID 표시
    %>
                    <div class="gallery-item">
                        <a href="galleryView.jsp?galleryID=<%=galleryId%>">
                            <img src="uploded/<%=fileRealName %>" alt="업로드한 이미지">
                        </a>
                        <div class="gallery-info">
                            <h5 style="text-align:center;"><%=gallery.getGalleryTitle()%></h5>
                            <p style="text-align:center;"><%=gallery.getUserID()%></p>
                        </div>
                    </div>
    <%
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</div>
			
				<%
                if(pageNumber != 1) { //현재 페이지가 있는지, 버튼 생성
            %>
				<a href="galleryList.jsp?pageNumber=<%=pageNumber - 1 %>"
					class="btn btn-success btn-infp">이전</a>
				<%
                } if(galleryDAO.nextPage(pageNumber + 1)) { //다음 페이지가 존재하는지
            %>
				<a href="galleryList.jsp?pageNumber=<%=pageNumber + 1 %>"
					class="btn btn-success btn-info">다음</a>
				<% 
                }
            %>
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
