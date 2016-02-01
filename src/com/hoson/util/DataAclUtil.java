package com.hoson.util;

import com.hoson.*;
import java.util.*;
import java.sql.*;
import com.hoson.app.*;


import javax.servlet.http.*;


//站位数据查看权限控制

public class DataAclUtil{
	
	
	
	public static String getNullSqlInString(){
		//没有任何查看权限站位时返回
		return "'0000000'";
	}
	
	public static String getStationIdInString(HttpServletRequest req,
			String station_type,String col)throws Exception{
		
		String acl = App.get("acl","0");
		if(acl.equals("0")){return "  ";}
		HttpSession session = req.getSession();
		String user_name = null;
		String view_all_station = null;
		
		Map map = null;
		
		String s = null;
		
		user_name = (String)session.getAttribute("user_name");
		view_all_station = (String)session.getAttribute("view_all_station");
		if(StringUtil.equals(user_name,"admin")){
			
			return "  ";
		}
		
		if(f.eq(view_all_station,"1")){return "  ";}
		
       if(StringUtil.equals(user_name,"adminv")){
			
			return "  ";
		}
		
		if(StringUtil.equals(user_name,"test")){
			
			return "  ";
		}
		
		if(StringUtil.equals(user_name,"sjadmin")){
			
			return "  ";
		}
		
		
		session = req.getSession();
		/*
		map = (Map)session.getAttribute("user_station_map");
		if(map==null){
			throw new Exception("未登录或超时");
		}
		*/
		
		String user_id = (String)session.getAttribute("user_id");
		
		if(f.empty(user_id)){
			f.error("未登录或超时");
		}
			
		
			
		s=" and "+col+" in(select station_id from t_sys_user_station where user_id='"+user_id+"') ";
			
		
		
		//LogUtil.debug(s);
		return s;
	}
	/*
	 public static String getStationIdInString(HttpServletRequest req,
			String station_type,String col)throws Exception{
		
		String acl = App.get("acl","0");
		if(acl.equals("0")){return "  ";}
		HttpSession session = req.getSession();
		String user_name = null;
		
		
		Map map = null;
		
		String s = null;
		
		user_name = (String)session.getAttribute("user_name");
		if(StringUtil.equals(user_name,"admin")){
			
			return "  ";
		}
		
		if(StringUtil.equals(user_name,"test")){
			
			return "  ";
		}
		
		if(StringUtil.equals(user_name,"sjadmin")){
			
			return "  ";
		}
		
		if(StringUtil.isempty(station_type)){
			throw new Exception("station_type不能为空");
		}
		
		session = req.getSession();
		map = (Map)session.getAttribute("user_station_map");
		if(map==null){
			throw new Exception("未登录或超时");
		}
		
		String user_id = (String)session.getAttribute("user_id");
		
		if(App.get("data_acl_sql","0").equals("1")){
			
			
			s=" and "+col+" in(select station_id from t_sys_user_station where user_id='"+user_id+"') ";
			
		}else{
		
		s = (String)map.get(station_type);
		if(StringUtil.isempty(s)){
			s = getNullSqlInString();
		}
		s = " and "+col+" in("+s+") ";
		
		
		}//end else
		
		//LogUtil.debug(s);
		return s;
	}
	
	  */
	
	
	public static Map getUserStationMap(String user_id)throws Exception{
		Map map = new HashMap();
		List list = null;
		Map m = null;
		int i,num=0;
		String sql = null;
		Connection cn = null;
		String s = null;
		String station_type = null;
		String station_ids = null;
		String[]arr = null;
		int j,idNum=0;
		String id = null;

		
		if(StringUtil.isempty(user_id)){
			throw new Exception("user_id不能为空");
		}
		sql = "select station_type,station_ids from t_sys_user_station where user_id='"+user_id+"'";
		try{
		cn = DBUtil.getConn();
		list =  DBUtil.query(cn,sql,null);
		num = list.size();
		
		for(i=0;i<num;i++){
			
			m = (Map)list.get(i);
			station_type=(String)m.get("station_type");
			station_ids = (String)m.get("station_ids");
			if(StringUtil.isempty(station_type)){continue;}
			
			if(StringUtil.isempty(station_ids)){
				//map.put(station_type,"0000000");
				//s=defs;
				s="";

			}else{
				s="";
				arr=station_ids.split(",");
				idNum=arr.length;
				
				for(j=0;j<idNum;j++){
					id=arr[j];
					if(StringUtil.isempty(id)){continue;}
					if(j>0){
						s=s+",";
					}
					s=s+"'"+id+"'";
				}
				
				
			}
			
			
			if(StringUtil.isempty(s)){
				s=getNullSqlInString();
				}
			map.put(station_type,s);
			
		}
		
		
		return map;
		}catch(Exception e){throw e;}finally{DBUtil.close(cn);}
		
	}
	
	
	
	
}