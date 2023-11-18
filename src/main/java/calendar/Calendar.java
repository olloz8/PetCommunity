package calendar;

import java.util.Date;

public class Calendar {
		
	private int cldID;
	private String userID;
	private String cldTitle;
	private String  cldStart;
	private String  cldEnd;
	

	public int getCldID() {
		return cldID;
	}
	public void setCldID(int cldID) {
		this.cldID = cldID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getCldTitle() {
		return cldTitle;
	}
	public void setCldTitle(String cldTitle) {
		this.cldTitle = cldTitle;
	}
	public String getCldStart() {
		return cldStart;
	}
	public void setCldStart(String cldStart) {
		this.cldStart = cldStart;
	}
	public String getCldEnd() {
		return cldEnd;
	}
	public void setCldEnd(String cldEnd) {
		this.cldEnd = cldEnd;
	}
	
}
