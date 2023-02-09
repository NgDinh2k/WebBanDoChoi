
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<c:url value="/resources/static" var="url"></c:url>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Product Management</title>
<!-- BOOTSTRAP STYLES-->
<link href="${url}/css/bootstrap.css" rel="stylesheet" />
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
	
<link href="${url}/css/container.css" rel="stylesheet" />
</head>
<body>
	<div id="wrapper">

		<jsp:include page="/WEB-INF/views/admin/view/nav-bar.jsp"></jsp:include>

		<!-- /. NAV TOP  -->
		<jsp:include page="/WEB-INF/views/admin/view/slide-bar.jsp"></jsp:include>
		<!-- /. NAV SIDE  -->
		<div id="page-wrapper">
		<div id="page-inner" style="min-height: 50px;">
				<div class="row">
					<div class="col-md-12">
						<h2>All Product</h2>
						<h5>You can management product in here</h5>

					</div>
				</div>
				<!-- /. ROW  -->
				<hr />
				${message}
				<form:form action="/java5/admin/listSP.htm" modelAttribute="SP">
				
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
											<button name="${btnStatus}" class="btn btn-primary">Save</button>
										</form:form>
		</div>
  



<br>
				
				
				
				<div class="row">
					<div class="col-md-12">
						<!-- Advanced Tables -->
						<div class="panel panel-default">
							<div class="panel-heading">Advanced Tables</div>
							<div class="panel-body">
								<div class="table-responsive">
									<table class="table table-striped table-bordered table-hover"
										id="dataTables-example">
										<thead>
											<tr>
												<th>Mã sản phẩm</th>
												<th>Tên sản phẩm</th>
												<th>Hình ảnh</th>
												<th>Nước sản xuất</th>
												<th>Mô tả</th>
												<th>Đơn giá</th>	
												<th>Đơn vị tính</th>
												<th>Số lượng tồn</th>
												<th>Sale</th>
												<th>Action </th>
											</tr>
										</thead>
										<tbody>
										<c:forEach items="${listSP}" var="sp" >
											<tr class="odd gradeX">
												<td>${sp.masp }</td>
												<td>${sp.tensp }</td>
													<c:url value="${sp.hinhanh }" var="imgUrl"></c:url>
													<td><img height="150" width="200" src="${sp.hinhanh}" /></td>
													
													<td>${sp.nuocsx }</td>
												<td height="150" width="200">${sp.mota }</td>
												<td>${sp.dongia }</td>
												<td>${sp.donvitinh} </td>
												<td>${sp.soluongton }</td>
												<td>${sp.sale }</td>
												<td>
							
														<a href="#" class="center">Insert</a> <br><br>
														<a href="/java5/admin/listSP/${sp.masp.trim()}.htm?linkEdit"
														class="center">Edit</a> <br><br>
														<a href="/java5/admin/listSP/${sp.masp.trim()}.htm?linkDelete"
														class="center">Delete</a></td>
														
											</tr>
											</c:forEach>
											
					<!-- Container -->
											<div class="modal js-modal">
										    <div class="modal-container js-modal-container">
										        <div class="modal-close js-modal-close">
										            <i class="ti-close"></i>
										        </div>
										
										        <header class="modal-header">
										            <i class="modal-heading-icon ti-bag"></i>
										            Tickets
										        </header>
										
										        <div class="modal-body">
										            <label for="ticket-quantity" class="modal-label">
										                <i class="ti-shopping-cart"></i>
										                Tickets, $15 per person
										            </label>
										            <input id="ticket-quantity" type="text" class="modal-input" placeholder="How many?">
										            <label for="ticket-email" class="modal-label">
										                <i class="ti-user"></i>
										                Send to
										            </label>
										            <input id="ticket-email" type="text" class="modal-input" placeholder="Enter email">
										
										            <button id="buy-tickets">
										                <i class="ti-check"></i>
										                Pay
										            </button>
										        </div>
										        
										        

        <footer class="modal-footer">
            <p class="modal-help">Need <a href="#">help?</a></p>
        </footer>
    </div>
</div>
											
										</tbody>
									</table>
								</div>

							</div>
						</div>
						<!--End Advanced Tables -->
					</div>
				</div>

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
	<!-- CUSTOM SCRIPTS -->
	<script src="${url}/js/custom.js"></script>

	
	<script>    
	    const insert = document.querySelector('.btn-insert')
	    const modal = document.querySelector('.js-modal')
	    const modalClose = document.querySelector('.js-modal-close')
	    const modalContainer =document.querySelector('.js-modal-container')
	    // Hàm hiển thị modal mua vé(thêm class open vào modal)
	    function showBuyTickets(){
	        modal.classList.add('open')
	    }
	     // Hàm ẩn modal mua vé(xoóa bỏ class open khoỉ modal)
	    function hideBuyTickets(){
	        modal.classList.remove('open')
	    }
	    
	    for(const buyBtn of buyBtns){
	    	insert.addEventListener('click', showBuyTickets)
	    }
	
	    modalClose.addEventListener('click', hideBuyTickets)
	
	    modal.addEventListener('click', hideBuyTickets)
	
	    //Dừng sự kiện nổi bọt
	    modalContainer.addEventListener('click', function (event) {
	        event.stopPropagation()
	    })
	</script>
</body>
</html>