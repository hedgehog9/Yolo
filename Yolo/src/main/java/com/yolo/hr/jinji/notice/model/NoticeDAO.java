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
	
	// 체크된 부서 유저 목록 가져오기
	@Override
	public List<Map<String, String>> getChooseDept(String str_empno) {
		List<Map<String, String>> deptList  = sqlsession.selectList("jinmj.selectChooseEmp", str_empno);
		return deptList;
	}

	
	// 공지글 작성하기
	@Override
	public void getSenNotice(NoticeVO noticevo) {
		
		sqlsession.insert("jinmj.insertSendNotice", noticevo);		
		
	}

	
	// 전체 공지 리스트 전체 보여주기 (select)
	@Override
	public List<Map<String, String>> getAllNoticeList(String empno) {
		List<Map<String, String>> allNoticeList = sqlsession.selectList("jinmj.allNoticeList", empno);
		return allNoticeList;
	}
	//	List<Map<String, String>> allNoticeList = sqlsession.selectList("jinmj.allNoticeList", fk_deptno);

	
	// 전체 공지사항 공지글 1개 보여주기(ajax)
	@Override
	public Map<String, String> showNoticeContent(String notino) {
		Map<String, String> noticeContent = sqlsession.selectOne("jinmj.showNoticeContent", notino);
		return noticeContent;
	}

	// 공지 작성시 해당 공지 받는 사원 번호 알아오기
	@Override
	public List<String> getEmpnoList(String fk_deptno) {
		List<String> empnoList = sqlsession.selectList("jinmj.empnoList", fk_deptno);
		return empnoList;


	}

	// seq 최신 공지번호 알아오기
	@Override
	public String getSeqNotino(String empno) {
		String seqNotino =  sqlsession.selectOne("jinmj.seqNotino", empno);
		return seqNotino;
	}

	// 내가 쓴 공지리스트 가져오기
	@Override
	public List<Map<String, String>> getMyNoticeList(String empno) {
		List<Map<String, String>> myNoticeList =  sqlsession.selectList("jinmj.myNoticeList", empno);
		return myNoticeList;
	}

	
}
