<%@page import="order.model.vo.PageInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="product.model.vo.Warehousing"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
	List<Warehousing> wList = (List<Warehousing>) request.getAttribute("wList");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
	String[] search = request.getParameterValues("search");

	
	PageInfo pi = (PageInfo) request.getAttribute("pi");
	
	int currentPage = pi.getCurrentPage();
	int startPage = pi.getStartPage();
	int endPage = pi.getEndPage();
	int maxPage = pi.getMaxPage();
%>
<!DOCTYPE html>
<html lang="en">
  <head>
	 <%@ include file="../common/meta.jsp" %>
	 <title>입고</title>
	 <%@ include file="../common/header.jsp" %>
  </head>
  <style>
	#stock-tr{
		/* font-family: 고딕; */
		font-weight: bold;
	}
	.popup_panel { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: 100;}
	.popup_panel div.popup_bg { position: absolute; top: 0; left: 0; width: 100%; height: 100%; background:#000; opacity:.5; filter:alpha(opacity=50); }
	.popup_panel div.popup_contents { position: absolute; top: 30%; left: 50%; width:600px; hight:800px; border:2px solid #b66dff; background-color:#fff; }
	.popup_contents2 {display:inline; float: right; margin: 30px; margin-top: 63px; margin-right: 38px;}
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
                </span> 입 고 </h3>
            </div>
          
          
          
          <%-- Contents --%>
          <div class="col-12">
                <div class="card">
                  <div class="card-body">
                    <form class="form-sample" id="searchForm" action="<%=contextPath%>/product/searchWarehousing">
                      <div class="row">
                        <div class="col-md-6">
                          <div class="form-group row">
                            <label class="col-sm-3 col-form-label stock-tr">입고코드</label>
                            <div class="col-sm-9">
                              <input type="text" class="form-control" name="search"/>
                            </div>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group row">
                            <label class="col-sm-3 col-form-label stock-tr">입고사유</label>
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
       	                 <button type="button" class="btn btn-inverse-info btn-fw" style="float: left" onclick="location.href=location.href='<%=contextPath%>/product/warehousing?currentPage=1'">전체보기</button>
                        </div>
                        <div class="col-md-6">
    					  <input type="hidden" name="currentPage" value="1" form="searchForm"/>
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
                    <h4 class="card-title">입고내역</h4>
                    <div class="table-responsive">
                      <table class="table">
                        <thead>
                          <tr>
                            <th id="stock-tr"> NO </th>
                            <th id="stock-tr"> 상품코드 </th>
                            <th id="stock-tr"> 수량 </th>
                            <th id="stock-tr"> 입고사유 </th>
                            <th id="stock-tr"> 센터</th>
                            <th id="stock-tr"> 입고일</th>
                          </tr>
                        </thead>
                        
                        <tbody>
                        <% if(wList == null || wList.isEmpty()) { %>
                  		<tr>
   							<th colspan="6">조회된 행이 없습니다.</th>
                  		</tr>
                       <% } else {
                       		for(Warehousing w : wList) {%>
                       		
                         <tr>
                           <td> <%= w.getwCode() %> </td>
                           <td><a href="javascript:void(0)" class="btn_popup_open" style='color:#b66dff'> <%= w.getpCode() %></a></td>
                           <td> <%= w.getwAmount() %> </td>
                           
                           <% if(w.getwReason().equals("S")) { %>
                           <td> <label class="badge badge-gradient-danger">공장입고</label> </td>
                           <% } else { %>
                           <td> <label class="badge badge-gradient-success">이송입고</label> </td>
                           <% } %>
                           
                           <td> <%= w.getcCode().equals("TK") ? "대구센터" : "경기센터" %> </td>
                           <td> <%= sdf.format(w.getwDate()) %> </td>
                         </tr>
                         
                        <% } 
                        } %> 
                        </tbody>
                      </table>
                    </div>
                    
                    <!--  페이징 -->
					<div class="pagingArea" align="center">
						<%
							if (currentPage != 1) {
						%>
						<a href="<%=contextPath%>/product/warehousing?currentPage=1" style="color:#b66dff">
							<i class='mdi mdi-chevron-double-left' style='color:#b66dff'></i>
						</a>
						<a href="<%=contextPath%>/product/warehousing?currentPage=<%=currentPage - 1%>" style="color:#b66dff">
							<i class="mdi mdi-chevron-left"></i>
						</a>
						<%
							}
						%>

						<%
							for (int p = startPage; p <= endPage; p++) {
						%>
						<%
								if (currentPage != p) {
						%>
					   <%
									if(search == null) {
						%> 
						<a href='<%=contextPath%>/product/warehousing?currentPage=<%=p%>' style='color:#b66dff'> <%= p %> </a>
						<%
									} else {
						%>
						<a href='<%=contextPath%>/product/searchWarehousing?currentPage=<%=p%>&search=<%=search[0]%>&search=<%=search[1]%>&search=<%=search[2]%>&search=<%=search[3]%>' style='color:#b66dff'> <%= p %> </a>
						<%
									}
						%>
						<%
								} else {
						%>
						<span class='cPage' style='color:#b66dff'><%= p %></span>
						<%
								}
						%>
						<%
							}
						%>

						<%
							if(maxPage != 0) 
							{
								if (currentPage != maxPage) 
								{
						%>
						<a href="<%=contextPath%>/product/warehousing?currentPage=<%=currentPage + 1%>" style='color:#b66dff'>
							<i class="mdi mdi-chevron-right"></i>
						</a>
						<a href="<%=contextPath%>/product/warehousing?currentPage=<%=maxPage%>" style='color:#b66dff'>
							<i class="mdi mdi-chevron-double-right"></i>
						</a>
						<%
								}
							}
						%>
					</div>
                    
                    
                    
                  </div>
                </div>
              </div>
            </div>
          
          
          </div>
          
          
          
          </div>
          <!-- 레이어 팝업 시작 -->
			<div class="popup_panel">
				<div class="popup_bg"></div>
					<div class="popup_contents" style="float: left;">
						<!-- images 폴더에 p_code와 같은 이름의 jpg파일 -->
						<img id="p_image" src="" alt="" />
					<div class="popup_contents2">
						<!-- db product테이블 p_theme 컬럼 --> 
						<span id="p_theme">p_theme</span>
						<!-- db product테이블 p_category 컬럼 -->
						<span id="p_category">p_category</span>
						<!-- db product테이블 p_name 컬럼 -->
						<span id="p_name">p_name</span>
						<hr />
						<span id="p_price" style="float:right">p_price</span>
						<div id="qrDiv" style="float: right; margin-top: 40px">
							<img id="p_qr_image" src="" alt="" style="width:130px; margin-right: -60px;"/>
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
	<script>
$(function () {
		
		// 레이어팝업 
	    var $panel = $(".popup_panel");
	    var $panelContents = $panel.find(".popup_contents");
	    
	    //상품상세팝업 클릭했을때
	    $(".btn_popup_open").on("click", function(e) {
	    	//상품코드 준비
	    	var pCode = $(this).text();
			var params = {pCode : pCode}; //서버로 보낼 파라미터
			
			$.post('<%=contextPath%>/order/productDetail', $.param(params), function(responseJson){
				//p_theme, p_category, p_name, p_price, p_qrImage

				var obj = $.parseJSON(JSON.stringify(responseJson));

				$("#p_image").attr("src", obj.pImage); //파일서블릿 경로(상품이미지 서버위치 가져옴)
				$("#p_theme").text("[" + obj.pTheme + "]");
				$("#p_category").text("[" + obj.pCategory + "]");
				$("#p_name").text(obj.pName);
				$("#p_price").text((obj.pPrice).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")); //가격 콤마찍기 
				$("#p_qr_image").attr("src", obj.pQrImage); //파일서블릿 경로(상품QR이미지 서버위치 가져옴)
				
				
			});
			
	        // 팝업 가운데 설정(가로)
	        if ($panelContents.outerWidth() < $(document).width()) {
	            $panelContents.css("margin-left", "-" + $panelContents.outerWidth() / 2 + "px");
	        } else {
	            $panelContents.css("left", "0px");
	        }

	        // 팝업 가운데 설정(세로)
	        if ($panelContents.outerHeight() < $(document).height()) {
	            $panelContents.css("margin-top", "-" + $panelContents.outerHeight() / 2 + "px");
	        } else {
	            $panelContents.css("top", "0px");
	        }
	        // 레이어 팝업 열기
	        $panel.fadeIn();
	        
	    });
	    // 팝업 닫기 이벤트 정의
	    $("#btn_popup_close").on("click", popupClose);

	    // 팝업 배경 클릭 이벤트 정의
	    $panel.find(".popup_bg").on("click", popupClose);

	
		function popupClose(e) {
		    $panel.fadeOut();
		    // 이벤트 기본 동작 중단
		    e.preventDefault();
		}

	})
	</script>
  </body>
</html>