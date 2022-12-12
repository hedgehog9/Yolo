package com.yolo.hr.jjy.employee.model;

import java.util.*;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class EmployeeDAO implements InterEmployeeDAO {

	@Resource
	private SqlSessionTemplate sqlsession; 
	
	// 전체 사원을 조회해오는 메소드 
	@Override
	public List<Map<String, String>> getEmpList(Map<String, String> empMap) {
		
		List<Map<String, String>> empList = sqlsession.selectList("jangjy.getEmpList", empMap);
		return empList;
	}
	
	// 사원 번호를 전달받아 사원 한명의 정보를 조회해오는 메소드
	@Override
	public Map<String, String> getEmpOne(Map<String, String> empnoMap) {
		Map<String, String> employeeMap = sqlsession.selectOne("jangjy.getEmpOne",empnoMap);
		return employeeMap;
	}

	// 시작일, 종료일, 사원번호, 메모, 사원번호를 Map 으로 전달받아 휴직테이블에 insert 하는 메소드
	@Override
	public int insertLeave(Map<String, String> leaveMap) {
		int result = sqlsession.insert("jangjy.insertLeave",leaveMap);
		return result;
	}
	
	// 사원번호를 Map 으로 전달받아 휴직 상태로 update 하는 메소드 
	@Override
	public int updateLeave(Map<String, String> leaveMap) {
		int leaveUpdate = sqlsession.update("jangjy.updateLeave", leaveMap);
		return leaveUpdate;
	}

	
	// 사원번호, 휴직시작일,휴직종료일을 Map 으로 전달받아 가능한 기간인지 조회하는 메소드
	@Override
	public int checkLeave(Map<String, String> leaveCheckMap) {
		int result = sqlsession.selectOne("jangjy.leaveCheck",leaveCheckMap);
		return result;
	}
	

	// 재직 처리해야 할 사원들의 목록을 조회하는 메소드  
	@Override
	public List<Map<String, String>> getLeaveEmpList() {
		List<Map<String, String>> leaveEmpList = sqlsession.selectList("jangjy.getLeaveEmpList");
		return leaveEmpList;
	}

	// 휴직 처리해야할 사원들의 목록을 조회하는 메소드 
	@Override
	public List<Map<String, String>> getLeaveStartEmpList() {
		List<Map<String, String>> leaveStartEmpList = sqlsession.selectList("jangjy.getLeaveStartEmpList");
		return leaveStartEmpList;
	}

	// 휴직중인 사원의 목록을 전달받아 배열로 변환 후 재직 상태로 update 하는 메소드
	@Override
	public void updateLeaveEmp(Map<String, String[]> paraMap) {
		sqlsession.selectList("jangjy.updateLeaveEmp",paraMap);
		
	}

	// 재직중인 사원의 목록을 전달받아 배열로 변환 후 휴직 상태로 update 하는 메소드
	@Override
	public void updateLeaveStartEmp(Map<String, String[]> paraMap) {
		sqlsession.selectList("jangjy.updateLeaveStartEmp",paraMap);
		
	}
	
	// 전체 부서번호, 부서명 조회하는 메소드 
	@Override
	public List<Map<String, String>> getDeptList() {
		String deptno = "1";
		List<Map<String, String>> deptList = sqlsession.selectList("jangjy.selectDept", deptno);
		return deptList;
	}
	
	
	// 해당부서 팀 구해오기
	@Override
	public List<Map<String, String>> getTeam(Map<String, String> deptMap) {
		List<Map<String, String>> teamList = sqlsession.selectList("jangjy.getTeamName", deptMap);
		return teamList;
	}

	// 페이징 처리를 위해 총 사원 수 구해오기 
	@Override
	public int getTotalCount(Map<String, Object> empMap) {
		int totalCount = sqlsession.selectOne("jangjy.getTotalCount",empMap);
		return totalCount;
	}

	// 페이징 처리한 글목록 가져오기 (검색이 있든지, 검색이 없든지 모두 다 포함한 것)
	@Override
	public List<Map<String, String>> empListSearchWithPaging(Map<String, Object> pageMap) {
		List<Map<String,String>> empListPaging = sqlsession.selectList("jangjy.empListSearchWithPaging", pageMap);
		return empListPaging;
	}

	// 페이징 처리를 위해 총 페이지 수 구해오기 
	@Override
	public int getTotalPage(Map<String, Object> pageMap) {
		int totalPage = sqlsession.selectOne("jangjy.getTotalPage",pageMap);
		return totalPage;
	}

	// rno 에 해당하는 사원 목록 가져오기 
	@Override
	public List<Map<String, String>> empListWithRno(Map<String, String> pageMap) {
		List<Map<String,String>> empList = sqlsession.selectList("jangjy.empListWithRno",pageMap);
		return empList;
	}

	// 회원가입시 이메일 중복 여부 확인 
	@Override
	public int checkDuplicateEmail(Map<String, Object> paraMap) {
		int duplicateEmail = sqlsession.selectOne("jangjy.checkDuplicateEmail",paraMap);
		return duplicateEmail;
	}

	// 신규 사원 등록 
	@Override
	public int registEployee(Map<String, Object> paraMap) {
		int registResult = sqlsession.insert("jangjy.registEmployee", paraMap);
		return registResult;
	}

	// 사원번호, 월요일(날짜), 금요일(날짜) 를 전달받아 한 주의 총 근무시간 구해오기 
	@Override
	public String getWorkTime(Map<String, Object> workTimeMap) {
		String time = sqlsession.selectOne("jangjy.getWorkTime", workTimeMap);
		return time;
	}

	@Override
	public int getManagerEmpno(Map<String, Object> paraMap) {
		int manager_yn = sqlsession.selectOne("jangjy.getManagerEmpno",paraMap);
		return manager_yn;
	}

	@Override
	public int insertPsa(Map<String, Object> paraMap) {
		int result = sqlsession.insert("jangjy.insertPsa", paraMap);
		return result;
	}

	@Override
	public int updatePsa(Map<String, Object> paraMap) {
		int result = sqlsession.update("jangjy.updatePsa", paraMap);
		return result;
	}

	@Override
	public int updateManagerEmpno(Map<String, Object> paraMap) {
		int result = sqlsession.update("jangjy.updateManagerEmpno",paraMap);
		return result;
	}

	@Override
	public List<Map<String, String>> getPsaHistory(Map<String, Object> paraMap) {
		List<Map<String, String>> psaHistoryList = sqlsession.selectList("jangjy.getPsaHistory",paraMap);
		return psaHistoryList;
	}

	@Override
	public List<Map<String, String>> getLeaveAbsence(Map<String, Object> paraMap) {
		List<Map<String, String>> leaveAbsenceList = sqlsession.selectList("jangjy.getLeaveAbsence",paraMap);
		return leaveAbsenceList;
	}

	@Override
	public int changePsInfo(Map<String, Object> psInfoMap) {
		int result = sqlsession.update("jangjy.changePsInfo", psInfoMap);
		return result;
	}

	@Override
	public int getTotalPsaPage(Map<String, Object> pageMap) {
		int totalCount = sqlsession.selectOne("jangjy.getTotalPsaPage",pageMap);
		return totalCount;
	}

	@Override
	public List<Map<String, String>> psaListSearchWithPaging(Map<String, Object> pageMap) {
		List<Map<String,String>> psaListPaging = sqlsession.selectList("jangjy.psaListSearchWithPaging", pageMap);
		return psaListPaging;
	}

	@Override
	public void addFile(Map<String, Object> fileMap) {
		sqlsession.insert("jangjy.addFile", fileMap);
		
	}

	@Override
	public List<Map<String, String>> getFile(Map<String, Object> paraMap) {
		List<Map<String, String>> FileList = sqlsession.selectList("jangjy.getFile", paraMap);
		return FileList;
	}

	
	
	
}
