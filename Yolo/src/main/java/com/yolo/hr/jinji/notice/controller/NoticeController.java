package com.yolo.hr.jinji.notice.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;


import com.yolo.hr.common.FileManager;
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
		
		String empno = loginuser.getEmpno();
		request.setAttribute("empno", empno);
		
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
        jsonObj.put("notino", notice.get("notino"));
        jsonObj.put("subject", notice.get("subject"));
        jsonObj.put("content", notice.get("content"));
        jsonObj.put("writedate", notice.get("writedate"));
        jsonObj.put("profile_color", notice.get("profile_color"));
        jsonObj.put("deptname", notice.get("deptname"));
        jsonObj.put("name", notice.get("name"));
        jsonObj.put("nickname", notice.get("nickname"));
        jsonObj.put("position", notice.get("position"));
        jsonObj.put("showDept", notice.get("showDept"));
        
        return jsonObj.toString(); // string 타입으로 변한다.  '[{}, {}, {} ]' 또는 "[ ]"  => select 된 것이 없을 때
    }
    

	// 부서 공지 리스트 
	@RequestMapping(value = "/notice/depNoticeList.yolo")
	public ModelAndView depNoticeList(HttpServletRequest request, ModelAndView mav, NoticeVO noticevo) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		loginuser.getFk_deptno().equals(noticevo.getFk_deptno());
		
		List<Map<String, String>> depNoticeList = service.depNoticeList(loginuser.getFk_deptno());
		
		
		mav.addObject("depNoticeList", depNoticeList);
//		System.out.println(showAllNoticeList);
		mav.setViewName("jinji/notice/depNoticeList.admin");
		
		return mav;
	}
	
	
	// 부서 공지리스트 공지 1개 내용 조회하기(ajax)
	@ResponseBody
	@RequestMapping(value="/notice/deptOneNoticeContent.yolo", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
    public String deptOneNoticeContent(HttpServletRequest request) {
    
		// 해당 공지글을 읽이 위해 필요한 공지번호를 가져오기
		String notino = request.getParameter("notino");
//		System.out.println(notino);

			
		// map 으로 넣기( 해당 글의 공지번호를 통해 글 하나만 가져오기)
	    Map<String, String> deptNotice = service.showDeptNoticeContent(notino);
	    
	    // ajax
        JSONObject jsonObj = new JSONObject(); 
        jsonObj.put("notino", deptNotice.get("notino"));
        jsonObj.put("subject", deptNotice.get("subject"));
        jsonObj.put("content", deptNotice.get("content"));
        jsonObj.put("writedate", deptNotice.get("writedate"));
        jsonObj.put("profile_color", deptNotice.get("profile_color"));
        jsonObj.put("deptname", deptNotice.get("deptname"));
        jsonObj.put("name", deptNotice.get("name"));
        jsonObj.put("nickname", deptNotice.get("nickname"));
        jsonObj.put("position", deptNotice.get("position"));
        jsonObj.put("showDept", deptNotice.get("showDept"));
        
        return jsonObj.toString(); // string 타입으로 변한다.  '[{}, {}, {} ]' 또는 "[ ]"  => select 된 것이 없을 때
    }
	
	
	// 내가 쓴 공지 리스트 
	@RequestMapping(value = "/notice/myNoticeList.yolo")
	public ModelAndView myNoticeList(HttpServletRequest request, ModelAndView mav, NoticeVO noticevo) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
	 // noticevo.setFk_senderno(loginuser.getEmpno());
		loginuser.getEmpno().equals(noticevo.getFk_senderno());
			
		List<Map<String, String>> myNoticeList = service.getMyNoticeList(loginuser.getEmpno());
		
//		System.out.println("확인용 공지 목록 : "+myNoticeList);
		
		mav.addObject("myNoticeList", myNoticeList);
		mav.setViewName("jinji/notice/myNoticeList.admin"); 
		
		return mav;
		
	}

	
	// 내가 쓴 공지리스트 공지 1개 내용 조회하기(ajax)
	@ResponseBody
	@RequestMapping(value="/notice/getMyOneNoticeContent.yolo", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
    public String MyOneNoticeContent(HttpServletRequest request) {
    
		// 해당 공지글을 읽이 위해 필요한 공지번호를 가져오기
		String notino = request.getParameter("notino");
		System.out.println(notino);

			
		// map 으로 넣기( 해당 글의 공지번호를 통해 글 하나만 가져오기)
	    Map<String, String> myNotice = service.showMyNoticeContent(notino);

	    // ajax
        JSONObject jsonObj = new JSONObject();
        jsonObj.put("notino", myNotice.get("notino"));
        jsonObj.put("subject", myNotice.get("subject"));
        jsonObj.put("content", myNotice.get("content"));
        jsonObj.put("writedate", myNotice.get("writedate"));
        jsonObj.put("profile_color", myNotice.get("profile_color"));
        jsonObj.put("deptname", myNotice.get("deptname"));
        jsonObj.put("name", myNotice.get("name"));
        jsonObj.put("nickname", myNotice.get("nickname"));
        jsonObj.put("position", myNotice.get("position"));
        jsonObj.put("showDept", myNotice.get("showDept"));
        
        return jsonObj.toString(); // string 타입으로 변한다.  '[{}, {}, {} ]' 또는 "[ ]"  => select 된 것이 없을 때
    }
	
	
	// 공지글 수정하기 (fk_serderno 만 가능하도록 하기)
	@ResponseBody
	@RequestMapping(value = "/notice/getEditNotice.yolo", produces="text/plain;charset=UTF-8",  method= {RequestMethod.POST})
	public String editNotice(NoticeVO noticevo, HttpServletRequest request) {
		
		String notino = noticevo.getNotino();
//		NoticeVO editNoticevo = service.getEditNotice(notino);
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		noticevo.setFk_senderno(loginuser.getEmpno());
		
		// map 으로 넣기( 공지 수정을 위해 해당 공지번호 글 하나만 가져오기)
	    Map<String, String> editNotice = service.showEditNoticeContent(notino);
		
//		service.editNotice(editNoticevo, noticevo); // 공지글 수정하기
		
		
		// ajax
        JSONObject jsonObj = new JSONObject();
//      jsonObj.put("editNoticevo", editNoticevo);
        jsonObj.put("notino", editNotice.get("notino"));
        jsonObj.put("subject", editNotice.get("subject"));
        jsonObj.put("content", editNotice.get("content"));
        
        
        return jsonObj.toString(); 
	}
	
	
	
	
	
	// 공지글 수정 완료 폼 요청
	@RequestMapping(value = "/notice/editNoticeFrm.yolo", produces="text/plain;charset=UTF-8",  method= {RequestMethod.POST})
	public ModelAndView editNoticeEnd(ModelAndView mav, NoticeVO noticevo, HttpServletRequest request) {
		
		int result = service.editNotice(noticevo);
		
		/*
		 * System.out.println(result); System.out.println(noticevo.getSubject());
		 * System.out.println(noticevo.getContent());
		 * System.out.println(noticevo.getNotino());
		 */
		 
	   if(result==0) {
           mav.addObject("message", "공지 수정이 완료되지 못했습니다.");
           mav.setViewName("jinji/notice/noticeList.admin"); 
       }
       else { // n == 1 이라면 성공된 경우다 
           mav.addObject("message", "공지 수정이 완료 되었습니다.");
           mav.setViewName("redirect:/notice/noticeList.yolo"); // 페이지만 변경시 redirect(데이터 보내는 곳과 띄우는 곳 다를 때)
       }
      
      return mav;
	}

	

	// 공지글 삭제 완료 폼 요청
	@RequestMapping(value = "/notice/deleteNoticeEnd.action", method = {RequestMethod.POST })
	public ModelAndView deleteNoticeEnd(ModelAndView mav, NoticeVO noticevo, HttpServletRequest request) {

		// 삭제하고자 하는 글의 번호 가져오기
		String notino = request.getParameter("notino"); // notino (jsp에 name or ajax로 데이터 넘겨줘야)

		System.out.println("글삭제번호 :" + notino);

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("notino", notino);

		// map 으로 넣기( 공지 수정을 위해 해당 공지번호 글 하나만 가져오기)
		// NoticeVO noticevo = service.getOnedeleteNotice(paraMap);
		// 1개글 조회

		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");

		noticevo.setFk_senderno(loginuser.getEmpno());
		
		int result = service.delEnd(paraMap);

	//	System.out.println("글삭제 int result :" + result);

		if (result == 0) {
			// 글 쓴 유저아이디와 로그인된 사워나이디 동일하지 않다면 삭제 못 함
			mav.addObject("message", "글 삭제가 불가합니다.");
			mav.setViewName("jinji/notice/noticeList.admin");

			// 보여줄 뷰단 페이지는 메세지 뷰단
		} else {
			// 자신의 글 삭제할 경우,
			// 글 작성시 입력해준 암호와 글삭제 암호 일치하는지 여부 알아오도록 암호 입력받아주는 del.jsp페이지 (폼태그) 띄운다.
			mav.addObject("message", "삭제 완료됐습니다"); // 키값은 메세지jsp의 값, 오른쪽 벨류값은 위 String message의 메세지
			mav.setViewName("redirect:/notice/noticeList.yolo");
		}

		return mav;

	}
	
	
	
}
