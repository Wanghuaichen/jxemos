package com.hoson.action;

import java.sql.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

import com.hoson.*;
import com.hoson.util.*;
import com.hoson.app.*;
public class FormAction extends BaseAction{
	
	public String form()throws Exception{
		
		String now = StringUtil.getNowDate()+"";
		String date1 = p("date1",now);
		String date2 = p("date2",now);
		String default_station_type = f.cfg("default_station_type","1");
		String station_type = p("station_type",default_station_type);
		String default_area_id = f.cfg("default_area_id","3301");
		String area_id = p("area_id",default_area_id);
		String trade_id = p("trade_id","");
		String sql = null;
		String areaOption,stationTypeOption,stationOption = null;
		
		getConn();
		String tradeOption = getTradeOption(trade_id);
		areaOption = JspPageUtil.getAreaOption(conn,area_id);
		stationTypeOption = JspPageUtil.getStationTypeOption(conn,station_type);
		
		//sql = "select station_id,station_desc from t_cfg_station_info ";
		if("".equals(trade_id)){
			sql = "select station_id,station_desc from t_cfg_station_info ";
			sql=sql+" where show_flag !='1' and station_type='"+station_type+"' ";//黄宝修改
			sql=sql+" and area_id like '"+area_id+"%' ";
			sql=sql+DataAclUtil.getStationIdInString(request,station_type,"station_id");
			sql=sql+" order by area_id,station_desc";
	    }else{
	    	sql = "select station_id,station_desc from t_cfg_station_info ";
			sql=sql+" where show_flag !='1' and station_type='"+station_type+"' ";//黄宝修改
			sql=sql+" and area_id like '"+area_id+"%' and trade_id like '"+trade_id+" '";
			sql=sql+DataAclUtil.getStationIdInString(request,station_type,"station_id");
			sql=sql+" order by area_id,station_desc";
	    }
		stationOption = f.getOption(conn,sql,null);
		
		seta("areaOption",areaOption);
		seta("stationTypeOption",stationTypeOption);
		seta("stationOption",stationOption);
		seta("tradeOption",tradeOption);
		seta("date1",date1);
		seta("date2",date2);
		
		
		return null;
	}
	
	public String area()throws Exception{
		String default_area_id = f.cfg("default_area_id","3301");
		
		String now = StringUtil.getNowDate()+"";
		String date1=p("date1");
		String area_id=p("area_id");
		if(f.empty(date1)){date1 = now;}
		if(f.empty(area_id)){area_id=default_area_id;}
		String areaOption = JspPageUtil.getAreaOption(area_id);
		
		seta("areaOption",areaOption);
		seta("date1",date1);
		
		
		return null;
	}
	
	/*!
	  * 获得行业的下拉菜单值，trade_id为选中值
	  */
	public static String getTradeOption(String trade_id)throws Exception{
		String sql = "select TRADE_ID,TRACE_NAME from t_cfg_trade where parentnode = 'root' order by TRADE_ID";
		String s = null;
		s = f.getOption(sql,trade_id);
		return s;
	}
	
}
	