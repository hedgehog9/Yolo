package com.yolo.hr.jihyunModel;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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

}
