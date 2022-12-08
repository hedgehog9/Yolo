package com.yolo.hr.jinji.notice.model;

import java.util.List;
import java.util.Map;

public interface InterNoticeDAO {

	// 전체 부서 조회하기
	List<Map<String, String>> getDeptList();

	// 체크된 부서 목록 가져오기
	List<Map<String, String>> getChooseDept(String str_empno);
	
	// 공지글 작성하기
	void getSenNotice(NoticeVO noticevo);

	// 전체 공지 리스트 보여주기
	List<Map<String, String>> getAllNoticeList(String fk_deptno);

	// 전체 공지사항 공지글 1개 보여주기(ajax)
	Map<String, String> showNoticeContent(String notino);
	
	// 내가 쓴 공지리스트 기져오기
	List<Map<String, String>> getMyNoticeList(String fk_deptno);






	

		
}
