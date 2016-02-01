package com.hoson.action;

import java.sql.*;
import java.util.*;
import com.hoson.*;
import com.hoson.util.*;

public class GisStationAction extends BaseAction{
	
	
	public String execute()throws Exception{
	
		if(StringUtil.equals(method,"form")){return execute_form();}
		if(StringUtil.equals(method,"query")){return execute_query();}
		throw new Exception("error method");
		//return null;
	}
	
	public String execute_form()throws Exception{
		
		String stationTypeOption = JspPageUtil.getStationTypeOption("",request);
		model.put("stationTypeOption",stationTypeOption);
		return null;
	}
	
	public String execute_query()throws Exception{
		
		String station_type = (String)model.get("station_type");
		String station_name = (String)model.get("station_name");
		String sql = null;
		List list = null;
		
		
		if(StringUtil.isempty(station_type)){
			
			throw new Exception("站位类型为空");
		}
		sql = "select station_id,station_desc from t_cfg_station_info ";
		sql=sql+" station_type='"+station_type+"' ";
		
		if(!StringUtil.isempty(station_name)){
			
			sql=sql+" and station_desc like '%"+station_name+"%'";
			
		}
		conn = DBUtil.getConn();
		
		list = DBUtil.query(conn,sql,null);
		model.put("stations",list);
		
		return null;
	}

	
	
}