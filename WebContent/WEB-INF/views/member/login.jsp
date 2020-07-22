<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="member.model.vo.Employee"%>
<%@page import="common.utill.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	Employee empLoggedIn = (Employee) session.getAttribute("empLoggedIn");
	String contextPath = request.getContextPath();
	
	//쿠키관련
	Cookie[] cookies = request.getCookies();
	boolean saveIdChecked = false;
	String saveIdValue = "";
	
	if (cookies != null) {
		for (Cookie c : cookies) {
			String k = c.getName();
			String v = c.getValue();
			//System.out.println(k + "=" + v);
			
			//쿠키에서 saveId(아이디저장 체크했을때) 가  true 이면
			if ("saveId".equals(k) && "true".equals(v)) {
				saveIdChecked = true;
			}
			//쿠키에서 사원번호가  있으면 저장
			if ("eCode".equals(k) && !Utils.isEmpty(v)) {
				saveIdValue = v; //eCode;
			}
		}
	
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- Required meta tags -->
<%@ include file="../common/meta.jsp"%>
<title>Login</title>
<%@ include file="../common/header.jsp"%>

<script>
	$(function() {		
		$("#eCode").val("<%=saveIdValue%>");             //사원번호 초기값 설정
		$("#saveId").prop("checked",<%=saveIdChecked%>); //아이디저장 초기값 설정		
		
		$("#loginFrm").submit(function() {
			
			//아이디저장 체크돼 있으면 쿠키 설정
			if($("#saveId").is(":checked")){
				setCookie("saveId", true, 90);
				setCookie("eCode", $("#eCode").val(), 90);
			}else{
				//체크없으면 쿠키값 초기화
				setCookie("saveId", false, 90);
				setCookie("eCode", "", 90);
			}
			
			let $eCode = $("#eCode");
			let $ePassword = $("#ePassword");

			if ($.trim($eCode.val()).length == 0) {
				alert("사번을 입력하세요.");
				$eCode.val(""); //값 초기화
				$eCode.focus();
				return false;
			}
			;

			if ($.trim($ePassword.val()).length == 0) {
				alert("비밀번호를 입력하세요.");
				$ePassword.val(""); //값 초기화
				$ePassword.focus();
				return false;
			}
			;

			//사번 유효성검사 : 숫자만 가능 
			var eCodeCheck = /^\d+/;

			if (!eCodeCheck.test($eCode.val())) {
				alert("사번은 숫자만 가능합니다.");
				$eCode.val(""); //값 초기화
				$eCode.focus();
				return false;
			}
			;
			return true;
		});
	});
	

	function submitForm() {

		alert("saveId checked="+$("#saveId").is(":checked"));
		
		if($("#saveId").is(":checked")){
			setCookie("saveId", true, 7);
			setCookie("eCode", $("#eCode").val(), 7);
		}else{
			setCookie("saveId", false, 7);
			setCookie("eCode", "", 7);
		}
		
	}
	

	// 쿠키 생성 함수
	function setCookie(cName, cValue, cDay) {
		var expire = new Date();
		expire.setDate(expire.getDate() + cDay);
		cookies = cName + '=' + escape(cValue) + '; path=/ '; // 한글 깨짐을 막기위해 escape(cValue)를 합니다.
		if (typeof cDay != 'undefined')
			cookies += ';expires=' + expire.toGMTString() + ';';
		document.cookie = cookies;
	}

	// 쿠키 가져오기 함수
	function getCookie(cName) {
		cName = cName + '=';
		var cookieData = document.cookie;
		var start = cookieData.indexOf(cName);
		var cValue = '';
		if (start != -1) {
			start += cName.length;
			var end = cookieData.indexOf(';', start);
			if (end == -1)
				end = cookieData.length;
			cValue = cookieData.substring(start, end);
		}
		return unescape(cValue);
	}
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
								<img
									src="<%=contextPath%>/resources/bootstrap/images/logo.png">
							</div>
							<h4>반갑습니다 :)</h4>
							<h6 class="font-weight-light kor">로그인 후 이용가능합니다.</h6>
							<form class="pt-3" action="<%=contextPath%>/member/login"
								id="loginFrm" method="post">
								<div class="form-group">
									<input type="text" class="form-control form-control-lg"
										id="eCode" name="eCode" placeholder="사번">
								</div>
								<div class="form-group">
									<input type="password" class="form-control form-control-lg"
										id="ePassword" name="ePassword" placeholder="비밀번호">
								</div>
								<div class="mt-3">
									<input type="submit" value="로그인"
										class="btn btn-block btn-gradient-primary btn-lg font-weight-medium auth-form-btn kor" />
								</div>
								<div
									class="my-2 d-flex justify-content-between align-items-center">
									<div class="form-check">
										<label class="form-check-label text-muted" for="saveId">
											<input type="checkbox" class="form-check-input kor" id="saveId">
												아이디 저장 
										</label>
									</div>
									<a class="auth-link text-black kor" href=""
										onclick="window.open('<%=contextPath%>/member/passwordFinder','_blank','top=1,left=500,width=500,height=600')">
										비밀번호찾기</a>
								</div>
							</form>
							<!-- <div class="text-center mt-4 font-weight-light kor"> 아직 계정이 없으신가요? <a href="register.jsp" class="text-primary kor">회원가입</a> -->
						</div>

					</div>
				</div>
			</div>
		</div>
		<!-- content-wrapper ends -->
	</div>
	<!-- page-body-wrapper ends -->
	</div>
	<%@ include file="../common/footerScript.jsp"%>
</body>
</html>