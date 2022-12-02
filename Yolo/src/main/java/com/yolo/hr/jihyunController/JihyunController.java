package com.yolo.hr.jihyunController;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.yolo.hr.jihyunModel.MessengerVO;
import com.yolo.hr.jihyunService.InterMessengerService;
import com.yolo.hr.jjy.employee.model.EmployeeVO;

@Controller
public class JihyunController {
	
	@Autowired
	private InterMessengerService service;
	
	
	// 보낸 메일함 열기
	@RequestMapping(value = "/messenger/sentMessage.yolo")
	public ModelAndView sentMessage( HttpServletRequest request, ModelAndView mav) {
		
		// 가라 세션
		EmployeeVO loginuser = new EmployeeVO();
		loginuser.setEmpno("1050");
		HttpSession session = request.getSession();
		session.setAttribute("loginuser", loginuser);
		// 가라세션 끝
		
		List<Map<String, String>> sentMsgList = service.getSentMsgList(loginuser.getEmpno());
		
		mav.addObject("sentMsgList", sentMsgList);
		mav.setViewName("jihyun/messenger/sentMessage.admin"); 
		
		return mav;
	}
	
	
	// 받은 메일함 열기
	@RequestMapping(value = "/messenger/receivedMessage.yolo")
	public ModelAndView receivedMessage( HttpServletRequest request, ModelAndView mav) {
		
		// 가라 세션
		EmployeeVO loginuser = new EmployeeVO();
		loginuser.setEmpno("1050");
		HttpSession session = request.getSession();
		session.setAttribute("loginuser", loginuser);
		// 가라세션 끝
		
		mav.setViewName("jihyun/messenger/receivedMessage.admin"); 
		return mav;
		
	}
	
	// 부서만 조회해오기
	@ResponseBody
	@RequestMapping(value = "/jihyun/getDept.yolo", produces="text/plain;charset=UTF-8")
	public String getDept( HttpServletRequest request) {
		
		// 부서만 조회해오기
		List<Map<String,String>> deptList = service.getDeptList();
		
		JSONArray jsonArr = new JSONArray();
		
		for(Map<String,String> dept: deptList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("deptname", dept.get("deptname") );
			jsonObj.put("deptno", dept.get("deptno") );
			
			jsonArr.put(jsonObj);
		}
		
		return jsonArr.toString() ;
	}
	
	// 부서 사람들(부서장) 조회해오기
	@ResponseBody
	@RequestMapping(value = "/jihyun/getDeptPerson.yolo", produces="text/plain;charset=UTF-8")
	public String getDeptPerson( HttpServletRequest request) {
		
		String deptno = request.getParameter("deptno");
		
		// 부서사람들 조회하기
		List<Map<String,String>> deptList = service.getDeptPersonList(deptno);
		
		JSONArray jsonArr = new JSONArray();
		
		for(Map<String,String> dept: deptList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("empno", dept.get("empno") );
			jsonObj.put("name", dept.get("name") );
			
			jsonArr.put(jsonObj);
		}
		return jsonArr.toString() ;
	}
	
	
	// 부서내 팀 사람들(사원들) 조회해오기
	@ResponseBody
	@RequestMapping(value = "/jihyun/getTeamPerson.yolo", produces="text/plain;charset=UTF-8")
	public String getTeamPerson( HttpServletRequest request) {
		
		String deptno = request.getParameter("deptno");
		
		// 부서사람들 조회하기
		List<Map<String,String>> teamList = service.getTeamPerson(deptno);
		
		JSONArray jsonArr = new JSONArray();
		
		for(Map<String,String> dept: teamList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("empno", dept.get("empno") );
			jsonObj.put("name", dept.get("name") );
			
			jsonArr.put(jsonObj);
		}
		return jsonArr.toString() ;
	}
	
	
	
	// 해당부서 팀 구해오기
	@ResponseBody
	@RequestMapping(value = "/jihyun/getTeam.yolo", produces="text/plain;charset=UTF-8")
	public String getTeam( HttpServletRequest request) {
		
		String deptno = request.getParameter("deptno");
		
		// 해당부서 팀 구해오기
		List<Map<String,String>> deptList = service.getTeam(deptno);
		
		JSONArray jsonArr = new JSONArray();
		
		for(Map<String,String> dept: deptList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("deptname", dept.get("deptname") );
			jsonObj.put("deptno", dept.get("deptno") );
			
			jsonArr.put(jsonObj);
		}
		return jsonArr.toString() ;
	}
	
	
	// 체크된 유저 목록 가져오기
	@ResponseBody
	@RequestMapping(value = "/messenger/chooseUser.yolo", produces="text/plain;charset=UTF-8")
	public String chooseUser( HttpServletRequest request) {
		
		String str_empno = request.getParameter("str_empno");
		
		// 해당부서 팀 구해오기
		List<Map<String, String>> empList = service.getChooseEmp(str_empno);
		
		JSONArray jsonArr = new JSONArray();
		
		for(Map<String, String> emp: empList) {
			JSONObject jsonObj = new JSONObject();
			
			
			jsonObj.put("name", emp.get("name") );
			jsonObj.put("nickname", emp.get("name").substring(emp.get("name").length()-2) );
			jsonObj.put("position", emp.get("position") );
			jsonObj.put("deptname", emp.get("deptname") );
			jsonObj.put("profile_color", emp.get("profile_color") );
			jsonObj.put("empno", emp.get("empno") );
			
			jsonArr.put(jsonObj);
		}
		return jsonArr.toString() ;
	}
	
	
	// 메신저 보내기
	@ResponseBody
	@RequestMapping(value = "/messenger/sendMessenger.yolo", produces="text/plain;charset=UTF-8")
	public void sendMessenger(HttpServletRequest request, MessengerVO msgvo) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		msgvo.setFk_senderno(loginuser.getEmpno());
		
		service.sendMessenger(msgvo);
		// System.out.println(msgvo.getSubject());
		
	}
	
	
	
	// 관리자 내휴가 휴가 개요
	@RequestMapping(value="/leaveSummary.yolo") 
    public String leaveSummary() {
		
        return "jihyun/leave/leaveSummary.admin"; // 뷰단 페이지
        // /WEB-INF/views/admin/{1}/{2}.jsp
    }
	

	// 관리자 구성원 휴가 보유 현황
	@RequestMapping(value="/empLeaveStatus.yolo") 
    public String empLeaveStatus() {
		
        return "jihyun/leave/empLeaveStatus.admin"; // 뷰단 페이지
    }
	
	// 관리자 구성원 휴가 사용 내역
	@RequestMapping(value="/empLeaveUsingList.yolo") 
    public String empLeaveUsingList() {
		
        return "jihyun/leave/empLeaveUsingList.admin"; // 뷰단 페이지
    }
		
}
