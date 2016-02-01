package com.hoson.ws;

import java.sql.Date;
import java.util.*;
import java.io.*;
import java.net.*;
import com.hoson.f;
import javax.servlet.http.*;
import java.sql.Timestamp;
import com.hoson.util.CacheUtil;


//20090319


public class WsUtil{
	
	
	
	public static String map2str(Map m,String spilt_str)throws Exception{
		if(m==null){return "";}
		if(m.isEmpty()){return "";}
		Set keySet = m.keySet();
		Iterator it = keySet.iterator();
		Object key = null;
		Object v = null;
		String s = null;
		String ss = "";
		int i=0;
		
		while(it.hasNext()){
			key=it.next();
			v = m.get(key);
			i++;
			if(i>1){ss=ss+spilt_str;}
			ss=ss+key+"="+obj2str(v,spilt_str);
		}
		
		
		
		return ss;
	}
	
	public static String map2str(Map m)throws Exception{
		return map2str(m,",");
	}
	
	
	
	public static String obj2str(Object o,String spilt_str){
		if(o==null){return "";}
		String s = o+"";
		s = s.replaceAll(spilt_str,"");
		return s;
	}
	
	
	public static String getErrorStr(Exception e){
		String s = "error:"+e;
		return s;
	}
	
	public static void no_obj()throws Exception{
		f.error("记录不存在");
	}
	
	
	//----------
	
	public static String get_station_info(HttpServletRequest req)throws Exception{
		String station_id = null;
		station_id = req.getParameter("station_id");
		if(f.empty(station_id)){f.error("station_id为空");}
		String sql = "select * from t_cfg_station_info where station_id='"+station_id+"'";
		Map m = null;
		
		m = f.queryOne(sql,null);
		if(m==null){no_obj();}
		String s = map2str(m);
		//req.setAttribute("s",s);
		return s;
	}
	
	
	public static String get_data(HttpServletRequest req)throws Exception{
		String station_type,infectant_id,data_table = null;
		station_type = req.getParameter("station_type");
	
		
		infectant_id = req.getParameter("infectant_id");
		data_table = req.getParameter("data_table");
		
		
		
		
		String sql = "select * from t_cfg_station_info where station_id";
		
		
		Map m = null;
		
		m = f.queryOne(sql,null);
		if(m==null){no_obj();}
		String s = map2str(m);
		//req.setAttribute("s",s);
		return s;
	}
	
	
	//------------20090414
	
	public static String get_time_type(String table)throws Exception{
		if(f.eq(table,"t_monitor_real_hour")){return "hour";}
		if(f.eq(table,"t_monitor_real_day")){return "day";}
		if(f.eq(table,"t_monitor_real_week")){return "week";}
		if(f.eq(table,"t_monitor_real_month")){return "month";}
		
		throw new Exception("错误的数据类型格式");
		
	}

	public static Timestamp[]getStartAndEndTime(String table,int num)throws Exception{
		
		Timestamp[]ts=new Timestamp[2];
		Timestamp t1,t2;
		
		t2=f.time();
		
		String type = get_time_type(table);
		num = 0-num-1;
		if(f.eq(type,"week")){
			t1 = f.dateAdd(t2,"day",num*7);
		}else{
		t1 = f.dateAdd(t2,type,num);
		}
		ts[0]=t1;
		ts[1]=t2;
		
		return ts;	
	}
	
	public static java.sql.Timestamp today(){
		java.sql.Date d = new java.sql.Date(f.ms());
		java.sql.Timestamp t = new Timestamp(d.getTime());
		
		return t;
	}
	private static String getStationData(String station_id,String data_table,String infectant_column,int num)throws Exception{
		String sql = "select station_desc from t_cfg_station_info where station_id=?";
		Map m = null;
		String station_name = null;
		String m_time,m_value;
		String s="";
		
		m = f.queryOne(sql,new Object[]{station_id});
		if(m==null){return "";}
		station_name = (String)m.get("station_desc");
		
		Timestamp[]ts=getStartAndEndTime(data_table,num);
		
		sql = "select station_id,m_time,"+infectant_column+" as m_value from "+data_table+" where station_id=? and m_time>? and m_time<? order by m_time desc";
		Object[]ps=new Object[3];
		
		ps[0] = station_id;
		ps[1] = ts[0];
		ps[2] = ts[1];
		
		List list = null;
		int i,dnum=0;
		
		list = f.query(sql,ps);
		dnum = list.size();
		
		
		s=station_id+","+station_name;
		for(i=0;i<dnum;i++){
			m = (Map)list.get(i);
			m_time = (String)m.get("m_time");
			m_value=(String)m.get("m_value");
			m_value=f.v(m_value);
			
			if(f.empty(m_time)){continue;}
			if(f.empty(m_value)){continue;}
			s=s+","+m_value+"@"+m_time;
			
			
		}
		
		
		
		
		
		return s;
	}
	//-------------------
	
	
	public static String get_station_data(HttpServletRequest req)throws Exception{
		String station_id = req.getParameter("station_id");
		String table = req.getParameter("table");
		String infectant_column = req.getParameter("infectant_column");
		String s="";
		String s1;
		String[]arr=null;
		int dnum=3;
		
		if(f.empty(station_id)){f.error("station_id is empty");}
		if(f.empty(infectant_column)){f.error("infectant_column is empty");}
		
		
		arr=station_id.split(",");
		int i,num=0;
		num=arr.length;
		for(i=0;i<num;i++){
			station_id=arr[i];
			if(f.empty(station_id)){continue;}
			s1 = getStationData(station_id,table,infectant_column,dnum);
			if(f.empty(s1)){continue;}
			s=s+s1+";";
		}
		
		//req.setAttribute("msg",s);
		return s;
		
	}
	
	
	public static String get_infectant_info(HttpServletRequest req)throws Exception{
		String station_type = req.getParameter("station_type");
		if(f.empty(station_type)){f.error("station_type is empty");}
		List list = f.getInfectantList(station_type);
		int i,num=0;
		Map m = null;
		String s="";
		String s1="";
		String unit = null;
		String col = null;
		
		num=list.size();
		for(i=0;i<num;i++){
			 m = (Map)list.get(i);
			 unit = (String)m.get("infectant_unit");
			 if(unit==null){unit=" ";}
			 col = (String)m.get("infectant_column");
			 if(col==null){col="";}
			 col=col.toLowerCase();
			 s1 = m.get("infectant_id")+","+m.get("infectant_name")+","+unit+","+col;
			 s=s+s1+";";
		}
		return s;
	}
	
	public static String get_warn_info(HttpServletRequest req)throws Exception{
		String station_id = req.getParameter("station_id");

		String s="";
		String s1=null;
		String[]arr=null;
		int dnum=3;
		
		if(f.empty(station_id)){f.error("station_id is empty");}

		Map msgWarnDataMap = f.getMsgWarnDataMap();
		
		arr=station_id.split(",");
		int i,num=0;
		num=arr.length;
		for(i=0;i<num;i++){
			station_id=arr[i];
			if(f.empty(station_id)){continue;}
			//s1 = getStationData(station_id,table,infectant_column,dnum);
			s1=get_warn_info(msgWarnDataMap,station_id);
			if(f.empty(s1)){continue;}
			s=s+s1+";";
		}
		
		//req.setAttribute("msg",s);
		return s;
	}
	
	
	public static String get_warn_info(Map msgWarnDataMap,String station_id)throws Exception{
		Map warnMap = (Map)msgWarnDataMap.get(station_id);
		if(warnMap==null){return "";}
		Map m = null;
		String sql = "select station_desc from t_cfg_station_info where station_id=?";
		String station_name=null;
		
		m = f.queryOne(sql,new Object[]{station_id});
		if(m==null){return "";}
		station_name = (String)m.get("station_desc");
		
		int i,num=0;
		String key = null;
		String v = null;
		num=30;
		String s = station_id+","+station_name+","+warnMap.get("m_time");
		//f.sop(warnMap);
		for(i=1;i<=num;i++){
			
			if(i<10){key="val0"+i;}
			v = (String)warnMap.get(key);
			if(f.empty(v)){continue;}
			s=s+","+key+"="+v;
			
		}
		
		return s;
		
		
	}
	//2009-04-16
	public static List getStationList(String ids)throws Exception{
		
		if(f.empty(ids)){f.error("station_id is empty");}
		String[]arr=ids.split(",");
		int i,num=0;
		String s="";
		int idnum=0;
		String id=null;
		String sql = null;
		List list = null;
	
		
		num =arr.length;
		for(i=0;i<num;i++){
			id=arr[i];
			if(f.empty(id)){continue;}
			idnum++;
			if(idnum>1){s=s+",";}
			s=s+"'"+id+"'";
			
			
		}
		sql = "select station_id,station_desc from t_cfg_station_info where station_id in("+s+")";
		list = f.query(sql,null);
		return list;
		
		
		
		
	}
	
  public static String get_online_info(HttpServletRequest req)throws Exception{
		String ids =  req.getParameter("station_id");
		if(f.empty(ids)){f.error("station_id is empty");}
		List list = getStationList(ids);
		Map dataMap;
		Map hour,minute;
		Map m = null;
		//int i,num=0;
		String ss="";
		String name = null;
		int i,num=0;
		String id = null;
		
		
		dataMap = CacheUtil.getAreaInfoDataMap();
		hour = (Map)dataMap.get("hour");
		minute = (Map)dataMap.get("minute");
		if(hour==null){hour=new HashMap();}
		if(minute==null){minute=new HashMap();}
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			id= (String)m.get("station_id");
			name= (String)m.get("station_desc");
			if(f.empty(id)){continue;}
			if(f.empty(name)){continue;}
			ss=ss+id+","+name+","+online_str(minute,hour,id)+";";
			
			
		}
		
		
		
		return ss;
		
		
		
	}
	
	
	
	
	public static String online_str(Map minute,Map hour,String station_id){
		    Object o = null;
		    o = minute.get(station_id);
		    if(o!=null){return "1";}
		    o = hour.get(station_id);
		    if(o!=null){return "1";}
		    return "0";
		    
	}
	
	
}