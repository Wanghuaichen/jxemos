package com.hoson.util;

import com.hoson.*;
import java.sql.*;
import java.util.*;

import com.hoson.app.*;

import javax.servlet.http.*;

public class JxReportUtil{
	
	
	public static Map getUpReport(String sql)throws Exception{
		List list = null;
		Map map = new HashMap();
		
		
		Connection cn = null;
		Connection hsql_cn = null;
		String table = null;
		String hsql_sql = null;
		Statement stmt = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		
		
		try{
		cn = DBUtil.getConn();		
		stmt = cn.createStatement();
		rs = stmt.executeQuery(sql);
		
		
		hsql_cn  = DBUtil.getHsqlConn();
		
		table = "t_"+StringUtil.getTime();
		hsql_sql = "create table "+table +"(station_id varchar(50),m_time date,toc double,cod double,q double)";
		
		DBUtil.update(hsql_cn,hsql_sql,null);
		
		
		hsql_sql = "insert into "+table+"(station_id,m_time,toc,cod,q) values(?,?,?,?,?)";
		ps = hsql_cn.prepareStatement(hsql_sql);
		while(rs.next()){
			
			ps.setString(1,rs.getString(1));
			ps.setObject(2,rs.getDate(2));
			ps.setObject(3,getDouble(rs.getString(3)));
			ps.setObject(4,getDouble(rs.getString(4)));
			ps.setObject(5,getDouble(rs.getString(5)));
			ps.executeUpdate();
		}
		/*
		hsql_sql = "select * from "+table;
		
		list = DBUtil.query(hsql_cn,hsql_sql);
		map.put("3",list);
		*/
		
		
		hsql_sql = "select station_id,m_time,sum(q) as q_sum,count(q) as q_count,"
			+"min(q) as q_min,max(q) as q_max,avg(q) as q_avg,"
			+"min(toc) as toc_min,max(toc) as toc_max,avg(toc) as toc_avg,"
			+"min(cod) as cod_min,max(cod) as cod_max,avg(cod) as cod_avg "
			+" from "+table+" group by station_id,m_time "
			
			;
			list = DBUtil.query(hsql_cn,hsql_sql);
			map.put("1",list);
			
		hsql_sql = "select station_id,m_time,sum(q) as q_100_sum from "+table 
		+" where cod>100 group by station_id,m_time "
		;
		list = DBUtil.query(hsql_cn,hsql_sql);
		map.put("2",list);
		
		
		hsql_sql = "drop table "+table;
		DBUtil.update(hsql_cn,hsql_sql,null);
		
		return map;		
		}catch(Exception e){
			throw e;
		}finally{
			
			DBUtil.close(rs,stmt,cn);
			DBUtil.close(null,ps,hsql_cn);
		}
	}
	
	
	public static Double getDouble(String s){
		
		 if(StringUtil.isempty(s)){return null;}
		 s = App.getValueStr(s);
		 double d = 0;
		 try{
		 d = Double.parseDouble(s);
		 if(d==0){return null;}
		 return new Double(d);
		 }catch(Exception e){
			 
			 return null;
		 }
	}
	
	public static Map getMap(List list,String key)throws Exception{
		Map map = new HashMap();
		if(list==null){return map;}
		Map m = null;
		int i,num =0;
		num = list.size();
		
		for(i=0;i<num;i++){
			m=(Map)list.get(i);
			if(m==null){continue;}
			map.put(m.get(key)+"",m);
		}
		return map;
	}
	
}