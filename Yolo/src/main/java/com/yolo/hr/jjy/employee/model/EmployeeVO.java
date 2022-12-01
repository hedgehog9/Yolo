package com.yolo.hr.jjy.employee.model;

public class EmployeeVO {

	private String empno; // 사원번호
	private String name; // 이름
	private String lastname; // 영문이름
	private String firstname; // 영문 성
	private String email; // 이메일(아이디)
	private String pwd; // 비밀번호
	private String mobile; // 핸드폰번호
	private String hiredate; // 입사일
	private String retiredate; // 퇴사일
	private String fk_deptno; // 부서번호
	private String time_salary; // 급여(시급)
	private String rrn; // 주민번호
	private String position; // 직위
	private String address; // 주소
	private String account; // 급여지급 계좌
	private String introduce; // 자기소개
	private String status; // 재직여부를 나타내는 컬럼
	private String profile_color; // 프로필 색상

	private String gender; // 성별 (오라클에서 func_gender()로 구해옴)
	
	
	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	// Getter, Setter ///////////////////////////////////////////////
	public String getEmpno() {
		return empno;
	}

	public void setEmpno(String empno) {
		this.empno = empno;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getHiredate() {
		return hiredate;
	}

	public void setHiredate(String hiredate) {
		this.hiredate = hiredate;
	}

	public String getRetiredate() {
		return retiredate;
	}

	public void setRetiredate(String retiredate) {
		this.retiredate = retiredate;
	}

	public String getFk_deptno() {
		return fk_deptno;
	}

	public void setFk_deptno(String fk_deptno) {
		this.fk_deptno = fk_deptno;
	}

	public String getTime_salary() {
		return time_salary;
	}

	public void setTime_salary(String time_salary) {
		this.time_salary = time_salary;
	}

	public String getRrn() {
		return rrn;
	}

	public void setRrn(String rrn) {
		this.rrn = rrn;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getIntroduce() {
		return introduce;
	}

	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getProfile_color() {
		return profile_color;
	}

	public void setProfile_color(String profile_color) {
		this.profile_color = profile_color;
	}
	
	

}
