package calendar;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

@WebServlet("/CalendarServlet")
public class CalendarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 요청 파라미터에서 데이터 추출
        String action = request.getParameter("action");

        // 사용자 세션에서 userID 가져오기 (로그인 상태를 가정합니다)
        String userID = (String) request.getSession().getAttribute("userID");

        // CalendarDAO 인스턴스 생성
        CalendarDAO calendarDAO = new CalendarDAO();

        // 응답 데이터 형식 설정
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            if ("get".equals(action)) {
                // 일정 가져오기
                ArrayList<Calendar> calendars = calendarDAO.getEventsByUser(userID);

                // JSON 응답 생성
                JsonObject jsonResponse = new JsonObject();
                jsonResponse.addProperty("status", "success");
                jsonResponse.add("cldList", getJsonArrayFromEvents(calendars));
                out.print(jsonResponse);
            }
        } catch (IOException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

            // JSON 응답 생성
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("status", "error");
            response.getWriter().print(jsonResponse);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 요청 파라미터에서 데이터 추출
        String action = request.getParameter("action");

        // 사용자 세션에서 userID 가져오기 (로그인 상태를 가정합니다)
        String userID = (String) request.getSession().getAttribute("userID");

        // CalendarDAO 인스턴스 생성
        CalendarDAO calendarDAO = new CalendarDAO();

        // 응답 데이터 형식 설정
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            // action에 따라 다른 동작 수행
            if ("add".equals(action)) {
                // 일정 추가
                String title = request.getParameter("cldTitle");
                String start = request.getParameter("cldStart");
                String end = request.getParameter("cldEnd");

                // Calendar 객체 생성
                Calendar calendar = new Calendar();
                calendar.setUserID(userID);
                calendar.setCldTitle(title);
                calendar.setCldStart(start);
                calendar.setCldEnd(end);

                // 일정 추가
                int generatedId = calendarDAO.addEvent(calendar);

                // JSON 응답 생성
                JsonObject jsonResponse = new JsonObject();
                jsonResponse.addProperty("status", "success");
                jsonResponse.addProperty("cldID", generatedId);
                out.print(jsonResponse);
            } else if ("update".equals(action)) {
                // 일정 수정
                int cldID = Integer.parseInt(request.getParameter("cldID"));
                String title = request.getParameter("cldTitle");
                String start = request.getParameter("cldStart");
                String end = request.getParameter("cldEnd");

                // Calendar 객체 생성
                Calendar calendar = new Calendar();
                calendar.setCldID(cldID);
                calendar.setUserID(userID);
                calendar.setCldTitle(title);
                calendar.setCldStart(start);
                calendar.setCldEnd(end);

                // 일정 수정
                calendarDAO.updateEvent(calendar);

                // JSON 응답 생성
                JsonObject jsonResponse = new JsonObject();
                jsonResponse.addProperty("status", "success");
                out.print(jsonResponse);
            } else if ("delete".equals(action)) {
                // 일정 삭제
                int cldID = Integer.parseInt(request.getParameter("cldID"));

                // 일정 삭제
                calendarDAO.deleteEvent(cldID);

                // JSON 응답 생성
                JsonObject jsonResponse = new JsonObject();
                jsonResponse.addProperty("status", "success");
                out.print(jsonResponse);
            }
        } catch (IOException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

            // JSON 응답 생성
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("status", "error");
            response.getWriter().print(jsonResponse);
        }
    }
    
    private JsonArray getJsonArrayFromEvents(ArrayList<Calendar> events) {
        JsonArray jsonArray = new JsonArray();
        for (Calendar event : events) {
            JsonObject jsonEvent = new JsonObject();
            jsonEvent.addProperty("cldID", event.getCldID());
            jsonEvent.addProperty("userID", event.getUserID());
            jsonEvent.addProperty("cldTitle", event.getCldTitle());
            jsonEvent.addProperty("cldStart", event.getCldStart());
            jsonEvent.addProperty("cldEnd", event.getCldEnd());
            jsonArray.add(jsonEvent);
        }
        return jsonArray;
    }

}
