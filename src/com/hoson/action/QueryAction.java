package com.hoson.action;
import com.hoson.mvc.*;
import com.hoson.*;
import java.util.*;
import java.sql.*;
import com.hoson.util.*;
import com.hoson.app.*;
import com.hoson.app.AppPagedUtil;

public class QueryAction extends BaseAction{
	
	
	String msg = "请选择一个站位";
	
	public String execute()throws Exception{
		
		if(method==null){method="";}
		
		if(method.equals("query")){return execute_query();}
	
		if(method.equals("real")){return execute_real();}
		throw new Exception("error method");
		

	}


	public String execute_query()throws Exception{
		
		
		
		//JspPageUtil.dateCheck(request);
		
		
		
		String sql = null;
		String station_id = null;
		String []arr=null;
		String data = null;
		String bar = null;
		conn = DBUtil.getConn();
		station_id = (String)model.get("station_id");
		
		if(StringUtil.isempty(station_id)){
			
			//return NULL;
			throw new Exception(msg);
		}
		
		sql = SqlUtil.getStationDataQuerySql(conn,station_id,request);
		
		
		
		
		arr=AppPagedUtil.query(conn,sql,request,0);
		data=arr[0];
		bar = arr[1];
		model.put("data",data);
		model.put("bar",bar);
		
		
		
		
		
		return null;
	}
	

	
	
public String execute_real()throws Exception{
		
		/*
	
		String station_id = null;
		String data = null;
		
	
		station_id = (String)model.get("station_id");


	    
		if(StringUtil.isempty(station_id)){
			
			//throw new Exception("站位编号不能为空");
			return NULL;
		}
		
		
		conn = DBUtil.getConn();
		
		data = JspPageUtil.getRealData(conn,station_id);
		model.put("data",data);
		
		*/
	
	//String data = RealDataUtil.getRealDataByDay(request);
	
	String station_id = null;
	
	station_id = (String)model.get("station_id");
	
	if(StringUtil.isempty(station_id)){
		
		//return NULL;
		throw new Exception(msg);
	}
	
	String data = AppPage.getRealDataByDay(request);
	request.setAttribute("data",data);
	
	
		
		return null;
	}
	
	
	
}