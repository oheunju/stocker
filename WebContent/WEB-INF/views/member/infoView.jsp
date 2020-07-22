<%@ page import="java.util.*" %>
<%@ page import="order.model.vo.Transfer" %>
<%@ page import="product.model.vo.Product" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();	
	Employee emp = (Employee) request.getAttribute("emp");
	String ePhone = (emp.getePhone().substring(0, 3)) + "-"
					+ (emp.getePhone().substring(3, 7)) + "-"
					+ (emp.getePhone().substring(7));
%>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<%@ include file="../common/meta.jsp" %>
<title>내 정보 보기</title>
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
	.info {
	font-size: 20px;
	color: #B66DFF;
	}
	
	.form-group {
	margin-bottom: 0px; !important
	}
	
	.col-sm-9 {
	padding: 16px;
	}
	
	.p, .span {
	color: #3E4B5B;
	}
	
	.fa-pencil:hover {
	cursor: Pointer;
	color: #B66DFF;
	}
	
</style>
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
               <span class="page-title-icon bg-gradient-primary text-white mr-2">
                 <i class="mdi mdi-account-card-details"></i>
               </span> 내 정보 보기 </h3>
          	</div>
	</div>
	
              
<div class="col-md-6 grid-margin stretch-card"> 
                <div class="card" style="width: 100%; min-width: 100%;">
                  <div class="card-body" style="padding:1.0rem 3.5rem;">
                   <h4 class="card-title" style="margin-bottom: 50px; text-align: center; font-weight: bold">내 정보 보기</h4>
                    <form class="forms-sample" action="" method="post">
                    <input type="hidden" name="eCode" value="<%=emp.geteCode()%>"/>
                      <div class="form-group row">
                        <label class="col-sm-3 col-form-label"><i class="mdi mdi-clipboard-account info"></i></label>
                        <div class="col-sm-9">
                        <p name="eCode" id="eCode"><%=emp.geteCode() %></p>
                        </div>
                      </div>
                      <div class="form-group row">
                        <label class="col-sm-3 col-form-label"><i class="mdi mdi-account info"></i></label>
                        <div class="col-sm-9">
                        <p name="eName" id="eName"><%=emp.geteName() %></p>
                        </div>
                      </div>
                      <div class="form-group row">
                        <label class="col-sm-3 col-form-label"><i class="mdi mdi-lock info"></i></label>
                        <div class="col-sm-9">
                        <i class="fa fa-pencil" 
                        aria-hidden="true" data-toggle="tooltip" data-placement="top" title="비밀번호 수정"
                        onclick="location.href='<%= request.getContextPath() %>/member/updatePassword?eCode=<%=user.geteCode()%>'"></i></p>
                        </div>
                      </div>
                      <div class="form-group row">
                        <label class="col-sm-3 col-form-label"><i class="mdi mdi-city info"></i></label>
                        <div class="col-sm-9">
                          <p name="eDept" id="eDept"><%=emp.geteDept()%>팀</p>
                        </div>
                      </div>
                      <div class="form-group row">
                        <label class="col-sm-3 col-form-label"><i class="mdi mdi-cellphone info"></i></label>
                        <div class="col-sm-9">
                          <p name="ePhone" id="ePhone">
                          <%= ePhone%>
                          </p>
                        </div>
                      </div>
                      <div class="form-group row">
                        <label class="col-sm-3 col-form-label"><i class="mdi mdi-email info"></i></label>
                        <div class="col-sm-9">
                          <p name="eEmail" id="eEmail"><%=emp.geteEmail() %></p>
                        </div>
                      </div>
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
<script>
	$('[data-toggle="tooltip"]').tooltip();
</script>
</html>