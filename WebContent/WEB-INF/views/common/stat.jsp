<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
  <%java.util.Calendar cal = java.util.Calendar.getInstance();
	java.text.DateFormat format1 = new java.text.SimpleDateFormat("yyyy년 MM월 dd일");
	String today = format1.format(cal.getTime());
	%>
			     
 <div class="row">
              <div class="col-md-4 stretch-card grid-margin">
                <div class="card bg-gradient-danger card-img-holder text-white">
                  <div class="card-body">
                    <img src="<%=request.getContextPath()%>/resources/bootstrap/images/dashboard/circle.svg" class="card-img-absolute" alt="circle-image" />
                    <h4 class="font-weight-normal mb-3" id="stat1"><i class="mdi mdi-chart-line mdi-24px float-right"></i>
                    </h4>
                    <h2 class="mb-5" id="stat2"></h2>
                    
                  </div>
                </div>
              </div>
              <div class="col-md-4 stretch-card grid-margin">
                <div class="card bg-gradient-info card-img-holder text-white">
                  <div class="card-body">
                    <img src="<%=request.getContextPath()%>/resources/bootstrap/images/dashboard/circle.svg" class="card-img-absolute" alt="circle-image" />
                    
                    <h4 class="font-weight-normal mb-3" id="stat3"><i class="mdi mdi-bookmark-outline mdi-24px float-right"></i>
                    </h4>
                    <h2 class="mb-5" id="stat4"></h2>
                  </div>
                </div>
              </div>
              <div class="col-md-4 stretch-card grid-margin">
                <div class="card bg-gradient-success card-img-holder text-white">
                  <div class="card-body">
                    <img src="<%=request.getContextPath()%>/resources/bootstrap/images/dashboard/circle.svg" class="card-img-absolute" alt="circle-image" />
                   
                    <h4 class="font-weight-normal mb-3"><%=today %> 총매출<i class="mdi mdi-diamond mdi-24px float-right"></i>
                    </h4>
                    <h2 class="mb-5" id="stat5"></h2>
                    
                  
                  </div>
                </div>
              </div>
            </div>
            
<script>
$(function () {
	$.ajax({
		url:"<%= request.getContextPath() %>/stat",
		type:"get",
		data:"stat",
		success:function(mstat){
			console.log("통계 ajax 통신성공!");
			 $('#stat1').append(mstat.thisYear+"년 "+mstat.thisMonth+"월 총 생산입고 수량");
			 $('#stat3').append(mstat.thisYear+"년 "+mstat.thisMonth+"월 총 판매출고 수량");
			 $('#stat2').append(((mstat.mInbound).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","))+"개");//갯수 콤마찍기 
			 $('#stat4').append(((mstat.mOutbound).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","))+"개");//갯수 콤마찍기 
			 $('#stat5').append(((mstat.drevenue).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","))+"원");//가격 콤마찍기 
			
			 
			
		},error:function(){
			console.log("통계 ajax 통신실패!");
		}
	});
})
</script>

