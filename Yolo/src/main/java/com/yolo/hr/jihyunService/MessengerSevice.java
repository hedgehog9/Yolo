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
	public List<Map<String, String>> getDeptPersonList(String deptno) {
		List<Map<String, String>> deptPersonList = mdao.getDeptPersonList(deptno);
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
	public List<Map<String, String>> getTeamPerson(String deptno) {
		List<Map<String, String>> teamPersonList = mdao.getTeamPerson(deptno);
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
	public List<Map<String, String>> getSentMsgList(String empno) {
		List<Map<String, String>>  sentMsgList = mdao.getSentMsgList(empno);
		return sentMsgList;
	}

	
	// 받은 메일 리스트 가져오기
	@Override
	public List<Map<String, String>> getReceivedMsgList(String empno) {
		List<Map<String, String>>  receivedMsgList = mdao.getReceivedMsgList(empno);
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

}
