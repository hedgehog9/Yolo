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

	// 부서사람들 조회하기
	@Override
	public List<Map<String, String>> getDeptPersonList(String deptno) {
		List<Map<String, String>> deptPersonList = dao.getDeptPersonList(deptno);
		return deptPersonList;
	}

	// 해당부서 팀 구해오기
	@Override
	public List<Map<String, String>> getTeam(String deptno) {
		List<Map<String, String>> teamList = dao.getTeam(deptno);
		return teamList;
	}

	// 팀 사람들 구해오기
	@Override
	public List<Map<String, String>> getTeamPerson(String deptno) {
		List<Map<String, String>> teamPersonList = dao.getTeamPerson(deptno);
		return teamPersonList;
	}


	// 체크된 유저 목록 가져오기
	@Override
	public List<Map<String, String>> getChooseEmp(String str_empno) {
		List<Map<String, String>>  empList = dao.getChooseEmp(str_empno);
		return empList;
		
	}
	
	// 공지글 작성하기
	@Override
	public void sendNotice(NoticeVO noticevo) {
		
		String str_fk_recipientno = noticevo.getFk_recipientno();
		String[] arr_fk_recipientno = str_fk_recipientno.split(",");
		
		StringBuilder sb = new StringBuilder();
		sb.append(" INSERT ALL ");

		
		String startLine = " into tbl_notice(notino, fk_senderno, fk_recipientno, subject, content ) values (";
		String endLine = ", '" + noticevo.getSubject() + "', '" + noticevo.getContent() + "') ";
		
		for( int i=0; i<arr_fk_recipientno.length; i++) {
			sb.append(startLine);
			sb.append( noticevo.getFk_senderno() +", " +arr_fk_recipientno[i] );
			sb.append(endLine);
		}
		
		sb.append(" SELECT * FROM DUAL ");
		
		//System.out.println(sql));
		dao.sendNotice(sb.toString());
		
	}
		
	///////////////////////
	// 전체 공지 리스트 보여주기


	// 내가 쓴 공지리스트 가져오기
	@Override
	public List<Map<String, String>> getSentNoticeList(String empno) {
		List<Map<String, String>> sentNoticeList = dao.getSentNoticeList(empno);
		return sentNoticeList;
	}

	

	
	

}
