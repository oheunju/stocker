<%@page import="member.model.vo.Employee"%>
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
	String cName = order != null ? ((order.getcCode()).equals("GG") ? "경기센터" : "대구센터") : "";
	Employee writer = (Employee) request.getAttribute("emp"); 
	
	// System.out.println("order = " + order);
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
	Date now = new Date();
	String today = sdf.format(now);
	String msg = (String) session.getAttribute("msg");
	Employee empLoggedIn = (Employee) session.getAttribute("empLoggedIn");
	
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
  
  <%
  	if(msg != null && !msg.equals(""))
  	{
  %>
		<script>
			alert("<%= msg %>"); 
			self.close();
		</script>
  <%
  		session.removeAttribute("msg");
  	}
  %>
  

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
		  
		 
		 <form class="forms-sample" id="orderForm" action="<%= contextPath %>/order/submitOrder" method="post">
		  
          <div class="col-lg-12 grid-margin stretch-card" style="margin-top: 30%">
			  <div class="card">
				<div class="card-body">
				  <table class="table">
					<thead>
					  <tr>
						<th class="kor"><strong>품의 제목</strong></th>
						<th><input type="text" name="title" id="title" class="form-control kor" 
								   placeholder="제목을 입력하세요." value="<%= order != null ? order.getoTitle() : "" %>" required
								   <%= order != null ? "disabled" : "" %>/></th>
					  </tr>
					</thead>
					<tbody>
					  <tr>
						<th><strong>발주 내용</strong></th>
						<th>
							<div class="form-group">	
							<%
								if(order == null) {
							%>
								<div class="form-group">
								  <div class="input-group">
									<input type="text" class="form-control" id="addProductInput" placeholder="상품코드로 검색" aria-label="Recipient's username" aria-describedby="basic-addon2">
									<div class="input-group-append">
									  <button class="btn btn-sm btn-gradient-primary" id="addProductBtn" type="button">Search</button>
									</div>
								  </div>
								</div>
							<%
								} 
							%>	
								
								<table class="table product" id="addProductTable">
								   <thead>
									<tr style="border-color: white;">
									<%
										if(order == null) {
									%>
									  <th style="width: 11%;"> <input type="checkbox" id="selectAll" onclick="selectAllCheckBox();"/> </th>
									<%
										}
									%>
									  <th style="font-weight: bold;"> 상품코드 </th>
									  <th style="width: 21%; font-weight: bold;"> 상품명 </th>
									  <th style="font-weight: bold;"> 수량 /개 </th>
								  	<%
										if(order == null) {
									%>
									  <th><button type="button" class="btn btn-inverse-danger btn-rounded btn-icon" id="deleteItem" onclick="deleteCheckedItem();">
										<i class="mdi mdi-delete-forever"></i>
									</button></th>
									<%
										}
									%>
									</tr>
								   </thead>
								   <tbody>
								   <%
										if(order != null) {
									%>
										<tr> 
											<th style="font-weight: 400;"><%= order.getpCode() %></th> 
											<th style="font-weight: 400;"><%= product.getpName() %></th> 
											<th style="font-weight: 400;"><%= order.getoAmount() %></th> 
										</tr>
									<%
										}
									%>
								   </tbody>
								</table>
							</div>
					  	  <div class="form-group"> 
							<label for="shop">주문매장</label>
							<%
								if(order != null) 
								{
							%>
								<input type="text"class="form-control kor" value="<%= shop.getsName() %>" disabled >
							<%
								}
								else
								{
							%>
							  <select class="form-control" name="shop" id="shop" onchange="selectCenter();" required>
								<option disabled selected>매장을 선택하세요.</option>
								<option value="S001">코엑스 별마당</option>
								<option value="S002">압구정</option>
								<option value="S003">강남오거리</option>
								<option value="S004">강남</option>
								<option value="S005">한티역</option>
								<option value="S006">도산가로수길</option>
								<option value="S007">수원시청</option>
								<option value="S008">수원성균관대</option>
								<option value="S009">범계역</option>
								<option value="S010">킨텍스이마트</option>
								<option disabled>-----------</option>
								<option value="S011">대구수목원</option>
								<option value="S012">대구동천</option>
								<option value="S013">경북대</option>
								<option value="S014">부산대연역</option>
								<option value="S015">수영강변</option>
							  </select>
							<%
								}
							%>
						  </div>
						  <div class="form-group">
							<label for="center">출고센터</label>
							<input type="text" id="center" name="center" class="form-control" placeholder="주문매장을 선택하세요." 
								   value="<%= cName %>" readonly>
						  </div>
						</th>
					  </tr>
					  <tr>
						<th class="kor"><strong>비고</strong></th>
						<td><textarea class="form-control" name="comment" id="comment" cols="30" rows="10" placeholder="메모를 입력하세요."
									  <%= order != null ? "disabled" : "" %>> <%= order != null ? (order.getoComment() == null ? "" : order.getoComment()) : "" %> </textarea></td>
					  </tr>
					</tbody>
				  </table>
				</div>
			  </div>
			</div>
			<div class="card-body" style="text-align: right;">
			  <h6 class="kor"><strong style="margin-right: 20px;">작성인 : </strong>  발주담당 <span> <%= order != null ? writer.geteName() : empLoggedIn.geteName()  %></span></h6>
			  <input type="hidden" name="oWriter" value="<%= empLoggedIn.geteCode() %>" />
			  <h6 class="kor"><%= order != null ? sdf.format(order.getoDate()) : today %></h6>
			  <br />
			   <button type="submit" class="btn btn-gradient-primary btn-icon-text kor" style="float: right;"
			   		   onclick="return validate();" <%= order != null ? "disabled" : "" %>>
				<i class="mdi mdi-file-check btn-icon-prepend" ></i> 결재요청 </button>		
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

    </script>
  </body>
</html>
		