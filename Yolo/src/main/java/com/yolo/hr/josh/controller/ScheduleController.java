package com.yolo.hr.josh.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yolo.hr.jjy.employee.model.EmployeeVO;
import com.yolo.hr.josh.model.MemberVO;
import com.yolo.hr.josh.model.ScheduleVO;
import com.yolo.hr.josh.service.InterScheduleService;

@Controller
public class ScheduleController {

	@Autowired
	private InterScheduleService service;
	
	@RequestMapping(value="/schedule/calendar.yolo")
	public String calendar(HttpServletRequest request) {
		
		
		return "josh/calendar.admin";
	}
	
	@ResponseBody
	@RequestMapping(value="/schedule/insertSchedule/searchJoinUserList.yolo", produces="text/plain;charset=UTF-8") 
	public String searchJoinUserList(HttpServletRequest request) {
		
		String joinuser = request.getParameter("joinuser");
		
		// System.out.println("확인용 joinuser" + joinuser);
		
		// 공유자 검색시 자동검색이 되는 기능
		List<MemberVO> searchJoinUserList = service.searchJoinUserList(joinuser);
		
		JSONArray jsonArr = new JSONArray();
		
		if(searchJoinUserList != null) {
			for(MemberVO mvo:searchJoinUserList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("name", mvo.getName());
				jsonObj.put("email", mvo.getEmail());
				jsonObj.put("empno", mvo.getEmpno());
				
				jsonArr.put(jsonObj);
			}
		}
		
		
		return jsonArr.toString();
	}
	
	// 켈린더에 일정을 등록하는 메소드
	@ResponseBody
	@RequestMapping(value="/schedule/insertSchedule.yolo", produces="text/plain;charset=UTF-8", method = {RequestMethod.POST})
	public String addAlarm_insertSchedule(Map<String, String> paraMap, HttpServletRequest request, ScheduleVO scvo) {
		
		String category = scvo.getCategory();
		
		HttpSession session = request.getSession();
		EmployeeVO empvo = (EmployeeVO) session.getAttribute("loginuser");
		String name = empvo.getName();
		
		String joinuser_empno = request.getParameter("joinuser_empno");
		
			System.out.println("확인용 공유자들" + scvo.getJoinuser());
		
		switch (category) { // 카테고리에 따라 색상 주기
		case "회의":
			scvo.setColor("#6666ff"); // 파란색
			break;

		case "미팅":
			scvo.setColor("#ffd699"); // 주황색	
			break;
		case "출장":
			scvo.setColor("#bfbfbf");	// 회색
			break;
		}
		
		int n = service.insertSchedule(scvo);
		
		System.out.println("확인용 => " + joinuser_empno);
		
		if(n > 0) {
			paraMap.put("fk_recipientno", joinuser_empno ); // 받는사람 (여러명일때는 ,으로 구분된 str)
		    paraMap.put("url", "/schedule/" );
		    paraMap.put("url2", "calendar.yolo" ); // 연결되는 pknum등...  (여러개일때는 ,으로 구분된 str)(대신 받는 사람 수랑 같아야됨)
		    paraMap.put("alarm_content", name+"님이 일정을 공유하였습니다." );
		    paraMap.put("alarm_type", "5" );
		}
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	// 켈린더에 일정을 수정하는 메소드
	@ResponseBody
	@RequestMapping(value="/schedule/updateSchedule.yolo", produces="text/plain;charset=UTF-8", method = {RequestMethod.POST})
	public String addAlarm_updateSchedule(Map<String, String> paraMap, HttpServletRequest request, ScheduleVO scvo) {
		
		HttpSession session = request.getSession();
		EmployeeVO empvo = (EmployeeVO) session.getAttribute("loginuser");
		String name = empvo.getName();
		
		String category = scvo.getCategory();
		
		String joinuser_empno = request.getParameter("joinuser_empno");
		
		// System.out.println("확인용 공유자들" + scvo.getJoinuser());
		
		switch (category) { // 카테고리에 따라 색상 주기
		case "회의":
			scvo.setColor("#6666ff"); // 파란색
			break;

		case "미팅":
			scvo.setColor("#ffd699"); // 주황색	
			break;
		case "출장":
			scvo.setColor("#bfbfbf");	// 회색
			break;
		}
		
		//String schedule_no = scvo.getSchedule_no();
		//System.out.println("확인용 schedule_no => " + schedule_no);
		
		System.out.println("확인용 scvo.getJoinuser() => " + scvo.getJoinuser());
		System.out.println("joinuser_empno => " + joinuser_empno);
		
		int n = service.updateSchedule(scvo);
		
		if(n > 0) {
			paraMap.put("fk_recipientno", joinuser_empno ); // 받는사람 (여러명일때는 ,으로 구분된 str)
		    paraMap.put("url", "/schedule/" );
		    paraMap.put("url2", "calendar.yolo" ); // 연결되는 pknum등...  (여러개일때는 ,으로 구분된 str)(대신 받는 사람 수랑 같아야됨)
		    paraMap.put("alarm_content", name+"님이 일정을 공유하였습니다." );
		    paraMap.put("alarm_type", "5" );
		}
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// 캘린더를 삭제하는 메소드
	@ResponseBody
	@RequestMapping(value="/schedule/deleteSchedule.yolo", produces="text/plain;charset=UTF-8", method = {RequestMethod.POST})
	public String deleteSchedule(HttpServletRequest request) {
		
		String schedule_no = request.getParameter("schedule_no");
		//System.out.println("확인용 schedule_no => " + schedule_no);
		
		int n = service.deleteSchedule(schedule_no);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	// 켈린더를 모두 가져오는 메소드
	@ResponseBody
	@RequestMapping(value="/schedule/selectScheduleList.yolo", produces="text/plain;charset=UTF-8")
	public String selectSchedule() {
		
		List<ScheduleVO> selectScheduleList = service.selectScheduleList();
		
		JSONArray jsonArr = new JSONArray();
		
		if(selectScheduleList != null) {
			
			for(ScheduleVO scvo : selectScheduleList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("schedule_no", scvo.getSchedule_no());
				jsonObj.put("fk_empno", scvo.getFk_empno());
				jsonObj.put("start_date", scvo.getStart_date());
				jsonObj.put("end_date", scvo.getEnd_date());
				jsonObj.put("subject", scvo.getSubject());
				jsonObj.put("content", scvo.getContent());
				jsonObj.put("color", scvo.getColor());
				jsonObj.put("category", scvo.getCategory());
				jsonObj.put("fk_deptno", scvo.getFk_deptno());
				jsonObj.put("joinuser", scvo.getJoinuser());
				jsonObj.put("place", scvo.getPlace());
				jsonObj.put("birthday", scvo.getBirthday());
				jsonObj.put("name", scvo.getName());
				
				jsonArr.put(jsonObj);
			}
			
		}
		
		return jsonArr.toString();
	}
	
	
	// 특정 하나 켈린더를 가져오는 메소드
	@ResponseBody
	@RequestMapping(value="/schedule/selectDetailSchedule.yolo", produces="text/plain;charset=UTF-8")
	public String selectDetailSchedule(HttpServletRequest request) {
		
		JSONObject jsonObj = new JSONObject();
		
		String schedule_no = request.getParameter("schedule_no");
		// System.out.println("확인용 : " + schedule_no);
		
		try {
			Integer.parseInt(schedule_no);
			
			ScheduleVO scvo = service.selectDetailSchedule(schedule_no);
			
			System.out.println(scvo.getFk_empno());
			
			jsonObj.put("schedule_no", scvo.getSchedule_no());
			jsonObj.put("fk_empno", scvo.getFk_empno());
			jsonObj.put("start_date", scvo.getStart_date());
			jsonObj.put("end_date", scvo.getEnd_date());
			jsonObj.put("subject", scvo.getSubject());
			jsonObj.put("content", scvo.getContent());
			jsonObj.put("color", scvo.getColor());
			jsonObj.put("category", scvo.getCategory());
			jsonObj.put("fk_deptno", scvo.getFk_deptno());
			jsonObj.put("joinuser", scvo.getJoinuser());
			jsonObj.put("place", scvo.getPlace());
			jsonObj.put("birthday", scvo.getBirthday());
			jsonObj.put("name", scvo.getName());
			
		} catch(NumberFormatException e) {
			e.printStackTrace();
			jsonObj.put("redirect", "true");
		}
		
		
		return jsonObj.toString();
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
