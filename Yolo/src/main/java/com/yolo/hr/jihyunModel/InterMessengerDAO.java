package com.yolo.hr.jihyunModel;

import java.util.List;
import java.util.Map;

public interface InterMessengerDAO {

	// 전체 부서 조회하기
	List<Map<String, String>> getDeptList();

	// 부서사람들 조회하기
	List<Map<String, String>> getDeptPersonList(Map<String, String> paraMap);

	// 해당부서 팀 구해오기
	List<Map<String, String>> getTeam(String deptno);

	// 팀 사람들 구해오기
	List<Map<String, String>> getTeamPerson(Map<String, String> paraMap);

	// 선택한 유저 목록 가져오기
	List<Map<String, String>> getChooseEmp(String str_empno);

	// 메신저 보내기
	void sendMessenger(String sql);

	// 보낸 메일 리스트 가져오기
	List<Map<String, String>> getSentMsgList(Map<String, String> paraMap);

	// 받은 메일 리스트 가져오기
	List<Map<String, String>> getReceivedMsgList(Map<String, String> paraMap);

	// 메신저 내용 조회하기 (보낸 메신저)
	Map<String, String> getMailContent(String msgno);
	
	// 메신저 내용 조회하기 (받은 메신저)
	Map<String, String> getMailContent2(String msgno);

	// 메신저 조회수 변경하기
	void updateViewStatus(String msgno);

	// 모든 안읽은 메신저 읽기
	void updateAllMsgStatus(String empno);

	// 메신저의 첨부파일 추가하기
	void addFile(FileVO filevo);

	// 메신저의 첨부파일에 원본 메신저 번호 저장하기
	void updateMsgno(Map<String, String> paraMap);

	// 조회한 메신저에 첨부파일이 있다면 조회하기
	List<FileVO> getMsgFileList(String group_msgno);

	// 전달할 메신저 상세사항 얻어오기
	MessengerVO getDeliverMsg(String msgno);

	// 총 게시물 건 수 알아오기 (페이지네이션 용 - 보낸)
	int getTotalCount(Map<String, String> paraMap);
	
	// 총 게시물 건 수 알아오기 (페이지네이션 용 - 받은)
	int getTotalCount2(Map<String, String> paraMap);

	// 메세지 발송을 위해 사람이름 알아오기
	String getEmpName(String empno);

	// 안 읽은 메신저 개수 알아오기
	String getUnreadMsgCnt(String empno);

}
