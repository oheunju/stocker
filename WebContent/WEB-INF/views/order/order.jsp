<%@page import="order.model.vo.PageInfo"%>
<%@page import="order.model.vo.Order"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
	PageInfo pi = (PageInfo) request.getAttribute("pi");
	List<Order> orderList = (List<Order>) request.getAttribute("orderList");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
	String[] search = request.getParameterValues("search");
	String msg = (String)session.getAttribute("msg");


	int currentPage = pi.getCurrentPage();
	int startPage = pi.getStartPage();
	int endPage = pi.getEndPage();
	int maxPage = pi.getMaxPage();
	
%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../common/meta.jsp"%>
<title>발주</title>
<%@ include file="../common/header.jsp"%>
<style>
.popup_panel { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: 100;}
.popup_panel div.popup_bg { position: absolute; top: 0; left: 0; width: 100%; height: 100%; background:#000; opacity:.5; filter:alpha(opacity=50); }
.popup_panel div.popup_contents { position: absolute; top: 30%; left: 50%; width:600px; hight:800px; border:2px solid #b66dff; background-color:#fff; }
.popup_contents2 {display:inline; float: right; margin: 30px; margin-top: 63px; margin-right: 38px;}
.stock-tr {
	/* font-family: 고딕; */
	font-weight: bold;
}
</style>
<script>
	$(function(){
		var message = "<%=msg%>";
		// var message = "회원가입 성공!!"; // "null"
		if(message != "null"){
			alert(message);
			<% session.removeAttribute("msg"); %>
		}
	});
</script>
</head>
<body>
<%
%>

	<div class="container-scroller">
		<%@ include file="../common/navbar.jsp"%>
		<!-- partial -->
		<div class="container-fluid page-body-wrapper">
			<%@ include file="../common/sidebar.jsp"%>
			<!-- partial -->
			<div class="main-panel">
				<div class="content-wrapper">
					<i class="mdi mdi-close" id="bannerClose" style="display: none;"></i>
					<div class="page-header" style="width: 100%">
						<div style="display: inline-block; width: 50%; text-align: left;">
							<h3 class="page-title kor"
								style="display: inline-block; margin-right: 25px;">
								<span
									class="page-title-icon bg-gradient-primary text-white mr-2">
									<i class="mdi mdi-barcode-scan"></i>
								</span> 발 주
							</h3>
						</div>


						<%-- Contents --%>



						<div
							style="display: inline-block; width: 50%; text-align: right; padding-right: 40px;">
							<!-- <button type="button" class="btn btn-inverse-info btn-rounded btn-icon" style="margin-right: 25px;"
	                		data-toggle="tooltip" data-placement="top" title="납품계약서 다운로드">
					  <i class="mdi mdi-file-word"></i>
					</button> -->
							<button type="button" 
								class="btn btn-inverse-success btn-rounded btn-icon"
								data-toggle="tooltip" data-placement="top" title="발주 엑셀폼 다운로드">
								
								<a download="order.xlsx" href="<%= contextPath %>/resources/order.xlsx"><i class="mdi mdi-file-excel"></i></a>
							</button>
							<div class="btn-group" style="float: right !important;">
								<button type="button" class="btn btn-link dropdown-toggle"
									data-toggle="dropdown">+ New Order</button>
								<div class="dropdown-menu">
									<a class="dropdown-item kor trigger"
										style="font-weight: 300; font-size: 14px;" href="" 
										onclick="window.open('<%=contextPath%>/order/orderForm?eCode=<%=empLoggedIn.geteCode()%>',
				            			'_blank', 'top=1,left=500,width=1000,height=700')">직접 입력</a> <a class="dropdown-item kor"
										style="font-weight: 300; font-size: 14px;" data-toggle="modal" data-target="#myModal">엑셀 업로드</a>
								</div>
							</div>
						</div>
					</div>

					<br claer="both" />

					<div class="order-main">
						<div class="col-12">
							<div class="card">
								<div class="card-body">
									<form class="form-sample" id="searchForm"
										action="<%=contextPath%>/order/searchCompleteOrder">
										<div class="row">
											<div class="col-md-6">
												<div class="form-group row">
													<label class="col-sm-3 col-form-label stock-tr">발주코드</label>
													<div class="col-sm-9">
														<input type="text" class="form-control" name="search" />
													</div>
												</div>
											</div>
											<div class="col-md-6">
												<div class="form-group row">
													<label class="col-sm-3 col-form-label stock-tr">상품코드</label>
													<div class="col-sm-9">
														<input type="text" class="form-control" name="search" />
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-6">
												<div class="form-group row">
													<label class="col-sm-3 col-form-label stock-tr">출고센터</label>
													<div class="col-sm-9">
														<select class="form-control" name="search"
															form="searchForm">
															<option selected></option>
															<option value="GG">광주센터</option>
															<option value="TK">대구센터</option>
														</select>
													</div>
												</div>
											</div>
											<div class="col-md-6">
												<div class="form-group row">
													<label class="col-sm-3 col-form-label stock-tr">주문매장</label>
													<div class="col-sm-9">
														<select class="form-control" name="search"
															form="searchForm">
															<option selected></option>
															<option value="S001">코엑스 별마당</option>
															<option value="s002">압구정</option>
															<option value="s003">강남오거리</option>
															<option value="s004">강남</option>
															<option value="s005">한티역</option>
															<option value="s006">도산가로수길</option>
															<option value="S007">수원시청</option>
															<option value="S008">수원성균관대</option>
															<option value="S009">범계역</option>
															<option value="S010">킨텍스이마트</option>
															<option disabled>-----------</option>
															<option value="S11">대구수목원</option>
															<option value="S12">대구동천</option>
															<option value="S13">경북대</option>
															<option value="S14">부산대연역</option>
															<option value="S15">수영강변</option>
														</select>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-6">
												<div class="form-group row">
													<label class="col-sm-3 col-form-label stock-tr">기간</label>
													<div class="col-sm-9">
														<input type="date" class="form-control" name="search" />
													</div>
												</div>
											</div>
											<div class="col-md-6">
												<div class="form-group row">
													<label class="col-sm-3 col-form-label stock-tr"
														style="text-align: center"> - </label>
													<div class="col-sm-9">
														<input type="date" class="form-control" name="search" />
													</div>
												</div>
											</div>
											<div class="col-md-6">
												<button type="button" class="btn btn-inverse-info btn-fw"
													style="float: left"
													onclick="location.href='<%=contextPath%>/order/ordr?currentPage=1'">전체보기</button>
											</div>
											<div class="col-md-6">
												<input type="hidden" name="currentPage" value="1" form="searchForm"/>
												<button type="submit" class="btn btn-inverse-primary btn-fw"
													style="float: right">Search</button>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>


					<div class="col-12 grid-margin" style="margin-top: 26px">
						<div class="card">
							<div class="card-body">
								<!-- <h4 class="card-title">발주 리스트</h4> -->
								<div class="table-responsive">
									<table class="table">
										<thead>
											<tr>
												<th style="font-weight: bold;">발주번호</th>
												<th style="font-weight: bold;">출고센터</th>
												<th style="font-weight: bold;">상품코드</th>
												<th style="font-weight: bold;">주문수량</th>
												<th style="font-weight: bold;">주문매장</th>
												<th style="font-weight: bold;">주문일자</th>
											</tr>
										</thead>

										<tbody>
											<%
												if (orderList == null || orderList.isEmpty()) {
											%>
											<tr>
												<th colspan="6">조회된 행이 없습니다.</th>
											</tr>
											<%
												} else {
													for (Order o : orderList) {
											%>

											<tr>
												<td><a href="#" style='color:#b66dff'
													onclick="window.open('<%=contextPath%>/order/orderDetailForm?oCode=<%=o.getoCode()%>',
				            			'_blank', 'top=1,left=500,width=1000,height=700')">
														<%=o.getoCode()%>
												</a></td>
												<%
													if (o.getcCode().equals("GG")) {
												%>
												<td><label class="badge badge-gradient-danger">경기광주</label>
												</td>
												<%
													} else {
												%>
												<td><label class="badge badge-gradient-info">대구</label>
												</td>
												<%
													}
												%>
												<td><a href="javascript:void(0)" class="btn_popup_open" style='color:#b66dff'> <%=o.getpCode()%>
												</a></td>
												<td><%=o.getoAmount()%></td>
												<td><%=o.getsCode()%></td>
												<td><%=sdf.format(o.getoDate())%></td>
											</tr>

											<%
												}
												}
											%>
										</tbody>
									</table>
								</div>


								<!--  페이징 -->
								<div class="pagingArea" align="center">
									<%
										if (currentPage != 1) {
									%>
									<a href="<%=contextPath%>/order/ordr?currentPage=1" style="color:#b66dff">
										<i class='mdi mdi-chevron-double-left' style='color:#b66dff'></i>
									</a>
									<a href="<%=contextPath%>/order/ordr?currentPage=<%=currentPage - 1%>" style="color:#b66dff">
										<i class="mdi mdi-chevron-left"></i>
									</a>
									<%
										}
									%>

									<%
										for (int p = startPage; p <= endPage; p++) {
									%>
									<%
											if (currentPage != p) {
									%>
									<%
												if(search == null) {
									%>
									<a href='<%=contextPath%>/order/ordr?currentPage=<%=p%>' style='color:#b66dff'> <%= p %> </a>
									<%
												} else {
									%>
									<a href='<%=contextPath%>/order/searchCompleteOrder?currentPage=<%=p%>&search=<%=search[0]%>&search=<%=search[1]%>&search=<%=search[2]%>&search=<%=search[3]%>&search=<%=search[4]%>&search=<%=search[5]%>' style='color:#b66dff'> <%= p %> </a>
									<%
												}
									%>
									<%
											} else {
									%>
									<span class='cPage' style='color:#b66dff; font-weight: bold;'><%= p %></span>
									<%
											}
									%>
									<%
										}
									%>

									<%
										if(maxPage != 0) 
										{
											if (currentPage != maxPage) 
											{
									%>
									<a href="<%=contextPath%>/order/ordr?currentPage=<%=currentPage + 1%>" style='color:#b66dff'>
										<i class="mdi mdi-chevron-right"></i>
									</a>
									<a href="<%=contextPath%>/order/ordr?currentPage=<%=maxPage%>" style='color:#b66dff'>
										<i class="mdi mdi-chevron-double-right"></i>
									</a>
									<%
											}
										}
									%>
								</div>

							</div>
						</div>
					</div>
				</div>
				<!-- content-wrapper ends -->
				<%@ include file="../common/footer.jsp"%>
				<!-- partial -->
			</div>
			<!-- main-panel ends -->
		</div>
		<!-- page-body-wrapper ends -->
	</div>
	
	<!-- 레이어 팝업 시작 -->
	<div class="popup_panel">
		<div class="popup_bg"></div>
			<div class="popup_contents" style="float: left;">
				<!-- images 폴더에 p_code와 같은 이름의 jpg파일 -->
				<img id="p_image" src="" alt="" />
			<div class="popup_contents2">
				<!-- db product테이블 p_theme 컬럼 --> 
				<span id="p_theme">p_theme</span>
				<!-- db product테이블 p_category 컬럼 -->
				<span id="p_category">p_category</span>
				<!-- db product테이블 p_name 컬럼 -->
				<span id="p_name">p_name</span>
				<hr />
				<span id="p_price" style="float:right">p_price</span>
				<div id="qrDiv" style="float: right; margin-top: 40px">
					<img id="p_qr_image" src="" alt="" style="width:130px; margin-right: -60px;"/>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 파일 업로드 모달 -->
	<div class="modal" id="myModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">발주서를 업로드 하세요.</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body">
	     	 <form action="<%= contextPath %>/order/upload?ecode=<%= empLoggedIn.geteCode() %>" name="upload" method="POST" enctype="multipart/form-data">
				<td><input type="file" name="filename" size="20" align="absmiddle" />    </td>
				<td><button type="button" class="btn btn-inverse-danger btn-fw" onclick="checkForm();" style="cursor:hand"> 등록 </button></td>
			</form>
	      </div>
	    </div>
	  </div>
	</div>
	
	
	<!-- container-scroller -->
	<%@ include file="../common/footerScript.jsp"%>
	<script>
	function checkForm() {  
		
		if (upload.filename.value == "") 
		{  
			alert("파일을 업로드해주세요.");  
			return false;  
		}  
		else if(!checkFileType(upload.filename.value)) 
		{  
			alert("엑셀파일만 업로드 해주세요.");  
			return false;  
		}  
		
		document.upload.submit();
	}  
	
	function checkFileType(filePath)
	{ 
			var fileLen = filePath.length;  
			var fileFormat = filePath.substring(fileLen - 5);  
			fileFormatfileFormat = fileFormat.toLowerCase();  
	
			if (fileFormat == ".xlsx")
			   return true;   
			else
				return false;    
	}  


	$(function () {
		
		// 레이어팝업 
	    var $panel = $(".popup_panel");
	    var $panelContents = $panel.find(".popup_contents");
	    
	    //상품상세팝업 클릭했을때
	    $(".btn_popup_open").on("click", function(e) {
	    	//상품코드 준비
	    	var pCode = $(this).text();
			var params = {pCode : pCode}; //서버로 보낼 파라미터
			
			$.post('<%=contextPath%>/order/productDetail', $.param(params), function(responseJson){
				//p_theme, p_category, p_name, p_price, p_qrImage

				var obj = $.parseJSON(JSON.stringify(responseJson));

				$("#p_image").attr("src", obj.pImage); //파일서블릿 경로(상품이미지 서버위치 가져옴)
				$("#p_theme").text("[" + obj.pTheme + "]");
				$("#p_category").html("[" + obj.pCategory + "]" + "<br>");
				$("#p_name").text(obj.pName);
				$("#p_price").text((obj.pPrice).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")); //가격 콤마찍기 
				$("#p_qr_image").attr("src", obj.pQrImage); //파일서블릿 경로(상품QR이미지 서버위치 가져옴)
				
				
			});
			
	        // 팝업 가운데 설정(가로)
	        if ($panelContents.outerWidth() < $(document).width()) {
	            $panelContents.css("margin-left", "-" + $panelContents.outerWidth() / 2 + "px");
	        } else {
	            $panelContents.css("left", "0px");
	        }

	        // 팝업 가운데 설정(세로)
	        if ($panelContents.outerHeight() < $(document).height()) {
	            $panelContents.css("margin-top", "-" + $panelContents.outerHeight() / 2 + "px");
	        } else {
	            $panelContents.css("top", "0px");
	        }
	        // 레이어 팝업 열기
	        $panel.fadeIn();
	        
	    });
	    // 팝업 닫기 이벤트 정의
	    $("#btn_popup_close").on("click", popupClose);

	    // 팝업 배경 클릭 이벤트 정의
	    $panel.find(".popup_bg").on("click", popupClose);

	
		function popupClose(e) {
		    $panel.fadeOut();
		    // 이벤트 기본 동작 중단
		    e.preventDefault();
		}

	})
	
	</script>

</body>
</html>