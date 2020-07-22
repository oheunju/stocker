<%@page import="member.model.vo.Employee"%>
<%@page import="order.model.vo.Transfer"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
	Transfer t = (Transfer) request.getAttribute("transfer");
	Date today = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");

	String str = sdf.format(today);
	String msg = (String) session.getAttribute("msg");
	Employee empLoggedIn = (Employee) session.getAttribute("empLoggedIn");
%>
<!DOCTYPE html>
<html lang="en">
  <head>
	 <%@ include file="../common/meta.jsp" %>
	 <title>이송요청 품의서</title>
	 <%@ include file="../common/header.jsp" %>
<style>
input {
 background-color: white !important;
}
th, td {
padding: 5px;
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
	          <div style="float:left; display: inline-block; margin-top: 48px; margin-left: 26px;"><h1 class="display-1 kor">
	          이송 품의서</h1></div>
			  <div class="card" style="display: inline-block; margin-top: 26px; width:250px; float:right" >
				<div class="card-body" style="padding: 1.5rem 2.9rem;">
					<table style="border-spacing:20px; text-align:center;">
						<tr>
							<th>재고 담당</th>
							<th>이송 담당</th>
						</tr>
						<tr>
							<td><input type="checkbox" checked disabled></td>
							<td><input type="checkbox" checked disabled></td>
						</tr>
					</table>
				</div>
			  </div>
          </div>
 
 <form class="forms-sample" name="stockFrom" id="stockForm" action="<%= contextPath %>/product/stockForm" method="post">
  
        <div class="col-lg-12 grid-margin stretch-card" style="margin-top: 23%">
  <div class="card">
    <div class="card-body">
      <table class="table">
        <thead>
          <tr>
            <th><strong>이송 코드</strong></th>
            <th><%=t == null ? "" : t.gettCode() %></th>
          </tr>
          <tr>
            <th><strong>품의 제목</strong></th>
            <th><%=t == null ? "" : t.gettTitle()%></th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <th><strong>품의 내용</strong></th>
            <th>
             <form class="forms-sample">
                  <div class="form-group">
                    <label for="exampleInputUsername1">상품코드</label>
                    <input type="text" class="form-control" value="<%=t == null ? "" : t.getpCode() %>" readonly>
                  </div>
                  <div class="form-group">
                    <label for="exampleInputUsername1">수량 (개)</label>
                    <input type="text" class="form-control" value="<%=t == null ? "" : t.gettAmount()%>" readonly>
                  </div>
                  <div class="form-group">
                    <label for="exampleInputUsername1">출고센터</label>
                    <input type="text" class="form-control" value="<%= t.getDepartureCode().equals("TK") ? "대구센터" : "경기 광주센터" %>" readonly>
                  </div>
                  <div class="form-group">
                    <label for="exampleInputUsername1">입고센터</label>
                    <input type="text" class="form-control" value="<%= t.getDestinationCode().equals("TK") ? "대구센터" : "경기 광주센터" %>" readonly>
                  </div>
                </form>
            </th>
          </tr>
        </tbody>
      </table>
      </div>
      </div>
      </div>
	<div class="card-body" style="text-align: right; padding: 0.25rem; padding-right: 30px;">
	  <h6 class="kor"><strong style="margin-right: 20px;">작성인 : </strong>재고담당 <span><%= t.gettWriter()%></span></h6>
	  <h6 class="kor"><%= str %></h6>
	  <br />
      <button type="button" class="btn btn-gradient-primary btn-rounded btn-icon"
      style="float:right;" onclick="window.print()">
               <i class="mdi mdi-printer btn-icon-append"></i></button>
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
  </body>
</html>