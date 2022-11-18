package com.yolo.hr.jinji.adminLeave.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AdminLeaveController {

	// 관리자 내휴가 휴가 개요
	@RequestMapping(value="jinji/leaveSummary.yolo") 
    public ModelAndView leaveSummary(ModelAndView mav) {
		
        mav.setViewName("/jinji/leaveSummary.admin"); // 뷰단 페이지
        // /WEB-INF/views/admin/{1}/{2}.jsp
        // http://localhost:9090/hr/jinji/leaveSummary.yolo
        
        return mav;
    }
	
	
	// 관리자 내휴가 연차 상세 
	@RequestMapping(value="jinji/leaveDetail.yolo") 
    public ModelAndView leaveDetail(ModelAndView mav) {
		
        mav.setViewName("/jinji/leaveDetail.admin"); // 뷰단 페이지
        // /WEB-INF/views/admin/{1}/{2}.jsp
        // http://localhost:9090/hr/jinji/leaveDetail.yolo
        
        return mav;
    }
	
	// 관리자 구성원 휴가 보유 현황
	@RequestMapping(value="jinji/empLeaveStatus.yolo") 
    public ModelAndView empLeaveStatus(ModelAndView mav) {
		
        mav.setViewName("/jinji/empLeaveStatus.admin"); // 뷰단 페이지
        // /WEB-INF/views/admin/{1}/{2}.jsp
        // http://localhost:9090/hr/jinji/empLeaveStatus.yolo
        
        return mav;
    }
	
	// 관리자 구성원 휴가 사용 내역
	@RequestMapping(value="jinji/empLeaveUsingList.yolo") 
    public ModelAndView empLeaveUsingList(ModelAndView mav) {
		
        mav.setViewName("/jinji/empLeaveUsingList.admin"); // 뷰단 페이지
        // /WEB-INF/views/admin/{1}/{2}.jsp
        // http://localhost:9090/hr/jinji/empLeaveUsingList.yolo
        
        return mav;
    }
	
	// 관리자 구성원 연차 촉진 	
	@RequestMapping(value="jinji/empLeavePromotion.yolo") 
    public ModelAndView empLeavePromotion(ModelAndView mav) {
		
        mav.setViewName("/jinji/empLeavePromotion.admin"); // 뷰단 페이지
        // /WEB-INF/views/admin/{1}/{2}.jsp
        // http://localhost:9090/hr/jinji/empLeavePromotion.yolo
        
        return mav;
    }
	
	
}
