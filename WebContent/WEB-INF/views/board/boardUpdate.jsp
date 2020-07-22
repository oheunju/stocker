<%@page import="board.model.vo.Board"%>
<%@page import="member.model.vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	Board b = (Board)request.getAttribute("board");
%>
<!DOCTYPE html>
<html lang="en">
  <head>
	 <%@ include file="../common/meta.jsp" %>
	 <title>게시판</title>
	 <%@ include file="../common/header.jsp" %>
  </head>


<script>
function boardValidate(){
	var $content = $("[name=content]");
	if($content.val().trim().length==0){
		alert("내용을 입력하세요");
		return false;
	}
	return true;
}
function boardView(){
	history.go(-1);
}
$(function(){
	//사용자가 파일을 선택/해제한 경우
	$("[name=upFile]").change(function(){
		console.log($(this).val());
		if($(this).val() != ""){
			$("#fname").hide();
		}else{
			$("#fname").show();
		}
	});
});
</script>
<style>
span#fname{
	position : absolute;
	left : 125px;
	top: 16px;
	width : 200px;
	background: #fff;
}
input:read-only {
  background-color: white !important;
  margin: -10px 0px;
  border:0px;
}
.back {
font-size: 30px;
padding-right: 10px;
}
.back:hover {
cursor: Pointer;
color: #B66DFF;
}
</style>
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
                <span style="float: left;">
               <i class="mdi mdi-chevron-left back" 
               onclick="boardView();"></i>
              </span>
                <span class="page-title-icon bg-gradient-primary text-white mr-2">
                  <i class="mdi mdi-bulletin-board" style="text-decoration:none; color:#fff;"></i>
                </span> 게시판</h3>
            </div>
            
            
			<section id="board-container">
			<form action="<%=request.getContextPath() %>/board/boardUpdate" method="post" enctype="multipart/form-data">
			<input type="hidden" name="boardNo" value="<%= b.getBoardNo() %>" />
			<div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
			<table id="tbl-board-view" class="table" style="width:70%; margin: 0px auto;">
				<tr>
					<td>
						<input type="text" name="boardTitle" class="form-control form-control-lg" value="<%=b.getBoardTitle()%>" required/>
					</td>
				</tr>		
				<tr>
					<td>
						<input type="text" name="boardWriter" class="form-control form-control-lg" value="<%=b.getBoardWriter() %>" readonly required/>
					</td>
				</tr>		
				<tr>
					<td style="position:relative;">
						<input type="file" name="upFile" style="margin: 0px 30px;"/>
						<!-- 파일태그의 value속성값은 보안상 이유로 임의변경할 수 없다. -->
						<span id="fname"><%= b.getBoardOriginalFileName() != null ? b.getBoardOriginalFileName() : "" %></span>
						<input type="hidden" name="oldOriginalFileName" value="<%= b.getBoardOriginalFileName() != null ? b.getBoardOriginalFileName() : "" %>"/>
						<input type="hidden" name="oldRenamedFileName" value="<%= b.getBoardRenamedFileName() != null ? b.getBoardRenamedFileName() : "" %>"/>
						<% if(b.getBoardOriginalFileName() != null) { %>
						<span class="form-check" style="display:inline; margin: 10px 30px;">
						 <label for="delFile" class="form-check-label" style="display: inline; font-size:13px;	">
                              	<input type="checkbox" name="delFile" id="delFile" class="form-check-input" style="margin-top:10px;"/>
                              	첨부파일 삭제
						</span>
						<% } %>
						<%-- <!-- 첨부파일 삭제 버튼 -->
						<% if(b.getBoardOriginalFileName() != null) { %>
							<div class="form-check" style="margin: 10px 30px;"> 
                              <label for="delFile" class="form-check-label">
                              	<input type="checkbox" name="delFile" id="delFile" class="form-check-input" style="margin-top:10px;"/>
                              	첨부파일 삭제
                              </label>
                            </div>
							<!-- <input type="checkbox" name="delFile" id="delFile" style="margin-top:10px;"/> -->
							<!-- <label for="delFile">첨부파일 삭제</label> -->
							
						<% } %> --%>
					</td>
				</tr>		
				<tr>
					<td>
						<textarea name="boardContent" class="form-control" cols="50" rows="5"><%=b.getBoardContent() %></textarea>
					</td>
				</tr>		
				<tr>
					<th colspan="2" style="text-align:center;">
						<!-- <input type="submit" onclick="return boardValidate();" value="수정하기" /> -->
						<button type="submit" value="수정하기" class="btn btn-primary btn-fw" onclick="return boardValidate();">수정하기</button>
						<!-- <input type="button" value="취소" onclick="boardView();"> -->
						<button type="button" value="취소" class="btn btn-danger btn-fw" onclick="boardView();">취소</button>
					</th>
				</tr>
				</table>
				</div>
                </div>
              </div>
			</form>
			
			</section>



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
  </body>
</html>