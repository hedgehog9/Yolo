package com.yolo.hr.jihyunController;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yolo.hr.jihyunModel.AlarmVO;
import com.yolo.hr.jihyunService.InterAlarmService;
import com.yolo.hr.jjy.employee.model.EmployeeVO;

@Controller
public class AlarmController {

	@Autowired
	private InterAlarmService service;
	
	
	// 알람 조회하기
	@ResponseBody
	@RequestMapping(value = "/alarm/getAlarmList.yolo", produces="text/plain;charset=UTF-8")
	public String getDept(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		List<AlarmVO> alarmList = service.getAlarmList(loginuser.getEmpno());
		
		JSONArray jsonArr = new JSONArray();
		
		for(AlarmVO alarmvo: alarmList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("pk_alarmno", alarmvo.getPk_alarmno());
			jsonObj.put("url", alarmvo.getUrl());
			jsonObj.put("url2", alarmvo.getUrl2());
			jsonObj.put("alarm_content", alarmvo.getAlarm_content());
			jsonObj.put("alarm_type", alarmvo.getAlarm_type());
			jsonObj.put("writedate", alarmvo.getWritedate());
			
			jsonArr.put(jsonObj);
		}
		
		return jsonArr.toString() ;
	}
	
	
	
	// 알람 조회하기
	@ResponseBody
	@RequestMapping(value = "/alarm/getPastAlarmList.yolo", produces="text/plain;charset=UTF-8")
	public String getPastAlarmList(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		List<AlarmVO> alarmList = service.getPastAlarmList(loginuser.getEmpno());
		
		JSONArray jsonArr = new JSONArray();
		
		for(AlarmVO alarmvo: alarmList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("pk_alarmno", alarmvo.getPk_alarmno());
			jsonObj.put("url", alarmvo.getUrl());
			jsonObj.put("url2", alarmvo.getUrl2());
			jsonObj.put("alarm_content", alarmvo.getAlarm_content());
			jsonObj.put("alarm_type", alarmvo.getAlarm_type());
			jsonObj.put("writedate", alarmvo.getWritedate());
			
			jsonArr.put(jsonObj);
		}
		
		return jsonArr.toString() ;
	}
	
	
	
	// 알람 읽기
	@ResponseBody
	@RequestMapping(value = "/alarm/readAlarm.yolo",  method= {RequestMethod.POST} , produces="text/plain;charset=UTF-8")
	public void readAlarm(HttpServletRequest request) {
		
		String alarmno = request.getParameter("alarmno");
		service.readAlarm(alarmno);
		
	}
	
	
	// 모든 알람 읽기
	@ResponseBody
	@RequestMapping(value = "/alarm/readAllAlarm.yolo" , produces="text/plain;charset=UTF-8")
	public void readAllAlarm(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		service.readAllAlarm(loginuser.getEmpno());
		
	}
	
	
	// 안 읽은 소식 개수 알아오기
	@ResponseBody
	@RequestMapping(value = "/alarm/getUnreadAlarmCnt.yolo" , produces="text/plain;charset=UTF-8")
	public String getUnreadAlarmCnt(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		String n = service.getUnreadAlarmCnt(loginuser.getEmpno());
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
		
	}
	
}
