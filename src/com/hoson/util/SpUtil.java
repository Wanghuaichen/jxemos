package com.hoson.util;


import com.hoson.*;
import com.hoson.app.*;


import java.util.*;
import java.sql.*;

import javax.servlet.http.*;



public class SpUtil{
	
	static Map sp = new HashMap();
	static long time_out = 15000;
	
	
	
	public static String getSpTypeOption(Connection cn,String sp_type)
	throws Exception{
		
		String s = null;		
		String sql = null;
		
		
		sql = "select parameter_value,parameter_name from t_cfg_parameter "
			+" where parameter_type_id='sp_type' ";
		
		s = JspUtil.getOption(cn,sql,sp_type);
		
		
		return s;
	}
	
	public static String info(){
		
		return sp+"";
	}
	
	public static void update(String user_name){
		if(f.empty(user_name)){return;}
		sp.put(user_name,StringUtil.getNowTime());
		
	}
	
	public static String getSeq(int i){
		i=i+1;
		
		if(i<10){return "00"+i;}
		return "0"+i;
		
	}
	
	public static  boolean isFree(String user){
		//Long t1 = (Long)sp.get(user);
		Timestamp t1 = (Timestamp)sp.get(user);
		if(t1==null){return true;}
		long v = t1.getTime();
		long now = StringUtil.getTime();
		
		long dif = now-v;
		if(dif<0){dif=0-dif;}
		
		if(dif>time_out){return true;}
		return false;
		
	}
	
	
	public static String getFreeUser(String user,int num)
	throws Exception{
		int i=0;
		String s = null;
		String s1 = null;
		String s2 = null;
		int pos = 0;
		
		for(i=0;i<num;i++){
			
			pos = user.indexOf("@");
			if(pos<1){throw new Exception("视频帐号格式不对");}
			s1 = user.substring(0,pos);
			s2 = user.substring(pos);
			
			//s = user+getSeq(i);
			s = s1+getSeq(i)+s2;
			
			
			if(isFree(s)){
				update(s);
				return s;
				}
			
		}
		
		//return user+"001";
		s = user+"001";
		update(s);
		
		return s;
		
	}
	
	
}