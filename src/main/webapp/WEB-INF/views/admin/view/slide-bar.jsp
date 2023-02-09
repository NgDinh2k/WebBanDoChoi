
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<c:url value="/resources/static" var="url"></c:url>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<nav class="navbar-default navbar-side" role="navigation">
	<div class="sidebar-collapse">
		<ul class="nav" id="main-menu">
			<li class="text-center" style="padding-top: 10px; padding-bottom: 8px;">
			<img alt="" src="/WebBanDoChoi/resources/images/${tk.getNhanvienlist().iterator().next().getHinhanh()}" style="height: 60px;width: 65px;    margin-bottom: 4%;
    margin-top: 3%;">
			<br>
			<span style="color: white;"><b>Tài khoản:</b>
			${tk.getTaikhoan()}
			</span>
			<br>
		
			<c:if test = "${tk.getChucvu().trim()=='NV'}">
			 <span style="color: white;margin-right: 2%">
			<b>Chức vụ:</b>
			Nhân viên
			</span>
			
        	 </c:if>
			 
			 <c:if test = "${tk.getChucvu().trim()=='AD'}">
			 <span style="color: white;margin-left: 3%">
			<b>Chức vụ:</b>
			Quản lý
			</span>
        	 </c:if>
			</li>


			<li><a class="active-menu" href="#"><i
					class="fa fa-dashboard fa-3x"></i>Dashboard</a></li>
			<li><a
				href="${pageContext.request.contextPath }/admin/product/list"><i
					class="fa fa-desktop fa-3x"></i>  Product Management</a>
				<ul class="nav nav-second-level">
					<li><a href="${pageContext.request.contextPath }/user/products/create.htm">Add New Product</a></li>
					<li><a href="${pageContext.request.contextPath }/user/products.htm">List All Products</a></li>
				</ul></li>
				<li><a
				href="${pageContext.request.contextPath }/admin/nhapHang/importList.htm"><i
					class="fa fa-book fa-3x"></i>  Import Management</a>
				<ul class="nav nav-second-level">
					<li><a href="${pageContext.request.contextPath }/nhapHang/import/insert.htm">Add New Import</a></li>
					<li><a href="${pageContext.request.contextPath }/nhapHang/importList.htm">List All Import</a></li>
				</ul></li>
				<li><a
				href="${pageContext.request.contextPath }/user/order.htm"><i
					class="fa fa-edit fa-3x"></i>  Order Management</a></li>
				<li><a href="/WebBanDoChoi/user/profile.htm"><i class="fa fa-id-card fa-3x"></i>  Profile Management </a></li>
				
				
			<li class="${tk.getChucvu().trim()}"><a
				href="java5/admin/NV/insert.htm"><i
					class="fa fa-user fa-3x"></i>  User Management</a>
					<ul class="nav nav-second-level">
					<li><a href="${pageContext.request.contextPath }/admin/NV/insert.htm">Add New User</a></li>
					<li><a href="${pageContext.request.contextPath }/admin/NV.htm">List All Users</a></li>
				</ul>
					</li>
			
			<li class="${tk.getChucvu().trim()}"><a href="/WebBanDoChoi/admin/HD.htm"><i class="fa fa-table fa-3x"></i>   Receipt Management</a></li>
			

			<li class="${tk.getChucvu().trim()}"><a href="/WebBanDoChoi/admin/KH.htm"><i class="fa fa-users  fa-3x"></i>  Customer Management </a></li>
		
		<li class="${tk.getChucvu().trim()}"><a
				href="java5/admin/NV/insert.htm"><i
					class="fa fa-bar-chart fa-3x"></i>  Report Management</a>
					<ul class="nav nav-second-level">
					<li><a href="${pageContext.request.contextPath }/report/reportBDCOT.htm">Sales Report</a></li>
					<li><a href="${pageContext.request.contextPath }/report/reportNhapHang.htm">Import Sales Report</a></li>
					<li><a href="${pageContext.request.contextPath }/report/reportNhapHangXuatHang.htm">Import and Export Summary Report</a></li>
				</ul>
					</li>
		
		</ul>

	</div>

</nav>
<script>
    var divsToHide = document.getElementsByClassName("NV"); //divsToHide is an array
    for(var i = 0; i < divsToHide.length; i++){
        divsToHide[i].style.visibility = "hidden"; // or
        divsToHide[i].style.display = "none"; // depending on what you're doing
    }
</script>