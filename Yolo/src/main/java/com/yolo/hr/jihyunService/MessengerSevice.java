package com.yolo.hr.jihyunService;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public void sendMessenger(MessengerVO msgvo) {
		
		Calendar currentDate = Calendar.getInstance();
		SimpleDateFormat dateft = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		
		String time = dateft.format(currentDate.getTime());

		String str_fk_recipientno = msgvo.getFk_recipientno();
		String[] arr_fk_recipientno = str_fk_recipientno.split(",");
		
		StringBuilder sb = new StringBuilder();
		sb.append(" INSERT ALL ");
		
		if(msgvo.getOrigin_msgno()=="") {
			msgvo.setOrigin_msgno("null");
		}
		
		String startLine = " into tbl_messenger(pk_msgno, fk_senderno, fk_recipientno, origin_msgno, subject, content ) values (";
		String endLine = ", " + msgvo.getOrigin_msgno() + ", '" + msgvo.getSubject() + "', '" + msgvo.getContent() + "') ";
		
		for( int i=0; i<arr_fk_recipientno.length; i++) {
			sb.append(startLine);
			sb.append( time+i +" , "+ msgvo.getFk_senderno() +", " +arr_fk_recipientno[i] );
			sb.append(endLine);
		}
		
		sb.append(" SELECT * FROM DUAL ");
		
		//System.out.println(sql));
		mdao.sendMessenger(sb.toString()); 
	}

	
	// 보낸 메일 리스트 가져오기
	@Override
	public List<Map<String, String>> getSentMsgList(String empno) {
		List<Map<String, String>>  sentMsgList = mdao.getSentMsgList(empno);
		return sentMsgList;
	}
}
