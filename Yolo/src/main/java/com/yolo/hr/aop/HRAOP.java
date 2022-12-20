package com.yolo.hr.aop;

import java.util.Map;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.yolo.hr.jihyunService.InterAlarmService;
import com.yolo.hr.josh.service.InterVacationScheduleService;


@Aspect// 공통관심사 클래스(Aspect 클래스)로 등록
@Component // bean 으로 등록
public class HRAOP {
	
	// 필드로 넣어줌
	@Autowired
	private InterVacationScheduleService VacationScheduleService; // Type 에 따라 Spring 컨테이너가 알아서 bean 을 주입시켜준다.
	
	// ===== #97. After Advice(보조업무) 만들기 ====== // 
	/*
	       주업무(<예: 글쓰기, 제품구매 등등>)를 실행한 다음에  
	       회원의 포인트를 특정점수(예: 100점, 200점, 300점) 증가해 주는 것이 공통의 관심사(보조업무)라고 보자.
	       관심 클래스(Aspect 클래스)를 생성하여 포인트컷(주업무)과 어드바이스(보조업무)를 생성하여
	       동작하도록 만들겠다. 
	*/   
	// === Pointcut(주업무)을 설정해야한다. === //
	// Pointcut 이란 공통관심사를 필요로 하는 메소드를 말한다 // 메소드를 찾아가야한다. 메소드가 포함되어있는 클래스명까지 명기해줘야 한다 (지금은 베이스 패키지 까지만 적어줬땅)
	@Pointcut("execution(public * com.yolo..*Controller.addAlarm_*(..) )")  
	// com.spring으로 시작하는 모든 패키지 에서 끝이 Controller로 끝나는 모든 클래스의 
	// requiredLogin_시잣하는 모든메소드 ( .. ) 해당 메소드에 파라미터가 없어도 되고 , 파라미터가 있어도 그 개수와 종류를 안따지겠다는 뜻
	public void addAlarm() {}
	
	
	// 필드로 넣어줌
	@Autowired
	private InterAlarmService alarmService; // Type 에 따라 Spring 컨테이너가 알아서 bean 을 주입시켜준다. 

	
	// === After Advice (공통관심사, 보조업무)를 구현한다 === //
	@SuppressWarnings("unchecked") // 기냥 노랑줄 없애려고 쓴거임
	@After("addAlarm()") // 이 메소드를 실행 하기 전에 아래의 메소드를 실행해준다 
	public void addAlarm(JoinPoint joinpoint) { // JoinPoint joinpoint는 포인트컷 되어진 주업무의 메소드이다. (requiredLogin_jumun 메소드 등등/...)
		
		
		Map<String, String> paraMap = (Map<String, String>) joinpoint.getArgs()[0]; // return타입이 Object의 배열이다 (주업무에 잇던 파라미터를 몽땅 가져온다. 파라미터의 개수가 복수개일수 잇으니..)
		// 첫번째 파라미터인 맵을 넣어준 것임 
		
		alarmService.addAlarm(paraMap);
		
	}
	
	
	@Pointcut("execution(public * com.yolo..*Controller.addSchedule_*(..) )")
	public void addSchedule() {}
	
	
	
	@SuppressWarnings("unchecked")
	@After("addSchedule()") // 이 메소드를 실행 하기 전에 아래의 메소드를 실행해준다 
	public void addSchedule(JoinPoint joinpoint) { 
		
		Map<String, String> paraMap = (Map<String, String>) joinpoint.getArgs()[0]; 
		VacationScheduleService.addSchedule(paraMap);
		
	}
	
	
	
	@Pointcut("execution(public * com.yolo..*Controller.*_delSchedule(..) )")  
	public void delSchedule() {}
	
	@SuppressWarnings("unchecked")
	@After("delSchedule()") // 이 메소드를 실행 하기 전에 아래의 메소드를 실행해준다 
	public void delSchedule(JoinPoint joinpoint) { 
		
		Map<String, String> paraMap = (Map<String, String>) joinpoint.getArgs()[1]; 
		
		VacationScheduleService.delSchedule(paraMap);
		
	}

}
