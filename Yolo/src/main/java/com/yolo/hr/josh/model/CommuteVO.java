package com.yolo.hr.josh.model;

public class CommuteVO {

	private String commuteno;           
	private String fk_empno;
	private String start_work_time;
	private String end_work_time;
	private String overtime;
	private String work_kind;
	
	
	public String getCommuteno() {
		return commuteno;
	}
	public void setCommuteno(String commuteno) {
		this.commuteno = commuteno;
	}
	public String getFk_empno() {
		return fk_empno;
	}
	public void setFk_empno(String fk_empno) {
		this.fk_empno = fk_empno;
	}
	public String getStart_work_time() {
		return start_work_time;
	}
	public void setStart_work_time(String start_work_time) {
		this.start_work_time = start_work_time;
	}
	public String getEnd_work_time() {
		return end_work_time;
	}
	public void setEnd_work_time(String end_work_time) {
		this.end_work_time = end_work_time;
	}
	public String getOvertime() {
		return overtime;
	}
	public void setOvertime(String overtime) {
		this.overtime = overtime;
	}
	public String getWork_kind() {
		return work_kind;
	}
	public void setWork_kind(String work_kind) {
		this.work_kind = work_kind;
	}
	
	
	
	
}
