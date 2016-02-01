package com.hoson.app;

import java.sql.*;
import java.io.*;
import java.util.*;
import java.text.*;
import com.hoson.*;
import javax.servlet.http.*;



public class SiteCompute2{
	
	private void SiteCompute2(){		
	}
	//-------------
	public static String getAlertReport(Connection cn,String station_type,
			String date1,String date2,
			String area_id,String valley_id)throws Exception{
	String s = null;
	String s1 = null;
	String s2 = null;
	
	s1 = getAlertNumReport(cn,station_type,
			date1,date2,
			area_id,valley_id);
	
	s2 = getStationAlertReport(cn,station_type,
			date1,date2,
			 area_id,valley_id);
	
	s=s1+"<br>"+s2;
	
	return s;
	}
	//----------------
	public static String getAlertNumReport(Connection cn,String station_type,
			String date1,String date2,
			String area_id,String valley_id)throws Exception{
	String s = "";	
	String sql = "";
	Map map = null;
	sql=sql+"select count(a.station_id) as station_num,";
	sql=sql+"sum(a.warning_cnt) as warning_cnt from ";
	sql=sql+"t_station_sum_info a,";
	sql=sql+"t_cfg_station_info b ";
	sql=sql+"where a.station_id=b.station_id ";
	sql=sql+"and a.warning_cnt>0 ";
	sql=sql+"and b.station_type='"+station_type+"' ";
	sql=sql+"and a.sum_time>='"+date1+"' ";
	sql=sql+"and a.sum_time<='"+date2+"' ";
	
	if(!StringUtil.isempty(area_id)){
	sql=sql+"and b.area_id like '"+area_id+"%' ";
	}
	
	if(!StringUtil.isempty(valley_id)){
	sql=sql+"and b.valley_id like '"+valley_id+"%' ";
	}
	
	System.out.println(sql);
	
	map=DBUtil.queryOne(cn,sql,null);
	
	String  station_num = (String)map.get("station_num");
	String  warning_cnt = (String)map.get("warning_cnt");
	
	if(station_num==null){station_num="0";}

	if(StringUtil.isempty(warning_cnt)){warning_cnt="0";}
	//System.out.println("warning_cnt="+warning_cnt);
	
	s = s+"共有 "+station_num+" 个站位发生 "+warning_cnt+" 次报警";
	//System.out.println(s);
	s=s+sql;
		return s;
	}
	//------------------------
	public static String getStationAlertReport(Connection cn,String station_type,
			String date1,String date2,
			String area_id,String valley_id)throws Exception{
	String s = "";	
	String sql = "";
	Map map = null;
	List list = null;
	sql=sql+"select ";
	sql=sql+"a.station_id as station_id,";
	sql=sql+"a.warning_cnt as warning_cnt,";
	sql=sql+"b.station_desc as station_name,";
	sql=sql+"a.warning_sum_info as warning_sum_info ";
	sql=sql+"from ";
	sql=sql+"t_station_sum_info a,";
	sql=sql+"t_cfg_station_info b ";
	sql=sql+"where a.station_id=b.station_id ";
	sql=sql+"and a.warning_cnt>0 ";
	sql=sql+"and b.station_type='"+station_type+"' ";
	sql=sql+"and a.sum_time>='"+date1+"' ";
	sql=sql+"and a.sum_time<='"+date2+"' ";
	
	if(!StringUtil.isempty(area_id)){
		sql=sql+"and b.area_id like '"+area_id+"%' ";
	}
	if(!StringUtil.isempty(valley_id)){
		sql=sql+"and b.valley_id like '"+valley_id+"%' ";
	}
	
	list=DBUtil.query(cn,sql,null);
	int i =0;
	int num =0;
	
	num = list.size();
	String station_id = null;
	String station_name = null;
	String warning_sum_info = null;
	String warning_cnt = null;
	for(i=0;i<num;i++){
		map=(Map)list.get(i);
		station_id=(String)map.get("station_id");
		station_name=(String)map.get("station_name");
		warning_sum_info=(String)map.get("warning_sum_info");
		warning_cnt=(String)map.get("warning_cnt");
		s=s+station_name+" "+warning_cnt+" "+"次 ";
		s=s+warning_sum_info+"<br>\n";
	}
	
	
		return s;
	}
	//------------------------
	//-----------------------------out info report------
	
	
//	-------------
	public static String getOutReport(Connection cn,String station_type,
			String date1,String date2,
			String area_id,String valley_id)throws Exception{
	String s = null;
	String s1 = null;
	String s2 = null;
	
	s1 = getOutNumReport(cn,station_type,
			date1,date2,
			area_id,valley_id);
	
	s2 = getStationOutReport(cn,station_type,
			date1,date2,
			 area_id,valley_id);
	
	s=s1+"<br>"+s2;
	
	return s;
	}
	//----------------
	public static String getOutNumReport(Connection cn,String station_type,
			String date1,String date2,
			String area_id,String valley_id)throws Exception{
	String s = "";	
	String sql = "";
	Map map = null;
	sql=sql+"select count(a.station_id) as station_num,";
	sql=sql+"sum(a.total_out_cnt) as out_cnt from ";
	sql=sql+"t_station_sum_info a,";
	sql=sql+"t_cfg_station_info b ";
	sql=sql+"where a.station_id=b.station_id ";
	sql=sql+"and a.total_out_cnt>0 ";
	sql=sql+"and b.station_type='"+station_type+"' ";
	
	sql=sql+"and a.sum_time>='"+date1+"' ";
	sql=sql+"and a.sum_time<='"+date2+"' ";
	
	if(!StringUtil.isempty(area_id)){
	sql=sql+"and b.area_id like '"+area_id+"%' ";
	}
	
	if(!StringUtil.isempty(valley_id)){
	sql=sql+"and b.valley_id like '"+valley_id+"%' ";
	}
	
	//System.out.println(sql);
	
	map=DBUtil.queryOne(cn,sql,null);
	
	String  station_num = (String)map.get("station_num");
	String  out_cnt = (String)map.get("out_cnt");
	
	
	if(StringUtil.isempty(station_num)){station_num="0";}
	if(StringUtil.isempty(out_cnt)){out_cnt="0";}
	//System.out.println("warning_cnt="+warning_cnt);
	
	s = s+"共有 "+station_num+" 个站位发生 "+out_cnt+" 次超标";
	//System.out.println(s);
	s=s+sql;
		return s;
	}
	//------------------------
	public static String getStationOutReport(Connection cn,String station_type,
			String date1,String date2,
			String area_id,String valley_id)throws Exception{
	String s = "";	
	String sql = "";
	Map map = null;
	List list = null;
	sql=sql+"select ";
	sql=sql+"a.station_id as station_id,";
	sql=sql+"a.total_out_cnt as out_cnt,";
	sql=sql+"b.station_desc as station_name,";
	sql=sql+"a.out_info as out_info ";
	sql=sql+"from ";
	sql=sql+"t_station_sum_info a,";
	sql=sql+"t_cfg_station_info b ";
	sql=sql+"where a.station_id=b.station_id ";
	sql=sql+"and a.total_out_cnt>0 ";
	sql=sql+"and b.station_type='"+station_type+"' ";
	sql=sql+"and a.sum_time>='"+date1+"' ";
	sql=sql+"and a.sum_time<='"+date2+"' ";
	
	if(!StringUtil.isempty(area_id)){
		sql=sql+"and b.area_id like '"+area_id+"%' ";
	}
	if(!StringUtil.isempty(valley_id)){
		sql=sql+"and b.valley_id like '"+valley_id+"%' ";
	}
	
	list=DBUtil.query(cn,sql,null);
	int i =0;
	int num =0;
	
	num = list.size();
	String station_id = null;
	String station_name = null;
	String out_info = null;
	String out_cnt = null;
	for(i=0;i<num;i++){
		map=(Map)list.get(i);
		station_id=(String)map.get("station_id");
		station_name=(String)map.get("station_name");
		out_info=(String)map.get("out_info");
		out_cnt=(String)map.get("out_cnt");
		s=s+station_name+" "+out_cnt+" "+"次 ";
		s=s+out_info+"<br>\n";
	}
	
	
		return s;
	}
	//------------------------
	//------------------device state----
	//-------------
	public static String getDeviceReport(Connection cn,String station_type,
			String date1,String date2,
			String area_id,String valley_id)throws Exception{
	String s = null;
	String s1 = null;
	String s2 = null;
	
	s1 = getAlertNumReport(cn,station_type,
			date1,date2,
			area_id,valley_id);
	
	s2 = getStationAlertReport(cn,station_type,
			date1,date2,
			 area_id,valley_id);
	
	s=s1+"<br>"+s2;
	
	return s;
	}
	//----------------
	public static String getDeviceNumReport(Connection cn,String station_type,
			String date1,String date2,
			String area_id,String valley_id)throws Exception{
	String s = "";	
	String sql = "";
	Map map = null;
	sql=sql+"select count(a.station_id) as station_num,";
	sql=sql+"sum(a.warning_cnt) as warning_cnt from ";
	sql=sql+"t_station_sum_info a,";
	sql=sql+"t_cfg_station_info b ";
	sql=sql+"where a.station_id=b.station_id ";
	sql=sql+"and a.warning_cnt>0 ";
	sql=sql+"and b.station_type='"+station_type+"' ";
	sql=sql+"and a.sum_time>='"+date1+"' ";
	sql=sql+"and a.sum_time<='"+date2+"' ";
	
	if(!StringUtil.isempty(area_id)){
	sql=sql+"and b.area_id like '"+area_id+"%' ";
	}
	
	if(!StringUtil.isempty(valley_id)){
	sql=sql+"and b.valley_id like '"+valley_id+"%' ";
	}
	
	System.out.println(sql);
	
	map=DBUtil.queryOne(cn,sql,null);
	
	String  station_num = (String)map.get("station_num");
	String  warning_cnt = (String)map.get("warning_cnt");
	
	if(station_num==null){station_num="0";}

	if(StringUtil.isempty(warning_cnt)){warning_cnt="0";}
	//System.out.println("warning_cnt="+warning_cnt);
	
	s = s+"共有 "+station_num+" 个站位发生 "+warning_cnt+" 次报警";
	//System.out.println(s);
	//s=s+sql;
		return s;
	}
	//------------------------
	public static String getStationDeviceReport(Connection cn,String station_type,
			String date1,String date2,
			String area_id,String valley_id)throws Exception{
	String s = "";	
	String sql = "";
	Map map = null;
	List list = null;
	sql=sql+"select ";
	sql=sql+"a.station_id as station_id,";
	sql=sql+"a.warning_cnt as warning_cnt,";
	sql=sql+"b.station_desc as station_name,";
	sql=sql+"a.warning_sum_info as warning_sum_info ";
	sql=sql+"from ";
	sql=sql+"t_station_sum_info a,";
	sql=sql+"t_cfg_station_info b ";
	sql=sql+"where a.station_id=b.station_id ";
	sql=sql+"and a.warning_cnt>0 ";
	sql=sql+"and b.station_type='"+station_type+"' ";
	sql=sql+"and a.sum_time>='"+date1+"' ";
	sql=sql+"and a.sum_time<='"+date2+"' ";
	
	if(!StringUtil.isempty(area_id)){
		sql=sql+"and b.area_id like '"+area_id+"%' ";
	}
	if(!StringUtil.isempty(valley_id)){
		sql=sql+"and b.valley_id like '"+valley_id+"%' ";
	}
	
	list=DBUtil.query(cn,sql,null);
	int i =0;
	int num =0;
	
	num = list.size();
	String station_id = null;
	String station_name = null;
	String warning_sum_info = null;
	String warning_cnt = null;
	for(i=0;i<num;i++){
		map=(Map)list.get(i);
		station_id=(String)map.get("station_id");
		station_name=(String)map.get("station_name");
		warning_sum_info=(String)map.get("warning_sum_info");
		warning_cnt=(String)map.get("warning_cnt");
		s=s+station_name+" "+warning_cnt+" "+"次 ";
		s=s+warning_sum_info+"<br>\n";
	}
	
	
		return s;
	}
	//------------------------
	
	
	
}//end class