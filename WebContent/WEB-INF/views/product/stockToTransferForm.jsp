<%@page import="member.model.vo.Employee"%>
<%@page import="order.model.vo.Transfer"%>
<%@page import="order.model.vo.Order"%>
<%@page import="product.model.vo.StockToTransfer"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();

	StockToTransfer stock = (StockToTransfer) request.getAttribute("stock");
	Order order = (Order)request.getAttribute("order");
	Transfer t = (Transfer) request.getAttribute("t");
	Employee empLoggedIn = (Employee) session.getAttribute("empLoggedIn");
	String msg = (String)session.getAttribute("msg");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
	Date now = new Date();
	String today = sdf.format(now);
	
%>
<!DOCTYPE html>
<html lang="en">
  <head>
  
	 <%@ include file="../common/meta.jsp" %>
	 <title>이송요청서</title>
	 <%@ include file="../common/header.jsp" %>
<style>
input {
 background-color: white !important;
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
<!--     <div class="container-scroller"> -->
      <!-- partial -->
      <div class="container-fluid page-body-wrapper">
        <!-- partial -->
        <div class="main-panel" style="width: 100%;">
          <div class="content-wrapper">
              <i class="mdi mdi-close" id="bannerClose" style="display: none;"></i>
              
              
              
              
          <%-- Contents --%>
          
          
          <div style="padding-right: 20px;">
	          <div style="float:left; display: inline-block; margin-top: 48px; margin-left: 26px;"><h1 class="display-1 kor"> 이송요청서 </h1></div>
			  <div class="card" style="display: inline-block; margin-top: 26px; width:148px; float:right" >
				<div class="card-body">
					<table style="border-spacing:10px; text-align:center">
						<tr><th class="kor"><strong>이송 담당</strong></th></tr>
						<tr><td><input type="checkbox" disabled></td></tr>
					</table>
				</div>
			  </div>
          </div>
        
		  
		 
		 <form class="forms-sample" name="stockFrom" id="stockForm" action="<%= contextPath %>/product/stockToTransferForm" method="post">
		  
          <div class="col-lg-12 grid-margin stretch-card" style="margin-top: 30%">
			  <div class="card">
				<div class="card-body">
				  <table class="table">
					<thead>
						
					  <tr>
						<th class="kor"><strong>품의 제목</strong></th>
						<th><input type="text" name="tTitle" id="tTitle" class="form-control kor" 
								   placeholder="제목을 입력하세요." value="<%= t.gettTitle() %>" readonly="readonly" required/></th>
					  </tr>
					
						
					   
					</thead>
					<tbody>
					  <tr>
						<th><strong>발주 내용</strong></th>
						<th>
						
							<div class="form-group">	
							<label style="padding-top: 3%;">이송코드</label>
								<input type="text" class="form-control" name="tCode" id="tCode" style="width: 20%; margin-left: 10%; display: inline-block;" placeholder=""
									value="<%= t.gettCode() %>" readonly="readonly"/>
							
								
							</div>
						
							<div class="form-group">	
							<label style="padding-top: 3%;">상품코드</label>
								<input type="text" class="form-control" name="pCode" id="pCode" style="width: 20%; margin-left: 10%; display: inline-block;" placeholder=""
									value="<%= t.getpCode() %>" readonly="readonly"/>
							
								
							</div>
							<div class="form-group">
							<label style="padding-top: 3%;">요청수량</label>
								<input type="text" class="form-control" name="tAmount" id="tAmount" style="width: 20%; margin-left: 10%; display: inline-block;" placeholder=""
									value="<%= t.gettAmount() %>" readonly="readonly"/>
							</div>
					  	  <div class="form-group"> 
							<label for="departure">출발센터</label>
							 
							 <% if(t.getDepartureCode().equals("GG")) { %>
								<input type="text" class="form-control" name="departureCode" id="departureCode" style="width: 40%; margin-left: 10%; display: inline-block;" placeholder=""
									value="경기광주재고센터" readonly="readonly"/>
							<%} else if(t.getDepartureCode().equals("TK")) { %>
							<input type="text" class="form-control" name="departureCode" id="departureCode" style="width: 40%; margin-left: 10%; display: inline-block;" placeholder=""
									value="대구재고센터" readonly="readonly"/>
							<% } else %>
							
						  </div>
						  <div class="form-group">
							<label for="destination">도착센터</label>
							  <!-- <select class="form-control" name="departure" id="center2" required> -->
							  <% if(t.getDestinationCode().equals("GG")) { %>
								<input type="text" class="form-control" name="destinationCode"" id="destinationCode"" style="width: 40%; margin-left: 10%; display: inline-block;" placeholder=""
									value="경기광주재고센터" readonly="readonly"/>
								<%} else if(t.getDestinationCode().equals("TK")) { %>
								<input type="text" class="form-control" name="destinationCode"" id="destinationCode"" style="width: 40%; margin-left: 10%; display: inline-block;" placeholder=""
									value="대구재고센터" readonly="readonly"/>
								<%} else %>
						  </div>
						  <!-- <div class="form-group">
						  <label style="padding-top: 3%;">요청일</label>
						<input type="date" class="form-control" name="tDate" id="tDate" readonly/>
<script>
  document.getElementById('tDate').valueAsDate = new Date();
</script>
						</div> -->
						</th>
					  </tr>
					 <!--  <tr>
						<th class="kor"><strong>비고</strong></th>
						<td><textarea class="form-control" name="comment" id="comment" cols="30" rows="10" placeholder="메모를 입력하세요."></textarea></td>
					  </tr> -->
					</tbody>
				  </table>
				</div>
			  </div>
			</div>
			<div class="card-body" style="text-align: right;">
			  <h6 class="kor"><strong style="margin-right: 20px;">작성인 : </strong> 재고담당 <span><%=t.gettWriter() %></span></h6>
			  <h6 class="kor"><%= today %></h6>
			  <br />
			  
			  <%
					if(empLoggedIn.geteDept().equals("이송")) {			
				%>
			   <button type="submit" class="btn btn-gradient-primary btn-icon-text kor" style="float: right;"
			   		   onsubmit="submitApproval();">
				<i class="mdi mdi-file-check btn-icon-prepend" ></i> 결재 </button>
				
				<% } else { %>
				<button type="submit" class="btn btn-gradient-primary btn-icon-text kor" style="float: right;"
			   		   onsubmit="submitApproval();" disabled="disabled">
				<i class="mdi mdi-file-check btn-icon-prepend" ></i> 결재 </button>
				<% } %>
				
			</div>
			</form>
          <!-- content-wrapper ends -->
          <!-- partial -->
        </div>
        <!-- main-panel ends -->
      </div>
      <!-- page-body-wrapper ends -->
    </div>
    
    
    
    
    
    
    <!-- container-scroller -->
    <%@ include file="../common/footerScript.jsp" %>
    <script>
 
    
    /* 출발센터 선택 시 자동으로 도착센터가 정해짐 */
/*     function selectCenter() {
    	let $departureCode = $("#departureCode").val();
    	let departureCodeNum =parseInt($departureCode.substring(1, 4));
    	
    	if(departureCodeNum == 1)
    		$("#destinationCode").val("대구센터");
    	else
    		$("#destinationCode").val("경기광주센터");
    } */
    /* 수량체크 */
   /*  function numCheck(e){
    	if(e.value == 0) {
    		if(document.activeElement != e) {
    			alert("수량을 입력하세요.");
    		}
    		e.select();
    	}
    	else if(e.value > 100){
    		alert("수량은 100박스 이하로 입력해주세요.");
    		return false;
    	}
    } */
    
    /* 발주서 작성 완료 */
/*   	function submitApproval() {
    	let $tTitle = $("input[name='tTitle']");
    	let $pCode = $("input[name='pCode']");
    	let $tAmount = $("input[name='tAmount']");
    	let $departureCode = $("input[name='departureCode']");
    	let $detinationCode = $("input[name='detinationCode']");
    	let $tDate= $("input[name='tDate']");
		
    	for(let i = 0; i<$tAmount.length; i++) {
    		if($tAmount[i].value == "") {
    			alert("수량을 입력하세요.");
    			$tAmount[i].select();
    			return false;
    		}
    	}
    	
    	$("#stockForm").submit();
    }; */
    
  

    </script>
    <script>
  /*   $(function(){
	$("[name=stockFrom]").submit(function(){

		let $tTitle = $("#tTitle"); 
		let $pCode = $("#pCode");
		let $tAmount = $("#tAmount");
		let $departureCode = $("#departureCode");
		let $destinationCode = $("#destinationCode");
		let $tDate = $("#tDate");
		
		
		
		return true;
	});
});
 */

</script>
  </body>
</html>
		