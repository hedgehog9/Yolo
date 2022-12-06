package com.yolo.hr.jinji.notice.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;


@Repository
public class NoticeDAO implements InterNoticeDAO {

	@Resource
	private SqlSessionTemplate sqlsession;

	// 전체부서 조회하기
	@Override
	public List<Map<String, String>> getDeptList() {
		String deptno = "1";
		List<Map<String, String>> deptList = sqlsession.selectList("jinmj.selectDept", deptno);
		return deptList;
	}

	// 해당부서 사람들 구하기
	/*
	@Override
	public List<Map<String, String>> getDeptPersonList(String deptno) {
		List<Map<String, String>> deptPeople = sqlsession.selectList("jinmj.selectDeptPeople", deptno);
		return deptPeople;
	}
	*/
	
	// 부서사람들 조회하기
	@Override
	public List<Map<String, String>> getDeptPersonList(String deptno) {
		List<Map<String, String>> deptPersonList = sqlsession.selectList("jinmj.selectDeptPerson", deptno);
		return deptPersonList;
	}
	
	// 해당부서 팀 구해오기
	@Override
	public List<Map<String, String>> getTeam(String deptno) {
		List<Map<String, String>> teamList  = sqlsession.selectList("jinmj.selectDept", deptno);
		return teamList ;
	}

	// 팀 사람들 구해오기
	@Override
	public List<Map<String, String>> getTeamPerson(String deptno) {
		List<Map<String, String>> teamList = sqlsession.selectList("jinmj.selectDeptPerson", deptno);
		return teamList;
	}
	
	// 체크된 유저 목록 가져오기
	@Override
	public List<Map<String, String>> getChooseEmp(String str_empno) {
		List<Map<String, String>> empList  = sqlsession.selectList("jinmj.selectChooseEmp", str_empno);
		return empList;
	}

	// 공지글 작성한 것 알림 보내기
	@Override
	public void sendNotice(String sql) {
		sqlsession.insert("jinmj.insertSendNotice", sql);		
	}

	
	///////////////////////////////
	// 전체 공지 리스트 보여주기 (select)


	// 내가 쓴 공지리스트 가져오기
	@Override
	public List<Map<String, String>> getSentNoticeList(String empno) {
		List<Map<String, String>> sentNoticeList = sqlsession.selectList("jinmj.selectSentNoticeList", empno);
		return sentNoticeList;
	}




	
}
