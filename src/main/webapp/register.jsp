<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="resources/css/register.css" rel="stylesheet" type="text/css">

<title>멍어스</title>
</head>
<body>
	<div id="root">
		<%@ include file="fix.jsp"%>
		<section id="container">
			<div id="container_box">
				<div class="container">
					<div class="row main">
						<div class="main-login custom-form">
							<h3>회원가입</h3>
							
							<form action="registerAction.jsp" method="post">
								<div class="form-group">
									<label for="name" class="cols-sm-2 control-label">아이디</label>
									<div class="cols-sm-10">
										<div class="input-group">
											<span class="input-group-addon"><i
												class="fa fa-user fa" aria-hidden="true"></i></span> <input
												type="text" class="form-control" name="userID"
												placeholder="ID" />
										</div>
									</div>
								</div>

								<div class "form-group">
                  					<label for="email" class="cols-sm-2 control-label">비밀번호<label>
                    				<div class="cols-sm-10">
                        				<div class="input-group">
                            				<span class="input-group-addon"><i class="fa fa-envelope fa" aria-hidden="true"></i></span>
                            					<input type="password" class="form-control" name="userPassword" placeholder="Password"/>
                        				</div>
                   				 	</div>
								
						</div>

                <div class="form-group">
                  <label for="username" class="cols-sm-2 control-label">이름</label>
                    <div class="cols-sm-10">
                        <div class="input-group">
                           <span class="input-group-addon"><i class="fa fa-users fa" aria-hidden="true"></i></span>
                           <input type="text" class="form-control" name="userName"  placeholder="Name"/>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                        <label for="password" class="cols-sm-2 control-label">이메일</label>
                        <div class="cols-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
                                <input type="text" class="form-control" name="userEmail" placeholder="Email"/>
                            </div>
                        </div>
                </div>
                
                <div class="form-group">
                        <input type="submit" value="Register" class="btn float-right login-button" />
                    </div>
                    
                </form>
            </div>
        </div>
    </div>
			
	
	
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