<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- fullcalendar css -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>

<!-- fullcalendar 언어 설정관련 script -->
<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>

<title>멍어스</title>

<style>
#calendar {
	width: 70%; /* 원하는 크기로 변경하세요. */
	margin: 0 auto; /* 페이지 중앙에 위치하도록 설정. 필요 없으면 제거하세요. */
}
</style>
</head>


<body>
	<div id="root">
		<%@ include file="fix.jsp"%>
		<section id="container">
			<div id="container_box">
			<h6>📢 강아지의 일정을 추가해보세요.
			<br>
			<br>* 원하는 날짜 클릭 후 일정 추가 기능
			<br>* 추가된 일정 클릭 시 수정, 삭제 가능</h6>
			<br>
			</div>

			<div id='calendar'></div>
			
<!-- Modal -->
<div class="modal fade" id="calendarModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">일정을 입력하세요.</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label for="taskId" class="col-form-label">일정 내용</label> 
					<input type="text" class="form-control" id="calendar_content" name="calendar_content"> 
					<label for="taskId" class="col-form-label">시작 날짜</label> 
					<input type="date" class="form-control" id="calendar_start_date" name="calendar_start_date"> 
					<label for="taskId" class="col-form-label">종료 날짜</label> 
					<input type="date" class="form-control" id="calendar_end_date" name="calendar_end_date">
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-warning" id="addCalendar">추가</button>
				<button type="button" class="btn btn-primary" id="updateCalendar">수정</button>
				<button type="button" class="btn btn-danger" id="deleteCalendar">삭제</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal" id="sprintSettingModalClose">취소</button>
			</div>
		</div>
	</div>
</div>
<script>
document.addEventListener('DOMContentLoaded', function() {
	  var calendarEl = document.getElementById('calendar');
	  var calendar = new FullCalendar.Calendar(calendarEl, {
	    initialView: 'dayGridMonth',
	    headerToolbar: {
	      start: 'prev next today',
	      center: 'title',
	      end: 'dayGridMonth,dayGridWeek,dayGridDay'
	    },
	    titleFormat: function(date) {
	      return date.date.year + '년 ' + (parseInt(date.date.month) + 1) + '월';
	    },
	    selectable: true,
	    droppable: true,
	    editable: true,
	    nowIndicator: true,
	    locale: 'ko',
	    select: function(info) {
	      $('#calendar_start_date').val(info.startStr.substring(0, 10));
	      var endDate = new Date(info.endStr);
	      endDate.setUTCDate(endDate.getUTCDate() - 1);
	      $('#calendar_end_date').val(endDate.toISOString().substring(0, 10));
	      $('#calendarModal').modal('show');
	      
	      $('#addCalendar').unbind().click(function() {
	        var title = $('#calendar_content').val();
	        if (title) {
	          $.ajax({
	            url: '/CalendarController/addEvent',
	            method: 'POST',
	            data: JSON.stringify({
	              userID: sessionStorage.getItem('userID'),
	              cldTitle: title,
	              cldStart: $('#calendar_start_date').val(),
	              cldEnd: $('#calendar_end_date').val()
	            }),
	            contentType: 'application/json',
	            success: function(response) {
	              calendar.addEvent({
	                title: title,
	                start: $('#calendar_start_date').val(),
	                end: $('#calendar_end_date').val()
	              });
	              $('#calendarModal').modal('hide');
	            },
	            error: function(xhr, status, error) {
	              alert('일정 추가에 실패하였습니다. 다시 시도해주세요.');
	            }
	          });
	        }
	        $('#updateCalendar').unbind();
	        $('#deleteCalendar').unbind();
	      });
	    },
	    eventClick: function(info) {
	      var eventObj = info.event;

	      $('#calendar_content').val(eventObj.title);
	      $('#calendar_start_date').val(eventObj.startStr.substring(0, 10));
	      $('#calendar_end_date').val(eventObj.endStr ? eventObj.endStr.substring(0, 10) : eventObj.startStr.substring(0, 10));
	      $('#calendarModal').modal('show');
	      
	      $('#updateCalendar').unbind().click(function() {
	        var title = $('#calendar_content').val();
	        if (title) {
	          $.ajax({
	            url: '/updateEvent/' + eventObj.id,
	            method: 'PUT',
	            data: JSON.stringify({
	              cldTitle: title,
	              cldStart: $('#calendar_start_date').val(),
	              cldEnd: $('#calendar_end_date').val()
	            }),
	            contentType: 'application/json',
	            success: function(response) {
	              eventObj.setProp('title', title);
	              eventObj.setStart($('#calendar_start_date').val());
	              eventObj.setEnd($('#calendar_end_date').val());
	              $('#calendarModal').modal('hide');
	            },
	            error: function(xhr, status, error) {
	              alert('일정 수정에 실패하였습니다. 다시 시도해주세요.');
	            }
	          });
	        }
	        $('#addCalendar').unbind();
	      });
	      
	      $('#deleteCalendar').unbind().click(function() {
	        if (confirm('일정을 삭제하시겠습니까?')) {
	          $.ajax({
	            url: '/deleteEvent/' + eventObj.id,
	            method: 'DELETE',
	            success: function(response) {
	              eventObj.remove();
	              $('#calendarModal').modal('hide');
	            },
	            error: function(xhr, status, error) {
	              alert('일정 삭제에 실패하였습니다. 다시 시도해주세요.');
	            }
	          });
	        }
	        $('#addCalendar').unbind();
	      });
	    }
	  });

	  calendar.render();
	});

</script>

		</section>

		<footer id="footer">
			<div id="footer_box">
				<%@ include file="footer.jsp"%>
			</div>
		</footer>
	</div>
</body>
</html>