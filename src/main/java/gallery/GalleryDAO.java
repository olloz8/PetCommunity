package gallery;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
	
    // 파일 이름으로 게시글의 galleryID를 가져오는 메서드
    public int getGalleryIDByFileName(String fileName) {
        int galleryID = 0;

        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // 'gallery' 테이블을 사용하도록 수정
            String sql = "SELECT galleryID FROM gallery WHERE fileName = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, fileName);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                galleryID = rs.getInt("galleryID");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(pstmt, rs);
        }

        return galleryID;
    }

    // 파일 이름으로 게시글의 postID를 가져오는 메서드
    public int getPostIdByFileName(String fileName) {
        int postId = 0;

        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT postID FROM gallery WHERE fileName = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, fileName);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                postId = rs.getInt("postID");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(pstmt, rs);
        }

        return postId;
    }
	
    public Gallery getGalleryByFileName(String fileName) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Gallery gallery = null;

        try {
            String SQL = "SELECT * FROM GALLERY WHERE fileName = ?";
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, fileName);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                gallery = new Gallery();
                gallery.setGalleryID(rs.getInt("galleryID"));
                gallery.setGalleryTitle(rs.getString("galleryTitle"));
                gallery.setUserID(rs.getString("userID"));
                gallery.setGalleryDate(rs.getString("galleryDate"));
                gallery.setGalleryContent(rs.getString("galleryContent"));
                gallery.setHit(rs.getInt("hit"));
                gallery.setGalleryAvailable(rs.getInt("galleryAvailable"));
                gallery.setFileName(rs.getString("fileName"));
                gallery.setFileRealName(rs.getString("fileRealName"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            /* 리소스 해제 코드 (pstmt, rs 등) */
            try {
                if (pstmt != null) pstmt.close();
                if (rs != null) rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return gallery;
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
	
    public List<String> getAllFileRealNames() {
        List<String> fileRealNames = new ArrayList<>();
        String SQL = "SELECT fileRealName FROM gallery";
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
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        Gallery gallery = null;

	        try {
	            String SQL = "SELECT * FROM GALLERY WHERE galleryID = ?";
	            pstmt = conn.prepareStatement(SQL);
	            pstmt.setInt(1, galleryID);
	            rs = pstmt.executeQuery();

	            if (rs.next()) {
	                gallery = new Gallery();
	                gallery.setGalleryID(rs.getInt("galleryID"));
	                gallery.setGalleryTitle(rs.getString("galleryTitle"));
	                gallery.setUserID(rs.getString("userID"));
	                gallery.setGalleryDate(rs.getString("galleryDate"));
	                gallery.setGalleryContent(rs.getString("galleryContent"));
	                gallery.setHit(rs.getInt("hit"));
	                gallery.setGalleryAvailable(rs.getInt("galleryAvailable"));
	                gallery.setFileName(rs.getString("fileName"));
	                gallery.setFileRealName(rs.getString("fileRealName"));
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	        	closeResources(pstmt, rs);
	        }

	        return gallery;
	    }
		
	    
	    
	 // GalleryDAO 클래스에 추가할 메서드
	    public int updateWithFile(int galleryID, String galleryTitle, String galleryContent, String fileName) {
	        String SQL = "UPDATE GALLERY SET galleryTitle = ?, galleryContent = ?, fileName = ? WHERE galleryID = ?";
	        try {
	            PreparedStatement pstmt = conn.prepareStatement(SQL);
	            pstmt.setString(1, galleryTitle);
	            pstmt.setString(2, galleryContent);
	            pstmt.setString(3, fileName);
	            pstmt.setInt(4, galleryID);
	            return pstmt.executeUpdate();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return -1; // DB 오류 
	    }

		// 게시글 및 해당 파일 삭제
		public int deleteGallery(int galleryID) {
		    String selectSQL = "SELECT fileName FROM GALLERY WHERE galleryID = ?";
		    String deleteSQL = "UPDATE GALLERY SET galleryAvailable = 0 WHERE galleryID = ?";

		    try {
		        // 파일 이름 조회
		        PreparedStatement selectPstmt = conn.prepareStatement(selectSQL);
		        selectPstmt.setInt(1, galleryID);
		        ResultSet rs = selectPstmt.executeQuery();

		        String fileName = null;
		        if (rs.next()) {
		            fileName = rs.getString("fileName");
		        }

		        // 게시글 삭제
		        PreparedStatement deletePstmt = conn.prepareStatement(deleteSQL);
		        deletePstmt.setInt(1, galleryID);
		        int result = deletePstmt.executeUpdate();

		        // 파일 삭제
		        if (result > 0 && fileName != null) {
		            // Replace "your_upload_directory" with the actual directory where your files are uploaded
		            String uploadDir = "C:\\Users\\82103\\eclipse-workspace\\PetCommunity\\src\\main\\webapp\\uploded";
		            File fileToDelete = new File(uploadDir + File.separator + fileName);

		            if (fileToDelete.exists()) {
		                if (fileToDelete.delete()) {
		                    System.out.println("파일 삭제 성공");
		                } else {
		                    System.out.println("파일 삭제 실패");
		                }
		            }
		        }

		        return result;
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return -1; // DB 오류
		}
		
		
		// Assuming you have methods like these in your GalleryDAO class
		public List<String> getFileRealNamesByAvailability(int availability) {
		    List<String> fileRealNames = new ArrayList<>();
		    String selectSQL = "SELECT fileRealName FROM GALLERY WHERE galleryAvailable = ?";

		    try {
		        PreparedStatement pstmt = conn.prepareStatement(selectSQL);
		        pstmt.setInt(1, availability);
		        ResultSet rs = pstmt.executeQuery();

		        while (rs.next()) {
		            fileRealNames.add(rs.getString("fileRealName"));
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }

		    return fileRealNames;
		}

		public boolean isGalleryAvailable(int galleryId) {
		    String selectSQL = "SELECT galleryAvailable FROM GALLERY WHERE galleryID = ?";

		    try {
		        PreparedStatement pstmt = conn.prepareStatement(selectSQL);
		        pstmt.setInt(1, galleryId);
		        ResultSet rs = pstmt.executeQuery();

		        if (rs.next()) {
		            int availability = rs.getInt("galleryAvailable");
		            return availability == 1;
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }

		    return false;
		}
		
		// 파일이 존재하는지 확인하는 메서드
		public boolean isFileExist(int galleryID) {
		    String selectSQL = "SELECT fileName FROM GALLERY WHERE galleryID = ?";

		    try {
		        PreparedStatement pstmt = conn.prepareStatement(selectSQL);
		        pstmt.setInt(1, galleryID);
		        ResultSet rs = pstmt.executeQuery();

		        return rs.next(); // 파일이 존재하면 true, 존재하지 않으면 false
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }

		    return false;
		}

		// 파일을 수정할 수 있는 메서드
		public int updateWithFile(int galleryID, String galleryTitle, String galleryContent, String fileName, String fileRealName) {
		    if (isFileExist(galleryID)) {
		        // 파일이 존재하면 파일명과 실제 파일명도 함께 업데이트
		        String SQL = "UPDATE GALLERY SET galleryTitle = ?, galleryContent = ?, fileName = ?, fileRealName = ? WHERE galleryID = ?";
		        try {
		            PreparedStatement pstmt = conn.prepareStatement(SQL);
		            pstmt.setString(1, galleryTitle);
		            pstmt.setString(2, galleryContent);
		            pstmt.setString(3, fileName);
		            pstmt.setString(4, fileRealName);
		            pstmt.setInt(5, galleryID);
		            return pstmt.executeUpdate();
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		    } else {
		        // 파일이 존재하지 않으면 파일명과 실제 파일명은 업데이트하지 않음
		        String SQL = "UPDATE GALLERY SET galleryTitle = ?, galleryContent = ? WHERE galleryID = ?";
		        try {
		            PreparedStatement pstmt = conn.prepareStatement(SQL);
		            pstmt.setString(1, galleryTitle);
		            pstmt.setString(2, galleryContent);
		            pstmt.setInt(3, galleryID);
		            return pstmt.executeUpdate();
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		    }

		    return -1; // DB 오류 
		}
		
		// GalleryDAO 클래스에 추가된 메서드
		public int update(int galleryID, String galleryTitle, String galleryContent) {
		    String SQL = "UPDATE GALLERY SET galleryTitle = ?, galleryContent = ? WHERE galleryID = ?";
		    try {
		        PreparedStatement pstmt = conn.prepareStatement(SQL);
		        pstmt.setString(1, galleryTitle);
		        pstmt.setString(2, galleryContent);
		        pstmt.setInt(3, galleryID);
		        return pstmt.executeUpdate();
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return -1; // DB 오류 
		}
		
	    // 리소스를 닫는 메서드
	    private void closeResources(PreparedStatement pstmt, ResultSet rs) {
	        try {
	            if (pstmt != null) pstmt.close();
	            if (rs != null) rs.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	}
