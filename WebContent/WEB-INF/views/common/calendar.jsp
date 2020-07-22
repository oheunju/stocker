<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="board.model.service.BoardService"%>
<%@page import="board.model.vo.Calendar"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<Calendar> calList = new BoardService().selectCalendar();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<link href='<%=request.getContextPath()%>/resources/calendar/core/main.css' rel='stylesheet' />
<link href='<%=request.getContextPath()%>/resources/calendar/daygrid/main.css' rel='stylesheet' />
<script src='<%=request.getContextPath()%>/resources/calendar/core/main.js'></script>
<script src='<%=request.getContextPath()%>/resources/calendar/interaction/main.js'></script>
<script src='<%=request.getContextPath()%>/resources/calendar/daygrid/main.js'></script>
<script>

document.addEventListener('DOMContentLoaded', function() {
    let calendarEl = document.getElementById('calendar');
    
    let date = new Date();
    let year = date.getFullYear(); 
    let month = new String(date.getMonth()+1); 
    let day = new String(date.getDate()); 
    
    
    // 한자리수일 경우 0을 채워준다. 
    if(month.length == 1){ 
      month = "0" + month; 
    } 
    if(day.length == 1){ 
      day = "0" + day; 
    } 
    
    let today = year + "-" + month + "-" + day;

    let calendar = new FullCalendar.Calendar(calendarEl, {
      plugins: [ 'interaction', 'dayGrid' ],
      header: {
        left: 'prev,next,today',
        center: 'title',
        right: 'dayGridMonth,dayGridWeek,dayGridDay'
      },
      defaultDate: today,
      navLinks: true, // can click day/week names to navigate views
      editable: true,
      eventLimit: true, // allow "more" link when too many events
      events: [
    	<% 
    	  	for(int i = 0; i < calList.size(); i++)
    	  	{
    	%>
		        {
		          title: "<%= calList.get(i).getTitle() %>",
		          start: '<%= calList.get(i).getStart() %>',
		          end: '<%= calList.get(i).getEnd() %>',
		          allDay: true,
		          color: '<%= calList.get(i).getColor() %>',
		          textColor: '#ffffff'
		        },
		<%
    	  	}
    	%>
      ]
    });

    calendar.render();
  });
  
  
</script>
<style>

  body {
    margin: 40px 10px;
    padding: 0;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
  }

  #calendar {
    max-width: 900px;
    margin: 0 auto;
  }

</style>