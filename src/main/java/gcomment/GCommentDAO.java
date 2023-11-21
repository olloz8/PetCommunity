package gcomment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class GCommentDAO {
    private Connection conn;
    private ResultSet rs;

    public GCommentDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/dogcommunity";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//날짜값 가져오기
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ""; //DB 오류 
	}
	
	
	public int getNext() {
	    String SQL = "SELECT cmtID FROM GCOMMENT ORDER BY cmtID DESC";
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            return rs.getInt(1) + 1;
	        }
	        return 1; // 첫 번째 댓글인 경우
	    } catch (Exception e) {
	        e.printStackTrace(); // 예외 발생 시 로그 출력
	    }
	    return -1; // DB 오류
	}
	
	
	
    // 댓글 작성
	public int write(int galleryID, String userID, String cmtContent) {
	    String SQL = "INSERT INTO GCOMMENT (cmtID, userID, cmtDate, cmtContent, galleryID, cmtAvailable) VALUES (?, ?, ?, ?, ?, ?)";
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setInt(1, getNext());
	        pstmt.setString(2, userID);
	        pstmt.setString(3, getDate());
	        pstmt.setString(4, cmtContent);
	        pstmt.setInt(5, galleryID);  // getGalleryID를 galleryID로 변경
	        pstmt.setInt(6, 1);  // cmtAvailable 필드에 대해 1을 설정
	        return pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -1; // DB 오류
	}


	public ArrayList<GComment> getCommentList(int galleryID) {
	    String SQL = "SELECT * FROM GCOMMENT WHERE galleryID = ? AND cmtAvailable = 1";
	    ArrayList<GComment> list = new ArrayList<GComment>();
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setInt(1, galleryID);
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            GComment comment = new GComment();
	            comment.setCmtID(rs.getInt(1));
	            comment.setUserID(rs.getString(2));
	            comment.setCmtDate(rs.getString(3));
	            comment.setCmtContent(rs.getString(4));
	            comment.setGalleryID(rs.getInt(5));
	            comment.setCmtAvailable(rs.getInt(6));
	            list.add(comment);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

 // 댓글 가져오기
    public GComment getComment(int cmtID) {
        String SQL = "SELECT * FROM GCOMMENT WHERE cmtID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, cmtID);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                GComment comment = new GComment();
                comment.setCmtID(rs.getInt(1));
                comment.setUserID(rs.getString(2));
                comment.setCmtDate(rs.getString(3));
                comment.setCmtContent(rs.getString(4));
                comment.setGalleryID(rs.getInt(5));
                comment.setCmtAvailable(rs.getInt(6));
                return comment;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    
    // 댓글 수정
    public int update(int cmtID, String cmtContent) {
        String SQL = "UPDATE GCOMMENT SET cmtContent = ? WHERE cmtID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, cmtContent);
            pstmt.setInt(2, cmtID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // DB 오류
    }

    // 댓글 삭제
    public int delete(int cmtID) {
        String SQL = "UPDATE GCOMMENT SET cmtAvailable = 0 WHERE cmtID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, cmtID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // DB 오류
    }
}
