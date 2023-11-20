package gallery;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class GalleryDAO {
	private Connection conn;
	private ResultSet rs; 
	
	public GalleryDAO() {
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
	
	//다음 페이지 가져오기
	public int getNext() {
		String SQL = "SELECT galleryID FROM GALLERY ORDER BY galleryID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //DB 오류 
	}
	
	//조회수
	public int increaseHit(int galleryID) {
	    String SQL = "UPDATE GALLERY SET hit = hit + 1 WHERE galleryID = ?";
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setInt(1, galleryID);
	        return pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -1; // DB 오류
	}

	// 글 작성
	// DAO의 write 메서드 수정
	public int write(String galleryTitle, String userID, String galleryContent, String fileName, String fileRealName) {
	    String SQL = "INSERT INTO GALLERY (galleryID, galleryTitle, userID, galleryDate, galleryContent, hit, galleryAvailable, fileName, fileRealName) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setInt(1, getNext());
	        pstmt.setString(2, galleryTitle);
	        pstmt.setString(3, userID);
	        pstmt.setString(4, getDate());
	        pstmt.setString(5, galleryContent);
	        pstmt.setInt(6, 1);
	        pstmt.setInt(7, 1); // Assuming galleryAvailable is initially set to 1
	        pstmt.setString(8, fileName);
	        pstmt.setString(9, fileRealName);
	        return pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -1; // DB 오류
	}
	
    //게시글 리스트
    public ArrayList<Gallery> getList(int pageNumber) {
        String SQL = "SELECT * FROM GALLERY WHERE galleryID < ? AND galleryAvailable = 1 ORDER BY galleryID DESC LIMIT 10";
        ArrayList<Gallery> list = new ArrayList<>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Gallery gallery = new Gallery();
                gallery.setGalleryID(rs.getInt("galleryID"));
                gallery.setGalleryTitle(rs.getString("galleryTitle"));
                gallery.setUserID(rs.getString("userID"));
                gallery.setGalleryDate(rs.getString("galleryDate"));
                gallery.setGalleryContent(rs.getString("galleryContent"));
                gallery.setHit(rs.getInt("hit"));
                gallery.setGalleryAvailable(rs.getInt("galleryAvailable"));
                gallery.setFileName(rs.getString("fileName"));
                gallery.setFileRealName(rs.getString("fileRealName"));
                list.add(gallery);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
		
    //페이징 처리
		public boolean nextPage(int pageNumber) {
			String SQL = "SELECT * FROM GALLERY WHERE galleryID < ? AND galleryAvailable = 1";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					return true;
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return false;	
		}	
		
		//게시글 가져오기
		public Gallery getGallery(int galleryID) {
			String SQL = "SELECT * FROM GALLERY WHERE galleryID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, galleryID);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					Gallery gallery = new Gallery();
					gallery.setGalleryID(rs.getInt(1));
					gallery.setGalleryTitle(rs.getString(2));
					gallery.setUserID(rs.getString(3));
					gallery.setGalleryDate(rs.getString(4));
					gallery.setGalleryContent(rs.getString(5));
					gallery.setHit(rs.getInt(6));
					gallery.setGalleryAvailable(rs.getInt(7));
	                gallery.setFileName(rs.getString("fileName"));
	                gallery.setFileRealName(rs.getString("fileRealName"));
					return gallery;
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
		//게시글 수정
		public int update(int galleryID, String galleryTitle, String galleryContent) {
			String SQL = "UPDATE GALLERY SET galleryTitle = ?, galleryContent = ? WHERE galleryID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, galleryTitle);
				pstmt.setString(2, galleryContent);
				pstmt.setInt(3, galleryID);
				return pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}
			return -1; //DB 오류 
		}
		
		//게시글 삭제
		public int delete(int galleryID) {
			String SQL = "UPDATE GALLERY SET galleryAvailable = 0 WHERE galleryID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, galleryID);
				return pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}
			return -1; //DB 오류 
		}
}