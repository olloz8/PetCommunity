package comment;


public class Comment {
	
	private int cmtID;
	private String userID;
	private String cmtDate;
	private String cmtContent;
	private int bbsID;
	private int cmtAvaliable;
	
	
	public int getBbsID() {
		return bbsID;
	}
	public void setBbsID(int bbsID) {
		this.bbsID = bbsID;
	}
	public int getCmtAvaliable() {
		return cmtAvaliable;
	}
	public void setCmtAvaliable(int cmtAvaliable) {
		this.cmtAvaliable = cmtAvaliable;
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
