package com.yolo.hr.josh.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yolo.hr.jjy.employee.model.EmployeeVO;
import com.yolo.hr.josh.model.InterCommuteDAO;
import com.yolo.hr.josh.service.InterCommuteService;

@Controller
public class AdminController {

	@Autowired
	private InterCommuteService service;
	
	@Autowired
	private InterCommuteDAO dao;
	
	@RequestMapping(value="/admin/commuteManagement.yolo")
	public String commuteManagement(HttpServletRequest request) {
		
		List<HashMap<String, String>> deptList = new ArrayList<>();
		
		// 부서들을 가져오는 메소드
		deptList = dao.selectDeptList();
		
		/*
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		
		if(startdate == null && enddate == null) { // 처음으로 페이지 진입시
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			
			Calendar cal = Calendar.getInstance();
			
			//일주일의 첫날 선택
	        cal.setFirstDayOfWeek(Calendar.MONDAY);
	 
	        //해당 주차 시작일과의 차이 구하기용
	        int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK) - cal.getFirstDayOfWeek();
	 
	        //해당 주차의 첫날 세팅
	        cal.add(Calendar.DAY_OF_MONTH, - dayOfWeek);
	        
	        //해당 주차의 첫일자
	        startdate = format.format(cal.getTime());
	 
	        //해당 주차의 마지막 세팅
	        cal.add(Calendar.DAY_OF_MONTH, 4); 
	 
	        //해당 주차의 마지막일자
	        enddate = format.format(cal.getTime());
	        
			
			System.out.println("stDt => "+startdate);
			System.out.println("edDt => "+enddate);
			 
	        
		}
		
		Map<String, String> paraMap = new HashMap<>();
        
        paraMap.put("startdate",startdate);
        paraMap.put("enddate",enddate);
        
        List<HashMap<String, String>> totalCommuteList = new ArrayList<>();
        
        totalCommuteList = service.totalCommuteList(paraMap);
		*/
		
		request.setAttribute("deptList", deptList);
		
		return "josh/commute_management.admin";
	}
	
	
	@ResponseBody
	@RequestMapping(value="/admin/selectCommuteList.yolo", produces="text/plain;charset=UTF-8", method = {RequestMethod.GET})
	public String selectCommuteList(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		EmployeeVO empvo = (EmployeeVO) session.getAttribute("loginuser");
		String empno = empvo.getEmpno();
		
		JSONArray jsonArr = new JSONArray();
		
		if(!empno.equals("9999")) { // 관리자가 아닌데 접근했을 경우
			RequestDispatcher dispatcher = request.getRequestDispatcher(request.getContextPath()+"/notice/noticeList.yolo");
			try {
				dispatcher.forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		}
		else { // 관리자 아이디로 접근했을 경우
			
			String startdate = request.getParameter("startdate");
			String enddate = request.getParameter("enddate");
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			String arrDept = request.getParameter("arrDept");
			
			
			System.out.println("확인용 startdate => " + startdate);
			System.out.println("확인용 enddate => " + enddate);
			System.out.println("확인용 currentShowPageNo => " + currentShowPageNo);
			System.out.println("확인용 arrDept => " + arrDept);
			/*
			확인용 startdate => 2022-11-28
			확인용 enddate => 2022-12-02
			확인용 currentShowPageNo => 1
			확인용 arrDept => 
			*/
			
			if(currentShowPageNo == null) {
				currentShowPageNo = "1";
			}
			
			if(arrDept == null) {
				arrDept = "";
			}
			
			int sizePerPage = 10;
			
			int startRno = (( Integer.parseInt(currentShowPageNo) - 1) * sizePerPage) + 1;
	        int endRno = startRno + sizePerPage - 1;
			
			Map<String, Object> paraMap = new HashMap<>();
			paraMap.put("startdate", startdate);
			paraMap.put("enddate", enddate);
			paraMap.put("currentShowPageNo", currentShowPageNo);
			paraMap.put("arrDept", arrDept);
			paraMap.put("startRno", String.valueOf(startRno));
			paraMap.put("endRno", String.valueOf(endRno));
			
			List<HashMap<String, String>> totalCommuteList = new ArrayList<>();
	        
	        totalCommuteList = service.totalCommuteList(paraMap);
	        
	        if(totalCommuteList != null) {
	        	
	        		for(HashMap<String, String> map : totalCommuteList) {
	        			JSONObject jsonObj = new JSONObject();
	        			
	        			jsonObj.put("name", map.get("name"));
	        			jsonObj.put("empno", map.get("empno"));
	        			jsonObj.put("total_worktime", map.get("total_worktime"));
	        			jsonObj.put("total_overtime", map.get("total_overtime"));
	        			jsonObj.put("fk_deptno", map.get("fk_deptno"));
	        			jsonObj.put("deptname", map.get("deptname"));
	        			jsonObj.put("upper_deptname", map.get("upper_deptname"));
	        			jsonObj.put("profile_color", map.get("profile_color"));
	        			
	        			jsonArr.put(jsonObj);
	        		}
	        	
	        }
	   }
		
		
		return jsonArr.toString();
		
	}
	
	
	
	@ResponseBody
	@RequestMapping(value="/admin/commuteTotalPage.yolo", produces="text/plain;charset=UTF-8", method = {RequestMethod.GET})
	public String commuteTotalPage(HttpServletRequest request) {
		
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String arrDept = request.getParameter("arrDept");
		
		if(arrDept == null) {
			arrDept = "";
		}
		
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("startdate", startdate);
		paraMap.put("enddate", enddate);
		paraMap.put("arrDept", arrDept);
		
		int totalPage = dao.commuteTotalPage(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("totalPage", totalPage);
		
		return jsonObj.toString();
	}
	
	
	
	@RequestMapping(value="/admin/payStub.yolo")
	public String payStub() {
		
		
		
		return "josh/pay_stub.admin";
	}
	
	@RequestMapping(value="/admin/payment.yolo")
	public String payment() {
		
		
		
		return "josh/payment.admin";
	}
	
	
	
}
