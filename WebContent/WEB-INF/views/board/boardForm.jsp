<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<!DOCTYPE html>
<html lang="en">
  <head>
	 <%@ include file="../common/meta.jsp" %>
	 <title>게시판</title>
	 <%@ include file="../common/header.jsp" %>
 <style>
input:read-only {
  background-color: white !important;
  margin: -10px 5px;
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
  </head>
<script>
function boardValidate(){
	//내용을 작성하지 않은 경우에 대한 유효성 검사하세요.
	//공백만 작성한 경우도 폼이 제출되어서는 안됨.
	let $boardTitle = $("[name=boardTitle]");
	let $boardContent = $("[name=boardContent]");
	
	if($boardTitle.val().trim().length == 0){
		alert("제목을 입력하세요.");
		return false;
	}
	
	if($boardContent.val().trim().length == 0){
		alert("내용을 입력하세요.");
		return false;
	}
	return true;
}
</script>
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
               onclick="location.href='<%= request.getContextPath() %>/board/boardList'"></i>
              </span>
                <span class="page-title-icon bg-gradient-primary text-white mr-2">
                  <i class="mdi mdi-bulletin-board" style="text-decoration:none; color:#fff;"></i>
                </span> 게시판</h3>
            </div>
            
              <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                    <form action="<%=request.getContextPath() %>/board/boardInsert" method="post" enctype="multipart/form-data">
						<table id="tbl-board-view" class="table" style="width:70%; margin: 0px auto;">
						<tr>
							<td><input type="text" name="boardTitle" class="form-control form-control-lg" placeholder="제목을 입력하세요." required></td>
							
						</tr>
						<tr>
							<td>
								<input style="border:0px;" type="text" class="form-control form-control-lg writer" name="boardWriter"
								value="<%= empLoggedIn.geteName() %>" readonly/>
							</td>
						</tr>
						<tr>
							<td>			
								<input type="file" name="upFile" class="file-upload-default" style="margin: 0px 35px;">
							</td>
						</tr>
						<tr>
							<td><textarea rows="5" cols="40" name="boardContent" class="form-control" placeholder="내용을 입력하세요."></textarea></td>
						</tr>
						<tr>
							<th colspan="2" style="text-align:center;">
								<!-- <input type="submit" value="등록하기" onclick="return boardValidate();"> -->
								<button type="submit" value="등록하기" class="btn btn-primary btn-fw" onclick="return boardValidate();">등록하기</button>
							</th>
						</tr>
					</table>
					</form>
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
  </body>
</html>
