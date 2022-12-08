package com.yolo.hr.jihyunService;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yolo.hr.jihyunModel.FileVO;
import com.yolo.hr.jihyunModel.InterMessengerDAO;
import com.yolo.hr.jihyunModel.MessengerVO;

@Service
public class MessengerSevice implements InterMessengerService {

	@Autowired
	private InterMessengerDAO mdao;

	
	// 전체 부서 조회하기
	@Override
	public List<Map<String, String>> getDeptList() {
		List<Map<String, String>> deptList = mdao.getDeptList();
		return deptList;
	}

	// 부서사람들 조회하기
	@Override
	public List<Map<String, String>> getDeptPersonList(Map<String, String> paraMap) {
		List<Map<String, String>> deptPersonList = mdao.getDeptPersonList(paraMap);
		return deptPersonList;
	}

	// 해당부서 팀 구해오기
	@Override
	public List<Map<String, String>> getTeam(String deptno) {
		List<Map<String, String>> teamList = mdao.getTeam(deptno);
		return teamList;
	}

	// 팀 사람들 구해오기
	@Override
	public List<Map<String, String>> getTeamPerson(Map<String, String> paraMap) {
		List<Map<String, String>> teamPersonList = mdao.getTeamPerson(paraMap);
		return teamPersonList;
	}

	// 선택한 유저 목록 가져오기
	@Override
	public List<Map<String, String>> getChooseEmp(String str_empno) {
		List<Map<String, String>>  empList = mdao.getChooseEmp(str_empno);
		return empList;
	}

	// 메신저 보내기
	@Override
	public String sendMessenger(MessengerVO msgvo) {
		
		Calendar currentDate = Calendar.getInstance();
		SimpleDateFormat dateft = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		
		String time = dateft.format(currentDate.getTime());

		String str_fk_recipientno = msgvo.getFk_recipientno();
		String[] arr_fk_recipientno = str_fk_recipientno.split(",");
		
		StringBuilder sb = new StringBuilder();
		sb.append(" INSERT ALL ");
		
		if(msgvo.getOrigin_msgno()=="" || msgvo.getOrigin_msgno()==null) {
			msgvo.setOrigin_msgno("null");
		}
		
		String startLine = " into tbl_messenger(group_msgno, having_attach, pk_msgno, fk_senderno, fk_recipientno, origin_msgno, subject, content ) values ("+time+", "+msgvo.getHaving_attach()+", ";
		String endLine = ", '" + msgvo.getOrigin_msgno() + "', '" + msgvo.getSubject() + "', '" + msgvo.getContent() + "') ";
		
		for( int i=0; i<arr_fk_recipientno.length; i++) {
			sb.append(startLine);
			sb.append( time+i +" , "+ msgvo.getFk_senderno() +", " +arr_fk_recipientno[i] );
			sb.append(endLine);
		}
		
		sb.append(" SELECT * FROM DUAL ");
		
		//System.out.println(sql));
		mdao.sendMessenger(sb.toString()); 
		
		return time;
	}

	
	// 보낸 메일 리스트 가져오기
	@Override
	public List<Map<String, String>> getSentMsgList(Map<String, String> paraMap) {
		List<Map<String, String>>  sentMsgList = mdao.getSentMsgList(paraMap);
		return sentMsgList;
	}

	
	// 받은 메일 리스트 가져오기
	@Override
	public List<Map<String, String>> getReceivedMsgList(Map<String, String> paraMap) {
		List<Map<String, String>>  receivedMsgList = mdao.getReceivedMsgList(paraMap);
		return receivedMsgList;
	}

	
	// 메신저 내용 조회하기 (보낸 메신저)
	@Override
	public Map<String, String> getMailContent(String msgno) {
		Map<String, String> mailContent = mdao.getMailContent(msgno);
		return mailContent;
	}
	
	
	// 메신저 내용 조회하기 (받은 메신저)
	@Override
	public Map<String, String> getMailContent2(String msgno) {
		Map<String, String> mailContent = mdao.getMailContent2(msgno);
		return mailContent;
	}

	
	// 메신저 조회수 업데이트 하기
	@Override
	public void updateViewStatus(String msgno) {
		mdao.updateViewStatus(msgno); 
	}

	
	// 모든 안읽은 메신저 읽기
	@Override
	public void updateAllMsgStatus(String empno) {
		mdao.updateAllMsgStatus(empno); 
	}

	
	// 메신저의 첨부파일 추가하기
	@Override
	public void addFile(FileVO filevo) {
		mdao.addFile(filevo);
	}

	
	// 메신저의 첨부파일에 원본 메신저 번호 저장하기
	@Override
	public void updateMsgno(Map<String, String> paraMap) {
		mdao.updateMsgno(paraMap);
	}

	
	// 조회한 메신저에 첨부파일이 있다면 조회하기
	@Override
	public List<FileVO> getMsgFileList(String group_msgno) {
		List<FileVO> msgFileList = mdao.getMsgFileList(group_msgno);
		return msgFileList;
	}

	
	// 전달할 메신저 상세사항 얻어오기
	@Override
	public MessengerVO getDeliverMsg(String msgno) {
		MessengerVO msgvo = mdao.getDeliverMsg(msgno);
		return msgvo;
	}

	
	// 메신저 전달하기
	@Override
	public void deleverMessenger(MessengerVO deliverMsgvo, MessengerVO msgvo) {
		Calendar currentDate = Calendar.getInstance();
		SimpleDateFormat dateft = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		
		String time = dateft.format(currentDate.getTime());
		
		String str_fk_recipientno = msgvo.getFk_recipientno();
		String[] arr_fk_recipientno = str_fk_recipientno.split(",");
		
		StringBuilder sb = new StringBuilder();
		sb.append(" INSERT ALL ");
		
		String startLine = " into tbl_messenger(group_msgno, having_attach, pk_msgno, fk_senderno, fk_recipientno, origin_msgno, subject, content ) values ("+deliverMsgvo.getGroup_msgno()+", "+deliverMsgvo.getHaving_attach()+", ";
		String endLine = ", null , '" + msgvo.getSubject() + "', '" + msgvo.getContent() + "') ";
		
		for( int i=0; i<arr_fk_recipientno.length; i++) {
			sb.append(startLine);
			sb.append( time+i +" , "+ msgvo.getFk_senderno() +", " +arr_fk_recipientno[i] );
			sb.append(endLine);
		}
		
		sb.append(" SELECT * FROM DUAL ");
		
		//System.out.println(sql));
		mdao.sendMessenger(sb.toString()); 
		
	}

	
	// 총 게시물 건 수 알아오기 (페이지네이션 용 - 보낸)
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int totalCount = mdao.getTotalCount(paraMap);
		return totalCount;
	}
	
	
	// 총 게시물 건 수 알아오기 (페이지네이션 용 - 받은)
	@Override
	public int getTotalCount2(Map<String, String> paraMap) {
		int totalCount = mdao.getTotalCount2(paraMap);
		return totalCount;
	}

	
	// 메세지 발송을 위해 사람이름 알아오기
	@Override
	public String getEmpName(String empno) {
		String name = mdao.getEmpName(empno);
		return name;
	}

}
