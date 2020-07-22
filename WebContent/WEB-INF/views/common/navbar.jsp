<%@page import="member.model.vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	Employee empLoggedIn = (Employee) session.getAttribute("empLoggedIn");
%>

<!DOCTYPE html>
<!-- partial:partials/_navbar.html -->
<nav class="navbar default-layout-navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
  <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
    <a class="navbar-brand brand-logo" href="<%= request.getContextPath() %>/index.jsp"><img src="<%=  request.getContextPath() %>/resources/bootstrap/images/logo.png" alt="logo" /></a>
    <a class="navbar-brand brand-logo-mini" href="<%= request.getContextPath() %>/index.jsp"><img src="<%=  request.getContextPath() %>/resources/bootstrap/images/logo-mini.svg" alt="logo" /></a>
  </div>
  <div class="navbar-menu-wrapper d-flex align-items-stretch">
    <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-toggle="minimize">
      <span class="mdi mdi-menu"></span>
    </button>
    <div class="search-field d-none d-md-block">
    </div>
    <ul class="navbar-nav navbar-nav-right">
      <li class="nav-item nav-profile dropdown" style="margin-top: 2%;">
        <a class="nav-link dropdown-toggle" id="profileDropdown" href="#" data-toggle="dropdown" aria-expanded="false">
          <div class="nav-profile-text" >
          <%if(empLoggedIn != null){%>
          <p class="mb-1 text-black" onclick="location.href='<%= request.getContextPath() %>/member/infoView?eCode=<%=empLoggedIn.geteCode()%>'"><%=empLoggedIn.geteDept()%> <strong><%=empLoggedIn.geteName() %></strong></p>
          <%}%>
          </div>
        </a>
      </li>
      <li class="nav-item d-none d-lg-block full-screen-link">
        <a class="nav-link">
          <i class="mdi mdi-fullscreen" id="fullscreen-button"></i>
        </a>
      </li>
	  <li class="nav-item">
	    <a class="nav-link" href="<%= request.getContextPath()%>/board/boardList">
	  	<i class="mdi mdi-bulletin-board"></i>
	    </a>
	  </li>
      <li class="nav-item nav-logout d-none d-lg-block">
        <a class="nav-link" href="<%= request.getContextPath()%>/member/logout">
          <i class="mdi mdi-power"></i>
        </a>
      </li>
      <li class="nav-item nav-settings d-none d-lg-block">
        <a class="nav-link" href="#">
          <i class="mdi mdi-format-line-spacing"></i>
        </a>
      </li>
    </ul>
    <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
      <span class="mdi mdi-menu"></span>
    </button>
  </div>
</nav>