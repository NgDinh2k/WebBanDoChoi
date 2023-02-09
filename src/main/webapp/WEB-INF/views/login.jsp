
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglib.jsp"%>
<%@include file="/WEB-INF/views/include/header.jsp"%>
 <script>
 document.getElementById("TenPage").innerHTML = "Login";
 
 </script>
<section class="padding-top100 login-page">
	<div class="container">
		<div class="row" style="display: flex; justify-content: center">
			<div class="col-sm-6 col-xs-12">
				<div class="login-content">
					<h4>Login</h4>
					<div>${messageA}</div>
					<form action="login/login.htm" method="post">
						<div class="form-group">
							<label for="input-email" class="control-label">User Name<span>*</span></label>
							<input name="taiKhoan" type="text" class="form-control" />
							<p
								style="color: #ff3366; font-size: 12px; margin-top: 5px; margin-bottom: 0px;">
								${errorTK}</p>
						</div>
						<div class="form-group">
							<label for="input-email" class="control-label">Password<span>*</span></label>
							<input name="matKhau" type="password" class="form-control" />
							<p
								style="color: #ff3366; font-size: 12px; margin-top: 5px; margin-bottom: 0px;">
								${errorMK}</p>
						</div>
						<div class="form-group">

							<img src="${pageContext.request.contextPath}/captcha/index.htm">
							<s:message code="login.Captcha.palceholder"
								var="placeHolderCaptcha" />

							<input style="margin-top: 10px; width: 50%;" name="captcha"
								type="text" class="form-control"
								placeholder="${placeHolderCaptcha}" style="" />

							<p
								style="color: #ff3366; font-size: 12px; margin-top: 5px; margin-bottom: 0px;">
								${errorCaptcha}</p>
						</div>

						<div class="site-btn">
							<button style="border-radius: 30px" class="btn btn-1">
								<a href="" class="btn btn-1"> <span class="txt">Login</span>
									<span class="round"><i class="fa fa-chevron-right"></i></span>
								</a>
							</button>
						</div>
						
					</form>
				</div>
			</div>

		</div>


	</div>
</section>

<%@include file="/WEB-INF/views/include/footer.jsp"%>
