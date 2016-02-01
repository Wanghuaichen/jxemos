package com.hoson.action;

import java.sql.*;
import java.util.*;
import com.hoson.*;
import com.hoson.util.*;

public class RealQueryAction extends BaseAction{
	
	
	public String execute()throws Exception{
		conn = DBUtil.getConn();
		String station_id = null;
	
		String sql = null;
	   String start = null;
	   String end = null;
	   String date1 = null;
	   String date2 = null;
	   
	   String starth = null;
	   String endh = null;
	   String infectant_id = null;
	   Map map = null;
	   String data = null;
	   String bar = null;
	   
	   start = model.get("date1")+" "+model.get("starth")+":0:0";
	   end = model.get("date2")+" "+model.get("endh")+":0:0";
	   station_id = (String)model.get("station_id");
	   infectant_id = (String)model.get("infectant_id");
	   
	   sql = "select a.station_desc,c.infectant_name,b.m_time,b.m_value,c.infectant_unit ";
		sql=sql+"from ";
		sql=sql+"t_cfg_station_info a,";
		sql=sql+"t_monitor_real_minute b,";
		sql=sql+"t_cfg_infectant_base c ";
		sql=sql+"where ";
		sql=sql+"a.station_id=b.station_id ";
		//sql=sql+"and b.station_id=c.station_id ";
		sql=sql+"and b.infectant_id=c.infectant_id ";
	    sql=sql+"and b.station_id='"+station_id+"' ";
	    sql=sql+"and b.infectant_id='"+infectant_id+"' ";
	    sql=sql+"and b.m_time>='"+start+"' ";
	    sql=sql+"and b.m_time<='"+end+"' ";
	    sql=sql+"order by b.infectant_id,b.m_time desc";
	    
	    
	    map = PagedUtil.queryStringWithUrl(conn,sql,1,0,request);
		data = (String)map.get("data");
		bar =  (String)map.get("page_bar");
		data=StringUtil.trimTdMilliSecond(data);
		model.put("data",data);
		model.put("bar",bar);
		model.put("sql",sql);
		model.put("hide",getHide());
		
		return null;
	}
	
	
	public  String getHide()throws Exception{
		
		String cols = "station_id,infectant_id,starth,endh,date1,date2";
		return JspUtil.getHiddenHtml(cols,request);
	}
	
	
}