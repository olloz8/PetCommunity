<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name='viewport' content='width=device-width, initial-scale=1'>

<!-- jquery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- bootstrap 4 -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<!-- fullcalendar -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/fullcalendar@5.7.0/main.min.css">
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/fullcalendar@5.7.0/main.min.js"></script>


<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function () {
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
        timeZone: 'UTC',
        initialView: 'dayGridMonth',
        events:[
            {
                title:'일정',
                start:'2021-05-26 00:00:00',
                end:'2021-05-27 24:00:00'
            }
        ], 
        headerToolbar: {
            center: 'addEventButton' 
        }, 
        customButtons: {
            addEventButton: { 
                text : "일정 추가", 
                click : function(){ 
                    var title = prompt("일정 내용을 입력하세요:");
                    var start = prompt("시작 날짜를 입력하세요 (YYYY-MM-DD):");
                    var end = prompt("종료 날짜를 입력하세요 (YYYY-MM-DD):");

                    if (title && start && end) {
                        var eventData = {
                            title: title,
                            start: start,
                            end: end
                        };
                        calendar.addEvent(eventData);
                    } else {
                        alert("모든 필드를 올바르게 입력해주세요.");
                    }
                }
            }
        },
        eventClick: function(info) {
            if (confirm("이 일정을 삭제하시겠습니까?")) {
                info.event.remove();
            }
        },
        editable: true, 
        selectable: true,
        displayEventTime: false 
    });
    calendar.render();
});
    </script>
<style>
#calendarBox {
	width: 70%;
	padding-left: 15%;
}
</style>
</head>

<body>
	<div id="calendarBox">
		<div id="calendar"></div>
	</div>

	<!-- modal 추가 -->
	<div class="modal fade" id="calendarModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">일정을 입력하세요.</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="taskId" class="col-form-label">일정 내용</label> <input
							type="text" class="form-control" id="calendar_content"
							name="calendar_content"> <label for="taskId"
							class="col-form-label">시작 날짜</label> <input type="date"
							class="form-control" id="calendar_start_date"
							name="calendar_start_date"> <label for="taskId"
							class="col-form-label">종료 날짜</label> <input type="date"
							class="form-control" id="calendar_end_date"
							name="calendar_end_date">
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-warning" id="addCalendar">추가</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal" id="sprintSettingModalClose">취소</button>
				</div>

			</div>
		</div>
	</div>
</body>
</html>