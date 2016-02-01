package com.hoson.action;

import java.sql.*;
import java.util.*;
import com.hoson.*;
import com.hoson.util.*;

public class HourDataTodayQueryAction extends BaseAction{
	
	
	public String execute()throws Exception{
		
		if(StringUtil.equals(method,"input")){
			
			return execute_input();
		}
		
	if(StringUtil.equals(method,"query")){
			
			return execute_query();
		}
		
		
		return null;
	}
	
	
	public String execute_input()throws Exception{
		
		String stationTypeOption = null;
		String areaOption = null;
		conn = DBUtil.getConn();
		stationTypeOption = JspPageUtil.getStationTypeOption("",request);
		areaOption = JspPageUtil.getTopAreaOption(conn,"");
		model.put("stationTypeOption",stationTypeOption);
		model.put("areaOption",areaOption);
		
		
		return null;
	}
	
	

	public String execute_query()throws Exception{
		
		return null;
	}
	
	
	
	public  String getHide()throws Exception{
		
		String cols = "station_id,infectant_id,starth,endh,date1,date2";
		return JspUtil.getHiddenHtml(cols,request);
	}
	
	
}