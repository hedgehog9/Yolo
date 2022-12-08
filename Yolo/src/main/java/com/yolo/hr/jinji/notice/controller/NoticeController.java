package com.yolo.hr.jinji.notice.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.*;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.yolo.hr.common.*;
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
 	@RequestMapping(value = "/notice/getDept.yolo", produces="text/plain;charset=UTF-8")
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
 	

 	
 	// 체크된 부서 유저 목록 가져오기
 	@ResponseBody
 	@RequestMapping(value = "/notice/chooseDept.yolo", produces="text/plain;charset=UTF-8")
 	public String chooseDept( HttpServletRequest request) {
 		
 		String str_empno = request.getParameter("str_empno");
 		
 		// 해당부서 구해오기
 		List<Map<String, String>> deptList = service.getChooseDept(str_empno);

 		JSONArray jsonArr = new JSONArray();
 		
 		for(Map<String, String> dept: deptList) {
 			JSONObject jsonObj = new JSONObject();
 			
 			jsonObj.put("name", dept.get("name") );
 			jsonObj.put("position", dept.get("position") );
 			jsonObj.put("deptname", dept.get("deptname") );
 			jsonObj.put("profile_color", dept.get("profile_color") );
 			jsonObj.put("empno", dept.get("empno") );
 			
 			jsonArr.put(jsonObj);

 		}
 		return jsonArr.toString();
 	}
 	
 	
 	// 공지글 작성
 	@ResponseBody
 	@RequestMapping(value = "/notice/sendNotice.yolo", produces="text/plain;charset=UTF-8",  method= {RequestMethod.POST})
 	public void sendNotice(NoticeVO noticevo, HttpServletRequest request) {
 
 		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");

		noticevo.setFk_senderno(loginuser.getEmpno());
		
		service.sendNotice(noticevo);		
		// System.out.println(noticevo.getSubject());	
		// System.out.println(noticevo.getFk_deptno());	
		// System.out.println(noticevo.getContent());	
			
	}// end of  메신저 보내기

 
 	
	// 전체 공지 리스트
	@RequestMapping(value = "/notice/noticeList.yolo")
	public ModelAndView noticeList(HttpServletRequest request, ModelAndView mav) {
		
		 // 가라 세션
		
	     EmployeeVO loginuser = new EmployeeVO();
	     loginuser.setEmpno("1050");
	      
	      
	     loginuser.setFk_deptno("106"); // 사원번호
	      
	     HttpSession session = request.getSession();
	     session.setAttribute("loginuser", loginuser);
	     
	     // 가라세션 끝
	
		 /*
		 HttpSession session = request.getSession();
		 EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		 session.setAttribute("loginuser", loginuser);
		 */
	     
	     EmployeeVO loginuser2 = (EmployeeVO)session.getAttribute("loginuser");
	    
	     List<Map<String, String>> noticeList = service.getAllNoticeList(loginuser2.getFk_deptno());
//	     System.out.println(noticeList); // 리스트 나오는지 확인
	     
	     mav.addObject("noticeList", noticeList);
	     mav.setViewName("jinji/notice/noticeList.admin"); 
	     
//       System.out.println(noticeList);
	     
		 return mav;
		
	}
	

	 
    // 전체 공지리스트 공지 1개 내용 조회하기(ajax)
	@ResponseBody
	@RequestMapping(value="/notice/getNoticeContent.yolo", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
    public String noticeContent( HttpServletRequest request) {
    
		String notino = request.getParameter("notino");
		// System.out.println(notino);

		
		// map 으로 넣기( 글 하나만 가져오기)
	    Map<String, String> notice = service.showNoticeContent(notino);

      
        JSONObject jsonObj = new JSONObject(); 
        jsonObj.put("subject", notice.get("subject"));
        jsonObj.put("content", notice.get("content"));
        jsonObj.put("writedate", notice.get("writedate"));
        jsonObj.put("profile_color", notice.get("profile_color"));
        jsonObj.put("deptname", notice.get("deptname"));
        jsonObj.put("name", notice.get("name"));
        jsonObj.put("position", notice.get("position"));
        
        return jsonObj.toString(); // string 타입으로 변한다.  '[{}, {}, {} ]' 또는 "[ ]"  => select 된 것이 없을 때
    }
    
			
	
	
	// 부서 공지 리스트 
	@RequestMapping(value = "/notice/depNoticeList.yolo")
	public String depNoticeList() {
		
		return "jinji/notice/depNoticeList.admin";
		
	}
	
	
	// 내가 쓴 공지 리스트 
	@RequestMapping(value = "/notice/myNoticeList.yolo")
	public ModelAndView myNoticeList(HttpServletRequest request, ModelAndView mav) {
		
		/*
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		session.setAttribute("loginuser", loginuser);
		*/
		
		 // 가라 세션
	     EmployeeVO loginuser = new EmployeeVO();
	     loginuser.setEmpno("1050");
	      
	     loginuser.setFk_deptno("106"); // 사원번호
	      
	     HttpSession session = request.getSession();
	     session.setAttribute("loginuser", loginuser);
	     // 가라세션 끝
	
	     EmployeeVO myloginuser = (EmployeeVO)session.getAttribute("loginuser");
	     
	     List<Map<String, String>> myNoticeList = service.getMyNoticeList(myloginuser.getFk_deptno());
		
	     mav.addObject("myNoticeList", myNoticeList);
	     mav.setViewName("jinji/notice/myNoticeList.admin"); 
		
	     
	     
	     System.out.println(myNoticeList);

	     return mav;
		
		
	}

	
}
