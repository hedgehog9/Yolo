package com.yolo.hr.jihee.workflowController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WorkflowControllor {
	
	@RequestMapping(value = "/workflow.yolo")
	public String viewWorkflow() {
		
		return "jihee/content/document.admin";
	}

}
