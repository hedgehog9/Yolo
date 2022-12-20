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
	
	
	
	/////// 전체 공지////////
	// 전체 공지 리스트 보여주기
	// List<Map<String, String>> getAllNoticeList(String empno);
	// 페이징 처리한 공지 리스트 페이지
	List<Map<String, String>> getAllNoticeList(Map<String, String> paraMap);

	// 전체 공지사항 공지글 1개 보여주기(ajax)
	Map<String, String> showNoticeContent(String notino);
	
	// 공지글 수정을 위한 원래 공지글 조회하기
	Map<String, String> showEditNoticeContent(String notino);

	// 공지글 수정 완료 폼 요청
	int editNotice(NoticeVO noticevo);

	// 공지글 삭제 요청하기 (1개 조회)
	int delNoticeEnd(Map<String, String> paraMap);

	//댓글쓰기(tbl_comment 테이블에 insert)
	int addComment(CommentVO commentvo);

	//원게시물tbl_board의 commentCount 컬럼 1 증가 시키기(update)
	int updateCommentCount(String fk_notino);

	// 원공지글에 해당하는 댓글 조회하기
	List<Map<String, String>> getCommentList(String fk_notino);
	
	// 공지 작성시 해당 공지 받는 사원 번호 알아오기
	List<String> getEmpnoList(String fk_deptno);

	// seq 최신 공지번호 알아오기
	String getSeqNotino(String empno);
	
	// 댓글 수정
	int showEditComment(Map<String, String> paraMap);
	
	// 댓글 삭제
	int delComment(Map<String, String> paraMap);
	
	// 댓글 삭제 카운터
	void delCmtCount(Map<String, String> paraMap);
	
	// 총 게시물 건수(페이징바)
	int getTotalCount(Map<String, String> paraMap);
	
	// 첨부파일 조회하기
	List<NoticeVO> getFileList(String notino);
	
	
	
	
	
	
	///////  부서 공지 ////////
	// 부서의 해당 공지 리스트 보여주기
	List<Map<String, String>> depNoticeList(Map<String, String> paraMap);

	// 부서 공지리스트 공지 1개 내용 조회하기(ajax)
	Map<String, String> showDeptNoticeContent(String notino);
	
	// 부서 공지 수정을 위해 해당 공지번호 글 하나만 가져오기
	NoticeVO showEditDepNoticeContent(String notino);
	
	// 부서 공지글 1개 삭제  요청
	int delDepNoticeEnd(Map<String, String> paraMap);
	
	// 부서 공지 댓글 작성하기
	//댓글쓰기(tbl_comment 테이블에 insert)
	int addDepComment(CommentVO commentvo);
	//원게시물tbl_board의 commentCount 컬럼
	int updateDepCommentCount(String fk_notino);

	// 부서 공지 댓글 조회하기
	List<Map<String, String>> getDepCommentList(String fk_notino);
	
	// 부서 공지 댓글 수정하기
	int showEditDepComment(Map<String, String> paraMap);
	
	// 댓글 삭제
	int delDepComment(Map<String, String> paraMap);
	
	// 총 게시물 수
	int getDepTotalCount(Map<String, String> paraMap);

	// 첨부파일 조회하기
	List<NoticeVO> getDepFile(String notino);

	
	
	
	/////// 내가 쓴 공지 ////////
	// 내가 쓴 공지리스트 기져오기
	List<Map<String, String>> getMyNoticeList(String empno);

	// 내가 쓴 공지사항 공지글 1개 보여주기(ajax)
	Map<String, String> showMyNoticeContent(String notino);

	// 내가 쓴 공지리스트 수정
	NoticeVO showEditMyNoticeContent(String notino);

	// 내가 쓴 공지글 1개 삭제  요청
	int delMyNoticeEnd(Map<String, String> paraMap);

	// 내가 쓴 공지 댓글 쓰기
	//댓글쓰기(tbl_comment 테이블에 insert)
	int addMyComment(CommentVO commentvo);
	//원게시물tbl_board의 commentCount 컬럼
	int updateMyCommentCount(String fk_notino);

	// 내가 쓴 공지 댓글 조회
	List<Map<String, String>> getMyCommentList(String fk_notino);

	// 댓글 수정
	int showEditMyComment(Map<String, String> paraMap);

	// 댓글 삭제
	int delMyComment(Map<String, String> paraMap);

	// 총게시물수
	int getMyTotalCount(Map<String, String> paraMap);

	// 페이징 처리한 공지 리스트
	List<Map<String, String>> getMyNoticeList(Map<String, String> paraMap);

	// 첨부 파일 조회
	List<NoticeVO> getMyFile(String notino);

	// 첨부파일 없는 글쓰기
	void sendNotice_noFile(NoticeVO noticevo);

	// 첨부파일 있는 글쓰기
	void sendMotice_withFile(NoticeVO noticevo);

	






		
}
