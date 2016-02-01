package com.hoson.test;

import java.sql.*;
import java.util.*;
import com.hoson.*;
import com.hoson.util.*;


public class TestReportTime{
	
	public static void main(String[]args)throws Exception{
		
		System.out.println(1);
		System.out.println(f.time().getDate()+"////////////");
		String s = "2008-8-28 15:8:8";
		String s2 = null;
		Timestamp t = f.time(s);
		System.out.println(t);
		int x =0;
		
		x = t.getDate();
		System.out.println(x);
		
		x = t.getDay();
		System.out.println(x);
		
		x = t.getMonth();
		System.out.println(x);
		
		x = t.getHours();
		System.out.println(x);
		
		
		
		
		String cls = null;
		
		cls = StringUtil.trimDay(t).getClass().getName()+"";
		System.out.println(cls);
		
		s2 = StringUtil.trimDay(t)+"";
		System.out.println(s2);
		
		//s2 = StringUtil.trimHour(t)+"";
		//System.out.println(s2);
		
		s2 = StringUtil.trimMon(t)+"";
		System.out.println(s2);
		
		//int x = 0;
		x = StdReportUtil.getMonthDayNum("2008-7-7");
		System.out.println(x);
		x = StdReportUtil.getMonthDayNum("2008-6-6");
		System.out.println(x);
		x = StdReportUtil.getMonthDayNum("2008-5-5");
		System.out.println(x);
		
		x = StdReportUtil.getMonthDayNum("2008-2-2");
		System.out.println(x);
		
		x = StdReportUtil.getMonthDayNum("2000-2-2");
		System.out.println(x);
		x = StdReportUtil.getMonthDayNum("2004-2-5");
		System.out.println(x);
		
		x = StdReportUtil.getMonthDayNum("1998-2-5");
		System.out.println(x);
		
		
	}
}