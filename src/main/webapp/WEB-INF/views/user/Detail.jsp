<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.80.0">

<link rel="canonical"
	href="https://getbootstrap.com/docs/5.0/examples/sign-in/">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.0/font/bootstrap-icons.css">

<!-- Bootstrap core CSS -->
<!-- <link href="assets/dist/css/bootstrap.min.css" rel="stylesheet"> -->
<link
	href="<c:url value='/resources/assets/dist/css/bootstrap.min.css' />"
	rel="stylesheet">

<style>
.order_sell {
	float: right !important;
}

.btn-setting:hover {
	opacity: 0.5;
}

.btn-setting {
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

.bi-gear {
	color: black
}

.table {
	max-width: 520px;
    max-height: 300px;
}

.hr-form{
	max-width: 548px;
    margin: auto;
    margin-top: 16px;
    margin-left: 10%
}
.order {
	display: none;
}

.btn-mr20 {
	margin-right: 20px
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

.product_image {
	width: 16px;
	height: 16px;
}
	.anhsp{
	width: 30px;
	height: 30px;
	}
.input_order {
	width: 100%;
}
.row{
    margin-left: 10%;
    margin-top: 3%;
}

.col {
	
}

.form-detail {
	width: 700px;
	height: 500px;
	background: white;
	margin-left: 450px;
	margin-top: 49px;
	border: 2px solid black;

}
.form-border{
	width: 660px;
	height: 470px;
	margin-left:18px;
	border: 2px solid #41464bb8;
	margin-top: 14px;
}
.header-form{
height: 150px;
}

.tittle-header{
	max-width: 300px;
	margin-left: 30%;
    padding-top: 6%;
    margin-top: -1%;
    color: #002bff;
}
.body-form{
height: 200px;
}
.footer-form{
	margin-left: 1%;
    margin-top: -1%;
}

.btn-close{
	float: right;
    margin-top: -10%;
    margin-right: 3%;
    opacity: 1;
}
.btn-close:hover {
	cursor: pointer;
	opacity: 0.5;
}
label{
	font-weight: 600 !important;
}
.list-order{
list-style-type:decimal;
width: 516px;
height: 151px;
white-space: nowrap; 
  border: 1px solid #000000;
  overflow: scroll;
  text-overflow: clip; 
}
.title_sp,.formlist{
	margin-left: 12%;
	margin-top: 2%;
}
.noidung{
	font-weight: 450;
}
.table-responsive {
    max-height:80%;
    max-width:82%;
}
</style>


<!-- Custom styles for this template -->
<link href="<c:url value='resources/assets/dist/signin.css' />"
	rel="stylesheet">
</head>
<body>

	<div style="display: flex; justify-content: space-between"
		id="body_content">
		<div class="d-flex flex-column flex-shrink-0 p-3 text-white bg-dark"
			style="width: 280px; height: 100vh;">
			<div class="">
				<a href="#"
					class="d-flex align-items-center text-white text-decoration-none "
					id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
					<img src="https://github.com/mdo.png" alt="" width="32" height="32"
					class="rounded-circle me-2" style="margin-left: 11px;"> <strong
					style="margin-left: 6px"></strong>
				</a>

			</div>
			<hr>
			<ul class="nav nav-pills flex-column mb-auto" id="list_item">
				<li class="nav-item nav-click"><a href="/WebBanDoChoi/user/home.htm"
					class="nav-link "> <i class="bi bi-house-door"></i> Home
				</a></li>

				<li><a href="/WebBanDoChoi/user/profile.htm"
					class="nav-link text-white " id="profile_click"> <i
						class="bi bi-person-circle"></i> Profile
				</a></li>

				<li><a href="/WebBanDoChoi/user/order.htm"
					class="nav-link text-white active" id="order_click"> <i
						class="bi bi-table"></i> Orders
				</a></li>
				<li><a href="/WebBanDoChoi/user/products.htm"
					class="nav-link text-white "> <i class="bi bi-grid"></i>
						Products
				</a></li>

			</ul>
			<hr>

			<a href="#" class="sign-out" style="padding-left: 66px"><i
				class="bi bi-box-arrow-left "></i> Sign out</a>
		</div>
		<div class="modal" id="modal">
			<div class="form-detail">
			<div class="form-border">
			<div class="header-form">
			<h3 class="tittle-header">Chi tiết đơn đặt hàng</h3>
			<a class="btn-close" href="/WebBanDoChoi/user/${linkx}.htm"></a>
			<div class="info" style="display: flex;flex-direction: column;">
				<div class="row">
				<div class="col">
				<label>Người nhận:<span class="noidung">${ctddh.hotenkh}</span></label>
				<br>
				<label>Địa chỉ:<span class="noidung"> ${ctddh.diachi}</span></label>
				</div>			
				<div class="col">
				<label>Số điện thoại: <span class="noidung">${ctddh.SDT}</span></label>
				<br>
				<label>Email: <span class="noidung">${ctddh.email}</span></label>
				</div>
				</div>
			</div>
			</div>
			<hr  class="hr-form">
			<div class="body-form">
			<h5 class="title_sp" >Danh sách sản phẩm</h5>
			<div class="formlist table-responsive" >
		
				
				<table class="table table-bordered ">
  <thead>
    <tr>
      <th scope="col">Tên sản phẩm</th>
      <th scope="col">Hình ảnh</th>
      <th scope="col">Số lượng</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="u" items="${ctddh.getCtddhlist()}">
    <tr>
  
      <th scope="row">${u.getSanpham().getTensp()}</th>
      <td><img alt="ảnh sản phẩm"  class="anhsp" src="/WebBanDoChoi/resources/images/${u.getSanpham().getHinhanh()}"> </td>
      <td>${u.getSL()}</td>
    </tr></c:forEach>
    </tbody>
    </table>
    
			
			

			</div>
			</div>
			<hr class="hr-form">
			<div class="footer-form">
			<div class="row">
			<div class="col">
			<label style="">Tổng tiền:${Tonggia}<span class="noidung"></span></label>
	
			</div>
			<div class="col">
				<label>Trạng thái: <span class="noidung" style="font-weight: 500">${ctddh.trangthai}</span></label>
				<br>
				<label>ngày lập: <span class="noidung">${ctddh.getHoadon().getNgaylaphd()}</span></label>
				</div>
			</div>
			</div>
			</div>
		</div>
	</div>
	</div>

</body>

</html>