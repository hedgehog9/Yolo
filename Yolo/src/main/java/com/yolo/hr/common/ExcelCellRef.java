package com.yolo.hr.common;


import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.util.CellReference;
 
public class ExcelCellRef {
 
    /**
     * Cell에 해당하는 Column Name을 가져온다(A,B,C..)
     * 만약 Cell이 Null이라면 int cellIndex의 값으로
     * Column Name을 가져온다.
     * @param cell
     * @param cellIndex
     * @return
     */
    public static String getName(Cell cell, int cellIndex) {
        int cellNum = 0;
        if(cell != null) {
            cellNum = cell.getColumnIndex();
        }
        else {
            cellNum = cellIndex;
        }
 
        return CellReference.convertNumToColString(cellNum);
    }
 
    @SuppressWarnings("deprecation")
    public static String getValue(Cell cell) {
        String value = "";
 
        if(cell == null) {
            value = "";
        }
        else {
            if( cell.getCellType() == CellType.FORMULA ) {
                value = cell.getCellFormula();
            }
            else if(cell.getCellType() == CellType.NUMERIC) {

    			if( DateUtil.isCellDateFormatted(cell)) {

    				Date date = cell.getDateCellValue();
    				value = new SimpleDateFormat("yyyy-MM-dd").format(date);

    			}

    			else
//    				value = String.valueOf(cell.getNumericCellValue());
    			value = String.valueOf((int)cell.getNumericCellValue());
    		}
            else if( cell.getCellType() == CellType.STRING ) {
                value = cell.getStringCellValue();
            }
            else if( cell.getCellType() == CellType.BOOLEAN ) {
                value = cell.getBooleanCellValue() + "";
            }
            else if( cell.getCellType() == CellType.ERROR ) {
                value = cell.getErrorCellValue() + "";
            }
            else if( cell.getCellType() == CellType.BLANK ) {
                value = "";
            }
            else {
                value = cell.getStringCellValue();
            }
        }
 
        return value;
    }
}