package com.yolo.hr.jihyunController;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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
