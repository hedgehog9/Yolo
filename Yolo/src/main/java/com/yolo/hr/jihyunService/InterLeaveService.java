package com.yolo.hr.jihyunService;

import java.util.List;
import java.util.Map;

public interface InterLeaveService {

	// 휴가 종류와 남은 일수 구해오기
	List<Map<String, String>> getLeaveTypeList(Map<String, String> paraMap);

	// 모달에 들어갈 해당 휴가에 대한 상세 내용 알아오기
	Map<String, String> getLeaveDate(Map<String, String> paraMap);

}
