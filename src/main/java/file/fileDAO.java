package file;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class fileDAO {

    private Connection conn;

    public fileDAO() {
        try {
            String dbURL = "jdbc:mysql://localhost:3306/dogcommunity";
            String dbID = "root";
            String dbPW = "1234";
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPW);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int upload(String fileName, String fileRealName) {
        String SQL = "INSERT INTO file (fileName, fileRealName) VALUES (?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL, PreparedStatement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, fileName);
            pstmt.setString(2, fileRealName);
            int affectedRows = pstmt.executeUpdate();
            if (affectedRows == 0) {
                throw new RuntimeException("파일 업로드에 실패했습니다.");
            }
            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new RuntimeException("파일 업로드에 실패했습니다. 생성된 키를 검색할 수 없습니다.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
    
    public List<String> getAllFileRealNames() {
        List<String> fileRealNames = new ArrayList<>();
        String SQL = "SELECT fileRealName FROM file";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                fileRealNames.add(rs.getString("fileRealName"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fileRealNames;
    }
}