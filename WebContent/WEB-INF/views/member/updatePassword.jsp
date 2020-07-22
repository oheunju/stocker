<%@ page import="java.util.*" %>
<%@ page import="order.model.vo.Transfer" %>
<%@ page import="product.model.vo.Product" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<script src="<%=contextPath %>/js/jquery.qrcode.js"></script>
<script src="<%=contextPath %>/js/qrcode.js"></script>
<%@ include file="../common/meta.jsp" %>
<title>비밀번호 변경</title>
<%@ include file="../common/header.jsp" %>
<style type="text/css">
	.stock-tr{
		font-family: "고딕";
		font-weight: bold;
	}
	.card {
	left:50%;
	margin: 20px 0px;
	padding:1.0rem 2.0rem;

	}
	
	.form-group {
	margin-bottom: 0px; !important
	}
	
	.col-sm-9 {
	padding: 16px;
	}
	
	.back {
	font-size: 30px;
	padding-right: 10px;
	}
	
	.back:hover {
	cursor: Pointer;
	color: #B66DFF;
	}
	
	.col-form-label {
	padding-top: calc(1.5rem + 1px);
    padding-bottom: calc(0.94rem + 1px);
    padding-left: 0px;
    padding-right: 0px;
	}
	
</style>
<script>
function passwordValidate(){
	
	var $pwd = $("#password");
	var $newPwd = $("#newPassword");
	var $newPwdChk = $("#newPasswordCheck");
	
	if($newPwd.val() != $newPwdChk.val()){
		alert("입력한 비밀번호가 일치하지 않습니다.");
		$newPwd.val("").select();
		$newPwdChk.val("");
		return false;
	} else if ($pwd.val() == $newPwd.val()) {
		alert("새 비밀번호와 현재 비밀번호를 동일하게 설정할 수 없습니다.");
		$newPwd.val("").select();
		$newPwdChk.val("");
		return false;
	} else if(!chkPwd($.trim($newPwd.val()))){
		alert("비밀번호는 영문,숫자를 혼합하여 6~20자 이내만 허용됩니다.");    
		$newPwd.val("").select();
		$newPwdChk.val("");
		return false;
	}
	return true;
}

//비밀번호 유효성 검사
function chkPwd(str){
	
	 var reg_pwd = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
	 
	 if(!reg_pwd.test(str)){
	  return false;
	 }
	 return true;
	}
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
        <div class="content-wrapper" style="margin-bottom: -55px;">
            <i class="mdi mdi-close" id="bannerClose" style="display: none;"></i>
           <div class="page-header" style="width: 100%">
          	<div style="display: inline-block; width: 50%; text-align: left;">
             <h3 class="page-title kor" style="display: inline-block; margin-right: 25px;">
             <span style="float: left;">
               <i class="mdi mdi-chevron-left back" 
               onclick="location.href='<%= request.getContextPath() %>/member/infoView?eCode=<%=user.geteCode()%>'"></i>
              </span>
               <span class="page-title-icon bg-gradient-primary text-white mr-2">
                 <i class="mdi mdi-lock info"></i>
               </span> 비밀번호 변경 </h3>
          	</div>
	</div>
              
<div class="col-md-6 grid-margin stretch-card"> 
                <div class="card" style="width: 100%; min-width: 100%;">
                  <div class="card-body" style="padding:1.0rem 3.5rem;">
                    <h3 class="card-title" style="margin-bottom: 50px; text-align: center; font-weight: bold">현재 비밀번호와 새 비밀번호를 입력해주세요.</h3>
    				<form class="forms-sample" action="" method="post">
                    <input type="hidden" name="eCode" value="<%=request.getParameter("eCode")%>"/>
                      <div class="form-group row">
                        <label for="exampleInputPassword2" class="col-sm-3 col-form-label">현재 비밀번호</label>
                        <div class="col-sm-9">
                          <input type="password" class="form-control" name="password" id="password" required>
                        </div>
                      </div>
                      <div class="form-group row">
                        <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">새 비밀번호</label>
                        <div class="col-sm-9">
                          <input type="password" class="form-control" name="newPassword" id="newPassword" required>
                        </div>
                      </div>
                      <div class="form-group row">
                        <label for="exampleInputConfirmPassword2" class="col-sm-3 col-form-label">비밀번호 확인</label>
                        <div class="col-sm-9">
                          <input type="password" class="form-control" id="newPasswordCheck" required>
                        </div>
                      </div>
                       <div style="text-align: center; margin-top:50px">
                      <button type="submit" class="btn btn-gradient-primary mr-2" onclick="return passwordValidate();">비밀번호 변경</button>
                      </div>
                    </form>
                  </div>
                </div>
              </div>

      <!-- content-wrapper ends -->
	   <%@ include file="../common/footer.jsp" %>
      <!-- partial -->
    </div>
    </div>
    <!-- main-panel ends -->
  </div>
  
  <!-- page-body-wrapper ends -->
</div>
<!-- container-scroller -->
	<%@ include file="../common/footerScript.jsp" %>
</body>

</html>