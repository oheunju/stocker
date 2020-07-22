<%@page import="order.model.vo.Transfer"%>
<%@page import="order.model.vo.PageInfo"%>
<%@page import="order.model.vo.Order"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
	List<Order> oList = (List<Order>) request.getAttribute("list");
	List<Transfer> tList = (List<Transfer>) request.getAttribute("tList");
	PageInfo pi = (PageInfo) request.getAttribute("pi");
	String flag = null;
	flag = (String) request.getAttribute("flag");
	String msg = (String)session.getAttribute("msg");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
	SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
	Date now = new Date();
	String today = sdf.format(now); 
	
	
	int currentPage = pi.getCurrentPage();
	int startPage = pi.getStartPage();
	int endPage = pi.getEndPage();
	int maxPage = pi.getMaxPage();
%>
<!DOCTYPE html>
<html lang="en">
  <head>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	 <%@ include file="../common/meta.jsp" %>
	 <title>결재관리</title>
	 <%@ include file="../common/header.jsp" %>
  <style>
  .bold {
  	font-weight: bold;
  }
  a {
  color:#b66dff;
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
    <div class="container-scroller">
	  <%@ include file="../common/navbar.jsp" %>
      <!-- partial -->
      <div class="container-fluid page-body-wrapper">
		<%@ include file="../common/sidebar.jsp" %>
        <!-- partial -->
        <div class="main-panel">
          <div class="content-wrapper">
              <i class="mdi mdi-close" id="bannerClose" style="display: none;"></i>
            <div class="page-header">
              <h3 class="page-title kor">
                <span class="page-title-icon bg-gradient-primary text-white mr-2">
                  <i class="mdi mdi-script"></i>
                </span> 진행결재 관리 </h3>
            </div>
          
          
          	<div class="order-main">
				<div class="row" style="margin-left: 0; margin-top: 48px; padding-left: 20px">
					<div style="display: inline-block;">
					
					<% if(empLoggedIn.geteDept().equals("경기물류") || empLoggedIn.geteDept().equals("대구물류"))
						{
					%>
						<%-- <button type="button" class="btn btn-info btn-fw" style="margin-right: 27px;" data-target="progress-approval"
							    onclick="location.href='<%= contextPath %>/approval?currentPage=1'"> 진행결재함 </button> --%>
						<button type="button" class="btn btn-primary btn-fw" style="margin-right: 27px;" data-target="progress-approval"
							    onclick="location.href='<%= contextPath %>/approval?currentPage=1'"> 재고 - 발주 진행결재함 </button>
						<button type="button" class="btn btn-primary btn-fw" style="margin-right: 27px;" data-target="progress-approval"
							    onclick="location.href='<%= contextPath %>/approval/stt?currentPage=1'"> 재고 - 이송 진행결재함 </button>
					<%
						} else if (empLoggedIn.geteDept().equals("이송")) {
					%>
						<button type="button" class="btn btn-primary btn-fw" style="margin-right: 27px;" data-target="progress-approval"
							    onclick="location.href='<%= contextPath %>/approval/stt?currentPage=1'"> 이송요청 진행결재함 </button>
					<% } %>
					</div>
				</div>
				
				
				<br clear="both">
				
				<div class="col-lg-12 grid-margin stretch-card" style="margin-top: 26px">
				  <div class="card">
				  
					  
					  <!-- 진행결재함 테이블 -->
  					<div class="card-body"  id="waiting-approval" style="padding-top: 2rem;">
					  <h2 class="card-title"><i class="fa fa-calendar" aria-hidden="true"></i>&emsp;<%= today %></h2> 
					  <table class="table">
						<thead>
						  <tr>
							<th style="font-weight: bold;"> 상태 </th>
							<th style="font-weight: bold;"> 문서분류</th>
							<th style="font-weight: bold;"> 문서번호 </th>
							<th style="font-weight: bold;"> 제목 </th>
							<th style="font-weight: bold;"> 요청일시 </th>
						  </tr>
						</thead>
						<tbody>
						<%-- 조회 테이블이 발주테이블일 경우 --%>
						
						<%
							if(empLoggedIn.geteDept().equals("발주"))
							{
								if (oList == null || oList.isEmpty()) {
						%>
						<!-- <tr>
							<th colspan="5">조회된 행이 없습니다.</th>
						</tr>	 -->			
						<%
								} else {
								
									for(Order o : oList) {
						%>
						  <tr>
								<td><label class="badge badge-warning"> 대기 </label></td>
								<td> 발주요청 </td>
								<td><a href="#" onclick="window.open('<%=contextPath%>/order/orderDetailForm?oCode=<%=o.getoCode()%>',
				            			'_blank', 'top=1,left=500,width=1000,height=700')"> <%= o.getoCode() %> </a></td>
								<td> <%= o.getoTitle() %> </td>
								<td> <%= sdf2.format(o.getoDate()) %> </td>
						  </tr>
						<% 
									} 
								}
							}
						%>
						<%-- 조회 유저가 재고담당일 경우 --%>
						<%-- 경기광주담당일 경우 --%> <%-- 경기담당, 대구담당일 경우 리스트가 다르게 보이게 했지만 페이징이 꼬여서 보류 --%>
						<%
							if(empLoggedIn.geteDept().equals("경기물류") || empLoggedIn.geteDept().equals("대구물류"))
							{
						%>
						<%
								if (oList == null || oList.isEmpty()) {
									%>
									<!-- <tr>
										<th  colspan="5" style="text-align:center;">조회된 행이 없습니다.</th>
									</tr>	 -->			
									<%
											} else {
												
											
												for(Order o : oList) {
												/* if(o.getcCode().equals("GG")) { */
									%>
									  <tr>
											<td><label class="badge badge-warning"> 대기 </label></td>
											<td> 발주요청 </td>
											<td><a href="#" onclick="window.open('<%=contextPath%>/product/stockOrderToBR?oCode=<%=o.getoCode()%>',
				            						'_blank', 'top=1,left=500,width=1000,height=700')"> <%= o.getoCode() %> </a></td>
											<td> <%= o.getoTitle() %> </td>
											<td> <%= sdf2.format(o.getoDate()) %> </td>
									  </tr>
									<% 				}
												} 
											}
										
									%>
						<%
							
								if (tList == null || tList.isEmpty()) {
						%>
						<!-- <tr>
							<th  colspan="5" style="text-align:center;">조회된 행이 없습니다.</th>
						</tr> -->				
						<%
								} else {
									if(empLoggedIn.geteDept().equals("경기물류") || empLoggedIn.geteDept().equals("대구물류"))
									{
									for(Transfer t : tList) {
						%>
						  <tr>
								<td><label class="badge badge-warning"> 대기 </label></td>
								<td> 이송요청 </td>
								<td><a href="#" onclick="window.open('<%=contextPath%>/stock/stockDetailForm?tCode=<%=t.gettCode()%>',
				            			'_blank', 'top=1,left=500,width=1000,height=700')"> <%= t.gettCode() %> </a></td>
								<td> <%= t.gettTitle() %> </td>
								<td> <%= sdf2.format(t.gettDate()) %> </td>
						  </tr>
						<% 
									} 
								}
								}	
						%>
						
						<%-- 대구담당일 경우 --%>
						<%-- <%
							if(empLoggedIn.geteDept().equals("대구물류"))
							{
						%>
						<%
								if (oList == null || oList.isEmpty()) {
									%>
									<!-- <tr>
										<th  colspan="5" style="text-align:center;">조회된 행이 없습니다.</th>
									</tr>	 -->			
									<%
											} else {
												
											
												for(Order o : oList) {
												if(o.getcCode().equals("TK")) {
									%>
									  <tr>
											<td><label class="badge badge-warning"> 대기 </label></td>
											<td> 발주요청 </td>
											<td><a href="#" onclick="window.open('<%=contextPath%>/product/stockOrderToBR?oCode=<%=o.getoCode()%>',
				            						'_blank', 'top=1,left=500,width=1000,height=700')"> <%= o.getoCode() %> </a></td>
											<td> <%= o.getoTitle() %> </td>
											<td> <%= sdf2.format(o.getoDate()) %> </td>
									  </tr>
									<% 				}
												} 
											}
										
									%>
						<%
								if (tList == null || tList.isEmpty()) {
						%>
						<!-- <tr>
							<th  colspan="5" style="text-align:center;">조회된 행이 없습니다.</th>
						</tr> -->				
						<%
								} else {
								
									for(Transfer t : tList) {
						%>
						  <tr>
								<td><label class="badge badge-warning"> 대기 </label></td>
								<td> 이송요청 </td>
								<td><a href="#" onclick="window.open('<%=contextPath%>/stock/stockDetailForm?tCode=<%=t.gettCode()%>',
				            			'_blank', 'top=1,left=500,width=1000,height=700')"> <%= t.gettCode() %> </a></td>
								<td> <%= t.gettTitle() %> </td>
								<td> <%= sdf2.format(t.gettDate()) %> </td>
						  </tr>
						<% 
									} 
								}
							}
						%> --%>
						
						<!-- 조회 테이블이 이송테이블일 경우 -->
							
						<%
							if(empLoggedIn.geteDept().equals("이송"))
							{
						%>
						<%
								if (tList == null || tList.isEmpty()) {
						%>
						<tr>
							<th colspan="5" style="text-align:center;">조회된 행이 없습니다.</th>
						</tr>
						<%
								} else {
									for(Transfer t : tList) {
						%>
						  <tr>
								<td><label class="badge badge-warning"> 대기 </label></td>
								<td> 이송요청 </td>
								<td><a href="#" onclick="window.open('<%=contextPath%>/stock/stockDetailForm?tCode=<%=t.gettCode()%>',
				            			'_blank', 'top=1,left=500,width=1000,height=700')"> <%= t.gettCode() %> </a></td>
								<td> <%= t.gettTitle() %> </td>
								<td> <%= sdf2.format(t.gettDate()) %> </td>
						  </tr>
						<% 
									} 
								}
							}
						%>
						</tbody>
					  </table>
					  </div>
					  
					<!--  페이징 -->
					
					<!-- 발주리스트 페이징 -->
					<% if (oList != null) { %>
					<div class="pagingArea" align="center" style="padding-bottom: 2%;">
						<%
							if (currentPage != 1) {
						%>
						<a href="<%=contextPath%>/approval?currentPage=1" style='color:#b66dff'>
							<i class="mdi mdi-chevron-double-left" style='color:#b66dff'></i>
						<a href="<%=contextPath%>/approval?currentPage=<%=currentPage - 1%>" style="color:#b66dff">
							<i class="mdi mdi-chevron-left"></i>
						<%
							}
						%>
				
						<%
							for (int p = startPage; p <= endPage; p++) {
						%>
						<%
								if (currentPage != p) {
									if(flag == null) {
						%>
						<a href='<%=contextPath%>/approval?currentPage=<%=p%>' style='color:#b66dff'> <%= p %> </a>
						<%
									} else {
						%>
						<a href='<%=contextPath%>/approval/complete/?currentPage=<%=p%>&flag='C' style='color:#b66dff'> <%= p %> </a>
						<%
									}
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
							if(maxPage != 0) {
								if (currentPage != maxPage) {
						%>
						<a href="<%=contextPath%>/approval?currentPage=<%=currentPage + 1%>" style='color:#b66dff'>
							<i class="mdi mdi-chevron-right"></i>
						</a>
						<a href="<%=contextPath%>/approval?currentPage=<%=maxPage%>" style='color:#b66dff'>
							<i class="mdi mdi-chevron-double-right"></i>
						</a>
						<%  
								}
							}
						%>
					</div>
					
					<% } %>
					
					<!-- 이송리스트 페이징 -->
					<% if(tList != null) { %>
					<div class="pagingArea" align="center" style="padding-bottom: 2%;">
						<%
							if (currentPage != 1) {
						%>
						<a href="<%=contextPath%>/approval/stt?currentPage=1" style='color:#b66dff'>
							<i class="mdi mdi-chevron-double-left" style='color:#b66dff'></i>
						<a href="<%=contextPath%>/approval/stt?currentPage=<%=currentPage - 1%>" style="color:#b66dff">
							<i class="mdi mdi-chevron-left"></i>
						<%
							}
						%>
				
						<%
							for (int p = startPage; p <= endPage; p++) {
						%>
						<%
								if (currentPage != p) {
									if(flag == null) {
						%>
						<a href='<%=contextPath%>/approval/stt?currentPage=<%=p%>' style='color:#b66dff'> <%= p %> </a>
						<%
									} else {
						%>
						<a href='<%=contextPath%>/approval/complete/?currentPage=<%=p%>&flag='C' style='color:#b66dff'> <%= p %> </a>
						<%
									}
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
							if(maxPage != 0) {
								if (currentPage != maxPage) {
						%>
						<a href="<%=contextPath%>/approval/stt?currentPage=<%=currentPage + 1%>" style='color:#b66dff'>
							<i class="mdi mdi-chevron-right"></i>
						</a>
						<a href="<%=contextPath%>/approval/stt?currentPage=<%=maxPage%>" style='color:#b66dff'>
							<i class="mdi mdi-chevron-double-right"></i>
						</a>
						<%  
								}
							}
						%>
					</div>
					
					<% } %>
					
					
					
				  </div>
				</div>
			
			</div>
          
          </div>
          <!-- content-wrapper ends -->
    	   <%@ include file="../common/footer.jsp" %>
          <!-- partial -->
        </div>
        <!-- main-panel ends -->
      </div>
      <!-- page-body-wrapper ends -->
    </div>
    <!-- container-scroller -->
	<%@ include file="../common/footerScript.jsp" %>
<script>
$('.btn').click(function() {
    $('[id$="-approval"]').hide();
    var target = '#' + $(this).data('target');
    $(target).show();
});
</script>
  </body>
</html>