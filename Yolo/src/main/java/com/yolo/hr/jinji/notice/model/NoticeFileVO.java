package com.yolo.hr.jinji.notice.model;

public class NoticeFileVO {

	private String uploadFileName; 	// 업로드시 WAS(톰캣)에 저장될 파일명
	private String fk_notino;  	   	// 실제 파일명
	private String orgFilename;		// 파일 크기
	private String fileSize;
	
	
	// 생성자
	public NoticeFileVO() {}
	public NoticeFileVO(String uploadFileName, String fk_notino, String orgFilename, String fileSize) 
	{
		super();
		this.uploadFileName = uploadFileName;
		this.fk_notino = fk_notino;
		this.orgFilename = orgFilename;
		this.fileSize = fileSize;
	}


	//  getters & setters
	public String getUploadFileName() {
		return uploadFileName;
	}


	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}


	public String getFk_notino() {
		return fk_notino;
	}


	public void setFk_notino(String fk_notino) {
		this.fk_notino = fk_notino;
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

	
	
	
	
}
