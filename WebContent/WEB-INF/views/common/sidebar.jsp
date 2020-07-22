<%@page import="member.model.service.EmpService"%>
<%@page import="member.model.vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	Employee user = (Employee) session.getAttribute("empLoggedIn");
%>
<!DOCTYPE html>
<!-- partial:partials/_sidebar.html -->
<nav class="sidebar sidebar-offcanvas" id="sidebar">
  <ul class="nav">
    <li class="nav-item">
      <a class="nav-link" href="<%= request.getContextPath() %>">
        <span class="menu-title kor">메 인</span>
        <i class="mdi mdi-home menu-icon"></i>
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link" data-toggle="collapse" href="#product" aria-expanded="false" aria-controls="ui-basic">
        <span class="menu-title kor">상품관리</span>
        <i class="menu-arrow"></i>
        <i class="mdi mdi-basket menu-icon"></i>
      </a>
      <div class="collapse" id="product">
        <ul class="nav flex-column sub-menu">
          <li class="nav-item"> <a class="nav-link kor" href="<%= request.getContextPath() %>/product/warehousing?currentPage=1">입고</a></li>
          <li class="nav-item"> <a class="nav-link kor" href="<%= request.getContextPath() %>/product/beReleased">출고</a></li>
          <li class="nav-item"> <a class="nav-link kor" href="<%= request.getContextPath() %>/product/stk">재고</a></li> 
        </ul>
      </div>
    </li>
    <li class="nav-item">
      <a class="nav-link" data-toggle="collapse" href="#order" aria-expanded="false" aria-controls="ui-basic">
        <span class="menu-title kor">거래관리</span>
        <i class="menu-arrow"></i>
        <i class="mdi mdi-barcode-scan menu-icon"></i>
      </a>
      <div class="collapse" id="order">
        <ul class="nav flex-column sub-menu">
          <li class="nav-item"> <a class="nav-link kor" href="<%= request.getContextPath() %>/order/ordr?currentPage=1">발주</a></li>
          <li class="nav-item"> <a class="nav-link kor" href="<%= request.getContextPath() %>/order/transfer">이송</a></li>
        </ul>
      </div>
    </li>
       <li class="nav-item">
        <a class="nav-link" href="<%= request.getContextPath() %>/sales">
        <span class="menu-title kor">통 계</span>
        <i class="menu-arrow"></i>
        <i class="mdi mdi-chart-line menu-icon"></i>
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="<%= request.getContextPath() %>/approval?currentPage=1">
        <span class="menu-title kor">결재진행</span>
        <i class="menu-arrow"></i>
        <i class="mdi mdi-script menu-icon"></i>
      </a>
    </li>
  </ul>
</nav>