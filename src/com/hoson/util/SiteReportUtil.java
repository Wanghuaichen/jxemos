package com.hoson.util;

import com.hoson.*;

import java.util.*;
import java.sql.*;

import javax.servlet.http.HttpServletRequest;





public class SiteReportUtil{
	
	public static Timestamp add(Timestamp t,String type,int offset)throws Exception{
		java.util.Date d = null;
		d = StringUtil.dateAdd(t,type,offset);
		return new Timestamp(d.getTime());
		
	}
	
	public static Map getReportTimeInfo(String report_type,String m_time,String station_type)
	throws Exception{
		if(f.eq(report_type,"0") && f.eq(station_type,"6")){
			return getDayReportTimeInfo2(m_time);
		}
		
		if(f.eq(report_type,"0")){
			return getDayReportTimeInfo(m_time);
		}
		
		if(f.eq(report_type,"1")){
			return getWeekReportTimeInfo(m_time);
		}
		if(f.eq(report_type,"2")){
			return getMonthReportTimeInfo(m_time);
		}
		return getDayReportTimeInfo(m_time);
		
	}
	
	public static Map getDayReportTimeInfo(String m_time)
	throws Exception{
		Map m = new HashMap();
		List list = new ArrayList();
		Timestamp t0 = f.time(m_time);
		Timestamp t = null;
		int i,num=0;
		String start,end = null;
		num=24;
		
		for(i=0;i<num;i++){
			t = add(t0,"hour",i);
			list.add(t);
		}
		start = m_time;
		end = m_time+" 23:59:59";
		m.put("start",start);
		m.put("end",end);
		m.put("list",list);
		
		
		return m;
	}
	
	public static Map getDayReportTimeInfo2(String m_time)
	throws Exception{
		Map m = new HashMap();
		List list = new ArrayList();
		Timestamp t0 = f.time(m_time);
		Timestamp t = null;
		int i,num=0;
		String start,end = null;
		num=24;
		t0 = add(t0,"hour",-12);
		for(i=0;i<num;i++){
			t = add(t0,"hour",i);
			list.add(t);
		}
		start = f.sub(t0+"",0,13)+":0:0";
		t = (Timestamp)list.get(23);
		end =  f.sub(t+"",0,13)+":59:59";
		m.put("start",start);
		m.put("end",end);
		m.put("list",list);
		
		
		return m;
	}
	
	public static Map getWeekReportTimeInfo(String m_time)
	throws Exception{
		Map m = new HashMap();
		List list = new ArrayList();
		Timestamp t0 = f.time(m_time);
		Timestamp t = null;
		int i,num=0;
		int day = 0;
		
		String start,end = null;
		num=7;
		
		day = t0.getDay();
		//System.out.println(t0+","+day);
		if(day<1){
			t0 = add(t0,"day",-7);
		}
		if(day>1){
			t0 = add(t0,"day",1-day);
		}
		//System.out.println(t0+","+t0.getDay());
		
		for(i=0;i<num;i++){
			t = add(t0,"day",i);
			list.add(t);
		}
		
		
		t = (Timestamp)list.get(0);
		start=  f.sub(t+"",0,10);
		
		t = (Timestamp)list.get(6);
		end =  f.sub(t+"",0,10)+" 23:59:59";
		m.put("start",start);
		m.put("end",end);
		m.put("list",list);
		
		
		return m;
	}
	
	public static Map getMonthReportTimeInfo(String m_time)
	throws Exception{
		Map m = new HashMap();
		List list = new ArrayList();
		Timestamp t0 = f.time(m_time);
		Timestamp t = null;
		int i,num=0;
		int day = 0;
		
		String start,end = null;
		num=7;
		
		day = t0.getDate();
		
		if(day>1){
			t0 = add(t0,"day",1-day);
		}
		
		t = add(t0,"month",1);
		t = add(t,"day",-1);
		num = t.getDate();
		
		for(i=0;i<num;i++){
			t = add(t0,"day",i);
			list.add(t);
		}
		t = (Timestamp)list.get(0);
		start=  f.sub(t+"",0,10);
		
		t = (Timestamp)list.get(num-1);
		end =  f.sub(t+"",0,10)+" 23:59:59";
		m.put("start",start);
		m.put("end",end);
		m.put("list",list);
		
		
		
		return m;
	}
	
	public static Map getSeasonReportTimeInfo(String m_time)
	throws Exception{
		Map m = new HashMap();
		
		
		return m;
	}
	
	public static Map getYearReportTimeInfo(String m_time)
	throws Exception{
		Map m = new HashMap();
		
		
		return m;
	}
	
	
	public static List getInfectantList(Connection cn,String station_id)
	throws Exception{
		 List list = null;
		 String sql = null;
		 List list2 = new ArrayList();
		 sql = "select * from t_cfg_infectant_base where infectant_id in(";
		 sql=sql+"select infectant_id from t_cfg_monitor_param ";
		 sql=sql+" where station_id='"+station_id+"' and report_flag='1'";
		 sql=sql+") order by infectant_order";
		 
		 list = f.query(cn,sql,null);
		 int i,num=0;
		 num = list.size();
		 Map m = null;
		 String s = null;
		 
		 for(i=0;i<num;i++){
			 m = (Map)list.get(i);
			 s = (String)m.get("infectant_column");
			 if(f.empty(s)){continue;}
			 s=s.toLowerCase();
			 m.put("infectant_column",s);
			 list2.add(m);
		 }
		 num = list2.size();
		 if(num<1){
			 throw new Exception("请配置要生成报表的指标列");
		 }
		 
		 return list2;
		
	}
	
	public static String getSql(String report_type,String station_id,
			Map timeMap,List infectantList)throws Exception{
		String sql = "";
		String table = null;
		if(f.eq(report_type,"0")){
			table = "t_monitor_real_hour";
		}else{
			table = "t_monitor_real_day";
		}
		int i,num=0;
		String col = null;
		Map m = null;
		String start = (String)timeMap.get("start");
		String end = (String)timeMap.get("end");
		
		num = infectantList.size();
		sql="select station_id,m_time";
		for(i=0;i<num;i++){
			m = (Map)infectantList.get(i);
			col = (String)m.get("infectant_column");
			sql=sql+","+col;
			
		}
		sql=sql+" from "+table+" where station_id='"+station_id+"' ";
		sql=sql+" and m_time>='"+start+"' and m_time<='"+end+"'";
		
		//System.out.println(timeMap+"\n"+sql);
		
		
		return sql;
	}
	
	public static List getData(Connection cn,
			String report_type,String station_id,
			Map timeMap,List infectantList)throws Exception{
		List list = null;
		String sql = null;
		int i,num,len = 0;
		List timeList = null;
		Map m = null;
		String col,v = null;
		Map infectantMap = null;
		Map dataMap = null;
		int j,colnum=0;
		Double vobj = null;
		String key = null;
		List dataList = new ArrayList();
		Timestamp m_time = null;
		
		//2008-08-08 08:08:08
		if(f.eq(report_type,"0")){
			len = 13;
		}else{
			len=10;
		}
		
		sql = getSql(report_type,station_id,timeMap,infectantList);
		//System.out.println(sql);
		list = f.query(cn,sql,null);
		num = list.size();
		//System.out.println(num);
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			v = (String)m.get("m_time");
			v = f.sub(v,0,len);
			m.put("m_time",v);
		}
		
		//dataMap = f.getListMap(list,"m_time");
		colnum = infectantList.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			for(j=0;j<colnum;j++){
				infectantMap = (Map)infectantList.get(j);
				//System.out.println(infectantMap);
				col=(String)infectantMap.get("infectant_column");
				v = (String)m.get(col);
				v=f.v(v);
				vobj = f.getDoubleObj(v,null);
				//vobj = (Double)m.get(col);
				m.put(col,vobj);
			}
			
		}
		//dataMap = f.getMap(list,"m_time");
		dataMap = f.getMap(list,"m_time");
		timeList = (List)timeMap.get("list");
		num = timeList.size();
		//System.out.println("time list num"+num);
		for(i=0;i<num;i++){
			m_time=(Timestamp)timeList.get(i);
			key = f.sub(m_time+"",0,len);
			m = (Map)dataMap.get(key);
			if(m==null){m=new HashMap();}
			m.put("m_time",m_time);
			dataList.add(m);
			
		}
		
		
		return dataList;
	}
	//
	public static Map min(List list,List infectantList)throws Exception{
		Map m = new HashMap();
		String col= null;
		int j,colnum = 0;
		Map m2 = null;
		Double dvobj = null;
		colnum=infectantList.size();	
			for(j=0;j<colnum;j++){
				m2 = (Map)infectantList.get(j);
				col = (String)m2.get("infectant_column");
				dvobj = min(list,col);
				m.put(col,dvobj);
			}
		return m;
	}
	public static Map max(List list,List infectantList)throws Exception{
		Map m = new HashMap();
		String col= null;
		int j,colnum = 0;
		Map m2 = null;
		Double dvobj = null;
		colnum=infectantList.size();	
			for(j=0;j<colnum;j++){
				m2 = (Map)infectantList.get(j);
				col = (String)m2.get("infectant_column");
				dvobj = max(list,col);
				m.put(col,dvobj);
			}
		return m;
	}
	public static Map count(List list,List infectantList)throws Exception{
		Map m = new HashMap();
		String col= null;
		int j,colnum = 0;
		Map m2 = null;
		Integer dvobj = null;
		colnum=infectantList.size();	
			for(j=0;j<colnum;j++){
				m2 = (Map)infectantList.get(j);
				col = (String)m2.get("infectant_column");
				dvobj = count(list,col);
				m.put(col,dvobj);
			}
		return m;
	}
	public static Map avg(Map sumMap,Map countMap,List infectantList)throws Exception{
		Map m = new HashMap();
		String col= null;
		int j,colnum = 0;
		Map m2 = null;
		Double dvobj = null;
		colnum=infectantList.size();	
			for(j=0;j<colnum;j++){
				m2 = (Map)infectantList.get(j);
				col = (String)m2.get("infectant_column");
				dvobj = avg(sumMap,countMap,col);
				m.put(col,dvobj);
			}
		return m;
	}
	public static Map sum(List list,List infectantList)throws Exception{
		Map m = new HashMap();
		String col= null;
		int j,colnum = 0;
		Map m2 = null;
		Double dvobj = null;
		colnum=infectantList.size();	
			for(j=0;j<colnum;j++){
				m2 = (Map)infectantList.get(j);
				col = (String)m2.get("infectant_column");
				dvobj = sum(list,col);
				m.put(col,dvobj);
			}
		return m;
	}
	
	public static Double min(List list,String col)throws Exception{
		Double dvobjmin = null;
		Double dvobj = null;
		int i,num=0;
		Map m = null;
		double dv = 0;
		num = list.size();
		
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			dvobj = (Double)m.get(col);
			if(dvobj==null){continue;}
			if(dvobjmin==null){dvobjmin=dvobj;}
			if(dvobj.doubleValue()<dvobjmin.doubleValue()){
				dvobjmin=dvobj;
			}
			
			
		}
		
		
		return dvobjmin;
	}
	
	
	public static Double max(List list,String col)throws Exception{
		Double dvobjmax = null;
		Double dvobj = null;
		int i,num=0;
		Map m = null;
		double dv = 0;
		num = list.size();
		
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			dvobj = (Double)m.get(col);
			if(dvobj==null){continue;}
			if(dvobjmax==null){dvobjmax=dvobj;}
			if(dvobj.doubleValue()>dvobjmax.doubleValue()){
				dvobjmax=dvobj;
			}
			
			
		}
		
		
		return dvobjmax;
	}
	
	public static Integer count(List list,String col)throws Exception{
		Double dvobjmax = null;
		Double dvobj = null;
		int i,num=0;
		Map m = null;
		double dv = 0;
		num = list.size();
		int count = 0;
		
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			dvobj = (Double)m.get(col);
			if(dvobj==null){continue;}
			count++;
			
			
		}
		if(count<1){return null;}
		
		return new Integer(count) ;
	}
	
	public static Double sum(List list,String col)throws Exception{
		Double dvobjsum = null;
		Double dvobj = null;
		int i,num=0;
		Map m = null;
		double dv = 0;
		num = list.size();
		
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			dvobj = (Double)m.get(col);
			if(dvobj==null){continue;}
			if(dvobjsum==null){
				dvobjsum=dvobj;
				}else{
			dv = dvobjsum.doubleValue()+dvobj.doubleValue();
			dvobjsum = new Double(dv);
				}
			
		}
		
		
		return dvobjsum;
	}
	public static Double avg(Map sumMap,Map countMap,String col)throws Exception{
		Integer count = null;
		Double sum = null;
		double dv = 0;
		Double avg = null;
		int icount = 0;
		
		count = (Integer)countMap.get(col);
		if(count==null){return null;}
		icount = count.intValue();
		if(icount<1){return null;}
		sum = (Double)sumMap.get(col);
		if(sum==null){return null;}
		dv=sum.doubleValue();
		dv=dv/icount;
		avg = new Double(dv);
		return avg;
	}
	
}