package com.yolo.hr.jinji.notice.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.yolo.hr.jinji.notice.model.CommentVO;
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
	
	
	

	//////////전체 공지///////////////////////
	// 전체 공지 리스트 보여주기
	@Override
	public List<Map<String, String>> showAllNoticeList(String empno) {
		List<Map<String, String>> allNoticeList = dao.getAllNoticeList(empno);
		return allNoticeList;
	}
	// List<Map<String, String>> allNoticeList = dao.getAllNoticeList(fk_deptno);
	

	// 전체 공지사항 공지글 1개 보여주기(ajax)
	@Override
	public Map<String, String> showNoticeContent(String notino) {
		 Map<String, String>  noticeContent = dao.showNoticeContent(notino);
		return noticeContent;
	}
	
	///////////// 공지 작성시 알림 ///////////
	// 공지 작성시 해당 공지 받는 사원 번호 알아오기
	@Override
	public List<String> getEmpnoList(String fk_deptno) {
		List<String> empnoList = dao.getEmpnoList(fk_deptno);
		return empnoList;
	}

	
	// seq 최신 공지번호 알아오기
	@Override
	public String getSeqNotino(String empno) {
		String seqNotino = dao.getSeqNotino(empno);
		return seqNotino;
	}

	///////////// 공지 작성시 알림  끝 ///////////
	
	
	// 공지글 수정을 위한 원래 공지글 조회하기
	@Override
	public Map<String, String> showEditNoticeContent(String notino) {
		Map<String, String> showEditNoticeContent = dao.showEditNoticeContent(notino);
		return showEditNoticeContent;
	}

	// 공지글 수정 완료 폼 요청하기
	@Override
	public int editNotice(NoticeVO noticevo) {
		int result = dao.editNotice(noticevo);
		return result;
	}


	
	// 전체 공지글 삭제 요청하기( 1개 조회)
	@Override
	public int delNoticeEnd(Map<String, String> paraMap) {
		int result = dao.delNoticeEnd(paraMap);
		return result;
	}

	// 전체 공지 댓글쓰기
	// tbl_comment 테이블에 insert 된 다음에 
    // tbl_board 테이블에 commentCount 컬럼이 1증가(update) 하도록 요청한다.
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int addComment(CommentVO commentvo) {
		
		int n = 0, m=0;
		
		//댓글쓰기(tbl_comment 테이블에 insert)
		n = dao.addComment(commentvo); 
	    // System.out.println("~~~ 댓글 확인용 n:"+ n);
	    
	    //원게시물tbl_board의 commentCount 컬럼
	    if(n==1) {
		    
	    	m = dao.updateCommentCount(commentvo.getFk_notino()); 
	        // System.out.println("~~~ 공지테이블 댓글수 확인용 m:"+ m);
	        //      확인용 m : 1       
	    }
	   
		return m;
	}

	// 전체 공지의 원글에 해당하는 댓글 조회하기
	@Override
	public List<Map<String, String>> getCommentList(String fk_notino) {
		List<Map<String, String>> getCommentList = dao.getCommentList(fk_notino);
		return getCommentList;
	}
	
	
	
	
	
	
	
	//////////부서 공지///////////////////////
	// 부서  공지 리스트 보여주기
	@Override
	public List<Map<String, String>> depNoticeList(String fk_deptno) {
		List<Map<String, String>> deptNoticeList = dao.depNoticeList(fk_deptno);
		return deptNoticeList;
	}

	
	// 부서 공지리스트 공지 1개 내용 조회하기(ajax)
	@Override
	public Map<String, String> showDeptNoticeContent(String notino) {
		Map<String, String> deptNoticeContent = dao.showDeptNoticeContent(notino);
		return deptNoticeContent;
	}
	
	// 부서 공지 수정을 위해 해당 공지번호 글 하나만 가져오기
	@Override
	public NoticeVO showEditDepNoticeContent(String notino) {
		NoticeVO showEditDepNoticeContent = dao.showEditDepNoticeContent(notino);
		return showEditDepNoticeContent;
	}
	
	// 부서 공지글 1개 삭제  요청
	@Override
	public int delDepNoticeEnd(Map<String, String> paraMap) {
		int result = dao.delDepNoticeEnd(paraMap);
		return result;
	}
	
	
	
	
	
	//////////내가 쓴 공지///////////////////////
	// 내가 쓴 공지리스트 가져오기
	@Override
	public List<Map<String, String>> getMyNoticeList(String empno) {
		List<Map<String, String>> myNoticeList = dao.getMyNoticeList(empno);
		return myNoticeList;
	}

	// 내가 쓴 공지사항 공지글 1개 보여주기(ajax)
	@Override
	public Map<String, String> showMyNoticeContent(String notino) {
		 Map<String, String> myNoticeContent = dao.showMyNoticeContent(notino);
		return myNoticeContent;
	}

	// 내가 쓴 공지리스트 수정
	@Override
	public NoticeVO showEditMyNoticeContent(String notino) {
		NoticeVO showEditMyNoticeContent = dao.showEditMyNoticeContent(notino); 
		return showEditMyNoticeContent;
	}

	// 내가 쓴 공지글 1개 삭제  요청
	@Override
	public int delMyNoticeEnd(Map<String, String> paraMap) {
		int result = dao.delMyNoticeEnd(paraMap);
		return result;
	}





	
	
}
