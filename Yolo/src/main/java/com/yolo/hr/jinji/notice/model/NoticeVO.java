package com.yolo.hr.jinji.notice.model;

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
	

	// 생성자
	public NoticeVO() {}
	
	public NoticeVO(String notino, String fk_senderno, String fk_deptno, String notiLevel,
					String writedate, String subject, String content, String readCount, String cmtCount, String status) 
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

	
	
	
}
