package com.yolo.hr.jinji.notice.service;

import java.util.List;
import java.util.Map;

import com.yolo.hr.jinji.notice.model.NoticeVO;

public interface InterNoticeService {

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
	
	// 공지글 작성하기
	void sendNotice(NoticeVO noticevo);

	///////////////////////
	// 전체 공지 리스트 보여주기

	// 내가 쓴 공지 리스트 가져오기
	List<Map<String, String>> getSentNoticeList(String empno);




	
}
