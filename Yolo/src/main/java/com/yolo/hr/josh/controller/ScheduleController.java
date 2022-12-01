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
				
				jsonArr.put(jsonObj);
			}
		}
		
		
		return jsonArr.toString();
	}
	
	// 켈린더에 일정을 등록하는 메소드
	@ResponseBody
	@RequestMapping(value="/schedule/insertSchedule.yolo", produces="text/plain;charset=UTF-8", method = {RequestMethod.POST})
	public String insertSchedule(HttpServletRequest request, ScheduleVO scvo) {
		
		String category = scvo.getCategory();
		
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
		
		int n = service.insertSchedule(scvo);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	// 켈린더에 일정을 수정하는 메소드
	@ResponseBody
	@RequestMapping(value="/schedule/updateSchedule.yolo", produces="text/plain;charset=UTF-8", method = {RequestMethod.POST})
	public String updateSchedule(HttpServletRequest request, ScheduleVO scvo) {
		
		String category = scvo.getCategory();
		
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
		
		int n = service.updateSchedule(scvo);
		
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
			
		} catch(NumberFormatException e) {
			e.printStackTrace();
			jsonObj.put("redirect", "true");
		}
		
		
		return jsonObj.toString();
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
