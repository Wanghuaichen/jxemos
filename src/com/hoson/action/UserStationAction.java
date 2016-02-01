package com.hoson.action;

import java.sql.*;
import java.util.*;
import com.hoson.*;
import com.hoson.app.*;
import com.hoson.util.*;

public class UserStationAction extends BaseAction{
	
	
	
	
	
	
	public String execute()throws Exception{
		
		String station_type = null;
		String sql = null;
		String option = null;
		String data = "";
		List list = null;
		String user_id = null;
		String user_name = null;
		String station_ids = null;
		String top_area_id = App.getAreaId();
		String area_id = request.getParameter("area_id");
		String areaOption = null;
		
		if(StringUtil.isempty(area_id)){
			area_id=top_area_id;
		}
		//System.out.println(StringUtil.getNowTime());
		user_id = (String)model.get("user_id");
		if(StringUtil.isempty(user_id)){
			throw new Exception("请选择一个用户");
		}
		user_name = (String)model.get("user_name");
		if(StringUtil.equals(user_name,"admin")){
			throw new Exception("不需要为admin用户配置权限");
		}
		
		station_type = request.getParameter("station_type");
		if (station_type == null) {
			station_type = App.getDefStationId(request);
		}
		
		if(StringUtil.isempty(station_type)){
			throw new Exception("请选择站位类型");
			
		}
		
		sql = App.getTreeSql(request);

		option = JspUtil.getOption(sql, station_type, request);
		
		/*
		sql = "select station_id,station_desc from t_cfg_station_info where station_type='"+station_type+"'";
		
		conn = DBUtil.getConn();
		
		list = DBUtil.query(conn,sql,null);
		
		data = getStation(list);
		*/
		conn = DBUtil.getConn();
		
		sql = "select area_id,area_name from t_cfg_area where area_id like '"+top_area_id+"%' order by area_id";
		areaOption = JspUtil.getOption(conn,sql,area_id);
		//data =  getStation(conn,station_type,user_id);
		data = getStation(conn,station_type,user_id,area_id);
		//System.out.println(data);
		model.put("option",option);
		model.put("data",data);
		model.put("areaOption",areaOption);
		return null;
	}
	
	
	String getStation(List list)
	throws Exception{
		String s="";
		
		int i =0;
		int num = 0;
		String station_id = null;
		String station_name = null;
		Map map = null;
		int size=5;
		String check_flag = " ";
		num = list.size();
		
		for(i=0;i<num;i++){
			
			map = (Map)list.get(i);
			station_id=(String)map.get("station_id");
			station_name=(String)map.get("station_desc");
			if(StringUtil.isempty(station_id)){
				continue;
			}
			
			
			if(i%size==0){
				
				s=s+"<tr class=tr"+i%2+">\n";
				s=s+"<td><input type=checkbox name='station_id' value='"+station_id+"'>"+station_name+"</td>\n";
			}else{
				
				s=s+"<td><input type=checkbox name='station_id' value='"+station_id+"'>"+station_name+"</td>\n";
			}
			
		}
		
		
		num = num%size;
		//System.out.println(num);
		
		
		if(num>0){
			
			

			
			num = size-num;
			for(i=0;i<num;i++){
				s=s+"<td></td>\n";
				
			}
			
		}
		
		s=s+"</tr>\n";
		
		return s;
	}
	
	
	
	String getStation(List list,String station_ids)
	throws Exception{
		String s="";
		
		int i =0;
		int num = 0;
		String station_id = null;
		String station_name = null;
		Map map = null;
		int size=5;
		String check_flag = " ";
		
		if(station_ids==null){
			station_ids="";
			}
		
		station_ids = "," + station_ids +",";
		
		num = list.size();
		
		for(i=0;i<num;i++){
			
			map = (Map)list.get(i);
			station_id=(String)map.get("station_id");
			station_name=(String)map.get("station_desc");
			if(StringUtil.isempty(station_id)){
				continue;
			}
			
			if(station_ids.indexOf(","+station_id+",")>=0){
				check_flag=" checked";
			}else{
				check_flag=" ";
			}
			if(i%size==0){
				
				s=s+"<tr class=tr"+i%2+">\n";
				s=s+"<td><input type=checkbox name='station_id' value='"+station_id+"' "+check_flag+">"+station_name+"</td>\n";
			}else{
				
				s=s+"<td><input type=checkbox name='station_id' value='"+station_id+"' "+check_flag+">"+station_name+"</td>\n";
			}
			
		}
		
		
		
		num = num%size;
		//System.out.println(num);
		
		
		if(num>0){
			
			

			
			num = size-num;
			for(i=0;i<num;i++){
				s=s+"<td></td>\n";
				
			}
			
		}
		
		s=s+"</tr>\n";
		
		
		return s;
	}
	
	

	
	String getStation(Connection cn,
			String station_type,String user_id)
	throws Exception{
		String s="";
		
		int i =0;
		int num = 0;
		String station_id = null;
		String station_name = null;
		Map map = null;
		List list = null;
		String sql = null;
		String station_ids = null;
		
		
	
		
		sql = "select station_ids from t_sys_user_station where user_id="+user_id +" and station_type='"+station_type+"'";
		try{
		map = DBUtil.queryOne(cn,sql,null);
		if(map!=null){
		station_ids=(String)map.get("station_ids");
		}
		//System.out.println(station_ids);
sql = "select station_id,station_desc from t_cfg_station_info where station_type='"+station_type+"'";
		
		
		
		list = DBUtil.query(cn,sql,null);
	
		s = getStation(list,station_ids);
		}catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
		
		return s;
		
	}
	
	
	String getStation(Connection cn,
			String station_type,String user_id,String area_id)
	throws Exception{
		String s="";
		
		int i =0;
		int num = 0;
		String station_id = null;
		String station_name = null;
		Map map = null;
		List list = null;
		String sql = null;
		String station_ids = null;
		
		
	
		
		sql = "select station_ids from t_sys_user_station where user_id="+user_id +" and station_type='"+station_type+"'";
		try{
			map = DBUtil.queryOne(cn,sql,null);
			if(map!=null){
			station_ids=(String)map.get("station_ids");
			}
			sql = "select station_id,station_desc from t_cfg_station_info where station_type='"+station_type+"'";
			
			sql = sql +" and area_id like '"+area_id+"%'";
			
			list = DBUtil.query(cn,sql,null);
		
			s = getStation(list,station_ids);
		}catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
		
		return s;
		
	}
	
	
	
	
	
}