package com.yolo.hr.jinji.notice.service;

import java.util.List;
import java.util.Map;

import com.yolo.hr.jinji.notice.model.CommentVO;
import com.yolo.hr.jinji.notice.model.NoticeVO;

public interface InterNoticeService {

	
	// 전체 부서 조회하기
	List<Map<String, String>> getDeptList();
	
	// 체크된 부서 목록 가져오기
	List<Map<String, String>> getChooseDept(String str_empno);
	
	
	
	
	// 공지글 작성하기
	void sendNotice(NoticeVO noticevo);
	
	
	
	//////////////////// 전체 /////////////////////
	// 전체 공지 리스트 보여주기
	// List<Map<String, String>> showAllNoticeList(String empno); // 페이징 처리 안한 공지 리스트 페이지
	List<Map<String, String>> showAllNoticeList(Map<String, String> paraMap);
	
	// 전체 공지사항 공지글 1개 보여주기(ajax)
	Map<String, String> showNoticeContent(String notino);

	// 공지 작성시 해당 공지 받는 사원 번호 알아오기
	List<String> getEmpnoList(String fk_deptno);

	// seq최신 공지번호 알아오기
	String getSeqNotino(String empno);
	
	// 공지 수정을 위해 해당 공지번호 글 하나만 가져오기
	Map<String, String> showEditNoticeContent(String notino);

	// 공지글 수정 완료 폼 요청
	int editNotice(NoticeVO noticevo);

	// 공지글 삭제 요청하기 (1개 조회)
	int delNoticeEnd(Map<String, String> paraMap);
	
	// 댓글 쓰기
	int addComment(CommentVO commentvo);

	// 원공지글에 해당하는 댓글 조회하기
	List<Map<String, String>> getCommentList(String fk_notino);
	
	// 원 공지글에 대한 댓글  수정하기 (fk_serderno 만 가능하도록 하기)
	int showEditComment(Map<String, String> paraMap);
	
	// 댓글 삭제
	int delComment(Map<String, String> paraMap);
	
	// 부서 공지 댓글 수정하기
	int showEditDepComment(Map<String, String> paraMap);
	
	// 총 게시물 건수 (total Count) 
	int getTotalCount(Map<String, String> paraMap);
	
	// 전체 공지 첨부파일 조회
	List<NoticeVO> getFileList(String notino);
	
	
	
	
	//////////////////// 부서 /////////////////////
	// 부서의 해당 공지 리스트 보여주기
	List<Map<String, String>> depNoticeList(Map<String, String> paraMap);

	// 부서 공지리스트 공지 1개 내용 조회하기(ajax)
	Map<String, String> showDeptNoticeContent(String notino);

	// 공지 수정을 위해 해당 공지번호 글  가져오기
	NoticeVO showEditDepNoticeContent(String notino);

	// 부서 공지글 1개 삭제  요청
	int delDepNoticeEnd(Map<String, String> paraMap);

	// 부서 공지 댓글 작성하기
	int addDepComment(CommentVO commentvo);
	
	// 원공지글에 해당하는 댓글 조회하기
	List<Map<String, String>> getDepCommentList(String fk_notino);

	// 댓글 삭제
	int delDepComment(Map<String, String> paraMap);

	// 부서 공지 총게시물수
	int getDepTotalCount(Map<String, String> paraMap);
		
	// 첨부파일 조회하기
	List<NoticeVO> getDepFile(String notino);

		
		
		
	
	
	//////////////////// 내가 쓴 공지 /////////////////////
	// 내가 쓴 공지 리스트 가져오기
	List<Map<String, String>> getMyNoticeList(String empno);

	// 내가 쓴 공지사항 공지글 1개 보여주기(ajax)
	Map<String, String> showMyNoticeContent(String notino);

	// 내가 쓴 공지리스트 수정
	NoticeVO showEditMyNoticeContent(String notino);

	// 내가 쓴 공지글 1개 삭제  요청
	int delMyNoticeEnd(Map<String, String> paraMap);

	// 내가 쓴 공지 댓글 쓰기
	int addMyComment(CommentVO commentvo);

	// 내가 쓴 공지 댓글 조회
	List<Map<String, String>> getMyCommentList(String fk_notino);

	// 댓글 수정
	int showEditMyComment(Map<String, String> paraMap);

	// 댓글 삭제
	int delMyComment(Map<String, String> paraMap);

	// 총 게시물 건수 (total Count) 
	int getMyTotalCount(Map<String, String> paraMap);

	// 페이징 처리한 공지 리스트
	List<Map<String, String>> getMyNoticeList(Map<String, String> paraMap);

	// 첨부파일 조회
	List<NoticeVO> getMyFile(String notino);

	////////////////////
	// 첨부파일 없는 글쓰기
	void sendNotice_noFile(NoticeVO noticevo);


	// 첨부파일 있는 글쓰기
	void sendMotice_withFile(NoticeVO noticevo);



	




	

	


	

	

}
