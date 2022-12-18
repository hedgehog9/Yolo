package com.yolo.hr.jinji.notice.model;

import org.springframework.web.multipart.MultipartFile;

public class NoticeVO {

	// insert용
	private String notino; 		// 공지번호
	private String fk_senderno; // 보내는 사람 사원번호
	private String fk_deptno; 	// 받는 사람 사원번호
	private String notiLevel; 	// 공지레벨 ㅡ default 0 
	private String writedate; 	// 공지작성일
	private String subject; 	// 공지제목
	private String content; 	// 공지내용
	private String readCount; 	// 공지조회수 default 0 
	private String cmtCount;  	// 공지댓글수 default 0 
	private String status; 		// 글삭제여부   1:사용가능한 글,  0:삭제된글  //  default 1 
	private String fileName;   			// WAS(톰캣)에 저장될 파일명(2022042911123035243254235235234.png) 
	private String orgFilename; 		// 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명
	private String fileSize; 		// 파일크기 

	
	
	/*
	=== #152. 파일을 첨부하도록 VO 수정하기
             먼저, 오라클에서 tbl_board 테이블에 3개 컬럼(fileName, orgFilename, fileSize)을 추가한 다음에 아래의 작업을 한다. 
	 */
	 private MultipartFile attach;
	 /* form 태그에서 type="file" 인 파일을 받아서 저장되는 필드이다. 
	       진짜파일 ==> WAS(톰캣) 디스크에 저장됨.
	           조심할것은 MultipartFile attach 는 오라클 데이터베이스 tbl_board 테이블의 컬럼이 아니다.   
	    /Board/src/main/webapp/WEB-INF/views/tiles1/board/add.jsp 파일에서 input type="file" 인 name 의 이름(attach)과  
	      동일해야만 파일첨부가 가능해진다.!!!!
	*/
	
	
	
	
	// 생성자
	public NoticeVO() {}
	
	public NoticeVO(String notino, String fk_senderno, String fk_deptno, String notiLevel,
					String writedate, String subject, String content, String readCount, String cmtCount, String status,
					String fileName, String orgFilename, String fileSize) 
	
	{
		this.notino = notino;
		this.fk_senderno = fk_senderno;
		this.fk_deptno = fk_deptno;
		this.notiLevel = notiLevel;
		this.writedate = writedate;
		this.subject = subject;
		this.content = content;
		this.readCount = readCount;
		this.cmtCount = cmtCount;
		this.status = status;
		this.fileName = fileName;
		this.orgFilename = orgFilename;
		this.fileSize = fileSize;
	}

	
	// getters & setters
	public String getNotino() {
		return notino;
	}

	public void setNotino(String notino) {
		this.notino = notino;
	}

	public String getFk_senderno() {
		return fk_senderno;
	}

	public void setFk_senderno(String fk_senderno) {
		this.fk_senderno = fk_senderno;
	}

	public String getFk_deptno() {
		return fk_deptno;
	}

	public void setFk_deptno(String fk_deptno) {
		this.fk_deptno = fk_deptno;
	}

	public String getNotiLevel() {
		return notiLevel;
	}

	public void setNotiLevel(String notiLevel) {
		this.notiLevel = notiLevel;
	}

	public String getWritedate() {
		return writedate;
	}

	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getReadCount() {
		return readCount;
	}

	public void setReadCount(String readCount) {
		this.readCount = readCount;
	}

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

	public String getCmtCount() {
		return cmtCount;
	}

	public void setCmtCount(String cmtCount) {
		this.cmtCount = cmtCount;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public MultipartFile getAttach() {
		return attach;
	}
	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	
}
