package com.yolo.hr.jinji.notice.controller;

import java.util.*;
import javax.servlet.http.*;

import org.json.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.yolo.hr.common.FileManager;
import com.yolo.hr.jinji.notice.model.CommentVO;
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
 
 	/////////////////////////////////////////////////// 전체 공지 끝 /////////////////////////////////
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
		
		/*
		for(Map<String, String> map:showAllNoticeList) {
			map.get("notino");
			System.out.println(map.get("notino"));
		}
		*/
		
		mav.addObject("showAllNoticeList", showAllNoticeList);
//		System.out.println(showAllNoticeList);
		
		mav.setViewName("jinji/notice/noticeList.admin"); 
		
		return mav;
		
	}
	
	// 전체 공지리스트 공지 1개 내용 조회하기(ajax)
	@ResponseBody
	@RequestMapping(value="/notice/getNoticeContent.yolo", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
    public String noticeContent( HttpServletRequest request) {
    
		// 해당 공지글을 읽기 위해 필요한 공지번호를 가져오기
		String notino = request.getParameter("notino");		
		// System.out.println(notino);

		
		// map 으로 넣기( 해당 글의 공지번호를 통해 글 하나만 가져오기)
	    Map<String, String> notice = service.showNoticeContent(notino);

	    // ajax
        JSONObject jsonObj = new JSONObject(); 
        jsonObj.put("notino", notice.get("notino"));
        jsonObj.put("fk_senderno", notice.get("fk_senderno"));
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
    
	
	// 전체 공지글 수정하기 (fk_serderno 만 가능하도록 하기)
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
//	   jsonObj.put("editNoticevo", editNoticevo);
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

	

	// 공지글 삭제  요청
   @ResponseBody
   @RequestMapping(value = "/notice/deleteNoticeEnd.yolo",produces="text/plain;charset=UTF-8", method = {RequestMethod.POST })
   public String deleteNoticeEnd(HttpServletRequest request, HttpServletResponse response) {
      
      // 삭제하고자 하는 글의 번호 가져오기
      String notino = request.getParameter("notino"); // notino (jsp에 name or ajax로 데이터 넘겨줘야)
      String fk_senderno = request.getParameter("fk_senderno");
      
      // System.out.println("글삭제번호 :" + notino);
      
      Map<String, String> paraMap = new HashMap<>();
      paraMap.put("notino", notino);
      paraMap.put("fk_senderno", fk_senderno);
      
      HttpSession session = request.getSession();
	  EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
	  
	  String empno = loginuser.getEmpno();
	  request.setAttribute("empno", empno);
	  
	  paraMap.put("empno", empno);
	  
	  System.out.println(paraMap);
	  
	  String message = "";

	  int result = 0;
	  
	  JSONObject jsonObj = new JSONObject();
//		  System.out.println("fk_send : " +fk_senderno);
//		  System.out.println("empno : " +empno);
	  
	  if( !(empno.equals(fk_senderno) )) {
		  message = "글작성자만 삭제 가능합니다.";
	  }
	  else {
		  result = service.delNoticeEnd(paraMap);	
		  message = "글이 삭제되었습니다.";
	  }

	  jsonObj.put("result", result); 
	  jsonObj.put("message", message); 

	  return jsonObj.toString();

	  
   }

   
   // 공지 댓글 작성하기
   @ResponseBody
   @RequestMapping(value="/notice/addComment.yolo", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
   public String addComment(CommentVO commentvo) {
   // ajax는 결과물 그대로 찍어줘야 하니까 String이 리턴타입이다//modelandview가 아니다.
      
       int n  = 0;
       
       n = service.addComment(commentvo);
       // 댓글쓰기(insert) 및 원게시물(tbl_board 테이블)에 댓글의 개수 증가(update 1씩 증가)하기 
       // 이어서 회원의 포인트를 50점을 증가하도록 한다. (tbl_member 테이블에 point 컬럼의 값을 50 증가하도록 update 한다.)
     
       JSONObject jsonObj = new JSONObject();
       jsonObj.put("n", n); // 위의 n 때문에 쓸 수 없으니 전역변수로 
       jsonObj.put("fk_notino", commentvo.getFk_notino());
       jsonObj.put("fk_empno", commentvo.getFk_empno());
       jsonObj.put("content", commentvo.getContent());
       
       System.out.println("json 확인용 :" + jsonObj);

       return jsonObj.toString();
   }

   
   // 원공지글에 해당하는 댓글 조회하기
   @ResponseBody
   @RequestMapping(value="/notice/readComment.yolo", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
   public String readComment(HttpServletRequest request) {
       
       String fk_notino = request.getParameter("fk_notino");
       
       // System.out.println("fk_notino :"+fk_notino);
       
       List<Map<String,String>> commentList = service.getCommentList(fk_notino); 
    
       // 어떤 글은 댓글 아예 없을 수도 있다.
       
       JSONArray jsonArr = new JSONArray();
       // DB에서 읽어온 것 네임,컨텐트, 작성일자를 put 해준다.
     
		for(Map<String,String> comment: commentList) { // 뷰단에 뿌려줄 값들 모두 넣기
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("commentno", comment.get("commentno"));
			jsonObj.put("name", comment.get("name"));
			jsonObj.put("fk_notino", comment.get("fk_notino"));
			jsonObj.put("fk_empno", comment.get("fk_empno"));
			jsonObj.put("content", comment.get("content"));
			jsonObj.put("writedate", comment.get("writedate"));
			jsonObj.put("profile_color", comment.get("profile_color") );
			jsonObj.put("nickname", comment.get("nickname"));
			jsonObj.put("deptname", comment.get("deptname"));
			jsonObj.put("position", comment.get("position"));
			
			jsonArr.put(jsonObj);
		}
	//	System.out.println(jsonArr);  
	// 	원공지글에 대한 댓글 여러개일 수 있음 => 뷰단 ajax로 for문 돌리기((  $.each(data,function(index, item)  ))
		return jsonArr.toString() ;

   }
   
    // 
	// 원 공지글에 대한 댓글  수정하기 (fk_serderno 만 가능하도록 하기)
	@ResponseBody
	@RequestMapping(value = "/notice/editComment.yolo", produces="text/plain;charset=UTF-8",  method= {RequestMethod.POST})
	public String editComment(CommentVO commentvo, HttpServletRequest request) {
		
		String commentno = commentvo.getCommentno();
	//		NoticeVO editNoticevo = service.getEditNotice(notino);
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		commentvo.setFk_empno(loginuser.getEmpno());
		
		// map 으로 넣기( 공지 수정을 위해 해당 공지번호 글 하나만 가져오기)
	    Map<String, String> editComment = service.showEditNoticeContent(commentno);
		
	    // service.editNotice(editNoticevo, noticevo); // 공지글 수정하기
		
		
		// ajax
	   JSONObject jsonObj = new JSONObject();
	   // jsonObj.put("editNoticevo", editNoticevo);
	   jsonObj.put("commentno", editComment.get("commentno"));
	   jsonObj.put("content", editComment.get("content"));
	   jsonObj.put("fk_empno", editComment.get("fk_empno"));
	   
	   
	   return jsonObj.toString(); 
	}
	
   
   
   
	   
   /////////////////////////////////////////////////// 전체 공지 끝 /////////////////////////////////
   
   
   
   
   
   
   
   /////////////////////////////////////////////////// 	부서 공지 시작 /////////////////////////////////
   
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
        jsonObj.put("fk_senderno", deptNotice.get("fk_senderno"));
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
	
	
	// 부서 공지글 수정하기 (fk_serderno 만 가능하도록 하기)
	@ResponseBody
	@RequestMapping(value = "/notice/getDepNoticeContent.yolo", produces="text/plain;charset=UTF-8",  method= {RequestMethod.POST})
	public String editDepNotice(NoticeVO noticevo, HttpServletRequest request ) {
		
		String notino = noticevo.getNotino();
		
//		System.out.println("부서수정번호 : "+ notino);
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		noticevo.setFk_senderno(loginuser.getEmpno());
		
		// map 으로 넣기( 공지 수정을 위해 해당 공지번호 글 하나만 가져오기) (맵에 담으면 맵으로 받음/VO는 NoticeVO로)
		
				
		noticevo =  service.showEditDepNoticeContent(notino);
//		service.editNotice(editNoticevo, noticevo); // 공지글 수정하기
		
		// ajax
        JSONObject jsonObj = new JSONObject();
		
        jsonObj.put("notino", noticevo.getNotino());
        jsonObj.put("subject", noticevo.getSubject());
        jsonObj.put("content", noticevo.getContent());
        
//      System.out.println("부서수정공지 맵 :" +jsonObj);
        return jsonObj.toString(); 
	}
	
	// 부서 공지글 1개 삭제  요청
   @ResponseBody
   @RequestMapping(value = "/notice/deleteDepNoticeEnd.yolo",produces="text/plain;charset=UTF-8", method = {RequestMethod.POST })
   public String deleteDepNoticeEnd(HttpServletRequest request, HttpServletResponse response) {
      
      // 삭제하고자 하는 글의 번호 가져오기
      String notino = request.getParameter("notino"); // notino (jsp에 name or ajax로 데이터 넘겨줘야)
      // 공지 작성자의 번호 가져오기
      String fk_senderno = request.getParameter("fk_senderno");
      
      // System.out.println("글삭제번호 :" + notino);
      
      // 글 한 개 삭제(삭제글 정보 1개 맵에 담기)
      Map<String, String> paraMap = new HashMap<>();
      paraMap.put("notino", notino);
      paraMap.put("fk_senderno", fk_senderno);
      
      HttpSession session = request.getSession();
	  EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
	  
	  String empno = loginuser.getEmpno();
	  request.setAttribute("empno", empno);
	  
	  paraMap.put("empno", empno);
	  
	  // System.out.println(paraMap);
	  
	  String message = "";

	  int result = 0;
	  
	  JSONObject jsonObj = new JSONObject();
//	  System.out.println("fk_send : " +fk_senderno);
//    System.out.println("empno : " +empno);
	  
	  if( !(empno.equals(fk_senderno) )) {
		  message = "글작성자만 삭제 가능합니다.";
	  }
	  else {
		  result = service.delDepNoticeEnd(paraMap);	
		  message = "글이 삭제되었습니다.";
	  }

	  jsonObj.put("result", result); 
	  jsonObj.put("message", message); 

	  return jsonObj.toString();

   }	  
	
	
	/////////////////////////////////////////////////// 부서 공지 끝 /////////////////////////////////
	
	
	
	
	
	
	
	
	/////////////////////////////////////////////////// 내가 쓴 공지 시작 /////////////////////////////////
	// 내가 쓴 공지 리스트 
	@RequestMapping(value = "/notice/myNoticeList.yolo")
	public ModelAndView myNoticeList(HttpServletRequest request, ModelAndView mav, NoticeVO noticevo) {
		
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		String empno = loginuser.getEmpno();
		request.setAttribute("empno", empno);
		
	 // noticevo.setFk_senderno(loginuser.getEmpno());
		empno.equals(noticevo.getFk_senderno());
			
		List<Map<String, String>> myNoticeList = service.getMyNoticeList(empno);
		
		/*
		for(Map<String, String> map : myNoticeList) {
			map.get("fk_senderno");
			System.out.println(map.get("fk_senderno"));
		}
		*/
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
		// System.out.println(notino);

			
		// map 으로 넣기( 해당 글의 공지번호를 통해 글 하나만 가져오기)
	    Map<String, String> myNotice = service.showMyNoticeContent(notino);

	    // ajax
        JSONObject jsonObj = new JSONObject();
        jsonObj.put("notino", myNotice.get("notino"));
        jsonObj.put("fk_senderno", myNotice.get("fk_senderno"));
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
	
	
	
	// 내가 쓴 공지리스트 수정
	@ResponseBody
	@RequestMapping(value = "/notice/getMyNoticeContent.yolo", produces="text/plain;charset=UTF-8",  method= {RequestMethod.POST})
	public String editMyNotice(NoticeVO noticevo, HttpServletRequest request ) {
		
		String notino = noticevo.getNotino();
		
//		System.out.println("수정번호 : "+ notino);
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		noticevo.setFk_senderno(loginuser.getEmpno());
		
		// map 으로 넣기( 공지 수정을 위해 해당 공지번호 글 하나만 가져오기) (맵에 담으면 맵으로 받음/VO는 NoticeVO로)
		
				
		noticevo =  service.showEditMyNoticeContent(notino);
//			service.editNotice(editNoticevo, noticevo); // 공지글 수정하기
		
		// ajax
        JSONObject jsonObj = new JSONObject();
		
        jsonObj.put("notino", noticevo.getNotino());
        jsonObj.put("subject", noticevo.getSubject());
        jsonObj.put("content", noticevo.getContent());
        
//	      System.out.println("부서수정공지 맵 :" +jsonObj);
        return jsonObj.toString(); 
	}
	
	
	// 내가 쓴 공지글 1개 삭제  요청
   @ResponseBody
   @RequestMapping(value = "/notice/deleteMyNoticeEnd.yolo",produces="text/plain;charset=UTF-8", method = {RequestMethod.POST })
   public String deleteMyNoticeEnd(HttpServletRequest request, HttpServletResponse response) {
      
      // 삭제하고자 하는 글의 번호 가져오기
      String notino = request.getParameter("notino"); // notino (jsp에 name or ajax로 데이터 넘겨줘야)
      // 공지 작성자의 번호 가져오기
      String fk_senderno = request.getParameter("fk_senderno");
      // System.out.println(fk_senderno);
      // System.out.println("글삭제번호 :" + notino);
      
      
      // 글 한 개 삭제(삭제글 정보 1개 맵에 담기)
      Map<String, String> paraMap = new HashMap<>();
      paraMap.put("notino", notino);
      paraMap.put("fk_senderno", fk_senderno);
      
      HttpSession session = request.getSession();
	  EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
	  
	  String empno = loginuser.getEmpno();
	  request.setAttribute("empno", empno);
	  
	  paraMap.put("empno", empno);
	  
	  String message = "";

	  int result = 0;
	  
	  JSONObject jsonObj = new JSONObject();
	  System.out.println("내가쓴공지:"+paraMap);
	  
	  if( !(empno.equals(fk_senderno) )) {
		  message = "글작성자만 삭제 가능합니다.";
	  }
	  else {
		  result = service.delMyNoticeEnd(paraMap);	
		  message = "글이 삭제되었습니다.";
	  }

	  jsonObj.put("result", result); 
	  jsonObj.put("message", message); 

	  return jsonObj.toString();

   }	  
	
	
	
	/////////////////////////////////////////////////// 내가 쓴 공지 끝 /////////////////////////////////
   
	
	
	
}
