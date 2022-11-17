package com.yolo.hr.jihyunController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class JihyunController {
	
	@RequestMapping(value = "/messenger/sendedMassage.yolo")
	public String sendedMassage() {
		return "jihyun/messenger/sendedMassage.admin";
	}
}
