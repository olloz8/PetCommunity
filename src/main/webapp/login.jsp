<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멍어스</title>
</head>
<body>
	<div id="root">
		<%@ include file="fix.jsp"%>
		<section id="container">
			<div id="container_box">
				<form action="loginAction.jsp" method="post">

					<div class="container"
						style="display: flex; justify-content: center; align-items: center; height: 60vh;">
						<div class="d-flex justify-content-center h-100">
							<div class="card">
								<div class="card-header">
									<h2>로그인</h2>

								</div>
								<div class="card-body">
									<form>
										<div class="input-group form-group">
											<div class="input-group-prepend">
												<span class="input-group-text"><i class="fas fa-user"></i></span>
											</div>
											<input type="text" name="userID" class="form-control"
												placeholder="ID" required>

										</div>
										<div class="input-group form-group">
											<div class="input-group-prepend">
												<span class="input-group-text"><i class="fas fa-key"></i></span>
											</div>
											<input type="password" name="userPassword" class="form-control"
												placeholder="Password" required>
										</div>

										<div class="form-group">
											<input type="submit" value="Login"
												class="btn float-right login_btn">
										</div>
									</form>
								</div>
								<div class="card-footer">
									<div class="d-flex justify-content-center links">
										처음이신가요? <a href="register.jsp">회원가입</a>
									</div>

								</div>
							</div>
						</div>
					</div>

				</form>
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