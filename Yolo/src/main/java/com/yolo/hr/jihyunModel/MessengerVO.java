package com.yolo.hr.jihyunModel;

public class MessengerVO {
	
	private String pk_msgno;
	private String fk_senderno ;
	private String fk_recipientno ;
	private String origin_msgno ;
	private String subject ;
	private String content ;
	private String view_status ;
	private String having_attach ;
	private String writedate ;
	private String group_msgno;
	
	public String getPk_msgno() {
		return pk_msgno;
	}
	public void setPk_msgno(String pk_msgno) {
		this.pk_msgno = pk_msgno;
	}
	public String getFk_senderno() {
		return fk_senderno;
	}
	public void setFk_senderno(String fk_senderno) {
		this.fk_senderno = fk_senderno;
	}
	public String getFk_recipientno() {
		return fk_recipientno;
	}
	public void setFk_recipientno(String fk_recipientno) {
		this.fk_recipientno = fk_recipientno;
	}
	public String getOrigin_msgno() {
		return origin_msgno;
	}
	public void setOrigin_msgno(String origin_msgno) {
		this.origin_msgno = origin_msgno;
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
	public String getView_status() {
		return view_status;
	}
	public void setView_status(String view_status) {
		this.view_status = view_status;
	}
	public String getWritedate() {
		return writedate;
	}
	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}
	public String getHaving_attach() {
		return having_attach;
	}
	public void setHaving_attach(String having_attach) {
		this.having_attach = having_attach;
	}
	public String getGroup_msgno() {
		return group_msgno;
	}
	public void setGroup_msgno(String group_msgno) {
		this.group_msgno = group_msgno;
	}
	
	
}
