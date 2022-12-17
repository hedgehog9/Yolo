package com.yolo.hr.jihyunController;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.yolo.hr.jihyunService.InterLeaveService;
import com.yolo.hr.jjy.employee.model.EmployeeVO;

@Controller
public class LeaveController {
	
	@Autowired
	private InterLeaveService service;

	// 관리자 내휴가 휴가 개요
	@RequestMapping(value="/leaveSummary.yolo") 
    public ModelAndView leaveSummary(HttpServletRequest request, ModelAndView mav) {
		
		// 가라 사원
		EmployeeVO loginuser = new EmployeeVO();
		loginuser.setEmpno("1050");
		// 가라 사원 끝
		
		Calendar currentDate = Calendar.getInstance();
		SimpleDateFormat dateft = new SimpleDateFormat("yyyy");
		
		String year = dateft.format(currentDate.getTime());
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("empno", loginuser.getEmpno());
		paraMap.put("year", year);
		
		List<Map<String, String>> leaveTypeList = service.getLeaveTypeList(paraMap); // 휴가 종류와 남은 일수 구해오기
		mav.addObject("leaveTypeList", leaveTypeList);
		
		
		mav.setViewName("jihyun/leave/leaveSummary.admin");
		
        return mav;
    }
	
	
	// 모달을 띄우기 위해서 해당 휴가에 대한 정보를 얻어온다
	@ResponseBody
	@RequestMapping(value = "/leave/getLeaveDate.yolo" , produces="text/plain;charset=UTF-8")
	public String getLeaveDate(HttpServletRequest request) {
		
		// 가라 사원
		EmployeeVO loginuser = new EmployeeVO();
		loginuser.setEmpno("1050");
		// 가라 사원 끝
		
		String pk_leave_type = request.getParameter("pk_leave_type");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("empno", loginuser.getEmpno());
		paraMap.put("pk_leave_type", pk_leave_type);
		
		Map<String, String> leaveData = service.getLeaveDate(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("pk_leave_type", leaveData.get("pk_leave_type"));
		jsonObj.put("leave_name", leaveData.get("leave_name"));
		jsonObj.put("limit_info", leaveData.get("limit_info"));
		jsonObj.put("add_file", leaveData.get("add_file"));
		jsonObj.put("emoji", leaveData.get("emoji"));
		jsonObj.put("limit_days", leaveData.get("limit_days"));
		jsonObj.put("remaining_leave", leaveData.get("remaining_leave"));
		jsonObj.put("info1", leaveData.get("info1"));
		jsonObj.put("info2", leaveData.get("info2"));
		jsonObj.put("info3", leaveData.get("info3"));
		
		return jsonObj.toString();
		
	}
	

	// 관리자 구성원 휴가 보유 현황
	@RequestMapping(value="/empLeaveStatus.yolo") 
    public String empLeaveStatus() {
		
        return "jihyun/leave/empLeaveStatus.admin"; // 뷰단 페이지
    }
	
	// 관리자 구성원 휴가 사용 내역
	@RequestMapping(value="/empLeaveUsingList.yolo") 
    public String empLeaveUsingList() {
		
        return "jihyun/leave/empLeaveUsingList.admin"; // 뷰단 페이지
    }
}
