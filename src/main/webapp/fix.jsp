<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name=viewport content="width=device-width , intial-scale=1">

<link href="resources/css/profile.css" rel="stylesheet" type="text/css">
<link href="resources/css/fix.css" rel="stylesheet" type="text/css">

<link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
	integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/"
	crossorigin="anonymous">

<title>멍어스</title>
</head>
<body>
	<header id="header">
		<div id="header_box">
			<%@ include file="header.jsp"%>
		</div>
	</header>

	<section>
		<aside>
			<br>
			<div id="custom-pro">
				<%@ include file="profile.jsp"%>
			</div>
			<br>
			<ul>
				<li><a href="bbsList.jsp?selectedBoardID=0">전체게시판</a></li>
				<li><a href="bbsList.jsp?selectedBoardID=1">자유게시판</a></li>
				<li><a href="bbsList.jsp?selectedBoardID=2">질문게시판</a></li>
				<li><a href="gallery.jsp">멍갤러리</a></li>
				<li><a href="calendar.jsp">멍캘린더</a></li>
				<li><a href="map.jsp">동물병원찾기</a></li>
				<li><a href="https://www.youtube.com/@Bodeumofficial" target='_blank'>강형욱의 보듬TV</a></li>
			</ul>
		</aside>
	</section>
</body>
</html>