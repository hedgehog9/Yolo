package com.yolo.hr.jihee.workflowController;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.annotation.RequestScope;

@Controller
public class WorkflowControllor {
	
	@RequestMapping(value = "/workflow.yolo")
	public String viewWorkflow() {
		
		return "jihee/content/document.admin";
	}
	
	@RequestMapping(value = "/cpWorkflow.yolo")
	public String viewCpWorkflow() {
		
		return "jihee/content/cpDocument.admin";
	}
	
	@RequestMapping(value = "/workflow/selectWrite.yolo")
	public String selectWriteWorkflow() {
		
		
		return "jihee/content/selectWrite.admin";
	}
	
	@RequestMapping(value = "/workflow/write.yolo")
	public String writeWorkflow(HttpServletRequest request) {
		
		String subject = request.getParameter("subject");
		String icon = request.getParameter("icon");
		String information = request.getParameter("information");
		
		request.setAttribute("subject", subject);
		request.setAttribute("icon", icon);
		request.setAttribute("information", information);
		
		
		return "jihee/content/write.admin";
	}
	
	@RequestMapping(value = "/workflow/modify.yolo")
	public String modifyWorkflow(HttpServletRequest request) {
		
		String subject = request.getParameter("subject");
		String icon = request.getParameter("icon");
		String information = request.getParameter("information");
		
		request.setAttribute("subject", subject);
		request.setAttribute("icon", icon);
		request.setAttribute("information", information);
		
		
		return "jihee/content/modify.admin";
	}

}
