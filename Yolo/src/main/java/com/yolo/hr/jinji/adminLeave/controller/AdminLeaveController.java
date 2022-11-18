package com.yolo.hr.jinji.adminLeave.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminLeaveController {

	// 관리자 내휴가 휴가 개요
	@RequestMapping(value="jinji/leaveSummary.yolo") 
    public String leaveSummary() {
		
        return "/jinji/leaveSummary.admin"; // 뷰단 페이지
        // /WEB-INF/views/admin/{1}/{2}.jsp
        // http://localhost:9090/hr/jinji/leaveSummary.yolo
        
    }
	
	
	// 관리자 내휴가 연차 상세 
	@RequestMapping(value="jinji/leaveDetail.yolo") 
    public String leaveDetail() {
		
        return "/jinji/leaveDetail.admin";
        // http://localhost:9090/hr/jinji/leaveDetail.yolo
    }
	
	
	// 관리자 구성원 휴가 보유 현황
	@RequestMapping(value="jinji/empLeaveStatus.yolo") 
    public String empLeaveStatus() {
		
        return "/jinji/empLeaveStatus.admin"; // 뷰단 페이지
        // http://localhost:9090/hr/jinji/empLeaveStatus.yolo
    }
	
	// 관리자 구성원 휴가 사용 내역
	@RequestMapping(value="jinji/empLeaveUsingList.yolo") 
    public String empLeaveUsingList() {
		
        return "/jinji/empLeaveUsingList.admin"; // 뷰단 페이지
        // http://localhost:9090/hr/jinji/empLeaveUsingList.yolo
    }
	
	// 관리자 구성원 연차 촉진 	
	@RequestMapping(value="jinji/empLeavePromotion.yolo") 
    public String empLeavePromotion() {
		
        return "/jinji/empLeavePromotion.admin";
        // http://localhost:9090/hr/jinji/empLeavePromotion.yolo
    }
	
	
}
