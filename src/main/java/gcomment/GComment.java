package gcomment;


public class GComment {
	
	private int cmtID;
	private String userID;
	private String cmtDate;
	private String cmtContent;
	private int galleryID;
	private int cmtAvailable;
	


	public int getGalleryID() {
		return galleryID;
	}
	public void setGalleryID(int galleryID) {
		this.galleryID = galleryID;
	}
	public int getCmtAvailable() {
		return cmtAvailable;
	}
	public void setCmtAvailable(int cmtAvailable) {
		this.cmtAvailable = cmtAvailable;
	}
	public int getCmtID() {
		return cmtID;
	}
	public void setCmtID(int cmtID) {
		this.cmtID = cmtID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getCmtDate() {
		return cmtDate;
	}
	public void setCmtDate(String cmtDate) {
		this.cmtDate = cmtDate;
	}
	public String getCmtContent() {
		return cmtContent;
	}
	public void setCmtContent(String cmtContent) {
		this.cmtContent = cmtContent;
	}
}
