package com.yolo.hr.jinji.notice.model;

import java.util.List;
import java.util.Map;

public interface InterNoticeDAO {

	// 전체 부서 조회하기
	List<Map<String, String>> getDeptList();

	// 부서사람들 조회하기
	List<Map<String, String>> getDeptPersonList(String deptno);

	// 해당부서 팀 구해오기
	List<Map<String, String>> getTeam(String deptno);

	// 팀 사람들 구해오기
	List<Map<String, String>> getTeamPerson(String deptno);
	
	// 체크된 유저 목록 가져오기
	List<Map<String, String>> getChooseEmp(String str_empno);
	

	// 공지글 작성한 것 알림 보내기
	void sendNotice(String sql);

	// 전체 공지 리스트 보여주기
	
	// 내가 쓴 공지리스트 기져오기
	List<Map<String, String>> getSentNoticeList(String empno);

		
}
