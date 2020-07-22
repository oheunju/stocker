<%@page import="java.text.SimpleDateFormat"%>
<%@page import="product.model.vo.BeReleased"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
	List<BeReleased> brList = (List<BeReleased>) request.getAttribute("list");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
	String pageBar = (String) request.getAttribute("pageBar");
%>
<!DOCTYPE html>
<html lang="en">
  <head>
	 <%@ include file="../common/meta.jsp" %>
	 <title>출고</title>
	 <%@ include file="../common/header.jsp" %>
  </head>
  <style>
	#stock-tr{
		/* font-family: 고딕; */
		font-weight: bold;
	}
	.stock-tr{
		font-weight: bold;
	}
	div#pageBar{
		margin-top:20px;
		text-align:center;
	}
	div#pageBar span.cPage{
		font-weight:bold; color: #b66dff; margin-right: 5px; font-size:15px
	}
	div#pageBar a{
		margin-right: 5px; font-size:15px
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
                <span class="page-title-icon bg-gradient-primary text-white mr-2">
                  <i class="mdi mdi-basket"></i>
                </span> 출 고 </h3>
            </div>
            
          <%-- Contents --%>
          <div class="col-12">
                <div class="card">
                  <div class="card-body">
                    <form class="form-sample" id="searchForm" action="<%= contextPath %>/beReleased/search">
                      <div class="row">
                        <div class="col-md-6">
                          <div class="form-group row">
                            <label class="col-sm-3 col-form-label stock-tr">출고코드</label>
                            <div class="col-sm-9">
                              <input type="text" class="form-control" name="search"/>
                            </div>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group row">
                            <label class="col-sm-3 col-form-label stock-tr">상품코드</label>
                            <div class="col-sm-9">
                              <input type="text" class="form-control" name="search"/>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="row">
                        <div class="col-md-6">
                          <div class="form-group row">
                            <label class="col-sm-3 col-form-label stock-tr">수량</label>
                            <div class="col-sm-9">
                              <input type="text" class="form-control" name="search"/>
                            </div>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group row">
                            <label class="col-sm-3 col-form-label stock-tr">출고사유</label>
                            <div class="col-sm-9">
                              <input type="text" class="form-control" name="search"/>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="row">
                        <div class="col-md-6">
                          <div class="form-group row">
                            <label class="col-sm-3 col-form-label stock-tr">기간</label>
                            <div class="col-sm-9">
                             <input type="date" class="form-control" name="search" id="r-date"/>
                            </div>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group row" >
                            <label class="col-sm-3 col-form-label stock-tr" style="text-align: center"> - </label>
                            <div class="col-sm-9">
                             <input type="date" class="form-control" name="search" id="r-date2"/>
                            </div>
                          </div>
                        </div>
                        <div class="col-md-6">
       	                 <button type="button" class="btn btn-inverse-info btn-fw" style="float: left" onclick="location.href='<%= contextPath %>/product/beReleased'">전체보기</button>
                        </div>
                        <div class="col-md-6">
                         <button type="submit" class="btn btn-inverse-primary btn-fw" style="float: right">Search</button>
                        </div>
                      </div>
                    </form>
                  </div>
                </div>
              </div>
              
              
          <div >
          		
          	
       
          	
          <div >
          	
          <div class="col-12 grid-margin" style="margin-top: 26px">
                <div class="card">
                  <div class="card-body">
                    <h4 class="card-title">출고내역</h4>
                    <div class="table-responsive">
                      <table class="table">
                        <thead>
                          <tr>
                            <th id="stock-tr"> NO </th>
                            <th id="stock-tr"> 상품코드 </th>
                            <th id="stock-tr"> 수량 </th>
                            <th id="stock-tr"> 출고사유 </th>
                            <th id="stock-tr"> 출고일</th>
                          </tr>
                        </thead>
                        
                        <tbody>
                        <!-- db구현되면 servlet작성 후 list이용해서 for문으로 구현할것 -->
                        <!-- 가상테이블 -->
                        <% if(brList == null || brList.isEmpty()) { %>
                  		<tr>
   							<th colspan="6">조회된 행이 없습니다.</th>
                  		</tr>
                       <% } else {
                       		for(BeReleased br : brList) {%>
                       		
                         <tr>
                           <td> R<%= br.getrCode() %> </td>
                           <td> <%= br.getpCode() %> </td>
                           <td> <%= br.getrAmount() %> </td>
                           
                           <% if(br.getrReason().equals("매장출고")) { %>
                           <td> <label class="badge badge-gradient-danger">매장출고</label> </td>
                           <% } else { %>
                           <td> <label class="badge badge-gradient-success">이송출고</label> </td>
                           <% } %>
                           <%-- <td> <%= br.getrReason() %> </td> --%>
                           
                           <td> <%= sdf.format(br.getrDate()) %> </td>
                         </tr>
                         
                        <% } 
                        } %> 
                        </tbody>
                      </table>
                      
                      
                      <!-- 페이징 -->
                      <div id='pageBar'>
                 		<%= pageBar %>
                  	  </div>
                  	  
                    </div>
                  </div>
                </div>
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
  /* document.getElementById('r-date').valueAsDate = new Date();
  document.getElementById('r-date2').valueAsDate = new Date(); */
  	
  </script>
</html>