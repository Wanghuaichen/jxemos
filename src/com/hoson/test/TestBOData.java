package com.hoson.test;


import com.hoson.*;
import com.hoson.util.*;

public class TestBOData{
	
	
	public static void main(String args[])throws Exception{
		String s = null;
		
		s = BOData.sql("t_bo_report_hour");
		//System.out.println(s);
		
		s = BOData.grosssql();
		//System.out.println(s);
		try{
		//BOData.create_table();
			System.out.println(f.time());
		BOData.dayData();
			//BOData.hourData();
			
		}catch(Exception e){
			System.out.println(e);
		}
		System.out.println(f.time());
	}
	
}
