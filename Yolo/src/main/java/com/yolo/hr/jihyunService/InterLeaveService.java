package com.yolo.hr.jihyunService;

import java.util.List;
import java.util.Map;

public interface InterLeaveService {

	// 휴가 종류와 남은 일수 구해오기
	List<Map<String, String>> getLeaveTypeList(Map<String, String> paraMap);

}
