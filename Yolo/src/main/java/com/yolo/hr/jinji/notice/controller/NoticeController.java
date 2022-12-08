package com.yolo.hr.jinji.notice.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.yolo.hr.common.FileManager;
import com.yolo.hr.common.MyUtil;
import com.yolo.hr.jinji.notice.model.NoticeVO;
import com.yolo.hr.jinji.notice.service.InterNoticeService;
import com.yolo.hr.jjy.employee.model.EmployeeVO;

@Controller
public class NoticeController {

	@Autowired
	private InterNoticeService service;
	
	// 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : Dependency Injection) ===  
    @Autowired // Type에 따라 알아서 bean을 주입시켜준다. 
    private FileManager fileManager; // 빈으로 올라가게 하고 그것을 사용하다. @Autowired 넣어준다.
    
	
    // 부서만 조회해오기
 	@ResponseBody
 	@RequestMapping(value = "/jinji/getDept.yolo", produces="text/plain;charset=UTF-8")
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
 	@RequestMapping(value = "/jinji/getDeptPerson.yolo", produces="text/plain;charset=UTF-8")
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
 	@RequestMapping(value = "/jinji/getTeamPerson.yolo", produces="text/plain;charset=UTF-8")
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
 	@RequestMapping(value = "/jinji/getTeam.yolo", produces="text/plain;charset=UTF-8")
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
 	@RequestMapping(value = "/notice/chooseUser.yolo", produces="text/plain;charset=UTF-8")
 	public String chooseUser( HttpServletRequest request) {
 		
 		String str_empno = request.getParameter("str_empno");
 		
 		// 해당부서 팀 구해오기
 		List<Map<String, String>> empList = service.getChooseEmp(str_empno);
 		
 		JSONArray jsonArr = new JSONArray();
 		
 		for(Map<String, String> emp: empList) {
 			JSONObject jsonObj = new JSONObject();
 			
 			
 			jsonObj.put("name", emp.get("name") );
 			jsonObj.put("position", emp.get("position") );
 			jsonObj.put("deptname", emp.get("deptname") );
 			jsonObj.put("profile_color", emp.get("profile_color") );
 			jsonObj.put("empno", emp.get("empno") );
 			
 			jsonArr.put(jsonObj);
 		}
 		return jsonArr.toString() ;
 	}
 	
 	
 	// 공지글 작성
 	@ResponseBody
 	@RequestMapping(value = "/notice/sendNotice.yolo", produces="text/plain;charset=UTF-8")
 	public void sendNotice(Map<String, String> paraMap, HttpServletRequest request, HttpServletResponse response, NoticeVO noticevo) {
 		
 		HttpSession session = request.getSession();
 		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
 		noticevo.setFk_senderno(loginuser.getEmpno());
 		
 		noticevo.setContent(MyUtil.secureCode(noticevo.getContent()));
 		
 		service.sendNotice(noticevo);
 		
 		/*
 		// === AOP After Advice를 사용하기 === //
 		paraMap.put("fk_recipientno", "1050,1050"); // 받는사람 (여러명일때는 ,,으로 구분된 str)
 		paraMap.put("url", "/messenger/receivedMessage.yolo?pk_msgno=" );
 		paraMap.put("url2", "202212021601569430" ); // 연결되는 pknum등...  (여러개일때는 ,,으로 구분된 str)(대신 받는 사람 수랑 같아야됨)
 		paraMap.put("alarm_content", "연습" );
 		paraMap.put("alarm_type", "5" );
 		*/
 	}
 
 	
	// 전체 공지 리스트
	@RequestMapping(value = "/notice/noticeList.yolo")
	public ModelAndView noticeList(HttpServletRequest request, ModelAndView mav) {
		
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		session.setAttribute("loginuser", loginuser);
		
		mav.setViewName("jinji/notice/noticeList.admin"); 
		
		return mav;
	//	request.setAttribute("noticeList", noticeList);

		 
	//	return "jinji/notice/noticeList.admin";
		
	}
	

	// 부서 공지 리스트 
	@RequestMapping(value = "/notice/depNoticeList.yolo")
	public String depNoticeList() {
		
		return "jinji/notice/depNoticeList.admin";
		
	}
	
	
	// 내가 쓴 공지 리스트 
	@RequestMapping(value = "/notice/myNoticeList.yolo")
	public ModelAndView myNoticeList(HttpServletRequest request, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		session.setAttribute("loginuser", loginuser);
		
		List<Map<String, String>> sentNoticeList = service.getSentNoticeList(loginuser.getFk_deptno());
		
		mav.addObject("sentNoticeList", sentNoticeList);
		mav.setViewName("jinji/notice/myNoticeList.admin"); 
		
		return mav;
	// return "jinji/notice/myNoticeList.admin";
		
	}

	
}
