package com.yolo.hr.jinji.notice.service;

import java.util.List;
import java.util.Map;

import com.yolo.hr.jinji.notice.model.NoticeVO;

public interface InterNoticeService {

	// 전체 부서 조회하기
	List<Map<String, String>> getDeptList();
	
	// 체크된 부서 목록 가져오기
	List<Map<String, String>> getChooseDept(String str_empno);
	
	// 공지글 작성하기
	void sendNotice(NoticeVO noticevo);
	
	// 전체 공지 리스트 보여주기
	List<Map<String, String>> showAllNoticeList(String empno);
	
	// 전체 공지사항 공지글 1개 보여주기(ajax)
	Map<String, String> showNoticeContent(String notino);

	// 공지 작성시 해당 공지 받는 사원 번호 알아오기
	List<String> getEmpnoList(String fk_deptno);

	// seq최신 공지번호 알아오기
	String getSeqNotino(String empno);

	// 내가 쓴 공지 리스트 가져오기
	List<Map<String, String>> getMyNoticeList(String empno);



	
	
}
