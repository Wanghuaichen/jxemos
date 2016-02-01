package com.hoson.util;

import com.hoson.*;
import com.hoson.app.*;
import java.util.*;
import java.sql.*;

import javax.servlet.http.HttpServletRequest;





public class SpAclUtil{
	
	public static void u(HttpServletRequest request)
	throws Exception{
		
		String[]ids = request.getParameterValues("station_id");
		if(ids==null){ids=new String[0];}
		String sb_id = null;
		String sql = null;
		Map sbMap = null;
		List list = new ArrayList();
		Connection cn = null;
		String station_id = null;
		String sp_user_name = null;
		String sp_user_pwd = "123456";
		String sp_user_pwd_md5 = StringUtil.md5(sp_user_pwd);
		String user_id = request.getParameter("user_id");
		String user_name = request.getParameter("user_name");
		Map map = null;
		String sb_ids = "";
		String sp_acl_url = null;
		String resturStr = null;
		
		
		
		sql = "select station_id,sb_id from t_sp_sb_station";
		
		try{
		cn = DBUtil.getConn();
		sbMap = DBUtil.getMap(cn,sql);
		
		int i,num = 0;
		num=ids.length;
		for(i=0;i<num;i++){
			station_id = ids[i];
			sb_id = (String)sbMap.get(station_id);
			if(StringUtil.isempty(sb_id)){continue;}
			list.add(sb_id);
			
		}
		num = list.size();
		//if(num<1){return;}
		//System.out.println(num+","+user_name);
		sql = "select sp_user_name from t_sp_user where user_id=?";
		map = DBUtil.queryOne(cn,sql,new Object[]{user_id});
		if(map==null){
			sp_user_name = "";
			}else{
		sp_user_name=(String)map.get("sp_user_name");
			}
		if(StringUtil.isempty(sp_user_name)){
			sp_user_name = "";
		}
		//System.out.println(sql+","+sp_user_name);
		for(i=0;i<num;i++){
			if(i>0){
				sb_ids = sb_ids+",";
			}
			sb_ids = sb_ids+list.get(i);
		}
		
		Properties prop = new Properties();
		
		prop.setProperty("userName",sp_user_name);
		prop.setProperty("userPwd",sp_user_pwd_md5);
		prop.setProperty("customId","20302020000001");
		prop.setProperty("strRoleInfo",sb_ids);
		//System.out.println(prop);
		try{
		sp_acl_url = App.get("sp_acl_url");
		}catch(Exception e){
			throw new Exception("读取sp_acl_url时发生错误");
		}
		resturStr = HttpClient.getUrlContent(sp_acl_url,"post",prop);
		if(resturStr==null){resturStr="";}
		//System.out.println(prop+"\n\n"+resturStr);
		if(resturStr.indexOf("<exception>")>=0){
			resturStr = resturStr.substring(11);
			throw new Exception(resturStr);
		}
		if(resturStr.equals("<OK>")){return;}
		String sqli = "insert into t_sp_user(sp_user_name,sp_user_pwd,user_id) values(?,?,?)";
		String sqlu = "update t_sp_user set sp_user_name=?,sp_user_pwd=? where user_id=?";
		sp_user_name = resturStr;
		Object[]p=new Object[]{sp_user_name,sp_user_pwd,user_id};
		
		num = DBUtil.update(cn,sqlu,p);
		if(num<1){
			DBUtil.update(cn,sqli,p);
		}
		
		
		//System.out.println(resturStr);
		}catch(Exception e){
			
			throw e;
		}finally{DBUtil.close(cn);}
		
	}

	
	
	
}