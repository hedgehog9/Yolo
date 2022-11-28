package com.yolo.hr.josh.controller;

import java.text.SimpleDateFormat;
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

import com.yolo.hr.josh.model.CommuteVO;
import com.yolo.hr.josh.model.MemberVO;
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
			jsonObj.put("worktime", commutevo.getWorktime());
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
	
	@RequestMapping(value="/commute/mycommute.yolo", method = {RequestMethod.GET})
	public String myschedule(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginuser");
		String empno = mvo.getEmpno();
		
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		
		if(startdate == null && enddate == null) { // 처음으로 페이지 진입시
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			
			Calendar cal = Calendar.getInstance();
			
			//일주일의 첫날 선택
	        cal.setFirstDayOfWeek(Calendar.MONDAY);
	 
	        //해당 주차 시작일과의 차이 구하기용
	        int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK) - cal.getFirstDayOfWeek();
	 
	        //해당 주차의 첫날 세팅
	        cal.add(Calendar.DAY_OF_MONTH, - dayOfWeek);
	        
	        //해당 주차의 첫일자
	        startdate = format.format(cal.getTime());
	 
	        //해당 주차의 마지막 세팅
	        cal.add(Calendar.DAY_OF_MONTH, 4); 
	 
	        //해당 주차의 마지막일자
	        enddate = format.format(cal.getTime());
	        
			/*
			 * System.out.println("stDt => "+startdate);
			 * System.out.println("edDt => "+enddate);
			 */
	        
		}
		
		Map<String, String> paraMap = new HashMap<>();
        
        paraMap.put("startdate",startdate);
        paraMap.put("enddate",enddate);
        paraMap.put("fk_empno",empno);
        
        List<CommuteVO> commuteList = service.mycommute(paraMap);
		
        request.setAttribute("commuteList", commuteList);
        
		return "josh/mycommute.admin";
	}
	
	
	@ResponseBody
	@RequestMapping(value="/commute/ajaxMycommute.yolo", produces="text/plain;charset=UTF-8", method = {RequestMethod.GET})
	public String ajaxMycommute(HttpServletRequest request) {
		
		String fk_empno = request.getParameter("fk_empno");
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		
		Map<String,String> paraMap = new HashMap<>();
		
		paraMap.put("startdate",startdate);
        paraMap.put("enddate",enddate);
        paraMap.put("fk_empno",fk_empno);
		
        List<CommuteVO> commuteList = service.mycommute(paraMap);
		
        JSONArray jsonArr = new JSONArray();
        
        if(commuteList != null) {
        		
        		for(CommuteVO commutevo : commuteList) {
        			JSONObject jsonObj = new JSONObject();
        			
        			jsonObj.put("dt", commutevo.getDt());
        			jsonObj.put("commuteno", commutevo.getCommuteno());
        			jsonObj.put("start_work_time", commutevo.getStart_work_time());
        			jsonObj.put("end_work_time", commutevo.getEnd_work_time());
        			jsonObj.put("worktime", commutevo.getWorktime());
        			jsonObj.put("overtime", commutevo.getOvertime());
        			
        			jsonArr.put(jsonObj);
        		}
        	
        }
		
		return jsonArr.toString();
	}
		
}
