package com.yolo.hr.jinji.notice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class NoticeController {

	// 게시판리스트
	@RequestMapping(value = "/notice/boardList.yolo")
	public String bordList() {
		
		return "jinji/notice/boardList.admin";
		
	}
}
