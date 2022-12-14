package com.yolo.hr.josh.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yolo.hr.josh.model.InterScheduleDAO;

@Service
public class VacationScheduleService implements InterVacationScheduleService {

	@Autowired
	private InterScheduleDAO scheduledao;
	
	
	@Override
	public void addSchedule(Map<String, String> paraMap) {
		/*
		insert into tbl_schedule(schedule_no, fk_empno, start_date, end_date, subject, color, category, fk_deptno)
		values(#{schedule_no}, #{fk_empno}, to_date(#{start_date},'YYYY-MM-DD HH24:MI:SS'), to_date(#{end_date},'YYYY-MM-DD HH24:MI:SS'), #{subject}, #{color}, #{category}, #{fk_deptno})
	
		paraMap.put("schedule_no", getSequenceNo 메소드로 채번해온 값 넣기) 
		paraMap.put("fk_empno", 사번);
		paraMap.put("start_date", 휴가시작날짜);
		paraMap.put("end_date", 휴가마지막날짜);
		paraMap.put("subject", "(신청자 이름) 휴가");
		paraMap.put("color", "#b380ff;");
		paraMap.put("category", "휴가");
		paraMap.put("fk_deptno", 휴가자 부서번호);
		
		*/
		
		scheduledao.insertVactionSchedule(paraMap);
		
		
	}

	
	
}
