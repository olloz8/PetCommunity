<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
        <div class="row">
            <form method="post" action="writeAction.jsp"><!-- 데이터를 액션페이지로, 셀제로 글등록 -->
                <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
                    <thead>
                        <tr><!-- 테이블의 행, 한줄 -->
                            <th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식                                  </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr><!-- 테이블의 행, 한줄 -->
                            <td>
                                <input type="text" class="form-control" placeholder="글 제                                                                                목" name="bbsTitle" maxlength="50">
                            </td>
                        </tr>
                        <tr><!-- 테이블의 행, 한줄 -->
                            <td><textarea class="form-control" placeholder="글 내                                                                                        용" name="bbsContent" maxlangth="2048" style="height: 350px;"></textarea>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <!-- 데이터를 액션페이지로 -->

                <input type="submit" class="btn btn-primary pull-right" value="글쓰기">
            </form>
        </div>
    </div>
</body>
</html>