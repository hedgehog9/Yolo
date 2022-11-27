package com.yolo.hr.josh.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yolo.hr.josh.model.CommuteVO;
import com.yolo.hr.josh.service.InterCommuteService;

@Controller
public class CommuteController {

	@Autowired
	private InterCommuteService service;
	
	// 출근 메소드
	@ResponseBody
	@RequestMapping(value="/commute/commuteStart.yolo", produces="text/plain;charset=UTF-8", method = {RequestMethod.POST})
	public String commuteStart(HttpServletRequest request) {
		
		String fk_empno = request.getParameter("fk_empno");
		
		int n = service.commuteStart(fk_empno);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	// 출근했는지 확인하는 메소드
	@ResponseBody
	@RequestMapping(value="/commute/checkCommute.yolo", produces="text/plain;charset=UTF-8", method = {RequestMethod.GET})
	public String checkCommute(HttpServletRequest request) {
		
		boolean isExist = false;
		
		JSONObject jsonObj = new JSONObject();
		
		String fk_empno = request.getParameter("fk_empno");
		
		CommuteVO commutevo = service.checkCommute(fk_empno);
		
		if(commutevo != null) {
			isExist = true;
			
			jsonObj.put("commuteno", commutevo.getCommuteno());
			jsonObj.put("fk_empno", commutevo.getFk_empno());
			jsonObj.put("start_work_time", commutevo.getStart_work_time());
			jsonObj.put("end_work_time", commutevo.getEnd_work_time());
			jsonObj.put("overtime", commutevo.getOvertime());
			jsonObj.put("work_kind", commutevo.getWork_kind());
		}
		
		jsonObj.put("isExist", isExist);
		
		
		return jsonObj.toString();
	}
	
	// 퇴근하기 버튼
	@ResponseBody
	@RequestMapping(value="/commute/commuteEnd.yolo", produces="text/plain;charset=UTF-8", method = {RequestMethod.POST})
	public String commuteEnd(HttpServletRequest request) {
		
		String fk_empno = request.getParameter("fk_empno");
		String worktime = request.getParameter("worktime");
		
		Map<String,String> paraMap = new HashMap<>();
		
		paraMap.put("fk_empno",fk_empno);
		paraMap.put("worktime",worktime);
		
		int n = service.commuteEnd(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
		
}
