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
}
