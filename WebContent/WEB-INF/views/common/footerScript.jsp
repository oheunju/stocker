<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- plugins:js -->
<script src="<%=  request.getContextPath() %>/resources/bootstrap/vendors/js/vendor.bundle.base.js"></script>
<!-- endinject -->
<!-- Plugin js for this page -->
<script src="<%=  request.getContextPath() %>/resources/bootstrap/vendors/chart.js/Chart.min.js"></script>
<!-- End plugin js for this page -->
<!-- inject:js -->
<script src="<%=  request.getContextPath() %>/resources/bootstrap/js/off-canvas.js"></script>
<script src="<%=  request.getContextPath() %>/resources/bootstrap/js/hoverable-collapse.js"></script>
<script src="<%=  request.getContextPath() %>/resources/bootstrap/js/misc.js"></script>
<!-- endinject -->
<!-- Custom js for this page -->
<script src="<%=  request.getContextPath() %>/resources/bootstrap/js/dashboard.js"></script>
<script src="<%=  request.getContextPath() %>/resources/bootstrap/js/todolist.js"></script>
  <script>
  var topEle = $('#topBtn');
  var delay = 1000;
  
  topEle.on('click', function() {
    $('html, body').stop().animate({scrollTop: 0}, delay);
  });
  </script>
<!-- End custom js for this page -->