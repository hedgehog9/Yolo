package com.yolo.hr.jinji.notice.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yolo.hr.jinji.notice.model.InterNoticeDAO;
import com.yolo.hr.jinji.notice.model.NoticeVO;

@Service
public class NoticeService implements InterNoticeService {

	// 의존 객체 주입하기
	@Autowired
	private InterNoticeDAO dao;

	// 전체 부서 조회하기
	@Override
	public List<Map<String, String>> getDeptList() {
		List<Map<String, String>> deptList = dao.getDeptList();
		return deptList;
	}

	// 체크된 부서 목록 가져오기
	@Override
	public List<Map<String, String>> getChooseDept(String str_empno) {
		List<Map<String, String>>  deptList = dao.getChooseDept(str_empno);
		return deptList;
		
	}
	
	// 공지글 작성하기
	@Override
	public void sendNotice(NoticeVO noticevo) {
		
		dao.getSenNotice(noticevo);
	
	}

	
	// 전체 공지 리스트 보여주기
	@Override
	public List<Map<String, String>> getAllNoticeList(String fk_deptno) {
		List<Map<String, String>> allNoticeList = dao.getAllNoticeList(fk_deptno);
		return allNoticeList;
	}

	// 전체 공지사항 공지글 1개 보여주기(ajax)
	@Override
	public Map<String, String> showNoticeContent(String notino) {
		 Map<String, String>  noticeContent = dao.showNoticeContent(notino);
		return noticeContent;
	}

	
	// 내가 쓴 공지리스트 가져오기
	@Override
	public List<Map<String, String>> getMyNoticeList(String fk_deptno) {
		List<Map<String, String>> myNotice = dao.getMyNoticeList(fk_deptno);
		return myNotice;
	}



	

	
	

	
	

}
