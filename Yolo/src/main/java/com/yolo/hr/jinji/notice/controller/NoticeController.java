package com.yolo.hr.jinji.notice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class NoticeController {

	// 전체 공지 리스트
	@RequestMapping(value = "/notice/noticeList.yolo")
	public String noticeList() {
		
		return "jinji/notice/noticeList.admin";
		
	}
	

	// 부서 공지 리스트 
	@RequestMapping(value = "/notice/depNoticeList.yolo")
	public String depNoticeList() {
		
		return "jinji/notice/depNoticeList.admin";
		
	}
	
	// 내 공지 리스트 
	@RequestMapping(value = "/notice/myNoticeList.yolo")
	public String myNoticeList() {
		
		return "jinji/notice/myNoticeList.admin";
		
	}

	
}
