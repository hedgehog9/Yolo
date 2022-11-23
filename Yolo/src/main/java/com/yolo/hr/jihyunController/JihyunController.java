package com.yolo.hr.jihyunController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class JihyunController {
	
	@RequestMapping(value = "/messenger/sentMessage.yolo")
	public String sendedMessage() {
		return "jihyun/messenger/sentMessage.admin";
	}
	
	@RequestMapping(value = "/messenger/receivedMessage.yolo")
	public String receivedMessage() {
		return "jihyun/messenger/receivedMessage.admin";
	}
	
	
	// 관리자 내휴가 휴가 개요
		@RequestMapping(value="leaveSummary.yolo") 
	    public String leaveSummary() {
			
	        return "jihyun/leave/leaveSummary.admin"; // 뷰단 페이지
	        // /WEB-INF/views/admin/{1}/{2}.jsp
	        
	    }
		
		// 관리자 내휴가 연차 상세 
		@RequestMapping(value="leaveDetail.yolo") 
	    public String leaveDetail() {
			
	        return "jihyun/leave/leaveDetail.admin";
	    }
		
		
		// 관리자 구성원 휴가 보유 현황
		@RequestMapping(value="empLeaveStatus.yolo") 
	    public String empLeaveStatus() {
			
	        return "jihyun/leave/empLeaveStatus.admin"; // 뷰단 페이지
	    }
		
		// 관리자 구성원 휴가 사용 내역
		@RequestMapping(value="empLeaveUsingList.yolo") 
	    public String empLeaveUsingList() {
			
	        return "jihyun/leave/empLeaveUsingList.admin"; // 뷰단 페이지
	    }
		
		// 관리자 구성원 연차 촉진 	
		@RequestMapping(value="empLeavePromotion.yolo") 
	    public String empLeavePromotion() {
			
	        return "jihyun/leave/empLeavePromotion.admin";
	    }
}
