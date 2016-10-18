package com.sykj.app.util;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

public class ExcelFileUtil {

	public static List<String[][]> read(File file) throws BiffException, IOException{ 
		//      创建方法返回List集合对象 
		        List<String[][]> contents = new ArrayList<String[][]>(); 
		//      创建excel文件的工作簿对象book 
		       Workbook book = Workbook.getWorkbook(file); 
		//      获取excel文件工作簿的工作表数量sheets 
		        Sheet[] sheets = book.getSheets(); 
		//      声明每个工作表存储的二维数组对象 
		        String[][] row_contents = null; 
		//      逐个工作表开始读取 
		       for(int sheet_index=0;sheet_index<sheets.length;sheet_index++) {
		//          测试语句 
		            //System.out.println("当前为"+sheet_index+"个工作簿！"); 
		//          创建工作表对象sheet 
		            Sheet sheet = sheets[sheet_index]; 
		//          获取excel当前工作表的总行数 
		            int rows = sheet.getRows(); 
		 
		//          获取excel当前工作表的总列数 
		            int columns = sheet.getColumns(); 
		//          测试语句 
		            //System.out.println("当前工作簿一共有"+rows+"行、"+columns+"列"); 
		//          创建当前工作表的存储二维数组 
		            row_contents = new String[rows][columns]; 
		//          循环将当前工作簿内容保存到对象中 
		//          循环行 
		            for(int row_index=0;row_index<rows;row_index++) { 
		//              循环列 
		                String[] column_contents = new String[columns]; 
		                for(int column_index=0;column_index<columns;column_index++) { 
		//                  获取当前工作表.row_index,column_index单元格的cell对象 
		                   Cell cell = sheet.getCell(column_index,row_index); 
		//                  获取内容值 
		                   column_contents[column_index] = cell.getContents(); 
		                } 
		//              当前sheet,当前row的所有column,存放到row_contents二维数组的row_index位置 
		                row_contents[row_index] = column_contents; 
		            } 
		            /**
		             * 读取测试输出代码片
		             */ 
		            //----------------------------------------------------------------------- 
//		           for(int j=0;j<row_contents.length;j++) { 
//		                for(int k=0;k<row_contents[j].length;k++){ 
//		                   System.out.print(row_contents[j][k]+"\t"); 
//		                }
//		                System.out.println(); 
//		            }
		            //-----------------------------------------------------------------------
		//          集合收集数据 
		            contents.add(row_contents); 
		        }
		//      返回
		      return contents; 
		   } 
}
