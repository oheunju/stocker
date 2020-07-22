<%@page import="member.model.vo.Employee"%>
<%@page import="product.model.vo.BeReleased"%>
<%@page import="sales.model.vo.Shop"%>
<%@page import="product.model.vo.Product"%>
<%@page import="order.model.vo.Order"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
	Order order = (Order) request.getAttribute("order");
	Product product = (Product) request.getAttribute("product");
	Shop shop = (Shop) request.getAttribute("shop");
	BeReleased br = (BeReleased) request.getAttribute("br");
	String cName = order != null ? ((order.getcCode()).equals("GG") ? "경기센터" : "대구센터") : "";
	
	// System.out.println("order = " + order);
	
	Employee user = (Employee) session.getAttribute("empLoggedIn");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
	Date now = new Date();
	String today = sdf.format(now);
%>
<!DOCTYPE html>
<html lang="en">
  <head>
	 <%@ include file="../common/meta.jsp" %>
	 <title>발주서 상세보기</title>
	 <%@ include file="../common/header.jsp" %>
<style>
input {
 background-color: white !important;
}
</style>

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
	          <div style="float:left; display: inline-block; margin-top: 48px; margin-left: 26px;"><h1 class="display-1 kor"> 발주서 </h1></div>
			  <div class="card" style="display: inline-block; margin-top: 26px; width:148px; float:right" >
				<div class="card-body">
					<table style="border-spacing:10px; text-align:center">
						<tr><th class="kor"><strong>재고 담당</strong></th></tr>
						<tr><td><input type="checkbox" <%= order != null ? (order.getoStatus().equals('C') ? "checked" : "") : "" %> disabled></td></tr>
					</table>
				</div>
			  </div>
          </div>
		  
		 
		 <form class="forms-sample" name="stockOrderForm" id="stockOrderForm" action="<%= contextPath %>/product/stockOrderToBRSubmit" method="post">
		  
          <div class="col-lg-12 grid-margin stretch-card" style="margin-top: 30%">
			  <div class="card">
				<div class="card-body">
				  <table class="table">
					<thead>
					  <tr>
						<th class="kor"><strong>품의 제목</strong></th>
						<th><input type="text" name="title" id="title" class="form-control kor" 
								   placeholder="제목을 입력하세요." value="<%= order.getoTitle() %>" required disabled/></th>
					  </tr>
					  <tr>
						<th class="kor"><strong>발주 코드</strong></th>
						<th>
								   <input type="text" name="oCode" id="oCode" class="form-control kor" 
								   placeholder="제목을 입력하세요." value="<%= order.getoCode() %>"" readonly="readonly" required style="width: 30%"/>
								   
					  </tr>
					</thead>
					<tbody>
					 <tr>
						<!-- <th><strong>발주 내용</strong></th> -->
							<div class="form-group">	
							
								
								<%-- <!-- <table class="table product" id="addProductTable"> -->
								   <thead>
									<tr>
									
									 <th class="kor"><strong>상품 코드</strong></th>
									 <th><input type="text" name="pCode" id="pCode" class="form-control kor" 
								   		 value="<%= order.getpCode() %>" required disabled
								   		 style="width: 30%"/></th>
								   		
									 <th class="kor"><strong>상품명</strong></th>
									 <input type="text" name="pName" id="pName" class="form-control kor" 
								  		 value="<%= product.getpName() %>" required disabled
								  		 style="width: 30%"/>
									 
									 <th class="kor"><strong>수량</strong></th>
									 <input type="text" name="rAmount" id="rAmount" class="form-control kor" 
								   		 value="<%= order.getoAmount() %>" required disabled
								   		 style="width: 30%"/>
								  	
									</tr>
								   </thead> --%>
								    <div class="form-group"> 
								    <tr>
										<th class="kor"><strong>상품 코드</strong></th>
										<th>
								   		 <input type="text" name="pCode" id="pCode" class="form-control kor" 
								   placeholder="제목을 입력하세요." value="<%= order.getpCode() %>" readonly="readonly" required style="width: 30%"/>
								   		 </th>
								</tr>
						  			
								    <tr>
										<th class="kor"><strong>상품명</strong></th>
										<th>
								   		 <input type="text" name="pName" id="pName" class="form-control kor" 
								   placeholder="제목을 입력하세요." value="<%= product.getpName() %>" readonly="readonly" required style="width: 50%"/>
								   		 </th>
									</tr>
						  			
								  
								    <tr>
										<th class="kor"><strong>수량</strong></th>
										<th>
								   		 <input type="text" name="oAmount" id="oAmount" class="form-control kor" 
								   placeholder="제목을 입력하세요." value="<%= order.getoAmount() %>" readonly="readonly" required style="width: 20%"/>
								   		</th>
									</tr>
						  			<tr>
										<th class="kor"><strong>주문매장</strong></th>
							
										<th><input type="text" class="form-control kor" value="<%= shop.getsName() %>" disabled style="width: 50%" ></th>
									</tr>
						  			<tr>
										<th class="kor"><strong>출고센터</strong></th>
										
										<th><input type="text"class="form-control" style="width: 50%" 
								   			value="<%= cName %>" readonly></th>
								   		</tr>	
						  			</div>
								   <tbody>
								   
										<%-- <tr> 
											<th name="pCode" id="pCode" style="font-weight: 400;"><%= order.getpCode() %></th> 
											<th style="font-weight: 400;"><%= product.getpName() %></th> 
											<th name="rAmount" id="rAmount" style="font-weight: 400;"><%= order.getoAmount() %></th> 
											
										</tr> --%>
										
									
								   </tbody>
								<!-- </table> -->
							</div>
					  	 <%--  <div class="form-group"> 
							<label for="shop">주문매장</label>
							
								<input type="text"class="form-control kor" value="<%= shop.getsName() %>" disabled >
							
						  </div>
						  <div class="form-group">
							<label for="center">출고센터</label>
							<input type="text" id="center" name="center" class="form-control" placeholder="주문매장을 선택하세요." 
								   value="<%= cName %>" readonly>
						  </div> --%>
						  </th>
						</tr>
					  
					  <tr>
						<th class="kor"><strong>비고</strong></th>
						<td><textarea class="form-control" name="comment" id="comment" cols="30" rows="10" placeholder="메모를 입력하세요."
									  disabled> <%=order.getoComment() == null ? "" : order.getoComment() %> </textarea></td>
									  
					  </tr>
					</tbody>
				  </table>
				</div>
			  </div>
			</div>
			<div class="card-body" style="text-align: right;">
			  <h6 class="kor"><strong style="margin-right: 20px;">작성인 : </strong> <%=user.geteDept() %> <span><%=user.geteName() %></span></h6>
			  <h6 class="kor"><%=sdf.format(order.getoDate()) %></h6>
			  <br />
			  
			  <% if((order.getcCode()).equals("GG")) { %>
			  	<% if(user.geteDept().equals("경기물류")) { %>
			   <button type="submit" class="btn btn-gradient-primary btn-icon-text kor" style="float: right;">
				<i class="mdi mdi-file-check btn-icon-prepend" ></i> 결재 </button>
			  	<% } else { %>
			   <button type="submit" class="btn btn-gradient-primary btn-icon-text kor" style="float: right;" disabled="disabled">
				<i class="mdi mdi-file-check btn-icon-prepend" ></i> 결재 </button>
				<br /><br /><br /><strong>본인 담당센터에 대한 발주가 아닙니다</strong>
			  <% } %>
			 <% } if((order.getcCode()).equals("TK")) { %>
			 		<% if(user.geteDept().equals("대구물류")) { %>
			 	<button type="submit" class="btn btn-gradient-primary btn-icon-text kor" style="float: right;">
				<i class="mdi mdi-file-check btn-icon-prepend" ></i> 결재 </button>
			 <% } else { %>
			 	<button type="submit" class="btn btn-gradient-primary btn-icon-text kor" style="float: right;" disabled="disabled">
				<i class="mdi mdi-file-check btn-icon-prepend" ></i> 결재 </button>
				<br /><br /><br /><strong>본인 담당센터에 대한 발주가 아닙니다</strong>
			 <% } } %>		
			 
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
<%--     <script>
    /* 선택항목 삭제 */
    function deleteCheckedItem() {
    	let $selectedItem = $(".selectOne:checked").not($("selectAll"));
    	$selectedItem.parent().parent().remove(); 
    }
    /* 전체선택 */
    function selectAllCheckBox() {
    	if($("#selectAll").prop("checked")) {
    		$(".selectOne").prop("checked", true);
    	}
    	else {
    		$(".selectOne").prop("checked", false);
    	}
    }
    
    /* 매장 선택시 자동으로 센터 지정되도록 하는 함수 */
    function selectCenter() {
    	let $shop = $("#shop").val();
    	let shopNum =parseInt($shop.substring(1, 4));
    	
    	if(shopNum > 10)
    		$("#center").val("대구센터");
    	else
    		$("#center").val("경기센터");
    }
    /* 수량체크 */
    function numCheck(e){
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
    }
    
    /* 발주서 작성 완료 */
    function validate() {
    	let $title = $("input[name='title']");
    	let $amount = $("input[name='amount']");
    	let $center = $("input[name='center']");
    	
   		if($("#addProductTable tbody tr").length == 0) {
   			alert("상품을 추가하세요.");
   			return false;
   		}
   		
    	for(let i = 0; i < $amount.length; i++) {
    		
    		if($amount[i].value == "") {
    			alert("수량을 입력하세요.");
    			$amount[i].select();
    			return false;
    		}
    		
    		if($amount[i].value > 100) {
    			alert("수량을 100개 이하로 입력하세요.");
    			$amount[i].select();
    			return false;
    		}
    	}
    	
    	if($shop.val() == "") {
    		alert("매장을 선택하세요.");
    		return false;
    	}
    	
    	return true;
    };
    
    /* 상품코드로 검색해서 테이블에 추가하기 */
    $("#addProductBtn").click(function(){
    	let inp = $("#addProductInput").val();
    	if(inp == "") {
    		alert("상품코드를 입력하세요.");
			return false;    		
    	}
    	
    	$.ajax({
			url:"<%= contextPath %>/order/searchPname",		
			data:{pCode:inp},	
			type:"get",			
			success:function(pList){ 
				console.log("ajax 통신 성공!");
				
				let result = "";
				
				if(pList.length == 0)
					alert("조회된 상품이 없습니다.");
				else {
					for(let i = 0; i < pList.length; i++) {
						/* 중복제거 */
						let arr = [];					
						
						$.each($("input[name='pCode']"),function(k,v) {
				            arr[arr.length] = $(v).val();
				         })
				         
				         if(arr.includes(pList[i].pCode)) {
							
						 }
				         else {
					         /* 중복되지 않는 행 추가 */
							result += "<tr>" +
								      "<td style='padding: 0 3%; width: 11%;'><input type='checkbox' class='selectOne'></td>" +
								      "<td style='padding: 0;'><input type='text' name='pCode' style='padding: 0; width: 100%; display: inline-block; border: none;' value='" + pList[i].pCode + "' readonly></td>" +
								      "<td>" + pList[i].pName + "</td>" +
								      "<td style='width: 100%;'><input type='number' class='form-control' name='amount' style='height: 1.875rem;' onblur='numCheck(this)'></td>" +
								      "</tr>";
				         }
				         
					}
					$("#addProductTable tbody").append(result);
				}
			},
			error:function(){	
				console.log("ajax 통신 실패!");
			},
			complete:function(){
				
			}
		});
    });

    </script> --%>
  </body>
</html>
		