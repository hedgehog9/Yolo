package com.yolo.hr.jjy.employee.controller;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelManagerXlsx {
	 
private static ExcelManagerXlsx excelXlsxMng;
    
    public ExcelManagerXlsx() {
        // TODO Auto-generated constructor stub
    }
    
    public static ExcelManagerXlsx getInstance() {
        if (excelXlsxMng == null)
            excelXlsxMng = new ExcelManagerXlsx();
        return excelXlsxMng;
    }
 
 
public List<HashMap<String, String>> getListXlsxRead(String excel) throws Exception {
 
List<HashMap<String, String>> list = new ArrayList<HashMap<String,String>>();
File file = new File( excel );
if( !file.exists() || !file.isFile() || !file.canRead() ) {
throw new IOException( excel );
}
XSSFWorkbook wb = new XSSFWorkbook( new FileInputStream(file) );
 
//xls시 이용
//HSSFWorkbook  wb = new HSSFWorkbook ( new FileInputStream(file) );
 
int check = 0;
 
try {
for( int i=0; i<1; i++ ) {  
   for( Row row : wb.getSheetAt(i) ) {
       if(check != 0) {
       
       HashMap<String, String> hMap = new HashMap<String, String>();
       String valueStr = ""; 
       int cellLength = (int) row.getLastCellNum();
       for(int j=0; j<cellLength; j++){
    Cell cell = row.getCell(j);
       
      if (cell == null || cell.getCellType() == CellType.BLANK) {
    valueStr = "";
  }else{
    switch(cell.getCellType()){
        case STRING :
            valueStr = cell.getStringCellValue();
            break;
        case NUMERIC : // 날짜 형식이든 숫자 형식이든 다 CELL_TYPE_NUMERIC으로 인식함.
            if(DateUtil.isCellDateFormatted(cell)){ // 날짜 유형의 데이터일 경우,
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
                String formattedStr = dateFormat.format(cell.getDateCellValue());
                valueStr = formattedStr;
                break;
            }else{ // 순수하게 숫자 데이터일 경우,
                Double numericCellValue = cell.getNumericCellValue();
                if(Math.floor(numericCellValue) == numericCellValue){ // 소수점 이하를 버린 값이 원래의 값과 같다면,,
                    valueStr = numericCellValue.intValue() + ""; // int형으로 소수점 이하 버리고 String으로 데이터 담는다.
                }else{
                    valueStr = numericCellValue + "";
                }
                break;
            }
        case BOOLEAN :
            valueStr = cell.getBooleanCellValue() + "";
            break;
    }
         
  }
       
 hMap.put("cell_"+j ,valueStr);
           
       }
       
      list.add(hMap);
 }
 
 check++; 
}
 
}
 
} catch( Exception ex ) {
ex.printStackTrace();
}
 
return list;
}
}