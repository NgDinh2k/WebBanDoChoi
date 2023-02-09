<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<c:url value="/resources/static" var="url"></c:url>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>REPORT</title>
<script src="${url}/js/bootstrap.min.js"></script>
	<!-- METISMENU SCRIPTS -->
	<script src="${url}/js/jquery.metisMenu.js"></script>
	<!-- DATA TABLE SCRIPTS -->

	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.12.1/datatables.min.css"/>
 
	<script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.12.1/datatables.min.js"></script>

	
<!-- BOOTSTRAP STYLES-->
<link href="${url}/css/bootstrap.css" rel="stylesheet" />
<!-- FONTAWESOME STYLES-->
<link href="${url}/css/font-awesome.css" rel="stylesheet" />
<!-- CUSTOM STYLES-->
<link href="${url}/css/custom.css" rel="stylesheet" />
<!-- GOOGLE FONTS-->
<link href='http://fonts.googleapis.com/css?family=Open+Sans'
	rel='stylesheet' type='text/css' />
<script src="${url}/js/jquery-1.10.2.js"></script>
	<!-- BOOTSTRAP SCRIPTS -->
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/ju/datatables.min.css"/>
 
<link rel="stylesheet" type="text/css" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/dataTables.jqueryui.min.css"/>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/2.2.3/css/buttons.jqueryui.min.css"/>
</head>
<body>
<script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
	<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.22/pdfmake.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.4.1/html2canvas.min.js"></script>
	<script type="text/javascript">
	
	 window.onload = function() { 
		 var dataPoints2 = [];
		 var chart2 = new CanvasJS.Chart("chartContainer", {
				title: {
					text: "LỢI NHUẬN THEO THÁNG"
				},
				axisX: {
					title: "Thời Gian"
				},
				axisY: {
					title: "Số Tiền (USD)",
					yValueFormatString: "$#,##0.0# billion",
					includeZero: true
				},
				data: [{
					type: "column",
					dataPoints: dataPoints2
				}]
			});
		 function addDataChart2(data) {
			   dataPoints2.length = 0;
				for (var i = 0 ; i < data.length; i++) {
					dataPoints2.push({
						label: data[i].date,
						y: data[i].profit
					});
					console.log(dataPoints2);
				}
				chart2.render();
			}
		    $.getJSON("/WebBanDoChoi/report/findLoiNhuan/2000-07/2030-07.htm", addDataChart2);
			$('#addbtn').click(function() {
				$('#dataTables-example-month > tbody').empty();
				console.log($('#dateStart').val());
				var startDate = $('#dateStart').val(); 
				var endDate = $('#dateEnd').val();
				$.getJSON("/WebBanDoChoi/report/findLoiNhuan/"+startDate+"/"+endDate+".htm", addDataChart2);
				
				$.getJSON("/WebBanDoChoi/report/findLoiNhuan/"+startDate+"/"+endDate+".htm", 
		                function (data) {
		            var row = '';
		            $.each(data, function (key, value) {
		            	row += '<tr>';
		            	row += '<td>' + value.date + '</td>';
		                row += '<td>' + value.money + '</td>';
		                row += '<td>' + value.money2 + '</td>';
		                row += '<td>' + value.profit + '</td>';
		                row += '</tr>';
		            });
		            $('#dataTables-example-month').append(row);
		        });
				$('.dataTables_empty').closest("tr").remove();
			});
			
	 }	
			
</script>
<script type="text/javascript">


	function exportData(e) {
		var table = document.getElementById("dataTables-example-month");
		
		var rows = [];

		for (var i = 0, row; row = table.rows[i]; i++) {
			column1 = row.cells[0].innerText;
			column2 = row.cells[1].innerText;
			column3 = row.cells[2].innerText;

			rows.push([ column1, column2, column3, ]);

		}
		csvContent = "data:text/csv;charset=utf-8,";
		rows.forEach(function(rowArray) {
			row = rowArray.join(",");
			csvContent += row + "\r\n";
		});

		var encodedUri = encodeURI(csvContent);
		var link = document.createElement("a");
		link.setAttribute("href", encodedUri);
		link.setAttribute("download", "Thống Kê Lợi Nhuận " + e + ".csv");
		document.body.appendChild(link);
		link.click();
	}
	function Export(e) {
		var table = document.getElementById("dataTables-example-month");
		html2canvas(table, {
			onrendered : function(canvas) {
				var data = canvas.toDataURL();
				var docDefinition = {
					content : [ {
						image : data,
						width : 530
					} ]
				};
				pdfMake.createPdf(docDefinition)
						.download("ThongKeLoiNhuan "+e+".pdf");
			}
		});
	}
</script>
	<div id="wrapper">

		<jsp:include page="/WEB-INF/views/admin/view/nav-bar.jsp"></jsp:include>
		<!-- /. NAV TOP  -->
		<jsp:include page="/WEB-INF/views/admin/view/slide-bar.jsp"></jsp:include>
		<!-- /. NAV SIDE  -->
		<div id="page-wrapper">
			<div id="page-inner">
				<div id="chartContainer" style="height: 370px; width: 100%;"></div>
				<hr />
				<h1 style="text-align: center; font-family:sans-serif; ; color: red;" >BÁO CÁO LỢI NHUẬN</h1>
				<br>
				<br>
				
				<div style="display: flex; justify-content: space-around; font-size: 16px">
				<div style="display: flex; flex-wrap: wrap; justify-content: space-between;">
				<label style="margin: 5px;">Từ Ngày :       </label><input style="width: 300px" class="form-control"  type="month" id="dateStart"> 
				 </div>
				 <div style="display: flex; flex-wrap: wrap; justify-content: space-between;">
				<label style="margin: 5px;">Đến Ngày :      </label><input style="width: 300px" class="form-control" type="month" id="dateEnd">
				</div>
				</div>
				<div style="display: flex; justify-content: space-between; margin: 20px" >
				<div style="margin-top: 20px">
				<button id='inbtn' onclick="exportData('')" class="btn btn-primary" >IN EXCEL</button>
				<button id='inpdf' onclick="Export('')" class="btn btn-primary" >IN PDF</button>
				<label id='lbTongTien' style="margin-left: 20px"></label>
				</div>
				<button id='addbtn' class="btn btn-lg btn-primary btn-success">Tìm Kiếm</button>
				</div>
					<div class="row">
					<div class="col-md-12">
						<!-- Advanced Tables -->
						
						<div class="panel panel-default">
							<div class="panel-heading" style="font-weight: bold;">BẢNG LỢI NHUẬN</div>
							<div class="panel-body">
								<div class="table-responsive">
									<table class="table table-striped table-bordered table-hover"
										id="dataTables-example-month">
										<thead style="background-color: #0000000d;">
											<tr>
												<th scope="col">Date</th>
												<th scope="col">Doanh Thu</th>
												<th scope="col">Nhập Hàng</th>
												<th scope="col">Lợi Nhuận</th>
											</tr>
										</thead>
										 <tbody>
										</tbody>
									</table>
								</div>

							</div>
						</div>
						<!--End Advanced Tables -->
					</div>
				</div>
				
			
			<!-- /. PAGE INNER  -->
		</div>
		
		<!-- /. PAGE WRAPPER  -->
	</div>
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
			 $('#dataTables-example-month').DataTable({
				 ordering: false,
				 searching: false,
				 info: false,
			 });
		
		});
	</script>
</body>
</html>