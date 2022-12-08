package com.yolo.hr.jinji.notice.model;

public class CommentVO {

	private String cmtno; 		// 댓글번호 
	private String fk_empno; 	// 사원번호
	private String fk_notino; 	// 공지번호
	private String content; 	// 댓글내용 (글자수 50으로 제한)
	private String writedate; 	// 댓글작성일
	private String status; 		// 글삭제여부 - default 1 
						   		// 1 : 사용가능한 글,  0 : 삭제된 글
	                            // 댓글은 원글이 삭제시, 자동 삭제 ( 댓글 삭제 후 게시글 삭제 고려)
	
	// 생성자
	public CommentVO(){}
	
	public CommentVO(String cmtno, String fk_empno, String fk_notino, String content,
			String writedate, String status) 
	{
		super();
		this.cmtno = cmtno;
		this.fk_empno = fk_empno;
		this.fk_notino = fk_notino;
		this.content = content;
		this.writedate = writedate;
		this.status = status;
	}

	
	// getters & setters 
	public String getCmtno() {
		return cmtno;
	}

	public void setCmtno(String cmtno) {
		this.cmtno = cmtno;
	}

	public String getFk_empno() {
		return fk_empno;
	}

	public void setFk_empno(String fk_empno) {
		this.fk_empno = fk_empno;
	}

	public String getFk_notino() {
		return fk_notino;
	}

	public void setFk_notino(String fk_notino) {
		this.fk_notino = fk_notino;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWritedate() {
		return writedate;
	}

	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
	
	
	
}
