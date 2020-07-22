<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="sales.model.vo.MostSoldProduct" %>
<%@ page import="sales.model.vo.RankedShop" %>
<%@ page import="sales.model.vo.RankedTransfer" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Map.Entry" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat" %>

<%	DecimalFormat formatter = new DecimalFormat("#,###,###,###");
	String contextPath = request.getContextPath();
%>
<%
	int thisYear = (int)request.getAttribute("thisYear");
%>
<%
	int thisMonth = (int)request.getAttribute("thisMonth"); 
%>
<% List<RankedShop> rshops = (List<RankedShop>)request.getAttribute("RankedShops"); 
   List<MostSoldProduct> mproducts = (List<MostSoldProduct>)request.getAttribute("MostSold");
   List<RankedTransfer> rtransfer1 = (List<RankedTransfer>)request.getAttribute("rankingTransfer1");
   List<RankedTransfer> rtransfer2 = (List<RankedTransfer>)request.getAttribute("rankingTransfer2");
   HashMap<String, Integer> scategory = (HashMap<String, Integer>)request.getAttribute("StockCategory");
   HashMap<String, Integer> stheme = (HashMap<String, Integer>)request.getAttribute("StockTheme");
   HashMap<Integer, Integer> ainbound1= (HashMap<Integer, Integer>)request.getAttribute("AnnualInbound1");
   HashMap<Integer, Integer> ainbound2= (HashMap<Integer, Integer>)request.getAttribute("AnnualInbound2");
   HashMap<Integer, Integer> aoutbound1= (HashMap<Integer, Integer>)request.getAttribute("AnnualOutbound1");
   HashMap<Integer, Integer> aoutbound2= (HashMap<Integer, Integer>)request.getAttribute("AnnualOutbound2");
   HashMap<Integer, Integer> annualreven1 = (HashMap<Integer, Integer>)request.getAttribute("AnnualRevenue1");
   HashMap<Integer, Integer> annualreven2 = (HashMap<Integer, Integer>)request.getAttribute("AnnualRevenue2");
   HashMap<Integer, Integer> monthreven1 = (HashMap<Integer, Integer>)request.getAttribute("MonthlyRevenue1");
   HashMap<Integer, Integer> monthreven2 = (HashMap<Integer, Integer>)request.getAttribute("MonthlyRevenue2");
   HashMap<String, Integer> dailyreven1 = (HashMap<String, Integer>)request.getAttribute("DailyRevenue1");
   HashMap<String, Integer> dailyreven2 = (HashMap<String, Integer>)request.getAttribute("DailyRevenue2");
   
%>

<!DOCTYPE html>
<html lang="en">
  <head>
	 <%@ include file="../common/meta.jsp" %>
	 <title>통계</title>
	 <%@ include file="../common/header.jsp" %>
	<style>
	.popup_panel { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: 100;}
	.popup_panel div.popup_bg { position: absolute; top: 0; left: 0; width: 100%; height: 100%; background:#000; opacity:.5; filter:alpha(opacity=50); }
	.popup_panel div.popup_contents { position: absolute; top: 30%; left: 50%; width:600px; hight:800px; border:2px solid #b66dff; background-color:#fff; }
	.popup_contents2 {display:inline; float: right; margin: 30px; margin-top: 63px; margin-right: 38px;}
	.stock-tr {
	/* font-family: 고딕; */
	font-weight: bold;
	}

    #bcard {
        width: 80%;
        margin: 0 auto;
        padding: 20px;
    }
		
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js"></script>
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
             	 <h3 class="page-title kor">
                	<span class="page-title-icon bg-gradient-primary text-white mr-2">
                  		<i class="mdi mdi-chart-line"></i>
                	</span> 통계 
                 </h3>
          		</div>
            <br>

            
         <div class="col-md-10 offset-md-1 grid-margin">
           <div class="card">
           	 <div class="card-body-wrapper">
           			<div class="card-body" id="bcard">
            		<h2 class="offset-md-1">
            			<button class="btn btn-gradient-primary font-weight-bold" id="btn1" onclick="updateYearly()">연간 매출 추이</button>
            			<button class="btn btn-gradient-primary font-weight-bold" id="btn2" onclick="updateMonthly()">월간 통합 매출 추이</button>
            			<button class="btn btn-gradient-primary font-weight-bold" id="btn4" onclick="updateDaily()">일간 매출 추이</button> 
            			</h2>
			 		 </div>
					 	<canvas id="rchart"></canvas>
 					   
 			  </div>
 			</div>
 		</div>
 				<br>
 				
<div class="row offset-md-1">
<!--   <div class="col-md-12 grid-margin stretch-card"> -->
<!--     <div class="card"> -->
<!--       <div class="card-body">  -->
 	  <div class="col-md-5 stretch-card grid-margin">
     	 <div class="card bg-gradient-danger card-img-holder text-white">
     		 <div class="card-body">
        		 <img src="<%=  contextPath %>/resources/bootstrap/images/dashboard/circle.svg" class="card-img-absolute" alt="circle-image" />
          	 	 <h4 class="font-weight-normal mb-3"><%=thisYear %>년 <%=thisMonth %>월 총 생산입고 수량<i class="mdi mdi-chart-line mdi-24px float-right"></i>
           	  	 </h4>
           	  	 <br>
              	 <h1 class="mb-5">
              	 <%=formatter.format((int)request.getAttribute("countInbound"))%> 개</h1>
         	 </div>
         </div>
      </div>

 	   <div class="col-md-6 grid-margin stretch-card">  
 	   		<div class="card">
       		   <div class="card-body">      
				 <canvas id="inbound" class="mt-2"></canvas>             
      		   </div>
 			</div>
	   </div>
</div>


<div class="row offset-md-1">
<!-- 		<div class="col-md-12 stretch-card grid-margin"> -->
<!-- 		<div class="card offset-md-1"> -->
<!-- 			<div class="card-body"> -->
	<div class="col-md-5 stretch-card grid-margin">
	  <div class="card bg-gradient-info card-img-holder text-white">
         <div class="card-body">
            <img src="<%=  contextPath %>/resources/bootstrap/images/dashboard/circle.svg" class="card-img-absolute" alt="circle-image" />
            <h4 class="font-weight-normal mb-3"><%=thisYear%>년 <%=thisMonth %>월 총 판매출고 수량<i class="mdi mdi-bookmark-outline mdi-24px float-right"></i>
            </h4>
            <br>
            <h1 class="mb-5"><%=formatter.format((int)request.getAttribute("countOutbound")) %> 개</h1>
         </div>
      </div>
    </div>
          

  	<div class="col-md-6 stretch-card grid-margin">
    	<div class="card">
       		<div class="card-body">    
			 <canvas id="outbound" class="mt-2"></canvas>                    	
       		</div>
 		  </div>
  		</div>
  	</div>

 <div class="row">
     <div class="col-md-6 grid-margin stretch-card">
        <div class="card">
          <div class="card-body">
            <div class="clearfix">
              <h4 class="card-title float-left">카테고리 실시간 재고 현황</h4>
<!--                       <div id="visit-sale-chart-legend" class="rounded-legend legend-horizontal legend-top-right float-right"></div> -->
            </div>
                <canvas id="c_stock1" class="mt-2"></canvas>
            </div>
         </div>
      </div>
      
   <div class="col-md-6 grid-margin stretch-card">
      <div class="card">
         <div class="card-body">
             <div class="clearfix">
                <h4 class="card-title float-left">상품 테마 실시간 재고 현황</h4>
<!--                       <div id="visit-sale-chart-legend" class="rounded-legend legend-horizontal legend-top-right float-right"></div> -->
             </div>
                <canvas id="theme_stock1" class="mt-2"></canvas>
         </div>
      </div>
 	</div>
 </div>
 
 
 <div class="row">
 	<div class="col-md-6 grid-margin stretch-card">
        <div class="card">
            <div class="card-body">
               <h4 class="card-title"><%=thisYear %>년 이송 빈도 순위</h4>
                 <h3 class="card-subtitle">경기도 광주 센터</h3>
                   <div class="table-responsive">
                      <table class="table">
                        <thead>
                        	<tr>
                            <th> # </th>
                            <th> 상품코드 </th>
                            <th> 상품명 </th>
                            <th> 이송요청 건수 </th>
                          </tr>
                        </thead>
                        <tbody>
                            <% if(rtransfer1 == null || rtransfer1.isEmpty()){ %>	
			<%--조회된 이송 상품이 없는 경우 --%>
			<tr>
				<th colspan="10"> 조회된 이송 상품이 없습니다.</th>
			</tr>
			
		<% 
			} else { 
				
				for(RankedTransfer t : rtransfer1){
		%>
			<%--조회된 상품이 있는 경우 --%>	
				<tr>
					<td><%=t.getRnum() %></td>
					<td><a href="javascript:void(0)" class="btn_popup_open" style='color:#b66dff'> <%=t.getP_code() %></a></td>
					<td><%=t.getP_name() %></td>
					<td><%=formatter.format((int)t.getT_amount()) %></td>
					
				</tr>
		<% 		
				}
		   } 
		%>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
              
	<div class="col-md-6 grid-margin stretch-card">
       <div class="card">
          <div class="card-body">
              <h4 class="card-title"><%=thisYear %>년 이송 빈도 순위</h4>
              <h3 class="card-subtitle">대구 센터</h3>
                 <div class="table-responsive">
                   <table class="table">
                       <thead>
                          <tr>
                            <th> # </th>
                            <th> 상품코드 </th>
                            <th> 상품명 </th>
                            <th> 이송요청 건수 </th>
                          </tr>
                        </thead>
                        <tbody>
                            <% if(rtransfer2 == null || rtransfer2.isEmpty()){ %>	
		
			<tr>
				<th colspan="10"> 조회된 이송 상품이 없습니다.</th>
			</tr>
			
		<% 
			} else { 
				
				for(RankedTransfer t : rtransfer2){
		%>	
				<tr>
					
					<td><%=t.getRnum() %></td>
					<td><a href="javascript:void(0)" class="btn_popup_open" style='color:#b66dff'><%=t.getP_code() %></a></td>
					<td><%=t.getP_name() %></td>
					<td><%=t.getT_amount() %></td>
				</tr>
		<% 		
				}
		   } 
		%>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
            </div>
             
<div class="row"> 
  <div class="col-md-12 grid-margin stretch-card">
    <div class="card">
       <div class="card-body"> 
 <h4 class="card-title">2020년 최다 판매 상품 TOP10</h4>          
 <canvas id="bestSellers"></canvas>             
       </div>
 	</div>
  </div>
</div>	     
           
<div class="row">
 	<div class="col-md-12 grid-margin stretch-card">
        <div class="card">
            <div class="card-body">
                <h4 class="card-title"><%=thisYear%>년 최다 발주 매장</h4>
              		<div class="table-responsive">
                      <table class="table">
                        <thead>
                          <tr>
                            <th> # </th>
                            <th> 매장코드 </th>
                            <th> 발주총액(원) </th>
                            <th> 매장명 </th>
                            <th> 매장 전화번호 </th>
                          </tr>
                        </thead>
                        <tbody>
                          <% if(rshops == null || rshops.isEmpty()){ %>	
			<%--조회된 매장이 없는 경우 --%>
			<tr>
				<th colspan="10"> 조회된 매장이 없습니다.</th>
			</tr>
			
		<% 
			} else { 
				
				for(RankedShop r : rshops){
		%>
			<%--조회된 매장이 있는 경우 --%>	
				<tr>
					
					<td><%=r.getRank() %></td>
					<td data-toggle="scode" data-placement="top" title=<%=r.getS_name()%>>
            		<label class="badge badge-gradient-info"><%=r.getS_code() %></label>

					<td><%=formatter.format((int)r.getTotalsum()) %></td>
					<td><label class="badge badge-gradient-danger"><%=r.getS_name() %></label></td>
					<td><a href="tel:<%=r.getS_tel()%>"><%=r.getS_tel()%></a></td>
            	</td>
				</tr>
		<% 		
				}
		   } 
		%>
                        </tbody>
                       </table>
                      </div>
                     </div>
                    </div>
                   </div>
                  </div>           
 	
 	
 	
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


	
    let ylabels = ["<%=thisYear-3%>", "<%=thisYear-2%>", "<%=thisYear-1%>", "<%=thisYear%>"];
    let yrevenue1 = [0,0,0,0];
    //경기도 광주 센터 연매출
    let yrevenue2 = [0,0,0,0];
    //대구 센터 연매출
    let rchart = document.getElementById('rchart').getContext('2d');
    
    <%
    Iterator<Entry<Integer, Integer>> reventries1 = annualreven1.entrySet().iterator();
  	while(reventries1.hasNext()){
  	    Map.Entry<Integer, Integer> entry = reventries1.next();
  	    
  	    for(int i=0; i<4; i++){
  	    	if(entry.getKey()==thisYear-3+i)
  	    		{%>yrevenue1[<%=i%>]=<%=entry.getValue()%>;
  	    					<%}
  	    }
  	}%>
  	
  	<%
    Iterator<Entry<Integer, Integer>> reventries2 = annualreven2.entrySet().iterator();
  	while(reventries2.hasNext()){
  	    Map.Entry<Integer, Integer> entry = reventries2.next();
  	    
  	    for(int i=0; i<4; i++){
  	    	if(entry.getKey()==thisYear-3+i)
  	    		{%>yrevenue2[<%=i%>]=<%=entry.getValue()%>;
  	    			<%}
  	    }
  	}%>
    
    let revenueChart = new Chart(rchart, {
        type: 'line',
        data: {labels: ylabels,
        	datasets:[{
        		label: "경기도 광주 센터",
//         		backgroundColor: '#fe7096',
        		borderColor: '#58c5ed',
        		data: yrevenue1,
        	},{
        		label: "대구 센터",
//         		backgroundColor: "#ffbb96",
        		borderColor: "#9a55ff",
        		data: yrevenue2,
        	}
        	]
        	
        },
        options: {
            responsive: true,
//         tooltips: {
//           callbacks: {
//                 label: function(tooltipItem, data) {
//                     var value = data.datasets[0].data[tooltipItem.index];
//                     if(parseInt(value) >= 1000){
//                                return '￦'+value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
//                             } else {
//                                return '￦'+value;
//                             }
//                 }
//           } // end callbacks:
//         }, //end tooltips                
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero:true,
                        callback: function(value, index, values) {
                            if(parseInt(value) >= 1000){
                               return '￦'+value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                            } else {
                               return '￦'+value;
                            }
                       }                            
                    }
                }]
            }
        }
        });
    
   
    
    
    function updateYearly(){
    	revenueChart.data.datasets[0].label = "경기도 광주 센터";
    	revenueChart.data.datasets[1].label = "대구 센터";
    	revenueChart.data.datasets[0].data = yrevenue1;
    	revenueChart.data.datasets[1].data = yrevenue2;    	
    	revenueChart.data.labels = ylabels;

    	
    	revenueChart.update();
    }
    
    	let mlabels=["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"];
    	let mrevenue1=[0,0,0,0,0,0,0,0,0,0,0,0];
    	let mrevenue2=[0,0,0,0,0,0,0,0,0,0,0,0];
    	
    	<%
        Iterator<Entry<Integer, Integer>> mentries1 =  monthreven1.entrySet().iterator();
      	while(mentries1.hasNext()){
      	    Map.Entry<Integer, Integer> entry = mentries1.next();
      	    
      	    for(int i=0; i<12; i++){
      	    	if(entry.getKey()==i+1)
      	    		{%>mrevenue1[<%=i%>]=<%=entry.getValue()%>;
      	    					<%}
      	    }
      	}%>
      	<%
        Iterator<Entry<Integer, Integer>> mentries2 =  monthreven2.entrySet().iterator();
      	while(mentries2.hasNext()){
      	    Map.Entry<Integer, Integer> entry = mentries2.next();
      	    
      	    for(int i=0; i<12; i++){
      	    	if(entry.getKey()==i+1)
      	    		{%>mrevenue2[<%=i%>]=<%=entry.getValue()%>;    	    			
      	    					<%}
      	    }
      	}%>
    
    function updateMonthly(){
    	revenueChart.data.datasets[0].label = "<%=thisYear%>";
    	revenueChart.data.datasets[1].label = "<%=thisYear-1%>";    	
    	revenueChart.data.labels = mlabels;
    	revenueChart.data.datasets[0].data = mrevenue1;
    	revenueChart.data.datasets[1].data = mrevenue2;
    	
    	revenueChart.update();
    }
    
    let drevenue1 = [0, 0, 0, 0, 0, 0, 0];
    let drevenue2 = [0, 0, 0, 0, 0, 0, 0];
    let dlabels = [];
    
    <%
    java.util.Calendar cal = java.util.Calendar.getInstance();
	java.text.DateFormat format1 = new java.text.SimpleDateFormat("MMdd");
	ArrayList<String> datelist = new ArrayList<String>();
	
	datelist.add(format1.format(cal.getTime()));
	
	for(int i=0; i<6; i++) {
	cal.add(cal.DATE, -1); 
	String day = format1.format(cal.getTime());
	datelist.add(day);
	}
	
	for(int i=6; i>=0; i--){
		%>dlabels.push('<%=datelist.get(i)%>'); 	
   		<%}
    
  //entrySet().iterator()
  	Iterator<Entry<String, Integer>> dreventries1 = dailyreven1.entrySet().iterator();
  	while(dreventries1.hasNext()){
  	    Map.Entry<String, Integer> entry = dreventries1.next();
  	  	String datekey = String.valueOf(entry.getKey());
  	  	String key = datekey.substring(4);
  	  	int getValue = entry.getValue();

  	   		for(int j=0; j<7; j++){
  	    		if(datelist.get(j).equals(key)){%>
  	    			drevenue1[<%=6-j%>]=(<%=getValue%>);
  	    		<%} 
  				
  	   		}
  			}%>
  	
	  	
  //entrySet().iterator()
  <%Iterator<Entry<String, Integer>> dreventries2 = dailyreven2.entrySet().iterator();
  	while(dreventries2.hasNext()){
  	    Map.Entry<String, Integer> entry = dreventries2.next();
  	  	String datekey2 = String.valueOf(entry.getKey());
  	  	String key2 = datekey2.substring(4);
  	  	int getValue2 = entry.getValue();
  	   		for(int j=0; j<7; j++){
  	    		if(datelist.get(j).equals(key2)){%>
  	    			drevenue2[<%=6-j%>]=(<%=getValue2%>);
  	    		<%} 
  	   		}
  			}
  	   %>
      	
    function updateDaily(){
    	revenueChart.data.datasets[0].label = "경기도 광주 센터";
    	revenueChart.data.datasets[1].label = "대구 센터";
    	revenueChart.data.datasets[0].data = drevenue1;
    	revenueChart.data.datasets[1].data = drevenue2;
    	revenueChart.data.labels = dlabels;
    	
    	revenueChart.update();
    }
    
    let labels1 = [];
    let data1 = [];
    
  	<%//entrySet().iterator()
  	Iterator<Entry<String, Integer>> cEntries = scategory.entrySet().iterator();
  	while(cEntries.hasNext()){
  	    Map.Entry<String, Integer> entry = cEntries.next();%>
  	   	labels1.push('<%=entry.getKey()%>');
  	   	data1.push(<%=entry.getValue()%>);
  	<%}
    %>
    
    
    let colors1 = ['#9a55ff', '#fe7096', "#68d2c6", "#58c5ed", "#fed711", "#ffbb96", "#68d2c6", "#58c5ed", "#fed711", "#ffbb96"];
    
    let labels2 = [];
    let data2 = [];
    
    <%//entrySet().iterator()
  	Iterator<Entry<String, Integer>> tEntries = stheme.entrySet().iterator();
  	while(tEntries.hasNext()){
  	    Map.Entry<String, Integer> entry = tEntries.next();%>
  	   	labels2.push('<%=entry.getKey()%>');
  	   	data2.push(<%=entry.getValue()%>);
  	<%}
    %>
    
    
    let c_stock1 = document.getElementById("c_stock1").getContext('2d');
    
    let stock1 = new Chart(c_stock1, {
        type:'doughnut',
        data:{
            labels: labels1,
            datasets: [{
                data: data1,
                backgroundColor: colors1
            }]
        },
        options: {
            title: {
                text: "센터 통합",
                display: true
            }
        }
    });
    

	let theme_stock1 = document.getElementById("theme_stock1").getContext('2d');
    
    let stock3 = new Chart(theme_stock1, {
    	type:'doughnut',
         data:{
             labels: labels2,
             datasets: [{
                 data: data2,
                 backgroundColor: colors1
             }]
         },
         options: {
             title: {
                 text: "센터 통합",
                 display: true
             }
         }
     });
    
    let ilabel1 = [];
    let ilabel2 = [];
    
    let idata1 = [0,0,0,0,0,0,0,0,0,0,0,0];
    let idata2 = [0,0,0,0,0,0,0,0,0,0,0,0];
    
    let olabel1 = [];
    let olabel2 = [];
    
    let odata1 = [0,0,0,0,0,0,0,0,0,0,0,0];
    let odata2 = [0,0,0,0,0,0,0,0,0,0,0,0];
    
    
    <%//entrySet().iterator()
  	Iterator<Entry<Integer, Integer>> inEntries1 = ainbound1.entrySet().iterator();
  	while(inEntries1.hasNext()){
  	    Map.Entry<Integer, Integer> entry = inEntries1.next();
  	    
  	    for(int i=0; i<4; i++){
  	    	if(entry.getKey()==thisYear-3+i)
  	    		{%>idata1[<%=i%>]=<%=entry.getValue()%>;
  	    			<%}
  	    }
  	}
    %>
    <%//entrySet().iterator()
  	Iterator<Entry<Integer, Integer>> inEntries2 = ainbound2.entrySet().iterator();
  	while(inEntries2.hasNext()){
  	    Map.Entry<Integer, Integer> entry = inEntries2.next();
  	    
  	    for(int i=0; i<4; i++){
  	    	if(entry.getKey()==thisYear-3+i)
  	    		{%>idata2[<%=i%>]=<%=entry.getValue()%>;
  	    			<%}
  	    }
  	}
    %>
  	
	let inbound = document.getElementById("inbound").getContext('2d');
    
    let inboundChart = new Chart(inbound, {
    	type:'bar',
    	data: {labels: ylabels,
        	datasets:[{
        		label: "경기도 광주 센터",
        		backgroundColor: '#fe7096',
        		borderColor: '#58c5ed',
        		data: idata1,
        	},{
        		label: "대구 센터",
        		backgroundColor: "#ffbb96",
        		borderColor: "#9a55ff",
        		data: idata2,
        	}
        	]
        	
        },
         options: {
             title: {
                 text: "생산 입고량 추이",
                 display: true
             }
         }
     });
    
    <%//entrySet().iterator()
  	Iterator<Entry<Integer, Integer>> outEntries1 = aoutbound1.entrySet().iterator();
  	while(outEntries1.hasNext()){
  	    Map.Entry<Integer, Integer> entry = outEntries1.next();
  	    
  	    for(int i=0; i<4; i++){
  	    	if(entry.getKey()==thisYear-3+i)
  	    		{%>odata1[<%=i%>]=<%=entry.getValue()%>;
  	    			<%}
  	    }
  	}
    %>
    <%//entrySet().iterator()
  	Iterator<Entry<Integer, Integer>> outEntries2 = aoutbound2.entrySet().iterator();
  	while(outEntries2.hasNext()){
  	    Map.Entry<Integer, Integer> entry = outEntries2.next();
  	    
  	    for(int i=0; i<4; i++){
  	    	if(entry.getKey()==thisYear-3+i)
  	    		{%>odata2[<%=i%>]=<%=entry.getValue()%>;
  	    			<%}
  	    }
  	}
    %>
    
    
	let outbound = document.getElementById("outbound").getContext('2d');
    
    let outboundChart = new Chart(outbound, {
    	type:'bar',
    	data: {labels: ylabels,
        	datasets:[{
        		label: "경기도 광주 센터",
        		backgroundColor: '#fe7096',
        		borderColor: '#58c5ed',
        		data: odata1,
        	},{
        		label: "대구 센터",
        		backgroundColor: "#ffbb96",
        		borderColor: "#9a55ff",
        		data: odata2,
        	}
        	]
        	
        },
         options: {
             title: {
                 text: "판매 출고량 추이",
                 display: true
             }
         }
     });
    
  
	let bestSellers = document.getElementById("bestSellers").getContext('2d');
    let bestLabels = [];
	let bestData = [];
	
	<%
	for(MostSoldProduct m : mproducts){%>
		
		bestLabels.push('<%=m.getP_name()%>');
		bestData.push(<%=m.getQuantity()%>);
	<%}%>
	
    
    let polarAreaChart = new Chart(bestSellers, {
    	type:'polarArea',
         data:{
             labels: bestLabels,
             datasets: [{
                 data: bestData,
                 backgroundColor: colors1
             }]
         },
         options: {
             title: {
                 text: "센터 통합",
                 display: true
             }
         }
     });  
    
    </script>

     
          
          <%-- Contents --%>
                   
          
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