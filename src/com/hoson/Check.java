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
		if(f.empty(s)){f.error("station_idΪ��");}
		s = b.get("station_desc");
		if(f.empty(s)){f.error("վλ����Ϊ��");}
		s = s.replaceAll("'","");
		s = s.replaceAll("\"","");
		model.put("station_desc",s);
		s = b.get("station_no");
		if(!f.empty(s)){
		num = f.getInt(s,0);
//		if(num<1){f.error("��ű���Ϊ����0������");}
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
    	    if(t<0){f.error("��ʼʱ�䲻�ܴ��ڽ���ʱ��");}
    	    
    	    if(!f.empty(station_id)){return;}
    	    if(!f.eq(data_type,"hour")){return;}
    	    
    	    long tmax = 29L*24*60*60*1000;
    	    if(t>tmax){f.error("��վλʱ��ֵ��ѯ���ܳ���30��");}
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
	    if(t<0){f.error("��ʼʱ�䲻�ܴ��ڽ���ʱ��");}
	    
	    if(!f.eq(data_table,"t_monitor_real_hour")){return;}
	    long maxday = 99;
	    long tmax = maxday*24*60*60*1000;
	    if(t>tmax){f.error("��վλʱ��ֵ��ѯ���ܳ���"+(maxday+1)+"��");}
}
}