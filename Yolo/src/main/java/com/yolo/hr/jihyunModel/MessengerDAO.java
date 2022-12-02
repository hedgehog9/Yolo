package com.yolo.hr.jihyunModel;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.yolo.hr.jjy.employee.model.EmployeeVO;

@Repository
public class MessengerDAO implements InterMessengerDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession;

	
	// 전체부서 조회하기
	@Override
	public List<Map<String, String>> getDeptList() {
		String deptno = "1";
		List<Map<String, String>> deptList = sqlsession.selectList("kimjh.selectDept", deptno);
		return deptList;
	}


	// 해당부서 사람들 구하기
	/*
	 * @Override public List<Map<String, String>> getDeptPeople(String deptno) {
	 * List<Map<String, String>> deptPeople =
	 * sqlsession.selectList("kimjh.selectDeptPeople", deptno); return deptPeople; }
	 */

	// 부서사람들 조회하기
	@Override
	public List<Map<String, String>> getDeptPersonList(String deptno) {
		List<Map<String, String>> deptPersonList = sqlsession.selectList("kimjh.selectDeptPerson", deptno);
		return deptPersonList;
	}

	// 해당부서 팀 구해오기
	@Override
	public List<Map<String, String>> getTeam(String deptno) {
		List<Map<String, String>> teamList = sqlsession.selectList("kimjh.selectDept", deptno);
		return teamList;
	}


	// 팀 사람들 구해오기
	@Override
	public List<Map<String, String>> getTeamPerson(String deptno) {
		List<Map<String, String>> teamList = sqlsession.selectList("kimjh.selectDeptPerson", deptno);
		return teamList;
	}


	// 선택한 유저 목록 가져오기
	@Override
	public List<Map<String, String>> getChooseEmp(String str_empno) {
		List<Map<String, String>> empList  = sqlsession.selectList("kimjh.selectChooseEmp", str_empno);
		return empList;
	}

	
	// 메신저 보내기
	@Override
	public void sendMessenger(String sql) {
		sqlsession.insert("kimjh.insertSendMessenger", sql);
	}


	// 보낸 메일 리스트 가져오기
	@Override
	public List<Map<String, String>> getSentMsgList(String empno) {
		List<Map<String, String>> sentMsgList  = sqlsession.selectList("kimjh.selectSentMsgList", empno);
		return sentMsgList;
	} 

}
