package com.yolo.hr.jihee.workflowController;



import java.util.*;
import java.util.Map.Entry;
import java.util.Map;import javax.annotation.Resource;
import javax.print.DocFlavor.STRING;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yolo.hr.jihee.workflow.service.InterWorkflowService;
import com.yolo.hr.jjy.employee.model.EmployeeVO;



@Controller
public class WorkflowControllor {
	
	@Autowired
	private InterWorkflowService service;
	
	@RequestMapping(value = "/workflow.yolo")
	public String viewWorkflow(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		
		
	

			
		return "jihee/content/document.workadmin";
	}
	
	//ajax
	@ResponseBody
	@RequestMapping(value = "/workflow/documentDetail.yolo")
	public String documentDetail(HttpServletRequest request) {
		

		JSONArray jsonArr = new JSONArray(); // []

		return jsonArr.toString(); // "[]" 또는 "[{},}{],{}]"
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
		
		//세션 값 받아오기 
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		//null 일떄 처리해주기
		String deptno = loginuser.getFk_deptno();
		
		if(!(deptno == null)) {
		//System.out.println("emono :" + deptno);		
		Map<String,String> paraMap = new HashMap<>();		
		paraMap.put("deptno", deptno);
		
		//참조 대상자들 알아오기
		List<Map<String,String>> appList = service.appList(paraMap);
		
		request.setAttribute("appList", appList);
		
		//list안의 map 출력
		/*
		 * for(int i = 0; i < appList.size(); i++){ //arraylist 사이즈 만큼 for문을 실행합니다.
		 * System.out.println("list 순서 " + i + "번쨰"); for( Entry<String, String> map :
		 * appList.get(i).entrySet() ){ // list 각각 hashmap받아서 출력합니다. System.out.println(
		 * String.format("키 : %s, 값 : %s", map.getKey(), map.getValue()) ); } }
		 */
		
		
		
		}
		
		
		
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
	
	//ajax
	@ResponseBody
	@RequestMapping(value = "/workflow/myDocument_dm.yolo")
	public String myDcument_dm(HttpServletRequest request) {
		

		JSONArray jsonArr = new JSONArray(); // []

		return jsonArr.toString(); // "[]" 또는 "[{},}{],{}]"
	}
		
	//ajax
	@ResponseBody
	@RequestMapping(value = "/workflow/watingDm.yolo")
	public String watingDm(HttpServletRequest request) {
		

		JSONArray jsonArr = new JSONArray(); // []

		return jsonArr.toString(); // "[]" 또는 "[{},}{],{}]"
	}

}
