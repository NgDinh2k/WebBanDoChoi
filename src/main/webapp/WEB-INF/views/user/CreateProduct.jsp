<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:url value="/resources/static" var="url"></c:url>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>List User</title>
<!-- BOOTSTRAP STYLES-->
<link href="${url}/css/bootstrap.css" rel="stylesheet" />
<link href="${url}/css/container.css" rel="stylesheet" />
<!-- FONTAWESOME STYLES-->
<link href="${url}/css/font-awesome.css" rel="stylesheet" />
<!-- MORRIS CHART STYLES-->

<!-- CUSTOM STYLES-->
<link href="${url}/css/custom.css" rel="stylesheet" />
<!-- GOOGLE FONTS-->
<link href='http://fonts.googleapis.com/css?family=Open+Sans'
	rel='stylesheet' type='text/css' />
<!-- TABLE STYLES-->
<link href="${url}/js/dataTables/dataTables.bootstrap.css"
	rel="stylesheet" />
<style type="text/css">
.form-edit {width =662px;
	height: 531px;
	color: black;
}
.bodyform-edit{
	display: flex;
	flex-direction: column;
	background: #cccccc5c; 
	margin-right: 64px; 
	height: 650px;
 	margin: auto;
  	width: 900px; 
   	border-radius: 25px;
   	padding-left:90px;
  	padding-right: 30px;
  	margin-left: 8%;
    margin-top: 2%;
}
.order_sell {
	float: right !important;
}

.btn-setting:hover, .btn-delete:hover {
	opacity: 0.5;
}

.btn-setting, .btn-delete {
	cursor: pointer
}

.btn:hover {
	background-color: #41464b;
	color: white;
}

#btn_huy, .btn_Oke {
	width: 90px;
}

.modal {
	position: fixed;
	top: 0;
	right: 0;
	bottom: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: #00000040;
	display: block;
}

.modal-title {
	margin-left: 150px;
}

.modal-form {
	margin-top: 60px;
	margin-left: 400px;
}

.modal-body {
	display: flex;
	flex-direction: column;
	justify-content: center;
	margin-left: 28px;
}

.modal-content {
	border-radius: 12px;
	margin-right: 118px;
}

#modal-success {
	display: none;
	margin-top: 80px;
	margin-left: 120px;
}

.modal-footer {
	margin-right: 33px;
}

.bi-gear {
	color: #df1919;
	padding-right: 6px;
}

.bi-trash {
	color: #23af19;
}

.table {
	
}

.order {
	display: none;
}

.input_order {
	margin-bottom: 10px;
	width: 100%;
}

.btn-mr20 {
	margin-right: 20px
}
.btn-update{
	width: 25vh;
	margin-left: 90vh;
}
a {
	color: white !important;
	text-decoration: none;
}

.sign-out:hover {
	opacity: 0.5;
}

.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}
#mota{
height: 100px;
}
.anhsp {
	width: 36px;
	height: 36px;
}


.labels {
	font-weight: Bold;
	font-size:15px;
	color: black;
}

.heading-formProduct{
	padding-top: 20px;
	margin-bottom: 30px;
}
.row{
	padding-bottom: 20px;
	width: 119vh;
}
.col{
	
}
.title-form{
	margin-top: 36px;  
    color: #red;
    font-size: 4rem;
    font-family: auto;
    text-align: center;
    font: 1000;
    
}
.id_sp{
	margin-left:5px;
	border: none;
	background: inherit;
	font-weight: 600;
}
 #loaisp ,	#nuocsx{
 	font-weight: 500;
 }
  *[id$=errors]{
color:red;
font-style: italic;
}
.row_1,.row_2,.row_3{
margin-top: 40px;
margin-right: 5%;
margin-left: -4%;

}
.row_1{
justify-content: space-between;
    display: flex;

}
.row_2{
justify-content: space-between;
    display: flex;

}
.row_3{
justify-content: space-between;
    display: flex;
}

</style>



</head>
<body>
	<div id="wrapper">

		<jsp:include page="/WEB-INF/views/admin/view/nav-bar.jsp"></jsp:include>

		<!-- /. NAV TOP  -->
		<jsp:include page="/WEB-INF/views/admin/view/slide-bar.jsp"></jsp:include>
		<!-- /. NAV SIDE  -->
		<div id="page-wrapper">

			<form:form action="create.htm" modelAttribute="product" method="POST"
				class="bodyform-edit" enctype="multipart/form-data">
				<h2 class="title-form">PRODUCT CREATE/EDIT</h2>


				<div class="row_1" style="margin-top: 56px;">

					<div class="" style="width: 350px;">
						<label class="labels">TÊN SẢN PHẨM :</label>
						<form:input 
							class="input_order form-control " type="text" value=""
							path="tensp" />
						<form:errors path="tensp" />
					</div>

					<div class="" style="width: 350px;">
						<label class="labels" style="">NƯỚC SẢN XUẤT:</label>
						<form:select path="nuocsx" items="${nuoc}" style="height: 35px"
							class="input_order form-control "  />
						<form:errors path="nuocsx" />
					</div>
				</div>
				<div class="row_2">
					<div class="" style="width: 350px;">
						<label class="labels">ĐƠN GIÁ :</label>
						<form:input 
							class="input_order form-control" path="dongia" type="number"
							value="" />
						<form:errors path="dongia" />
					</div>
					<div class="" style="width: 350px;">
						<label class="labels">MÔ TẢ</label>
						<form:textarea 
							class="input_order form-control" path="mota" />

					</div>
				</div>
				<div class="row_2">
					<form:hidden path="soluongton" value="0" />
					<div class="" style="width: 350px;">
						<label class="labels">HÌNH ẢNH :</label>
						<form:input 
							class="input_order form-control" type="text" value=""
							path="hinhanh" />
							<input name="photo" type="file" class="form-control" style="border: none;outline: none;" /> 
					</div>
					<div class="" style="width: 350px;">
						<label class="labels" style="width: 191px;">LOẠI SẢN PHẨM:</label>
						<form:select path="loaisp" items="${loaisps}" style="height: 36px"
							class="input_order form-control">
						</form:select>
						<form:errors path="loaisp" />
					</div>
				</div>
				<button name="btnCreate" type="submit"
					class="btn btn-primary btn-lg"
					style="margin-top: 5%; margin-left: 30%;margin-right: 30%; text-align: center;">SAVE
					PRODUCT</button>

			</form:form>

		</div>
		<!-- /. PAGE INNER  -->
	</div>
	<!-- /. PAGE WRAPPER  -->
	<!-- /. WRAPPER  -->
	<!-- SCRIPTS -AT THE BOTOM TO REDUCE THE LOAD TIME-->
	<!-- JQUERY SCRIPTS -->
	<script src="${url}/js/jquery-1.10.2.js"></script>
	<!-- BOOTSTRAP SCRIPTS -->
	<script src="${url}/js/bootstrap.min.js"></script>
	<!-- METISMENU SCRIPTS -->
	<script src="${url}/js/jquery.metisMenu.js"></script>
	<!-- DATA TABLE SCRIPTS -->
	<script src="${url}/js/dataTables/jquery.dataTables.js"></script>
	<script src="${url}/js/dataTables/dataTables.bootstrap.js"></script>
	<script>
		$(document).ready(function() {
			$('#dataTables-example').dataTable();
		});
	</script>
	
	<!-- CUSTOM SCRIPTS -->
	<script src="${url}/js/custom.js"></script>
	<script type="text/javascript">   
	    const buyBtns = document.querySelectorAll('.js-delete')
	    console.log(buyBtns);
	    for(const buyBtn of buyBtns){
	        buyBtn.addEventListener('click', function(){
	        	if(confirm("Bạn có chắc muốn xóa nhân viên này")==false)
	        	{
	        		buyBtn.href="/java5/admin/NV.htm";
	        		

	        	}
	        	else
	        	{
	        		console.log(buyBtn.getAttribute("name"));
	        		var t = "/java5/admin/NV/delete/" + buyBtn.getAttribute("name") + ".htm";
	        		buyBtn.href= t ;

	        	}
	        });
	    }
	</script>


</body>
</html>