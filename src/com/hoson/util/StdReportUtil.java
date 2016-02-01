package com.hoson.util;

import java.util.*;
import com.hoson.*;
import java.sql.*;
import java.sql.Date;




public class StdReportUtil{
	
	public static Map getStartAndEndTime(String date,String report_type)
	throws Exception{
		Map m = null;
		
		if(f.eq(report_type,"month")){
			return getMonthReportStartAndEndTime(date);
		}
		
		if(f.eq(report_type,"year")){
			return getYearReportStartAndEndTime(date);
		}
		
		
		return getDayReportStartAndEndTime(date);
		
	}
	
	
	public static Map getDayReportStartAndEndTime(String date)
	throws Exception{
		Map m = new HashMap();
		
		Timestamp t1 = f.time(date);
		Timestamp t2 = null;
		
		t2 = f.dateAdd(t1,"day",1);
		
		Date d = null;
		
		d = new Date(t2.getTime());
		
		String s1 = date;
		String s2 = d+"";
		m.put("start",s1);
		m.put("end",s2);
		
		
	
		
		
		return m;
		
	}
	
	public static Map getMonthReportStartAndEndTime(String date)
	throws Exception{
		Map m = new HashMap();
		
		Timestamp t1 = f.time(date);
		Timestamp t2 = null;
		Date d1 = null;
		Date d2 = null;
		
		
		
		
		
		t1 = (Timestamp)StringUtil.trimDay(t1);
		
		t2 = f.dateAdd(t1,"month",1);
		
		
		d1 = new Date(t1.getTime());
		d2 = new Date(t2.getTime());
		
		
		String s1 = d1+"";
		String s2 = d2+"";
		m.put("start",s1);
		m.put("end",s2);
		
		
		
		return m;
		
	}
	public static Map getYearReportStartAndEndTime(String date)
	throws Exception{
		Map m = new HashMap();
		
		Timestamp t1 = f.time(date);
		Timestamp t2 = null;
		Date d1 = null;
		Date d2 = null;
		
		
		
		
		
		t1 = (Timestamp)StringUtil.trimMon(t1);
		
		t2 = f.dateAdd(t1,"year",1);
		
		
		d1 = new Date(t1.getTime());
		d2 = new Date(t2.getTime());
		
		
		String s1 = d1+"";
		String s2 = d2+"";
		m.put("start",s1);
		m.put("end",s2);
		
		
		
		return m;
		
	}
	
	public static void q(List list,String qcol,String col){
		int i,num=0;
		Map m = null;
		Double qobj = null;
		Double vobj = null;
		double q,v = 0;
		double hjValue = 0;
		
		
		
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			
			//try{
			qobj = (Double)m.get(qcol);
			if(qobj==null){continue;}
			
			vobj = (Double)m.get(col);
			if(vobj==null){continue;}
			
			q = qobj.doubleValue();
			v = vobj.doubleValue();
			v = q*v ;
			hjValue = hjValue + v;
			//System.out.println(qcol+","+col+","+v);
			
			m.put(col+"_q",new Double(v));
			//}catch(Exception e){}
			
		}
		
		if(num==0){
			m = new HashMap();
			m.put("hj_flag", "false");
		}else{
			m.put(col+"_hj", new Double(hjValue));
			m.put("hj_flag", "true");
		}
		
	}
	
	
	public static void qs(List list,String qcol,String cols){
		String[]arr = cols.split(",");
		int i,num=0;
		String col = null;
		
		num =arr.length;
		
		for(i=0;i<num;i++){
			col=arr[i];
			q(list,qcol,col);
		}
		
		
	}
	
	public static void qs(List list){
		qs(list,"g_q","g_pm,g_so2,g_nox,g_pm2,g_so22,g_nox2");
		qs(list,"w_q","w_cod,w_ss,w_tn,w_tp,w_nh3n");
	}
	
	public static void hztj(List list,String col,Map map){
		
		Map m = null;
		int i,num=0;
		int ynum = 0;
		Double vobj = null;
		Double minobj,maxobj,sumobj = null;
		double v = 0;
		Double avgobj = null;
		Object v_flag = null;
		minobj=null;
		maxobj=null;
		
		
		num = list.size();
		
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			v_flag = m.get("v_flag");
			if(v_flag !=null && !"".equals(v_flag) && !v_flag.equals("5")){//不统计无效数据
				vobj = (Double)m.get(col);
				if(vobj==null){continue;}
				
				if(minobj==null){
					minobj=vobj;
					}else{
						v = vobj.doubleValue();
						if(v<minobj.doubleValue()){minobj=vobj;}
					}
				
				if(maxobj==null){
					maxobj=vobj;
					}else{
						v = vobj.doubleValue();
						if(v>maxobj.doubleValue()){maxobj=vobj;}
					}
				
				if(sumobj==null){
					sumobj=vobj;
					}else{
						v = vobj.doubleValue();
						//if(v>maxobj.doubleValue()){maxobj=vobj;}
						v = sumobj.doubleValue()+v;
						sumobj=new Double(v);
					}
				
				ynum++;
	     	}else if(v_flag == null){
	     		vobj = (Double)m.get(col);
				if(vobj==null){continue;}
				
				if(minobj==null){
					minobj=vobj;
					}else{
						v = vobj.doubleValue();
						if(v<minobj.doubleValue()){minobj=vobj;}
					}
				
				if(maxobj==null){
					maxobj=vobj;
					}else{
						v = vobj.doubleValue();
						if(v>maxobj.doubleValue()){maxobj=vobj;}
					}
				
				if(sumobj==null){
					sumobj=vobj;
					}else{
						v = vobj.doubleValue();
						//if(v>maxobj.doubleValue()){maxobj=vobj;}
						v = sumobj.doubleValue()+v;
						sumobj=new Double(v);
					}
				
				ynum++;
	     		
	     	}
			
			
		}
		
		
		if(ynum<1){return;}
		
		if(sumobj!=null){
			v = sumobj.doubleValue();
			v = v/ynum;
			avgobj=new Double(v);
		}
		
		map.put(col+"_min",minobj);
		map.put(col+"_max",maxobj);
		map.put(col+"_sum",sumobj);
		map.put(col+"_avg",avgobj);
		map.put(col+"_count",new Integer(ynum));
		
		
	}
	public static void hztjs(List list,String cols,Map map){
		String[]arr=cols.split(",");
		int i,num=0;
		String col = null;
		
		num =arr.length;
		
		for(i=0;i<num;i++){
			col=arr[i];
			if(f.empty(col)){continue;}
			hztj(list,col,map);
		}
		
		
	}
	
	public static int getMonthDayNum(String time)throws Exception{
		int num =0;
		Timestamp t  = null;
		
		t = f.time(time);
		t = (Timestamp)StringUtil.trimDay(t);
		
		//t  = f.
		t = f.dateAdd(t,"month",1);
		t = f.dateAdd(t,"day",-1);
		
		num = t.getDate();
		
		
		return num;
	}
	
	
	public static Timestamp time(String s,Timestamp def){
		Timestamp t = null;
		try{
		t = f.time(s);
		}catch(Exception e){
			t=def;
		}
		
		return t;
	}
	
	public static List getDayReportDataList(List list)
	throws Exception{
		List list2 = new ArrayList();
		int i,num=0;
		Map m = null;
		String m_time = null;
		Timestamp t = null;
		int h = 0;
		Map data = new HashMap();
		List list3 = new ArrayList();
		
		num = list.size();
		
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			m_time = (String)m.get("m_time");
			t = time(m_time,null);
			if(t==null){continue;}
			h = t.getHours();
			m.put("time",new Integer(h));
			list2.add(m);
			
			
			
			
			
		}
		
		num = list2.size();
		for(i=0;i<num;i++){
			m = (Map)list2.get(i);
		    data.put(m.get("time"),m);
		}
		
		 
		for(i=0;i<24;i++){
			m = (Map)data.get(new Integer(i));
			if(m==null){m=new HashMap();}
			m.put("time",new Integer(i));
			list3.add(m);
			
		}
		
		return list3;
		
	}
	
	public static List getMonthReportDataList(List list,String date)
	throws Exception{
		List list2 = new ArrayList();
		int i,num=0;
		Map m = null;
		String m_time = null;
		Timestamp t = null;
		int h = 0;
		Map data = new HashMap();
		List list3 = new ArrayList();
		
		num = list.size();
		
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			m_time = (String)m.get("m_time");
			t = time(m_time,null);
			if(t==null){continue;}
			//h = t.getHours();
			h = t.getDate()-1;
			m.put("time",new Integer(h));
			list2.add(m);
			
			
			
			
			
		}
		
		num = list2.size();
		for(i=0;i<num;i++){
			m = (Map)list2.get(i);
		    data.put(m.get("time"),m);
		}
		
		 num = getMonthDayNum(date);
		for(i=0;i<num;i++){
			m = (Map)data.get(new Integer(i));
			if(m==null){m=new HashMap();}
			m.put("time",new Integer(i));
			list3.add(m);
			
		}
		
		return list3;
		
	}
	
	
	public static List getYearReportDataList(List list)
	throws Exception{
		List list2 = new ArrayList();
		int i,num=0;
		Map m = null;
		String m_time = null;
		Timestamp t = null;
		int h = 0;
		Map data = new HashMap();
		List list3 = new ArrayList();
		
		num = list.size();
		
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			m_time = (String)m.get("m_time");
			t = time(m_time,null);
			if(t==null){continue;}
			h = t.getMonth();
			m.put("time",new Integer(h));
			list2.add(m);
			
			
			
			
			
		}
		
		num = list2.size();
		for(i=0;i<num;i++){
			m = (Map)list2.get(i);
		    data.put(m.get("time"),m);
		}
		
		 
		for(i=0;i<12;i++){
			m = (Map)data.get(new Integer(i));
			if(m==null){m=new HashMap();}
			
			m.put("time",new Integer(i));
			
			list3.add(m);
			
		}
		
		return list3;
		
	}
	
	public static List getReportDataList(String report_type,List list,String date)
	throws Exception{
		
		if(f.eq(report_type,"month")){
			return getMonthReportDataList(list,date);
			}
		if(f.eq(report_type,"year")){
			return getYearReportDataList(list);
			}
		return getDayReportDataList(list);
		
		
	}
	
	
	
}