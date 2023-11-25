<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="calendar.CalendarDAO"%>
<%@ page import="calendar.Calendar" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.text.SimpleDateFormat" %>



<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name='viewport' content='width=device-width, initial-scale=1'>
 
    <!-- jQuery 추가 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!-- FullCalendar CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">
    <!-- FullCalendar JS -->
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
    <!-- Moment.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
    <!-- FullCalendar 언어 설정 관련 script -->
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

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
        <%@ include file="fix.jsp" %>
        <section id="container">
            <div id="container_box">
                <h3>멍캘린더</h3>
                    📢 날짜 선택 후 일정을 추가해보세요! 
                <br><br>
            </div>

            <!-- 캘린더 -->
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
                                <label for="calendar_content" class="col-form-label">일정 내용</label>
                                <input type="text" class="form-control" id="calendar_content" name="calendar_content">
                                <label for="calendar_start_date" class="col-form-label">시작 날짜</label>
                                <input type="date" class="form-control" id="calendar_start_date" name="calendar_start_date">
                                <label for="calendar_end_date" class="col-form-label">종료 날짜</label>
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

    document.addEventListener('DOMContentLoaded', function () {
        var userID = "<%= request.getSession().getAttribute("userID") %>";
        var selectedEvent = null;
        var calendarEl = document.getElementById('calendar');
        
        // 추가된 부분: 현재 로그인한 사용자의 ID를 서버로 전송하여 해당 사용자의 일정만 받아옴
       	

        
        var calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            headerToolbar: {
                start: 'prev next today',
                center: 'title',
                end: 'dayGridMonth,dayGridWeek,dayGridDay'
            },
            titleFormat: function (date) {
                return date.date.year + '년 ' + (parseInt(date.date.month) + 1) + '월';
            },
            selectable: true,
            droppable: true,
            editable: true,
            nowIndicator: true,
            locale: 'ko',
            events: [], // 초기에 서버에서 받아올 데이터 없음
            select: function (info) {
                $('#calendar_start_date').val(info.startStr.substring(0, 10));
                var endDate = new Date(info.endStr);
                endDate.setDate(endDate.getDate() - 1);
                $('#calendar_end_date').val(endDate.toISOString().substring(0, 10));
                $('#calendarModal').modal('show');

                // 추가 버튼 클릭 이벤트
                $('#addCalendar').unbind().click(function () {
                    var title = $('#calendar_content').val();
                    if (title) {
                        var data = {
                            userID: userID,
                            cldTitle: title,
                            cldStart: $('#calendar_start_date').val(),
                            cldEnd: $('#calendar_end_date').val()
                        };

                        $.ajax({
                            url: 'CalendarServlet?action=add',
                            method: 'POST',
                            data: data,
                            success: function (response) {
                                console.log(response);
                                calendar.addEvent({
                                    id: String(response.cldID),
                                    title: title,
                                    start: $('#calendar_start_date').val(),
                                    end: $('#calendar_end_date').val()
                                });
                                $('#calendarModal').modal('hide');
                            },
                            error: function (xhr, status, error) {
                                console.error(error);
                                Swal.fire({
                                    icon: 'error',
                                    title: '일정 추가 실패',
                                    text: '일정 추가에 실패하였습니다. 다시 시도해주세요.'
                                });
                            }
                        });
                    }
                });
            },
            eventClick: function (info) {
                selectedEvent = info.event;
                $('#calendar_content').val(selectedEvent.title);
                $('#calendar_start_date').val(selectedEvent.startStr);
                $('#calendar_end_date').val(selectedEvent.endStr);
                $('#calendarModal').modal('show');

                // 수정 버튼 클릭 이벤트
                $('#updateCalendar').unbind().click(function () {
                    var title = $('#calendar_content').val();
                    if (title) {
                        var data = {
                            cldID: selectedEvent.id,
                            userID: userID,
                            cldTitle: title,
                            cldStart: $('#calendar_start_date').val(),
                            cldEnd: $('#calendar_end_date').val()
                        };

                        $.ajax({
                            url: 'CalendarServlet?action=update',
                            method: 'POST',
                            data: data,
                            success: function (response) {
                                if (response.status === 'success') {
                                    selectedEvent.setProp('title', title);
                                    selectedEvent.setStart($('#calendar_start_date').val());
                                    selectedEvent.setEnd($('#calendar_end_date').val());
                                    $('#calendarModal').modal('hide');
                                    console.log("Event updated successfully.");
                                } else {
                                    console.error("Failed to update event: Server responded with status " + response.status);
                                    Swal.fire({
                                        icon: 'error',
                                        title: '일정 수정 실패',
                                        text: '일정 수정에 실패하였습니다. 다시 시도해주세요.'
                                    });
                                }
                            },
                            error: function (xhr, status, error) {
                                console.error("Failed to update event: " + error);
                                Swal.fire({
                                    icon: 'error',
                                    title: '일정 수정 실패',
                                    text: '일정 수정에 실패하였습니다. 다시 시도해주세요.'
                                });
                            }
                        });
                    }
                });

                // 삭제 버튼 클릭 이벤트
                $('#deleteCalendar').unbind().click(function () {
                    var data = {
                        action: "delete",
                        cldID: selectedEvent.id
                    };

                    $.ajax({
                        url: 'CalendarServlet',
                        method: 'POST',
                        data: data,
                        success: function (response) {
                            if (response.status === 'success') {
                                selectedEvent.remove(); // 캘린더에서 이벤트 삭제
                                $('#calendarModal').modal('hide');
                                console.log("Event deleted successfully.");
                            } else {
                                console.error("Failed to delete event: Server responded with status " + response.status);
                                Swal.fire({
                                    icon: 'error',
                                    title: '일정 삭제 실패',
                                    text: '일정 삭제에 실패하였습니다. 다시 시도해주세요.'
                                });
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error("Failed to delete event: " + error);
                            Swal.fire({
                                icon: 'error',
                                title: '일정 삭제 실패',
                                text: '일정 삭제에 실패하였습니다. 다시 시도해주세요.'
                            });
                        }
                    });
                });
            }
        });

        // 캘린더 초기화
        calendar.render();
        
        // 서버에서 사용자별로 저장된 일정을 가져오는 AJAX 코드
        $.ajax({
            url: 'CalendarServlet?action=get', // 서버에서 일정을 가져오는 URL.
            method: 'GET',
            success: function (response) {
                // 서버에서 일정 데이터를 가져온 후에 캘린더의 일정 목록을 갱신합니다.
                for (var i = 0; i < response.cldList.length; i++) {
                    var event = response.cldList[i];
                    calendar.addEvent({
                        id: event.cldID,
                        title: event.cldTitle,
                        start: event.cldStart,
                        end: event.cldEnd
                    });
                }
            },
            error: function (xhr, status, error) {
                console.error(error);
                Swal.fire({
                    icon: 'error',
                    title: '일정 로드 실패',
                    text: '서버에서 일정을 가져오는데 실패하였습니다. 다시 시도해주세요.'
                });
            }
        });
    });
</script>
        </section>

        <footer id="footer">
            <div id="footer_box">
                <%@ include file="footer.jsp" %>
            </div>
        </footer>
    </div>
</body>
</html>