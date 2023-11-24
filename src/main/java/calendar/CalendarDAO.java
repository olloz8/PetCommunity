package calendar;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;

public class CalendarDAO {
    private final String url = "jdbc:mysql://localhost:3306/dogcommunity";
    private final String user = "root";
    private final String password = "1234";

    
    
    
    public int addEvent(Calendar calendar) {
        if (calendar == null) {
            throw new IllegalArgumentException("calendar cannot be null");
        }

        int generatedId = -1;

        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement pstmt = conn.prepareStatement(
                     "INSERT INTO calendar (userID, cldTitle, cldStart, cldEnd) VALUES (?, ?, ?, ?)",
                     Statement.RETURN_GENERATED_KEYS
             )) {
            pstmt.setString(1, calendar.getUserID());
            pstmt.setString(2, calendar.getCldTitle());
            pstmt.setDate(3, Date.valueOf(calendar.getCldStart()));
            pstmt.setDate(4, Date.valueOf(calendar.getCldEnd()));
            pstmt.execute();

            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    generatedId = generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return generatedId;
    }

    public void updateEvent(Calendar calendar) {
        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement pstmt = conn.prepareStatement(
                     "UPDATE calendar SET cldTitle = ?, cldStart = ?, cldEnd = ? WHERE cldID = ? AND userID = ?"
             )) {
            pstmt.setString(1, calendar.getCldTitle());            
            pstmt.setDate(2, Date.valueOf(calendar.getCldStart()));
            pstmt.setDate(3, Date.valueOf(calendar.getCldEnd()));
            pstmt.setInt(4, calendar.getCldID());
            pstmt.setString(5, calendar.getUserID());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteEvent(int cldID) {
        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement pstmt = conn.prepareStatement(
                     "DELETE FROM calendar WHERE cldID = ?"
             )) {
            pstmt.setInt(1, cldID);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<Calendar> getEventsByUser(String userID) {
        ArrayList<Calendar> calendars = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement pstmt = conn.prepareStatement(
                     "SELECT * FROM calendar WHERE userID = ?"
             )) {
            pstmt.setString(1, userID);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Calendar calendar = new Calendar();
                    calendar.setCldID(rs.getInt("cldID"));
                    calendar.setUserID(rs.getString("userID"));
                    calendar.setCldTitle(rs.getString("cldTitle"));
                    calendar.setCldStart(rs.getString("cldStart"));
                    calendar.setCldEnd(rs.getString("cldEnd"));
                    calendars.add(calendar);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return calendars;
    }
}