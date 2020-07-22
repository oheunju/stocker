<%@page import="product.model.vo.Stock"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
	List<Stock> list = (List<Stock>)request.getAttribute("list");
	String pageBar = (String) request.getAttribute("pageBar");
	String msg = (String)session.getAttribute("msg");
	
%>
<!DOCTYPE html>
<html lang="en">
  <head>
	 <%@ include file="../common/meta.jsp" %>
	 <title>재고</title>
	 <%@ include file="../common/header.jsp" %>
  </head>
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
            
            <div style="display: inline-block;  text-align: left; ">
              <h3 class="page-title kor"style="display: inline-block; margin-right: 25px;">
                <span class="page-title-icon bg-gradient-primary text-white mr-2">
                  <i class="mdi mdi-basket"></i>
                </span> 재 고 </h3>
                <!-- 재고메인버튼 -->
                <!-- <button class="add btn btn-gradient-primary font-weight-bold todo-list-add-btn" id="stock-main-btn" style="display: inline-block; margin-right: 10px;"  "> 재고조회
                <i class="mdi mdi-basket"></i>
                </button> -->
                <!-- 이송요청버튼 -->
                 </div>
                <button class="add btn btn-gradient-primary font-weight-bold todo-list-add-btn" 
                id="stock-submit-btn" style="display: inline-block; margin-right: 40px; text-align: right !important;"
                onclick="window.open('<%=contextPath%>/product/stockForm?eCode=<%=empLoggedIn.geteCode()%>','_blank', 'top=1,left=500,width=1000,height=700')  "> 이송요청
                <i class="mdi mdi-file-check"></i>
                </button>
            

<style>
.stock-tr {
	/* font-family: 고딕; */
	font-weight: bold;
}
</style>
<script>
	$(function(){
		var message = "<%=msg%>";
		// var message = "회원가입 성공!!"; // "null"
		if(message != "null"){
			alert(message);
			<% session.removeAttribute("msg"); %>
		}
	});
</script>                
                
                
            </div>
          
          <div class="stock-main">
          
        
           <div class="col-12">
                <div class="card">
                  <div class="card-body">
                    <form action="<%=contextPath %>/product/stockSearch" id="searchForm" class="form-sample">
                      <div class="row">
                        <div class="col-md-6">
                          <div class="form-group row">
                            <label class="col-sm-3 col-form-label stock-tr">상품명</label>
                            <div class="col-sm-9" id="search-pName">
                              <input type="text" class="form-control" name="search" id="search_pname" />
                            </div>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group row">
                            <label class="col-sm-3 col-form-label stock-tr">상품코드</label>
                            <div class="col-sm-9" id="search-pCode">
                              <input type="text" class="form-control" name="search" id="search_pcode" />
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="row">
                        <div class="col-md-6">
                          <div class="form-group row">
                            <label class="col-sm-3 col-form-label stock-tr">테마</label>
                            <div class="col-sm-9" id="search-pTheme">
                                 <input type="text" class="form-control" name="search" id="search_ptheme" />
                            </div>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="form-group row">
                            <label class="col-sm-3 col-form-label stock-tr">종류</label>
                            <div class="col-sm-9" id="search-pCategory">
                                 <input type="text" class="form-control" name="search" id="search_pcategory" />
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="row">
                        <div class="col-md-6">
       	                 <button type="button" class="btn btn-inverse-info btn-fw" style="float: left; font-weight: bold" onclick="location.href='<%= contextPath %>/product/stk'">전체보기</button>
                     </div>
                        <div class="col-md-6">
                         <button type="submit" class="btn btn-inverse-primary btn-fw" style="float: right">Search</button>
                        </div>
                      </div>
                    </form>
                  </div>
                </div>
              </div>
            
              
              
          
          <%-- Contents --%>
          
          <!-- <div class="row"> -->
              <div class="col-12 grid-margin" style="margin-top: 26px">
                <div class="card">
                  <div class="card-body">
                    <h4 class="card-title">재고 리스트</h4>
                    <div class="table-responsive">
                      <table class="table">
                        <thead>
                        <style>
                        #stock-tr{
                        	/* font-family: 고딕; */
                        	font-weight: bold;
                        }
                        </style>
                          <tr>
                            <th id="stock-tr"> 센터 </th>
                            <th id="stock-tr"> 테마 </th>
                            <th id="stock-tr"> 종류 </th>
                            <th id="stock-tr"> 상품명 </th>
                            <th id="stock-tr"> 상품코드 </th>
                            <th id="stock-tr"> 안전재고량 </th>
                            <th id="stock-tr"> 재고량 </th>
                          </tr>
                        </thead>
                        
                        <tbody>
                        <!-- db구현되면 servlet작성 후 list이용해서 for문으로 구현할것 -->
                  		 <%
                   			for(Stock s : list) {
                  		 %>
                   		<!-- 조회된 행이 있는 경우 -->
			 	         <tr>
<!-- 				selectStockList=select C_CODE, P_THEME, P_NAME, P_CODE, S_CAPA, S_AMOUNT from stock left join product using(P_CODE) order by P_THEME -->
            				<td data-toggle="tooltip">
            				<% if(s.getcCode().equals("GG")){ %>
            					<label class="badge badge-gradient-danger">경기광주</label>           					
            				<% } else { %>
            					<label class="badge badge-gradient-info">대구</label>
            				<% } %>
            				</td>
            				<td><%= s.getpTheme() %></td>
            				<td><%= s.getpCategory() %></td>
            				<td><%= s.getpName() %></td>
            				<td>
            					<a href="javascript:void(0)" class="btn_popup_open">
            						<%= s.getpCode() %>
            					</a>
            				</td>
            				<td><%= s.getsCapa() %></td>
            				<% if(s.getsCapa()>s.getsAmount()){ %> <!-- 재고량이 안전재고량보다 낮으면 빨간색, 높으면 파란색으로 표시 -->
            					<td style="color: red"><%= s.getsAmount() %></td>
            				<% } else { %>
            					<td style="color: blue"><%= s.getsAmount() %></td>
            				<% } %>
           				</tr>
                        <% }%>
                      
                        </tbody>
                      </table>
                      	<!-- 페이징처리 -->
                 		<div id='pageBar'>
                 			<%= request.getAttribute("pageBar") %>
                  		</div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <!-- </div> -->
<!-- 레이어 팝업 시작 -->
<div class="popup_panel">
<div class="popup_bg"></div>
<div class="popup_contents" style="float: left;">
	<!-- images/...jpg로 저장 -->
	<img id="p_image" src="" alt="" />
	<div class="popup_contents2">
	<!-- product : p_theme --> 
	<span id="p_theme"> </span>
	<!-- product : p_category -->
	<span id="p_category"> </span>
	<!-- product : p_name-->
	<span id="p_name"> </span>
	<hr />
	<!-- product : p_price -->
	<span id="p_price" style="float:right"> </span>
	<!-- qrcode-->
	<div id="qrDiv" style="float: right; margin-top: 40px">
	<img id="p_qr_image" src="" alt="" style="width:130px; margin-right: -60px;"/>
	</div>
   	</div>
</div>
</div>
<!-- 레이어 팝업 끝 -->
        
<style>
.popup_panel { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: 100;}
.popup_panel div.popup_bg { position: absolute; top: 0; left: 0; width: 100%; height: 100%; background:#000; opacity:.5; filter:alpha(opacity=50); }
.popup_panel div.popup_contents { position: absolute; top: 30%; left: 50%; width:600px; hight:800px; border:2px solid #b66dff; background-color:#fff; }
.popup_contents2 {display:inline; float: right; margin: 30px; margin-top: 63px; margin-right: 38px;}
input {
 background-color: white !important;
}
div#pageBar{margin-top:20px; text-align:center;}
	div#pageBar span.cPage{font-weight:bold; color: #b66dff; margin-right: 5px; font-size:15px}
	div#pageBar a{margin-right: 5px; font-size:15px}
</style>   

<script>
$(document).ready(function() {
	
	//검색눌러도 검색어 사라지지 않음
	var searchs = [
		 'search_pname'
		,'search_pcode'
		,'search_ptheme'
		,'search_pcategory'
		];
	
	var url = unescape(location.href); //현재 주소 decoding
    var paramArr = (url.substring(url.indexOf("?")+1,url.length)).split("&"); //파라미터만 자르고, 다시 &그분자를 잘라서 배열에 넣는다.
    for(var i = 0 ; i < paramArr.length ; i++){
        var temp = paramArr[i].split("="); //파라미터 변수명을 담음
        $("#"+searchs[i]).val(temp[1]);
    }
	
	// 센터명 호버했을때 한글설명나오게하기
	/* $('[data-toggle="tooltip"]').tooltip(); */
	
	/*********** 레이어팝업 함수 시작 ***********/
    var $panel = $(".popup_panel");
    var $panelContents = $panel.find(".popup_contents");
    
    //상품상세팝업 클릭했을때
    $(".btn_popup_open").on("click", function(e) {
    	//상품코드 준비
    	var pCode = $(this).text();
		var params = {pCode : pCode}; //서버로 보낼 파라미터
		console.log("request post="+"<%=contextPath%>/order/productDetail");
		$.post('<%=contextPath%>/order/productDetail', $.param(params), function(responseJson){
			//p_theme, p_category, p_name, p_price, p_qrImage

			var obj = $.parseJSON(JSON.stringify(responseJson));

			$("#p_image").attr("src", obj.pImage); //파일서블릿 경로(상품이미지 서버위치 가져옴)
			$("#p_theme").text("[" + obj.pTheme + "]");
			$("#p_category").html("[" + obj.pCategory + "]" + "<br>");
			
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

/*********** 레이어팝업 함수 끝 ***********/

});

</script>
          
          
          
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