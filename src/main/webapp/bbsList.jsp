<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="resources/css/bbsList.css" rel="stylesheet" type="text/css">
    <link href="resources/css/fix.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <title>멍어스</title>
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
    
    BbsDAO bbsDAO = new BbsDAO();
    int selectedBoardID = 0; // 기본값은 전체 게시판
    if (request.getParameter("selectedBoardID") != null) {
        selectedBoardID = Integer.parseInt(request.getParameter("selectedBoardID"));
    }

    // 선택한 게시판의 정보 가져오기
    String boardTitle = "";
    String boardContent ="";
    if (selectedBoardID == 1) {
        boardTitle = "자유게시판";
        boardContent = "* 주제 상관없이 자유롭게 대화하는 게시판입니다. *";
    } else if (selectedBoardID == 2) {
        boardTitle = "질문게시판";
        boardContent = "* 강아지 관련 질문 이외 질문들은 금지입니다. *";
    } // 다른 게시판에 대한 조건 추가
    %>

    <div id="root">
        <%@ include file="fix.jsp"%>

        <section id="container">
            <div id="container_box">
                <h3><%= boardTitle %></h3>
                <h6><%= boardContent %></h6>

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
                        ArrayList<Bbs> list = bbsDAO.getList(pageNumber, selectedBoardID);
                        for (int i = 0; i < list.size(); i++) {
                        %>
                        <tr>
                            <td><%=list.get(i).getBbsID()%></td>
                            <td><a href="bbsView.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle()%></a></td>
                            <td><%=list.get(i).getUserID()%></td>
                            <td><%=list.get(i).getBbsDate()%></td>
                            <td><%=list.get(i).getHit()%></td>
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>

                <%
                if (pageNumber != 1) {
                %>
                <a href="bbsList.jsp?pageNumber=<%=pageNumber - 1%>">이전</a>
                <%
                }
                if (bbsDAO.nextPage(pageNumber + 1)) {
                %>
                <a href="bbsList.jsp?pageNumber=<%=pageNumber + 1%>">다음</a>
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
