package com.hoson;

import javax.servlet.http.*;
import java.util.*;
import com.hoson.XBean;
import com.hoson.f;
import java.sql.*;


public class Check{
	
	public static void jsgs(HttpServletRequest req)throws Exception{
		
	}
	
    public static void station_wry_update(Map model,HttpServletRequest req)throws Exception{
		XBean b = new XBean(model);
		String s = null;
		int num =0;
		
		s = b.get("station_id");
		if(f.empty(s)){f.error("station_id为空");}
		s = b.get("station_desc");
		if(f.empty(s)){f.error("站位名称为空");}
		s = s.replaceAll("'","");
		s = s.replaceAll("\"","");
		model.put("station_desc",s);
		s = b.get("station_no");
		if(!f.empty(s)){
		num = f.getInt(s,0);
//		if(num<1){f.error("序号必须为大于0的整数");}
		}
	}
    
    public static void data_query(HttpServletRequest req)throws Exception{
    	    String date1,date2,station_id,data_type;
    	    date1 = req.getParameter("date1");
    	    date2 = req.getParameter("date2");
    	    station_id = req.getParameter("station_id");
    	    data_type = req.getParameter("data_type");
    	    
    	    Timestamp t1,t2;
    	    long t=0;
    	    t1 = f.time(date1);
    	    t2 = f.time(date2);
    	    t = t2.getTime()-t1.getTime();
    	    if(t<0){f.error("开始时间不能大于结束时间");}
    	    
    	    if(!f.empty(station_id)){return;}
    	    if(!f.eq(data_type,"hour")){return;}
    	    
    	    long tmax = 29L*24*60*60*1000;
    	    if(t>tmax){f.error("多站位时均值查询不能超过30天");}
    }
    
    public static void station_report(HttpServletRequest req)throws Exception{
	    String date1,date2,data_table;
	    date1 = req.getParameter("date1");
	    date2 = req.getParameter("date2");
	    data_table = req.getParameter("rpt_data_table");
	    
	    Timestamp t1,t2;
	    long t=0;
	    
	    t1 = f.time(date1);
	    t2 = f.time(date2);
	    t = t2.getTime()-t1.getTime();
	    if(t<0){f.error("开始时间不能大于结束时间");}
	    
	    if(!f.eq(data_table,"t_monitor_real_hour")){return;}
	    long maxday = 99;
	    long tmax = maxday*24*60*60*1000;
	    if(t>tmax){f.error("多站位时均值查询不能超过"+(maxday+1)+"天");}
}
}