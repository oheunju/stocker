<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import="common.mail.*" %>
<%
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <!-- Required meta tags -->
	 <%@ include file="../common/meta.jsp" %>
    <title>비밀번호 찾기</title>
	 <%@ include file="../common/header.jsp" %>
	 
	 
<script>
$(function (){
	$("#passwordFinderFrm").submit(function(){
		let $eCode = $("#eCode");
		let $eEmail = $("#eEmail");
		
		if($.trim($eCode.val()).length == 0) {
			alert("사번을 입력하세요.");
			$eCode.val(""); //값 초기화
			$eCode.focus();
			return false;
		};
		
		if($.trim($eEmail.val()).length == 0) {
			alert("이메일을 입력하세요.");
			$eEmail.val(""); //값초기화 
			$eEmail.focus();
			return false;
		};
		
		//사번 유효성검사 : 숫자만 가능 
		var eCodeCheck= /^\d+/; 
		
		if(!eCodeCheck.test($eCode.val())) {
			alert("사번은 숫자만 가능합니다.");
			$eCode.val(""); //값 초기화
			$eCode.focus();
			return false;
		};
		return true;
	});
});
</script>
</head>
<body>
    <div class="container-scroller">
      <div class="container-fluid page-body-wrapper full-page-wrapper">
        <div class="content-wrapper d-flex align-items-center auth">
          <div class="row flex-grow">
            <div class="col-lg-4 mx-auto">
              <div class="auth-form-light text-left p-5">
                <div class="brand-logo">
                  <img src="<%= contextPath %>/resources/bootstrap/images/logo.png">
                </div>
                <h4>비밀번호 찾기</h4>
                <h6 class="font-weight-light kor">사번과 이메일을 입력해주세요.</h6>
                <form class="pt-3" method="post" action="<%=contextPath%>/member/resetPassword" id="passwordFinderFrm">
                
                  <div class="form-group">
                    <input type="text" class="form-control form-control-lg" id="eCode" name="eCode" placeholder="사번">
                  </div>
                  <div class="form-group">
                    <input type="email" class="form-control form-control-lg" id="eEmail" name="eEmail" placeholder="이메일">
                  </div>
                  <div class="mt-3">
                  	<input type="submit" value="비밀번호 찾기" class="btn btn-block btn-gradient-primary btn-lg font-weight-medium auth-form-btn kor"/>
                  </div>
                  </form>
                  </div>
              </div>
            </div>
          </div>
        </div>
        <!-- content-wrapper ends -->
      </div>
      <!-- page-body-wrapper ends -->
    </div>
<%@ include file="../common/footerScript.jsp" %>

  </body>
</html>