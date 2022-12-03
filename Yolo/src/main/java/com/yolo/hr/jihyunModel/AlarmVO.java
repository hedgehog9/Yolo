package com.yolo.hr.jihyunModel;

public class AlarmVO {
	private String pk_alarmno;
	private String fk_recipientno;
	private String url ;
	private String url2 ;
	private String alarm_content;
	private String alarm_type;
	private String view_status;
	private String writedate2;
	
	public String getPk_alarmno() {
		return pk_alarmno;
	}
	public void setPk_alarmno(String pk_alarmno) {
		this.pk_alarmno = pk_alarmno;
	}
	public String getFk_recipientno() {
		return fk_recipientno;
	}
	public void setFk_recipientno(String fk_recipientno) {
		this.fk_recipientno = fk_recipientno;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getUrl2() {
		return url2;
	}
	public void setUrl2(String url2) {
		this.url2 = url2;
	}
	public String getAlarm_content() {
		return alarm_content;
	}
	public void setAlarm_content(String alarm_content) {
		this.alarm_content = alarm_content;
	}
	public String getAlarm_type() {
		return alarm_type;
	}
	public void setAlarm_type(String alarm_type) {
		this.alarm_type = alarm_type;
	}
	public String getView_status() {
		return view_status;
	}
	public void setView_status(String view_status) {
		this.view_status = view_status;
	}
	public String getWritedate() {
		return writedate2;
	}
	public void setWritedate(String writedate) {
		this.writedate2 = writedate;
	}
}
