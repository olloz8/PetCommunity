package calendar;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@WebServlet("/CalendarController")
public class CalendarController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    private CalendarDAO calendarDAO;
    private Gson gson = new Gson();

    public void init() {
        calendarDAO = new CalendarDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Calendar calendar = gson.fromJson(request.getReader(), Calendar.class);
        int id = calendarDAO.addEvent(calendar);
        calendar.setCldID(id);
        response.setStatus(HttpServletResponse.SC_CREATED);
        response.getWriter().println(gson.toJson(calendar));
    }

    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Calendar calendar = gson.fromJson(request.getReader(), Calendar.class);
        calendarDAO.updateEvent(calendar);
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().println("Event updated successfully");
    }

    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int cldID = Integer.parseInt(request.getParameter("id"));
        calendarDAO.deleteEvent(cldID);
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().println("Event deleted successfully");
    }

}
