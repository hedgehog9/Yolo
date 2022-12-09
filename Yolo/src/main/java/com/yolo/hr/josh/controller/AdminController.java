package com.yolo.hr.josh.controller;

import java.io.IOException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections4.map.HashedMap;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
		
		request.setAttribute("deptList", deptList);
		
		return "josh/commute_management.admin";
	}
	
	
	@ResponseBody
	@RequestMapping(value="/admin/selectCommuteList.yolo", produces="text/plain;charset=UTF-8", method = {RequestMethod.GET})
	public String selectCommuteList(HttpServletRequest request, HttpServletResponse response, @RequestParam(name = "arrDept[]", required = false) List<String> arrDept) {
		
		HttpSession session = request.getSession();
		EmployeeVO empvo = (EmployeeVO) session.getAttribute("loginuser");
		String empno = empvo.getEmpno();
		
		JSONArray jsonArr = new JSONArray();
		
		if(!empno.equals("9999")) { // 관리자가 아닌데 접근했을 경우
			RequestDispatcher dispatcher = request.getRequestDispatcher("/notice/noticeList.yolo");
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
			
			System.out.println("selectCommuteList 확인용 startdate => " + startdate);
			System.out.println("selectCommuteList 확인용 enddate => " + enddate);
			System.out.println("selectCommuteList 확인용 currentShowPageNo => " + currentShowPageNo);
			System.out.println("selectCommuteList 확인용 arrDept => " + arrDept);
			/*
			확인용 startdate => 2022-11-28
			확인용 enddate => 2022-12-02
			확인용 currentShowPageNo => 1
			확인용 arrDept => 
			*/
			
			
			if(currentShowPageNo == null) {
				currentShowPageNo = "1";
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
	public String commuteTotalPage(HttpServletRequest request, @RequestParam(name = "arrDept[]", required = false) List<String> arrDept) {
		
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		
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
	public String payStub(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO empvo = (EmployeeVO) session.getAttribute("loginuser");
		String empno = empvo.getEmpno();
		
		String select_year = request.getParameter("select-year");
		
		Map<String, Object> paraMap = new HashMap<>();
		
		
		if(empno.equals("9999")) { // 관리자 아이디로 들어왔을때
			if(select_year == null) {
				
				Calendar now = Calendar.getInstance();
				 
				select_year = String.valueOf(now.get(Calendar.YEAR));
			}
			
			
		}
		else { // 일반사원이 들어왔을 때
			
			if(select_year == null) {
				
				Calendar now = Calendar.getInstance();
				 
				select_year = String.valueOf(now.get(Calendar.YEAR));
			}
			
		}
		
		paraMap.put("empno",empno);
		paraMap.put("select_year",select_year);
		
		List<Map<String, String>> payStubList = service.getPayStubList(paraMap);
		
		request.setAttribute("payStubList", payStubList);
		
		
		return "josh/pay_stub.admin";
	}
	
	@RequestMapping(value="/admin/payment.yolo")
	public String payment(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		EmployeeVO empvo = (EmployeeVO) session.getAttribute("loginuser");
		String empno = empvo.getEmpno();
		
		if(!empno.equals("9999")) { // 관리자가 아닌데 접근했을 경우
			RequestDispatcher dispatcher = request.getRequestDispatcher("/notice/noticeList.yolo");
			try {
				dispatcher.forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		}
		else {
			List<HashMap<String, String>> deptList = new ArrayList<>();
			
			// 부서들을 가져오는 메소드
			deptList = dao.selectDeptList();
			
			request.setAttribute("deptList", deptList);
			
		}
		
		return "josh/payment.admin";
	}
	
	@ResponseBody
	@RequestMapping(value="/admin/getPaymentList.yolo", produces="text/plain;charset=UTF-8", method = {RequestMethod.GET})
	public String getPaymentList(HttpServletRequest request, HttpServletResponse response, @RequestParam(name = "arrDept[]", required = false) List<String> arrDept) {
		
		HttpSession session = request.getSession();
		EmployeeVO empvo = (EmployeeVO) session.getAttribute("loginuser");
		String empno = empvo.getEmpno();
		
		JSONArray jsonArr = new JSONArray();
		
		if(!empno.equals("9999")) { // 관리자가 아닌데 접근했을 경우
			RequestDispatcher dispatcher = request.getRequestDispatcher("/notice/noticeList.yolo");
			try {
				dispatcher.forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		}
		else { // 관리자 아이디로 접근했을 경우
			
			String startdate = request.getParameter("startdate");
			String enddate = request.getParameter("enddate");
			String month_payment = request.getParameter("month_payment");
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			
			System.out.println("getPaymentList 확인용 startdate => " + startdate);
			System.out.println("getPaymentList 확인용 enddate => " + enddate);
			System.out.println("getPaymentList 확인용 currentShowPageNo => " + currentShowPageNo);
			System.out.println("getPaymentList 확인용 arrDept => " + arrDept);
			/*
			확인용 startdate => 2022-11-28
			확인용 enddate => 2022-12-02
			확인용 currentShowPageNo => 1
			확인용 arrDept => 
			*/
			
			
			if(currentShowPageNo == null) {
				currentShowPageNo = "1";
			}
			
			
			int sizePerPage = 10;
			
			int startRno = (( Integer.parseInt(currentShowPageNo) - 1) * sizePerPage) + 1;
	        int endRno = startRno + sizePerPage - 1;
			
			Map<String, Object> paraMap = new HashMap<>();
			paraMap.put("startdate", startdate);
			paraMap.put("enddate", enddate);
			paraMap.put("month_payment", month_payment);
			paraMap.put("currentShowPageNo", currentShowPageNo);
			paraMap.put("arrDept", arrDept);
			paraMap.put("startRno", String.valueOf(startRno));
			paraMap.put("endRno", String.valueOf(endRno));
			
			List<HashMap<String, String>> getPaymentList = new ArrayList<>();
	        
			getPaymentList = service.getPaymentList(paraMap);
	        
	        if(getPaymentList != null) {
	        	
	        		for(HashMap<String, String> map : getPaymentList) {
	        			JSONObject jsonObj = new JSONObject();
	        			
	        			jsonObj.put("name", map.get("name"));
	        			jsonObj.put("empno", map.get("empno"));
	        			jsonObj.put("worktime_salary", map.get("worktime_salary"));
	        			jsonObj.put("overtime_salary", map.get("overtime_salary"));
	        			jsonObj.put("fk_deptno", map.get("fk_deptno"));
	        			jsonObj.put("deptname", map.get("deptname"));
	        			jsonObj.put("upper_deptname", map.get("upper_deptname"));
	        			jsonObj.put("profile_color", map.get("profile_color"));
	        			jsonObj.put("sum_salary", map.get("sum_salary"));
	        			
	        			jsonArr.put(jsonObj);
	        		}
	        	
	        }
	   }
		
		
		return jsonArr.toString();
		
	}
	
	
	@ResponseBody
	@RequestMapping(value="/admin/paymentListTotalPage.yolo", produces="text/plain;charset=UTF-8", method = {RequestMethod.GET})
	public String paymentListTotalPage(HttpServletRequest request, @RequestParam(name = "arrDept[]", required = false) List<String> arrDept) {
		
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String month_payment = request.getParameter("month_payment");
		
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("startdate", startdate);
		paraMap.put("enddate", enddate);
		paraMap.put("month_payment", month_payment);
		paraMap.put("arrDept", arrDept);
		
		int totalPage = dao.paymentListTotalPage(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("totalPage", totalPage);
		
		return jsonObj.toString();
	}
	
	
	@ResponseBody
	@RequestMapping(value="/admin/checkedPayment.yolo", produces="text/plain;charset=UTF-8", method = {RequestMethod.POST})
	public String addAlarm_checkedPayment(Map<String, String> paraMap, HttpServletRequest request, @RequestParam String jsonData) {
		
		String month_payment = "";
		
		JSONObject jsonObj = new JSONObject();
		
		JSONArray array = new JSONArray(jsonData);
		
		String empnoList = "";
	    
		List<Map<String, Object>> paraList = new ArrayList<Map<String, Object>>();
		
		for(Object obj : array) {
			 
			jsonObj = (JSONObject)obj;
			 
			//System.out.println("확인용 jsonObj => " + jsonObj);
			 
			String empno = (String) jsonObj.get("empno");
			month_payment = (String) jsonObj.get("month_payment");
			String salary = (String) jsonObj.get("salary");
			String over_salary = (String) jsonObj.get("over_salary");
			
			Map<String, Object> paymentMap = new HashMap<>();
			paymentMap.put("empno", empno);
			paymentMap.put("month_payment", month_payment);
			paymentMap.put("salary", salary);
			paymentMap.put("over_salary", over_salary);
			
			paraList.add(paymentMap);
			
			empnoList += empno+",";
			 
		 }// end of for ------------------------------------------
		
		int n = service.checkedPayment(paraList);
		
		empnoList = empnoList.substring(0, empnoList.length()-1);
		
		if(n > 0) {
			paraMap.put("fk_recipientno", empnoList ); // 받는사람 (여러명일때는 ,으로 구분된 str)
		    paraMap.put("url", "/admin/payStub.yolo?empno=" );
		    paraMap.put("url2", empnoList ); // 연결되는 pknum등...  (여러개일때는 ,으로 구분된 str)(대신 받는 사람 수랑 같아야됨)
		    paraMap.put("alarm_content", month_payment+"월 급여가 지급되었습니다." );
		    paraMap.put("alarm_type", "6" );
		}
		
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
}
