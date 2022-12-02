package com.yolo.hr.jihyunService;

import java.util.List;
import java.util.Map;

import com.yolo.hr.jihyunModel.MessengerVO;

public interface InterMessengerService {

	// 전체 부서 조회하기
	List<Map<String, String>> getDeptList();

	// 부서사람들 조회하기
	List<Map<String, String>> getDeptPersonList(String deptno);

	// 해당부서 팀 구해오기
	List<Map<String, String>> getTeam(String deptno);

	// 팀 사람들 구해오기
	List<Map<String, String>> getTeamPerson(String deptno);

	// 선택한 유저 목록 가져오기
	List<Map<String, String>> getChooseEmp(String str_empno);

	// 메신저 보내기
	void sendMessenger(MessengerVO msgvo);

	// 보낸 메일 리스트 가져오기
	List<Map<String, String>> getSentMsgList(String empno);

}
