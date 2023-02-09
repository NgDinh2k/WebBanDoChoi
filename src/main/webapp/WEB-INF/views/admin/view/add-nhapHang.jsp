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
<title>List Import</title>
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
	height: 500px;
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
    color: red;
    font-size: 4rem;
    font-family: auto;
    text-align: center;
    
}
.id_sp{
	margin-left:5px;
	border: none;
	background: inherit;
	font-weight: 600;
}
 #loaisp ,	#nuocsx{
 	background: #0000000f;
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
.tableCT{
	font-size: 18px;
	display: flex;
	flex-direction: column;
	margin-right: 64px; 
	height: 500px;
 	margin: auto;
  	width: 900px; 
   	
  	margin-left: 8%;
    margin-top: 80px;
}
.btncss{
	margin-top: 5%; 
    padding-left: 8%;
    padding-right: 8%;
}
hr {
  margin: 1rem 0;
  color: red;
  border: 0;
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
				<h2 class="title-form" style="text-align: center;">IMPORT CREATE </h2>
				
				<form:form action="add.htm" modelAttribute="NH" method="POST" class="bodyform-edit">
				<div class="row_2">
					<div class="" style="width: 350px;">
						<label class="labels">NGÀY NHẬP :</label>
						<form:input path="NGAYNHAP" class="form-control input_order"
							type="date" id="NGAYNHAP" onload="getDate()"/>
					</div>
					<div class="" style="width: 350px;">
						<label class="labels" style="width: 191px;">TÊN NHÂN VIÊN:</label>
						<form:input class="form-control" readonly="true"
							 type="text" path="tenNhanVien"
							value="${nv.hoten }" />
						<form:hidden path="maNhanVien" value="${nv.manv }"/>
					</div>
				</div>
				<hr class="bg-danger border-2 border-top border-danger">
				<div class="row_2" style="margin-top: 56px;">
					<div class="" style="width: 350px;">
						<label class="labels">MÃ SẢN PHẨM:</label>
							<input class="form-control input_order" readonly="true"
							placeholder="Mã Sản Phẩm" id="maSanPham" />
					</div>

					<div class="" style="width: 350px;">
						<label class="labels" style="">TÊN SẢN PHẨM:</label>
						<select class="form-control" id="tenSanPham">
							<c:forEach items="${listSP}" var="sp">
								<option value="${sp.tenSP}" data-id="${sp.maSP}">${sp.tenSP}<option>
							</c:forEach>
						<select>
					</div>
				</div>
				<div class="row_2">
					<div class="" style="width: 350px;">
						<label class="labels">ĐƠN GIÁ :</label>
						<input class="form-control input_order"
							type="number" id="DONGIA" min='1' />
					</div>
					<div class="" style="width: 350px;">
						<label class="labels">SỐ LƯỢNG</label>
						<input class="form-control input_order" 
							id="SL" type="number" />
					</div>
				</div>
				
				<div style="display: flex; justify-content: center;">
				<button id="btnCreate" type="button" name="btnCreate" style="margin-right: 20px"
					class="btn btn-primary btn-lg btncss">ADD
					</button>
					<button name="btnCreate" type="submit"
					class="btn btn-primary btn-lg btncss btn-success" style="margin-left: 20px">SAVE
					</button>
					</div>
				<div id="inputHidden">
				</div>
				</form:form>
				<div class="tableCT">
			<table id="tableCTNH" class="table table-striped">
				<thead>
					<tr>
						<th scope="col">Mã Sản Phẩm</th>
						<th scope="col">Tên Sản Phẩm</th>
						<th scope="col">Đơn Giá</th>
						<th scope="col">Số Lượng</th>
						<th scope="col">Action</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		
		</div>
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
	<script type="text/javascript">
		$(function() {
			var tableIndex = 0;
			$('select#tenSanPham').on('change', function() {
				var maSP = $(this).find('option:selected').attr('data-id');
				$('#maSanPham').val(maSP);
			})
			$('select#tenSanPham').trigger('change');
			
			$('#btnCreate').on('click', function() {
				var maSP = $('#maSanPham').val();
				var SL = $('#SL').val();
				var DONGIA = $('#DONGIA').val();
				var tenSP = $('#tenSanPham').find('option:selected').val();
				
				$('#tableCTNH > tbody:last-child').append('<tr><th scope="row">'+ maSP
						+'</th><td>'+tenSP+'</td><td>'+DONGIA+'</td><td>'+SL+'</td><td class="remove"><i class="bi bi-trash "> Delete</i></td></tr>');
				$('#inputHidden').append('<input type="hidden" name="listDetail['+tableIndex+'].maSanPham" value="'+ maSP +'">'+
						'<input type="hidden" name="listDetail['+tableIndex+'].DONGIA" value="'+ DONGIA +'">'+
						'<input type="hidden" name="listDetail['+tableIndex+'].SL" value="'+ SL +'">');
				tableIndex ++;
			});
			
			$(document).on('click', '.remove', function () {
				var index = $(this).closest('tr').index();
				$('input[name="listDetail['+index+'].maSanPham"]').remove();
				$('input[name="listDetail['+index+'].DONGIA"]').remove();
				$('input[name="listDetail['+index+'].SL"]').remove();
				$(this).closest('tr').hide();
				
			});
			Date.prototype.toDateInputValue = (function() {
			    var local = new Date(this);
			    local.setMinutes(this.getMinutes() - this.getTimezoneOffset());
			    return local.toJSON().slice(0,10);
			});
			 $('#NGAYNHAP').val(new Date().toDateInputValue());
		})
	</script>
	


</body>
</html>