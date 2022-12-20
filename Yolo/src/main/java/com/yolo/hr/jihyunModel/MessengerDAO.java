package com.yolo.hr.jihyunModel;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.yolo.hr.jjy.employee.model.EmployeeVO;

@Repository
public class MessengerDAO implements InterMessengerDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession;

	
	// 전체부서 조회하기
	@Override
	public List<Map<String, String>> getDeptList() {
		String deptno = "1";
		List<Map<String, String>> deptList = sqlsession.selectList("kimjh.selectDept", deptno);
		return deptList;
	}


	// 해당부서 사람들 구하기
	/*
	 * @Override public List<Map<String, String>> getDeptPeople(String deptno) {
	 * List<Map<String, String>> deptPeople =
	 * sqlsession.selectList("kimjh.selectDeptPeople", deptno); return deptPeople; }
	 */

	// 부서사람들 조회하기
	@Override
	public List<Map<String, String>> getDeptPersonList(Map<String, String> paraMap) {
		List<Map<String, String>> deptPersonList = sqlsession.selectList("kimjh.selectDeptPerson", paraMap);
		return deptPersonList;
	}

	// 해당부서 팀 구해오기
	@Override
	public List<Map<String, String>> getTeam(String deptno) {
		List<Map<String, String>> teamList = sqlsession.selectList("kimjh.selectDept", deptno);
		return teamList;
	}


	// 팀 사람들 구해오기
	@Override
	public List<Map<String, String>> getTeamPerson(Map<String, String> paraMap) {
		List<Map<String, String>> teamList = sqlsession.selectList("kimjh.selectDeptPerson", paraMap);
		return teamList;
	}


	// 선택한 유저 목록 가져오기
	@Override
	public List<Map<String, String>> getChooseEmp(String str_empno) {
		List<Map<String, String>> empList  = sqlsession.selectList("kimjh.selectChooseEmp", str_empno);
		return empList;
	}

	
	// 메신저 보내기
	@Override
	public void sendMessenger(String sql) {
		sqlsession.insert("kimjh.insertSendMessenger", sql);
	}


	// 보낸 메일 리스트 가져오기
	@Override
	public List<Map<String, String>> getSentMsgList(Map<String, String> paraMap) {
		List<Map<String, String>> sentMsgList  = sqlsession.selectList("kimjh.selectSentMsgList", paraMap);
		return sentMsgList;
	}


	// 받은 메일 리스트 가져오기
	@Override
	public List<Map<String, String>> getReceivedMsgList(Map<String, String> paraMap) {
		List<Map<String, String>> receivedMsgList  = sqlsession.selectList("kimjh.selectReceivedMsgList", paraMap);
		return receivedMsgList;
	}


	// 메신저 내용 조회하기 (보낸 메신저)
	@Override
	public Map<String, String> getMailContent(String msgno) {
		Map<String, String> mailContent = sqlsession.selectOne("kimjh.selectMailContent", msgno);
		return mailContent;
	}
	
	
	// 메신저 내용 조회하기  (받은 메신저)
	@Override
	public Map<String, String> getMailContent2(String msgno) {
		Map<String, String> mailContent = sqlsession.selectOne("kimjh.selectMailContent2", msgno);
		return mailContent;
	}


	// 메신저 조회수 변경하기
	@Override
	public void updateViewStatus(String msgno) {
		sqlsession.update("kimjh.updateViewStatus", msgno);
	}


	// 모든 안읽은 메신저 읽기
	@Override
	public void updateAllMsgStatus(String empno) {
		sqlsession.update("kimjh.updateAllMsgStatus", empno);
	}


	// 메신저의 첨부파일 추가하기
	@Override
	public void addFile(FileVO filevo) {
		sqlsession.insert("kimjh.insertMsgFile", filevo);
	}


	// 메신저의 첨부파일에 원본 메신저 번호 저장하기
	@Override
	public void updateMsgno(Map<String, String> paraMap) {
		sqlsession.update("kimjh.updateFileMsgno", paraMap);
	}


	// 조회한 메신저에 첨부파일이 있다면 조회하기
	@Override
	public List<FileVO> getMsgFileList(String group_msgno) {
		List<FileVO> msgFileList = sqlsession.selectList("kimjh.selectMsgFileList", group_msgno);
		return msgFileList;
	}


	// 전달할 메신저 상세사항 얻어오기
	@Override
	public MessengerVO getDeliverMsg(String msgno) {
		MessengerVO msgvo = sqlsession.selectOne("kimjh.selectDeliverMsg", msgno);
		return msgvo;
	}


	// 총 게시물 건 수 알아오기 (페이지네이션 용 - 보낸)
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int totalCount = sqlsession.selectOne("kimjh.getTotalCount", paraMap);
		return totalCount;
	} 
	
	
	// 총 게시물 건 수 알아오기 (페이지네이션 용 - 받은)
	@Override
	public int getTotalCount2(Map<String, String> paraMap) {
		int totalCount = sqlsession.selectOne("kimjh.getTotalCount2", paraMap);
		return totalCount;
	}


	// 메세지 발송을 위해 사람이름 알아오기
	@Override
	public String getEmpName(String empno) {
		String name = sqlsession.selectOne("kimjh.getEmpName", empno);
		return name;
	}


	// 안 읽은 메신저 개수 알아오기
	@Override
	public String getUnreadMsgCnt(String empno) {
		String n = sqlsession.selectOne("kimjh.getUnreadMsgCnt", empno);
		return n;
	} 

}
