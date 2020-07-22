<%@page import="board.model.vo.BoardComment"%>
<%@page import="board.model.vo.Board"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Board board = (Board)request.getAttribute("board");
	List<BoardComment> commentList
	= (List<BoardComment>)request.getAttribute("commentList");
%>
<!DOCTYPE html>
<html lang="en">
  <head>
	 <%@ include file="../common/meta.jsp" %>
	 <title>게시판</title>
	 <%@ include file="../common/header.jsp" %>
	 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  </head>
	 <style>
	 .reply-btn:hover {
	 cursor: pointer;
	 opacity:50%;
	 }
	 .btn-link {
	 padding: 5px;
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
               onclick="location.href='<%= request.getContextPath() %>/board/boardList'"></i>
              </span>
                <span class="page-title-icon bg-gradient-primary text-white mr-2">
                  <i class="mdi mdi-bulletin-board" style="text-decoration:none; color:#fff;"></i>
                </span> 게시판</h3>
            </div>
            
            
            <!-- 콘텐츠영역 -->
            <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                    <table class="table table-bordered" style="width: 70%; margin:0 auto;">
                      <tr>
						<th class="col-md-3" style="text-align:center; weight:300px"><%= board.getBoardTitle() %></th>
						<td style="text-align:center;"><%= board.getBoardDate() %></td>
					</tr>
						<tr>
						<td style="text-align:center;"><%= board.getBoardWriter() %></td>
						<td style="text-align:right;">
						<% if(empLoggedIn != null && board.getBoardWriter().equals(empLoggedIn.geteName())){ %>
						<button type="button" class="btn btn-gradient-primary btn-sm" value="수정하기"
								onclick="location.href='<%= request.getContextPath() %>/board/boardUpdate?boardNo=<%= board.getBoardNo() %>'">
						<i class="fa fa-pencil"></i>
						</button>
						<button type="button" class="btn btn-gradient-primary btn-sm" value="삭제하기" onclick="deleteBoard();">
						<i class="mdi mdi-delete"></i>
						</button>
                            </td>
                            <% } %>
					</tr>
										<tr>
						<td colspan=2 style="text-align:right;">
							<!-- 첨부파일이 있을경우만, 이미지와 함께 original파일명 표시 -->
							<% if(board.getBoardOriginalFileName() != null){ %>
							<a href="javascript:fileDownload('<%= board.getBoardOriginalFileName() %>','<%= board.getBoardRenamedFileName() %>');">
								<i class="mdi mdi-file"></i>
								<%= board.getBoardOriginalFileName() %>
							</a>
							<% } %>
						</td>
					</tr>
					<tr>
						<td colspan=2 height="300px" style="text-align:center;"><%= board.getBoardContent() %></td>
					</tr>
                    </table>
                    
                    <hr style="margin-top: 30px;"/>
                    
                    <div class="comment-container">
                    <div class="comment-editor">
						<form action="<%= request.getContextPath() %>/board/boardCommentInsert"
						      method="post"
						      name="boardCommentFrm">
						      <input type="hidden" name="boardRef" 
						      		 value="<%= board.getBoardNo() %>" />
						      <input type="hidden" name="boardCommentWriter" 
						      		 value="<%= empLoggedIn != null ? empLoggedIn.geteName() : ""%>" />
							  <input type="hidden" name="boardCommentLevel" value="1" />
							  <!-- 대댓글인 경우, 참조하는 댓글번호 -->
							  <input type="hidden" name="boardCommentRef" value="0" />
							  <div style="width: 70%; margin:0 auto;">
						      <textarea name="boardCommentContent" 
						      			id="boardCommentContent"
						      			class="form-control"
						      			style="width:80%; display:inline-block;"
						      			cols="60" rows="3"></textarea>
						      <!-- <input type="submit" value="등록" id="btn-insert" style="position:relative"/> -->
						      <button type="submit" value="등록" id="btn-insert" class="btn btn-gradient-primary btn-fw"
						      style="height:70px; margin-left:0px; position:absolute;">등록</button>
						      </div>
						
						</form>
					</div>
					<!-- 댓글 보기 -->
					<table id="tbl-comment" class="table table-hover" style="width: 70%; margin:0 auto;">
					<% 
						if(commentList != null && !commentList.isEmpty()){ 
							for (BoardComment bc : commentList) {
								if(bc.getBoardCommentLevel() == 1) {
								//댓글
					%>
						<tr class="level1">
							<td>
								<sub class="comment-writer">
									<strong><%= bc.getBoardCommentWriter() %></strong>
								</sub>
								<sub class="comment-date">
									&emsp; <%= bc.getBoardCommentDate() %>
								</sub>
								<br />
								<br />
								<%= bc.getBoardCommentContent() %>
							</td>
							<td style="text-align:right;">
								<button class="btn btn-link btn-reply" id="btn-reply"
										value="<%= bc.getBoardCommentNo() %>">
										<i class="mdi mdi-subdirectory-arrow-right reply-btn"
										style="color:#b66dff; font-size:20px"></i>
										</button>
								<% if(
										empLoggedIn != null
									  && empLoggedIn.geteName().equals(bc.getBoardCommentWriter())
										
									){ %>
								<button class="btn btn-link btn-delete1" id="btn-delete1"
										value="<%= bc.getBoardCommentNo() %>">
										<i class="mdi mdi-delete reply-btn" style="color:#fe7096; font-size:18px"></i>
										</button>
								<% } %>
							</td>
						</tr>	
					<% 
								} else {
								//대댓글
					%>		
						<tr class="level2">
							<td><i class="mdi mdi-subdirectory-arrow-right"></i>
								<sub class="comment-writer">
									<strong><%= bc.getBoardCommentWriter() %></strong>	
								</sub>
								<sub class="comment-date">
									&emsp; <%= bc.getBoardCommentDate() %>
								</sub>
								<br />
								<br />
								&emsp; <%= bc.getBoardCommentContent() %>
							</td>
							<td style="text-align:right;">
								<% if(
										empLoggedIn != null
									  && empLoggedIn.geteName().equals(bc.getBoardCommentWriter())
										
									){ %>
								<button class="btn btn-link btn-delete2" id="btn-delete2"
										value="<%= bc.getBoardCommentNo() %>">
										<i class="mdi mdi-delete reply-btn"
											style="color:#fe7096; font-size:18px;"></i>
										</button>
								<% } %>
							</td>
						</tr>
			
					<% 		
								}
							}
						} 
					%>
					</table>
					
					<!-- 댓글 삭제 폼 -->
					<form name="deleteCommentFrm">
						<input type="hidden" name="boardCommentNo" value="" />
						<input type="hidden" name="boardNo" value="<%= board.getBoardNo() %>" />
					</form>
								
					</div>
                    <% if(empLoggedIn != null && board.getBoardWriter().equals(empLoggedIn.geteName())){ %>
						<form name="deleteBoardFrm" action="<%= request.getContextPath() %>/board/boardDelete" method="POST">
							<input type="hidden" name="boardNo" value="<%= board.getBoardNo() %>" />
							<input type="hidden" name="rname" value="<%= board.getBoardRenamedFileName() != null ? board.getBoardRenamedFileName() : ""  %>" />
						</form>
						<script>
						function deleteBoard(){
							
							if(!confirm('정말 삭제하시겠습니까?')) return;
							
							$deleteFrm = $([name=deleteBoardFrm]);
							
							$deleteFrm.submit();
						}
						</script>
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
  </body>
  <script>
function fileDownload(oname, rname){
	let url = "<%= request.getContextPath() %>/board/fileDownload";
	//한글을 %문자(유니코드)로 변경
	oname = encodeURIComponent(oname);
	/* console.log(oname); */
	location.href = url + "?oname=" + oname + "&rname=" + rname;
}
$(function(){
	
	/*
	* @실습문제
	* 1. 삭제버튼은  작성자 본인과 관리자에게 노출한다.
	* 		-> 로그인한 사용자 == BoardComment.boardCommentWriter
	* 		-> 관리자
	* 2. 삭제는 deleteCommentFrm를 통해 POST요청한다. 
	* 		-> /board/boardCommentDelete 
	* 		-> deleteCommentFrm POST전송
	* 		-> boardCommentNo : delete from board_comment where board_comment_no = ?
	* 3. 삭제후에는 해당게시글 상세보기 페이지로 이동한다.
	* 		-> msg.jsp msg loc
	* 		-> loc: /board/boardView?boardNo=?
	*/
	$(".btn-delete2").click(function(){
		if(!confirm('댓글을 정말 삭제하시겠습니까?')) return;
		
		//삭제 : post방식 요청
		//삭제할 번호 가져오기
		let boardCommentNo = $(this).val();
		//alert(boardCommentNo);
		
		let $frm = $("[name=deleteCommentFrm]");
		$frm.children("[name=boardCommentNo]").val(boardCommentNo);
		$frm.attr('action', '<%= request.getContextPath()%>/board/boardCommentDelete')
			.attr('method', 'POST')
			.submit();
		
	});
	$(".btn-delete1").click(function(){
		if(!confirm('댓글을 정말 삭제하시겠습니까?')) return;
		
		//삭제 : post방식 요청
		//삭제할 번호 가져오기
		let boardCommentNo = $(this).val();
		//alert(boardCommentNo);
		
		let $frm = $("[name=deleteCommentFrm]");
		$frm.children("[name=boardCommentNo]").val(boardCommentNo);
		$frm.attr('action', '<%= request.getContextPath()%>/board/boardCommentDelete')
			.attr('method', 'POST')
			.submit();
		
	});
	
	$("#boardCommentContent").click(function(){
		if(<%= empLoggedIn == null %>)
			loginAlert();
	});
	
	$("[name=boardCommentFrm]").submit(function(){
		
		//로그인 여부 검사
		if(<%= empLoggedIn == null %>){
			loginAlert();
			return false;			
		}
		
		//댓글 검사
		let $boardContent = $("#boardCommentContent");
		if(!/^.{1,}$/.test($boardContent.val())){
			alert("댓글 내용을 작성해 주세요.");
			return false;
		}
		
		
	});
	
	$(".btn-reply").click(function(){
		if(<%= empLoggedIn == null %>)
			loginAlert();
		else {
			let $tr = $("<tr></tr>");
			let $td = $("<td style='display:none; text-align:left;' colspan=2></td>");
			let $frm = $("<form action='<%=request.getContextPath() %>/board/boardCommentInsert' method='POST'></form>");
			$frm.append("<input type='hidden' name='boardRef' value='<%= board.getBoardNo() %>' />");
			$frm.append("<input type='hidden' name='boardCommentWriter' value='<%= empLoggedIn != null ? empLoggedIn.geteName() : "" %>' />");
			$frm.append("<input type='hidden' name='boardCommentLevel' value='2' />");
			$frm.append("<input type='hidden' name='boardCommentRef' value='"+$(this).val()+"' />");
			$frm.append("<textarea name='boardCommentContent' class='form-control' style='width:80%; height:75px; display:inline-block;' cols=60 rows=1></textarea>");
			
			
			$frm.append("<button type='submit' class='btn btn-gradient-primary btn-fw' style='position:relative; left:10px; bottom:32px; width:60px; height:75px;'>등록</button>");
			
			$td.append($frm);
			$tr.append($td);
			let $boardCommentTr = $(this).parent().parent();
			$tr.insertAfter($boardCommentTr)
			   .children("td").slideDown(800)
			   .children("form").submit(function(){
				   let $textarea = $(this).find("textarea");
				   if($textarea.val().length == 0)
					   return false;
			   })
			   .children("textarea").focus();
		}
		
		//1회만 작동하도록 함.
		$(this).off("click");
	});
	
});

function loginAlert(){
	alert("로그인 후 이용하실 수 있습니다.");
}

function boardView(){
	history.go(-1);
}
</script>
</html>