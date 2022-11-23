package com.yolo.hr.jinji.adminLeave.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminLeaveController {

	// 관리자 내휴가 휴가 개요
	@RequestMapping(value="leaveSummary.yolo") 
    public String leaveSummary() {
		
        return "/jinji/leaveSummary.admin"; // 뷰단 페이지
        // /WEB-INF/views/admin/{1}/{2}.jsp
        
    }
	
	// 관리자 내휴가 연차 상세 
	@RequestMapping(value="leaveDetail.yolo") 
    public String leaveDetail() {
		
        return "/jinji/leaveDetail.admin";
    }
	
	
	// 관리자 구성원 휴가 보유 현황
	@RequestMapping(value="empLeaveStatus.yolo") 
    public String empLeaveStatus() {
		
        return "/jinji/empLeaveStatus.admin"; // 뷰단 페이지
    }
	
	// 관리자 구성원 휴가 사용 내역
	@RequestMapping(value="empLeaveUsingList.yolo") 
    public String empLeaveUsingList() {
		
        return "/jinji/empLeaveUsingList.admin"; // 뷰단 페이지
    }
	
	// 관리자 구성원 연차 촉진 	
	@RequestMapping(value="empLeavePromotion.yolo") 
    public String empLeavePromotion() {
		
        return "/jinji/empLeavePromotion.admin";
    }
	
	
}
