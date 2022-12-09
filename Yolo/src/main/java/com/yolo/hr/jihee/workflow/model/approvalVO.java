package com.yolo.hr.jihee.workflow.model;

public class approvalVO {

	
	
	 private int approval_no; 		//결재번호
	 private int fk_doc_no;   		//문서번호
	 private int fk_senior_empno; //결제할 사원번호
	 private int levelno; 			// 결제단계번호
	 private int approval; 			// 0:승인 1: 허가 -1:반려
	 private String comments; 		// 코멘트
	 private String approval_day;  	// 승인 일자
	 
	 
	public int getApproval_no() {
		return approval_no;
	}
	public void setApproval_no(int approval_no) {
		this.approval_no = approval_no;
	}
	public int getFk_doc_no() {
		return fk_doc_no;
	}
	public void setFk_doc_no(int fk_doc_no) {
		this.fk_doc_no = fk_doc_no;
	}
	public int getFk_senior_empno() {
		return fk_senior_empno;
	}
	public void setFk_senior_empno(int fk_senior_empno) {
		this.fk_senior_empno = fk_senior_empno;
	}
	public int getLevelno() {
		return levelno;
	}
	public void setLevelno(int levelno) {
		this.levelno = levelno;
	}
	public int getApproval() {
		return approval;
	}
	public void setApproval(int approval) {
		this.approval = approval;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getApproval_day() {
		return approval_day;
	}
	public void setApproval_day(String approval_day) {
		this.approval_day = approval_day;
	}
	 
	 
	 
	 
}
