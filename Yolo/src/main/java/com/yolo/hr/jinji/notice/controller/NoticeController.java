package com.yolo.hr.jinji.notice.controller;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestMethod;
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
    
    // 1050 이메일 ptucker@yolo.com
	
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
 	@RequestMapping(value = "/notice/chooseUser.yolo", produces="text/plain;charset=UTF-8")
 	public String chooseUser( HttpServletRequest request) {
 		
 		String str_empno = request.getParameter("str_empno");
 		
 		// 해당부서 팀 구해오기
 		List<Map<String, String>> empList = service.getChooseDept(str_empno);
 		
 		JSONArray jsonArr = new JSONArray();
 		
 		for(Map<String, String> emp: empList) {
 			JSONObject jsonObj = new JSONObject();
 			
 			jsonObj.put("name", emp.get("name") );
 			jsonObj.put("nickname", emp.get("nickname") );
 			jsonObj.put("position", emp.get("position") );
 			jsonObj.put("deptname", emp.get("deptname") );
 			jsonObj.put("profile_color", emp.get("profile_color") );
 			jsonObj.put("empno", emp.get("empno") );
 			
 			jsonArr.put(jsonObj);
 		}
 		return jsonArr.toString() ;
 	}
 	
 	
 	// 공지글 작성 (공지 작성시 aop 알림 설정)
 	@ResponseBody
 	@RequestMapping(value = "/notice/sendNotice.yolo", produces="text/plain;charset=UTF-8")
 	public void addAlarm_sendNotice(Map<String, String> paraMap, HttpServletRequest request, HttpServletResponse response, NoticeVO noticevo) {
 		
 		HttpSession session = request.getSession();
 		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
 		noticevo.setFk_senderno(loginuser.getEmpno()); // 작성 -> vo 인서트
 		
 		service.sendNotice(noticevo);
 		
 		List<String> empnoList = new ArrayList<String>();
 		 
 		if("1".equals( noticevo.getFk_deptno())) {
 			
 		}
 		else {
 			
 			empnoList = service.getEmpnoList(noticevo.getFk_deptno());
 		}
 		
 		// 해당 사원 번호 알아오기
 		String ste_empnoList = String.join(",", empnoList );
 		
 		// System.out.println(noticevo.getSubject());	
 		// System.out.println(noticevo.getFk_deptno());	
 		// System.out.println(noticevo.getContent());	
 		
 		// seq최신 공지번호 알아오기 (noticevo는 입력한 것을 가져오는)
 		String notino = service.getSeqNotino(loginuser.getEmpno());
//		System.out.println(notino);
 		
// 		System.out.println(empnoList);
 		
 		// === AOP After Advice를 사용하기 === //
 		paraMap.put("fk_recipientno", ste_empnoList); // 받는사람 (여러명일때는 ,,으로 구분된 str)
 		paraMap.put("url", "/notice/noticeList.yolo?alarm_noticeno=" );
 		paraMap.put("url2", notino ); // 연결되는 pknum등...  (여러개일때는 ,,으로 구분된 str)(대신 받는 사람 수랑 같아야됨)
 		paraMap.put("alarm_content", loginuser.getName() + "님이 공지를 작성하셨습니다. 확인해 주세요." );
 		paraMap.put("alarm_type", "5" );
 		
 	}
 
 	
	// 전체 공지 리스트
	@RequestMapping(value = "/notice/noticeList.yolo")
	public ModelAndView noticeList(HttpServletRequest request, ModelAndView mav) {
		
		// 가라 세션
		/*
	    EmployeeVO loginuser = new EmployeeVO();
	    loginuser.setEmpno("1050");
	      
	      
	    loginuser.setFk_deptno("106"); // 사원번호
	      
	    HttpSession session = request.getSession();
	    session.setAttribute("loginuser", loginuser);
	    */
	    // 가라세션 끝
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		// 공지 알림으로 뜬 공지 사항 누르면 해당 공지 내용 띄우기
		String alarm_noticeno = request.getParameter("alarm_noticeno");
		mav.addObject("alarm_noticeno", alarm_noticeno);
		
		List<Map<String, String>> showAllNoticeList = service.showAllNoticeList(loginuser.getFk_deptno());
		
		
		mav.addObject("showAllNoticeList", showAllNoticeList);
//		System.out.println(showAllNoticeList);
		
		mav.setViewName("jinji/notice/noticeList.admin"); 
		
		return mav;
		
	}
	
	// 전체 공지리스트 공지 1개 내용 조회하기(ajax)
	@ResponseBody
	@RequestMapping(value="/notice/getNoticeContent.yolo", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
    public String noticeContent( HttpServletRequest request) {
    
		// 해당 공지글을 읽이 위해 필요한 공지번호를 가져오기
		String notino = request.getParameter("notino");
		// System.out.println(notino);

		
		// map 으로 넣기( 해당 글의 공지번호를 통해 글 하나만 가져오기)
	    Map<String, String> notice = service.showNoticeContent(notino);

	    // ajax
        JSONObject jsonObj = new JSONObject(); 
        jsonObj.put("subject", notice.get("subject"));
        jsonObj.put("content", notice.get("content"));
        jsonObj.put("writedate", notice.get("writedate"));
        jsonObj.put("profile_color", notice.get("profile_color"));
        jsonObj.put("deptname", notice.get("deptname"));
        jsonObj.put("name", notice.get("name"));
        jsonObj.put("nickname", notice.get("nickname"));
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
	public ModelAndView myNoticeList(HttpServletRequest request, ModelAndView mav, NoticeVO noticevo) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
	 // noticevo.setFk_senderno(loginuser.getEmpno());
		loginuser.getEmpno().equals(noticevo.getFk_senderno());
			
		List<Map<String, String>> myNoticeList = service.getMyNoticeList(loginuser.getEmpno());
		
		System.out.println("확인용 공지 목록 : "+myNoticeList);
		
		mav.addObject("myNoticeList", myNoticeList);
		mav.setViewName("jinji/notice/myNoticeList.admin"); 
		
		return mav;
		
	}

	
	// 내가 쓴 공지리스트 공지 1개 내용 조회하기(ajax)
	@ResponseBody
	@RequestMapping(value="/notice/getMyOnwNoticeContent.yolo", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
    public String MyOnwNoticeContent(HttpServletRequest request) {
    
		// 해당 공지글을 읽이 위해 필요한 공지번호를 가져오기
		String notino = request.getParameter("notino");
		System.out.println(notino);

			
		// map 으로 넣기( 해당 글의 공지번호를 통해 글 하나만 가져오기)
	    Map<String, String> myNotice = service.showMyNoticeContent(notino);

	    // ajax
        JSONObject jsonObj = new JSONObject(); 
        jsonObj.put("subject", myNotice.get("subject"));
        jsonObj.put("content", myNotice.get("content"));
        jsonObj.put("writedate", myNotice.get("writedate"));
        jsonObj.put("profile_color", myNotice.get("profile_color"));
        jsonObj.put("deptname", myNotice.get("deptname"));
        jsonObj.put("name", myNotice.get("name"));
        jsonObj.put("nickname", myNotice.get("nickname"));
        jsonObj.put("position", myNotice.get("position"));
        
        return jsonObj.toString(); // string 타입으로 변한다.  '[{}, {}, {} ]' 또는 "[ ]"  => select 된 것이 없을 때
    }
	
	
	
}
