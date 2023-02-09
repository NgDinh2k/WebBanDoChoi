<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="java.util.*" %>
<%@include file="/WEB-INF/views/include/taglib.jsp"%>
<%@include file="/WEB-INF/views/include/header.jsp"%>

<input type="hidden" id="ID" value="${ID}" />
 <script type="text/javascript">
 document.getElementById("TenPage").innerHTML = "REPORT";
 window.onload = function() { 
	 var id = document.getElementById("ID").value;
	 var dataPoints = [];
	 var tongTien = 0;
	 var myJsonString;
	 var chart = new CanvasJS.Chart("chartContainer", {
			title: {
				text: "DOANH SỐ MUA HÀNG TRONG THÁNG"
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
				dataPoints: dataPoints
			}]
		});
	 
	 function addData2(data) {
		   tongTien = 0;
		   dataPoints.length = 0;
			for (var i = data.length - 1 ; i >= 0; i--) {
				dataPoints.push({
					label: data[i].date,
					y: data[i].money
				});
				tongTien += data[i].money;
			}
			console.log("tongtien: " + tongTien);
			document.getElementById("lbTongTien").innerHTML = "Tổng Tiền: " + tongTien + " USD";
			chart.render();
			
		}
	    $.getJSON("http://localhost:8082//findChiTieu/"+id+"/2000-07-10/2030-07-10.json", addData2);
		$('#addbtn').click(function() {
			$('#dataTables-example-month > tbody').empty();
			var startDate = $('#dateStart').val(); 
			var endDate = $('#dateEnd').val();
			console.log("http://localhost:8082//findChiTieu/"+id+"/"+startDate+"/"+endDate+".json");
			$.getJSON("http://localhost:8082//findChiTieu/"+id+"/"+startDate+"/"+endDate+".json", addData2);
			
			$.getJSON("http://localhost:8082//findChiTieu/" + id+ "/"+startDate+"/"+endDate+".json", 
	                function (data) {
	            var row = '';
	            $.each(data, function (key, value) {
	            	row += '<tr>';
	            	row += '<td>' + value.date + '</td>';
	                row += '<td>' + value.money + '</td>';
	                row += '<td>' + value.slDH + '</td>';
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
		link.setAttribute("download", "Thống Kê Doanh Thu " + e + ".csv");
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
						.download("ThongKeDoanhThu "+e+".pdf");
			}
		});
	}
</script>
<div id="chartContainer" style="height: 370px; width: 100%;"></div>



				<br>
				<br>
				
				<div style="display: flex; justify-content: space-around; font-size: 16px">
				<div style="display: flex; flex-wrap: wrap; justify-content: space-between;" >
				<label style="margin: 5px;">Từ Ngày :       </label><input style="width: 300px" class="form-control"  type="month" id="dateStart"> 
				 </div>
				 <div style="display: flex; flex-wrap: wrap; justify-content: space-between;">
				<label style="margin: 5px;">Đến Ngày :      </label><input style="width: 300px" class="form-control" type="month" id="dateEnd">
				</div>
				</div>
				<div style="display: flex; justify-content: center; ">
				<div style="display: flex; justify-content: space-between; margin: 20px; width: 1200px" >
				<div style="margin-top: 20px">
				<button id='inbtn' onclick="exportData('Theo Tháng')" class="btn btn-primary" >IN EXCEL</button>
				<button id='inpdf' onclick="Export('Theo Tháng')" class="btn btn-primary" >IN PDF</button>
				<label id='lbTongTien' style="margin-left: 20px"></label>
				</div>
				<button id='addbtn' class="btn btn-lg btn-primary btn-success">Tìm Kiếm</button>
				</div>
				</div>
					<div class="row">
					<div class="col-md-12" style="display: flex; justify-content: center;">
						<!-- Advanced Tables -->
						
						<div class="panel panel-default" style="width: 1200px">
							<div class="panel-heading" style="font-weight: bold;">BẢNG THÔNG TIN THEO THÁNG</div>
							<div class="panel-body">
								<div class="table-responsive">
									<table class="table table-striped table-bordered table-hover"
										id="dataTables-example-month">
										<thead style="background-color: #0000000d;">
											<tr>
												<th scope="col">Date</th>
												<th scope="col">Tổng Tiền</th>
												<th scope="col">Số lượng Đơn Hàng</th>
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







<script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<%@include file="/WEB-INF/views/include/footer.jsp"%>
