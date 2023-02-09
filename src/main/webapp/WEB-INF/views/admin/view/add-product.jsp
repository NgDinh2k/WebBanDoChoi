<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<c:url value="/resources/static" var="url"></c:url>
<!DOCTYPE html>
<html>
<head>
<script src="<c:url value="/ckeditor/ckeditor.js" />"></script>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Edit User</title>
<!-- BOOTSTRAP STYLES-->
<link href="${url}/css/bootstrap.css" rel="stylesheet" />
<!-- FONTAWESOME STYLES-->
<link href="${url}/css/font-awesome.css" rel="stylesheet" />
<!-- CUSTOM STYLES-->
<link href="${url}/css/custom.css" rel="stylesheet" />
<!-- GOOGLE FONTS-->
<link href='http://fonts.googleapis.com/css?family=Open+Sans'
	rel='stylesheet' type='text/css' />
</head>
<body>
	<div id="wrapper">
		<jsp:include page="/WEB-INF/views/admin/view/nav-bar.jsp"></jsp:include>
		<!-- /. NAV TOP  -->
		<jsp:include page="/WEB-INF/views/admin/view/slide-bar.jsp"></jsp:include>
		<!-- /. NAV SIDE  -->
		<div id="page-wrapper">
			<div id="page-inner">
				<div class="row">
					<div class="col-md-12">
						<h2>Add Product</h2>
						<h5>Add product you can sell</h5>
					</div>
				</div>
				<!-- /. ROW  -->
				<hr />
				<div class="row">
					<div class="col-md-12">
						<!-- Form Elements -->
						<div class="panel panel-default">
							<div class="panel-heading">Add Product</div>
							<div class="panel-body">
								<div class="row">
									<div class="col-md-6">
										<h3>Info Product:</h3>

										<%-- <form role="form" action="add" method="post"
											enctype="multipart/form-data">
											<div class="form-group">
												<label>Name:</label> <input class="form-control"
													placeholder="please enter Product Name" name="name" />
											</div>
											<div class="form-group">
												<label>Price ($)</label> <input class="form-control"
													placeholder="please enter Price" type="number" name="price" />
											</div>
											<div class="form-group">
												<label>Description </label>
												<br>
												<textarea rows="4" cols="50" name="des" id="editer"></textarea>

											</div>

											<div class="form-group">
												<label>Category</label>
												<div class="checkbox">
													<select name="category">
														<c:forEach items="${categories}" var="c">
															<option value="${c.id}">${c.name}</option>
														</c:forEach>
													</select>
												</div>

											</div>
											<div class="form-group">
												<label>image</label> <input type="file" name="image" />
											</div>
											<button type="submit" class="btn btn-default">Add</button>
											<button type="reset" class="btn btn-primary">Reset</button>
										</form> --%>
										<form:form action="insert.htm" modelAttribute="SP">
											<div class="form-group">
												<label>Mã sản phẩm:</label> <form:input class="form-control"
													placeholder="Nhập mã sản phẩm" path="masp" />
											</div>
											<div class="form-group">
												<label>Tên sản phẩm:</label> <form:input class="form-control"
													placeholder="Nhập tên sản phẩm" path="tensp" />
											</div>
											<div class="form-group">
												<label>Nước sản xuất:</label> <form:input class="form-control"
													placeholder="Nhập nước sản xuất" path="nuocsx" />
											</div>
											<div class="form-group">
												<label>Đơn vị tính</label> <form:input class="form-control"
													placeholder="Nhập đơn vị tính" type="number" path="donvitinh" />
											</div>
											<div class="form-group">
												<label>Đơn giá($)</label> <form:input class="form-control"
													placeholder="Nhập đơn giá" type="number" path="dongia" />
											</div>
											<div class="form-group">
												<label>Số lượng tồn</label> <form:input class="form-control"
													placeholder="Nhập số lượng tồn" type="number" path="soluongton" />
											</div>
											<div class="form-group">
												<label>Sale</label> <form:input class="form-control"
													placeholder="Sale" type="number" path="sale" />
											</div>
											<div class="form-group">
												<label>Mô tả </label>
												<br>
												<form:textarea rows="4" cols="50" path="mota" id="editer"></form:textarea>

											</div>

											<div class="form-group">
												<label>Category</label>
												<div class="checkbox">
													<select name="category">
														<c:forEach items="${categories}" var="c">
															<option value="${c.id}">${c.name}</option>
														</c:forEach>
													</select>
												</div>

											</div>
											<div class="form-group">
												<label>Hình ảnh</label> <form:input type="file" path="hinhanh" />
											</div>
											<button type="submit" class="btn btn-default">Insert</button>
										</form:form>

									</div>
								</div>
							</div>
						</div>
						<!-- End Form Elements -->
					</div>
				</div>
				<!-- /. ROW  -->
				<div class="row">
					<div class="col-md-12"></div>
				</div>
				<!-- /. ROW  -->
			</div>
			<!-- /. PAGE INNER  -->
		</div>
		<!-- /. PAGE WRAPPER  -->
	</div>
	<!-- /. WRAPPER  -->
	<!-- SCRIPTS -AT THE BOTOM TO REDUCE THE LOAD TIME-->
	<!-- JQUERY SCRIPTS -->
	<script src="${url}/js/jquery-1.10.2.js"></script>
	<!-- BOOTSTRAP SCRIPTS -->
	<script src="${url}/js/bootstrap.min.js"></script>
	<!-- METISMENU SCRIPTS -->
	<script src="${url}/js/jquery.metisMenu.js"></script>
	<!-- CUSTOM SCRIPTS -->
	<script src="${url}/js/custom.js"></script>
<script type="text/javascript" language="javascript">
   CKEDITOR.replace('editer', {width: '700px',height: '300px'});
</script>
</body>
</html>