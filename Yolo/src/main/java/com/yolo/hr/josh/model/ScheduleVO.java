package com.yolo.hr.josh.model;

public class ScheduleVO {

	private String schedule_no; 
	private String fk_empno;
	private String start_date;
	private String end_date;
	private String subject;
	private String content;
	private String color;
	private String category;
	private String fk_deptno;
	private String joinuser;
	private String place;
	
	// select 용 field
	private String birthday;
	private String name;
	
	public String getSchedule_no() {
		return schedule_no;
	}
	public void setSchedule_no(String schedule_no) {
		this.schedule_no = schedule_no;
	}
	public String getFk_empno() {
		return fk_empno;
	}
	public void setFk_empno(String fk_empno) {
		this.fk_empno = fk_empno;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
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
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getFk_deptno() {
		return fk_deptno;
	}
	public void setFk_deptno(String fk_deptno) {
		this.fk_deptno = fk_deptno;
	}
	public String getJoinuser() {
		return joinuser;
	}
	public void setJoinuser(String joinuser) {
		this.joinuser = joinuser;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
	
}
