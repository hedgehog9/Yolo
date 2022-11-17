package com.yolo.hr.josh.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yolo.hr.josh.model.MemberVO;
import com.yolo.hr.josh.service.InterScheduleService;

@Controller
public class ScheduleController {

	@Autowired
	private InterScheduleService service;
	
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
}
