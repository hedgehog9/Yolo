package com.yolo.hr.jihyunModel;

public class FileVO {
	
	private String fk_msgno;	// 원본 메세지 그룹넘버임
	private String pk_fileno;
	private String fileName;    // WAS(톰캣)에 저장될 파일명(2022042911123035243254235235234.png) 
	private String orgFilename; // 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명
	private String fileSize;    // 파일크기 
	
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getOrgFilename() {
		return orgFilename;
	}
	public void setOrgFilename(String orgFilename) {
		this.orgFilename = orgFilename;
	}
	public String getFileSize() {
		return fileSize;
	}
	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	public String getFk_msgno() {
		return fk_msgno;
	}
	public void setFk_msgno(String fk_msgno) {
		this.fk_msgno = fk_msgno;
	}
	public String getPk_fileno() {
		return pk_fileno;
	}
	public void setPk_fileno(String pk_fileno) {
		this.pk_fileno = pk_fileno;
	}
	
	
}
