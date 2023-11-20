<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="file.fileDAO, java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>Gallery</title>
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

    <!-- 파일 업로드 폼 -->
    <form action="uploadAction.jsp" method="post" enctype="multipart/form-data">
        파일 : <input type="file" name="file"><br>
        <input type="submit" value="업로드"><br>
    </form>

    <!-- DB에서 이미지를 읽어와서 표시 -->
    <div class="gallery">
        <%
            try {
                file.fileDAO fileDao = new file.fileDAO();
                List<String> fileRealNames = fileDao.getAllFileRealNames();
                for (String fileRealName : fileRealNames) {
        %>
                    <img src="uploded/<%=fileRealName %>" alt="업로드한 이미지">
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </div>

</body>
</html>