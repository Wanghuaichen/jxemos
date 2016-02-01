package com.hoson.action;

import java.sql.*;
import java.util.*;
import com.hoson.*;
import com.hoson.util.*;

public class DataAction extends BaseAction{
	
	
	public String execute()throws Exception{
		
		if(StringUtil.equals(method,"1")){
			
			return execute_1();
		}
		
		
		if(StringUtil.equals(method,"q")){
			
			return execute_q();
		}
		
		return null;
	}
	
	public String execute_q()throws Exception{
		Map map = null;
		
		String sql = null;
		conn=DBUtil.getConn();
		sql = JspPageUtil.getDataQuerySql(conn,model);
		
		map =PagedUtil.queryStringWithUrl(conn,sql, 1,1,request);
		//data=(String)map.get("data");
		//pageBar=(String)map.get("page_bar");
		
		
		
		
		
		
		return null;
	}

	public String execute_1()throws Exception{
		String station_id = null;
		String sql = null;
		String station_name = null;
		String msg = null;
		Map map = null;
		String typeOption = null;
		String vs = "hour,day,week,month,year";
		String ts = "时均值,日均值,周均值,月均值,年均值";
		
		typeOption = JspUtil.getOption(vs,ts,"");
		
		station_id=(String)model.get("objectid");
		if(StringUtil.isempty(station_id)){
			
			msg = "请选择一个站位";
			throw new Exception(msg);
		}
		
		sql = "select station_desc from t_cfg_station_info ";
		sql=sql+"where station_id='"+station_id+"'";
		conn = DBUtil.getConn();
		map = DBUtil.queryOne(conn,sql,null);
		if(map==null){
			msg = "站位不存在,station_id="+station_id;
			throw new Exception(msg);
		}
		station_name = (String)map.get("station_desc");
		model.put("station_name",station_name);
		model.put("station_id",station_id);
		model.put("now",StringUtil.getNowDate());
		model.put("option",typeOption);
		return null;
	}

	
	
	
}