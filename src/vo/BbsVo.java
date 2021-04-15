package vo;

import java.io.*;


public class BbsVo {
	private int bbsID;
	private String bbsTitle;
	private String logId;
	private String bbsDate;
	private String bbsContent;
	private int bbsAvailable;
	private String im_name;
	public BbsVo() {}
	
	public int getBbsID() {
		return bbsID;
	}
	public void setBbsID(int bbsID) {
		this.bbsID = bbsID;
	}
	public String getBbsTitle() {
		return bbsTitle;
	}
	public void setBbsTitle(String bbsTitle) {
		this.bbsTitle = bbsTitle;
	}
	public String getLogId() {
		return logId;
	}
	public void setLogId(String logId) {
		this.logId = logId;
	}
	public String getBbsDate() {
		return bbsDate;
	}
	public void setBbsDate(String bbsDate) {
		this.bbsDate = bbsDate;
	}
	public String getBbsContent() {
		return bbsContent;
	}
	public void setBbsContent(String bbsContent) {
		this.bbsContent = bbsContent;
	}
	public int getBbsAvailable() {
		return bbsAvailable;
	}
	public void setBbsAvailable(int bbsAvailable) {
		this.bbsAvailable = bbsAvailable;
	}
	public String getIm_name() {
		return im_name;
	}
	public void setIm_name(String im_name) {
		this.im_name = im_name;
	}
	
	
}
