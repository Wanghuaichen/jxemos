package com.hoson.app;

import javax.servlet.http.*;
import javax.servlet.*;

import com.hoson.*;
import com.hoson.util.*;
import java.util.regex.*;
import java.text.*;
import java.net.*;
import java.util.*;
import java.sql.*;


public class Zljs{
	
	
	static String  zljs_table = "t_monitor_real_day";
	
	
	
	
	public static List getGrossInfectant(Connection cn,String station_type)
	throws Exception{
		List list = null;
		
		String sql = null;
		
		sql = "select infectant_id,infectant_name,infectant_unit,infectant_column ";
		sql=sql+"from t_cfg_infectant_base where station_type='"+station_type+"' ";
		sql=sql+"and need_gross='1'";
		//System.out.println(sql);
		list = DBUtil.query(cn,sql,null);
	
		return list;
		
	}
	
	public static List getGrossVolumn(Connection cn,String station_type)
	throws Exception{
		List list = null;
		
		String sql = null;
		
		sql = "select infectant_id,infectant_name,infectant_unit,infectant_column ";
		sql=sql+"from t_cfg_infectant_base where station_type='"+station_type+"' ";
		sql=sql+"and need_gross='2'";
		
		list = DBUtil.query(cn,sql,null);
		
		return list;
		
	}
	
	public static String getGrossSql(Connection cn,
			String station_type,String station_id,
			String date1,String date2)
	throws Exception{
		String s = "";
		List list1 = null;
		List list2 = null;
		String date3 = null;
		int i =0;
		int num = 0;
		Map map = null;
		String col = null;
		String msg = null;
		int colNum = 0;
		String infectant_id = null;
		int flag = 0;
		
		
		date3 = StringUtil.getNextDay(java.sql.Date.valueOf(date2))+"";
		
		list1 = getGrossInfectant(cn,station_type);
		num=list1.size();
		if(num<1){
			msg = "请配置需要总量计算的指标";
			throw new Exception(msg);
		}
		
		list2 = getGrossVolumn(cn,station_type);
		num=list2.size();
		if(num!=1){
			msg = "请配置用于总量计算的流量列，有且只能有一个流量列";
			throw new Exception(msg);
		}
		
		colNum = list1.size();
		flag=colNum-1;
		
		for(i=0;i<colNum;i++){
			
			map=(Map)list1.get(i);
			col=(String)map.get("infectant_column");
			infectant_id=(String)map.get("infectant_id");
			if(StringUtil.isempty(col)){
				msg = "infectant_column不能为空，infectant_id="+infectant_id;
				throw new Exception(msg);
				
			}
			
				s=s+col+",";
			
		}
		
		map = (Map)list2.get(0);
		col=(String)map.get("infectant_column");
		infectant_id=(String)map.get("infectant_id");
		if(StringUtil.isempty(col)){
			msg = "infectant_column不能为空，infectant_id="+infectant_id;
			throw new Exception(msg);
			
		}
		
		s=s+col;
		
		s=" select "+s+" from "+zljs_table;
		s=s+" where station_id='"+station_id+"' ";
		s=s+" and m_time>='"+date1+"' ";
		//s=s+"and m_time<='"+date2+"'";
		s=s+" and m_time<'"+date3+"'";
		
		//System.out.println(s);
		return s;
		
	}
	

	public static String getGrossSql(List list1,List list2,
			String station_type,String station_id,
			String date1,String date2)
	throws Exception{
		String s = "";
		//List list1 = null;
		//List list2 = null;
		String date3 = null;
		int i =0;
		int num = 0;
		Map map = null;
		String col = null;
		String msg = null;
		int colNum = 0;
		String infectant_id = null;
		int flag = 0;
		
		
		date3 = StringUtil.getNextDay(java.sql.Date.valueOf(date2))+"";
		
		//list1 = getGrossInfectant(cn,station_type);
		num=list1.size();
		
		if(num<1){
			msg = "请配置需要总量计算的指标";
			throw new Exception(msg);
		}
		
		//list2 = getGrossVolumn(cn,station_type);
		num=list2.size();
		if(num!=1){
			msg = "请配置用于总量计算的流量列，有且只能有一个流量列";
			throw new Exception(msg);
		}
		
		colNum = list1.size();
		flag=colNum-1;
		
		for(i=0;i<colNum;i++){
			
			map=(Map)list1.get(i);
			col=(String)map.get("infectant_column");
			infectant_id=(String)map.get("infectant_id");
			if(StringUtil.isempty(col)){
				msg = "infectant_column不能为空，infectant_id="+infectant_id;
				throw new Exception(msg);
				
			}
			
				s=s+col+",";
			
		}
		
		map = (Map)list2.get(0);
		col=(String)map.get("infectant_column");
		infectant_id=(String)map.get("infectant_id");
		if(StringUtil.isempty(col)){
			msg = "infectant_column不能为空，infectant_id="+infectant_id;
			throw new Exception(msg);
			
		}
		
		s=s+col;
		
		s="select "+s+" from "+zljs_table;
		s=s+" where station_id='"+station_id+"' ";
		s=s+" and m_time>='"+date1+"' ";
		//s=s+"and m_time<='"+date2+"'";
		s=s+" and m_time<'"+date3+"'";
		
		
		return s;
		
	}
	
	
	
	public static String getGross(Connection cn,String station_id,
			HttpServletRequest req)
	throws Exception{
		
	String s = "";
	String station_type = null;
	String date1 = null;
	String date2 = null;
	String sql = null;
	Statement stmt = null;
	ResultSet rs = null;
	int i =0;
	int num = 0;
	List list = null;
	int volColIndex = 0;
	double v = 0;
	double vol = 0;
	String strv = null;
	String strvol = null;
	
	
	
	
	station_type=req.getParameter("station_type");
	date1 = req.getParameter("date1");
	date2 = req.getParameter("date2");
	
	try{
	list = getGrossInfectant(cn,station_type);
	num = list.size();
	
	double[]arrV = new double[num];
	for(i=0;i<num;i++){
		arrV[i]=0;
	}
	volColIndex = num+1;
	
	sql = getGrossSql(cn,
			station_type,station_id,
			date1,date2);
	stmt = cn.createStatement();
	rs = stmt.executeQuery(sql);
	
	while(rs.next()){
		for(i=0;i<num;i++){
			strv=rs.getString(i+1);
			strvol=rs.getString(volColIndex);
			
			strv = App.getValueStr(strv);
			strvol = App.getValueStr(strvol);
			
			v=StringUtil.getDouble(strv,0);
			vol=StringUtil.getDouble(strvol,0);
			if(v>0&&vol>0){
				arrV[i]=arrV[i]+v*vol;
			}
		}
		
	}
	
	for(i=0;i<num;i++){
		s=s+"<td>"+StringUtil.round(arrV[i],3)+"</td>";		
	}
	
	return s;
	
	}catch(Exception e){
		throw e;
		
	}finally{
		DBUtil.close(rs,stmt,null);
	}
		
	}
	
	
	public static String getGross(Connection cn,List list1,List list2,
			String station_id,
			String date1,String date2)
	throws Exception{
		
	String s = "";
	String station_type = null;
	//String date1 = null;
	//String date2 = null;
	String sql = null;
	Statement stmt = null;
	ResultSet rs = null;
	int i =0;
	int num = 0;
	//List list = null;
	int volColIndex = 0;
	double v = 0;
	double vol = 0;
	String strv = null;
	String strvol = null;
	
	
	
	
	//station_type=req.getParameter("station_type");
	//date1 = req.getParameter("date1");
	//date2 = req.getParameter("date2");
	
	try{
	//list = getGrossInfectant(cn,station_type);
	num = list1.size();
	
	double[]arrV = new double[num];
	for(i=0;i<num;i++){
		arrV[i]=0;
	}
	volColIndex = num+1;
	
	sql = getGrossSql(list1,list2,
			station_type,station_id,
			date1,date2);
	stmt = cn.createStatement();
	rs = stmt.executeQuery(sql);
	
	while(rs.next()){
		for(i=0;i<num;i++){
			strv=rs.getString(i+1);
			strvol=rs.getString(volColIndex);
			
			strv = App.getValueStr(strv);
			strvol = App.getValueStr(strvol);
			
			v=StringUtil.getDouble(strv,0);
			vol=StringUtil.getDouble(strvol,0);
			if(v>0&&vol>0){
				arrV[i]=arrV[i]+v*vol;
			}
		}
		
	}
	
	for(i=0;i<num;i++){
		s=s+"<td>"+StringUtil.round(arrV[i],3)+"</td>";		
	}
	
	return s;
	
	}catch(Exception e){
		throw e;
		
	}finally{
		DBUtil.close(rs,stmt,null);
	}
		
	}
	
	
	public static double[] getGrossValue(Connection cn,List list1,List list2,
			String station_id,
			String date1,String date2)
	throws Exception{
		
	String s = "";
	String station_type = null;
	//String date1 = null;
	//String date2 = null;
	String sql = null;
	Statement stmt = null;
	ResultSet rs = null;
	int i =0;
	int num = 0;
	//List list = null;
	int volColIndex = 0;
	double v = 0;
	double vol = 0;
	String strv = null;
	String strvol = null;
	
	
	
	
	//station_type=req.getParameter("station_type");
	//date1 = req.getParameter("date1");
	//date2 = req.getParameter("date2");
	
	try{
	//list = getGrossInfectant(cn,station_type);
	num = list1.size();
	
	double[]arrV = new double[num];
	for(i=0;i<num;i++){
		arrV[i]=0;
	}
	volColIndex = num+1;
	
	sql = getGrossSql(list1,list2,
			station_type,station_id,
			date1,date2);
	stmt = cn.createStatement();
	rs = stmt.executeQuery(sql);
	
	while(rs.next()){
		for(i=0;i<num;i++){
			strv=rs.getString(i+1);
			strvol=rs.getString(volColIndex);
			
			strv = App.getValueStr(strv);
			strvol = App.getValueStr(strvol);
			
			v=StringUtil.getDouble(strv,0);
			vol=StringUtil.getDouble(strvol,0);
			if(v>0&&vol>0){
				arrV[i]=arrV[i]+v*vol;
			}
		}
		
	}
	

	
	return arrV;
	
	}catch(Exception e){
		throw e;
		
	}finally{
		DBUtil.close(rs,stmt,null);
	}
		
	}
	
	
	
	
	
	public static List getStationIdByAreaAndValleyId(
			Connection cn,
			String station_type,
			String area_id,String valley_id,
			HttpServletRequest req)
	throws Exception{
		List list = new ArrayList();
		String sql = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		
		
		sql="select station_id from t_cfg_station_info ";
		sql=sql+" where station_type='"+station_type+"' ";
		if(!StringUtil.isempty(area_id)){
			sql=sql+" and area_id like '"+area_id+"%' ";
		}
		
		if(!StringUtil.isempty(valley_id)){
			sql=sql+" and valley_id like '"+valley_id+"%' ";
		}
		sql = sql+DataAclUtil.getStationIdInString(req,station_type,"station_id");


		
		
		try{
		stmt = cn.createStatement();
		rs = stmt.executeQuery(sql);
		
		while(rs.next()){
		list.add(rs.getString(1));
		
		}
		
		return list;
		}catch(Exception e){
			throw e;
		}finally{
			DBUtil.close(rs,stmt,null);
		}
	}
	
	
	public static String getGross(Connection cn,
			HttpServletRequest req)
	throws Exception{
	String s = "";
	int i =0;
	int num =0;
	String station_id = null;
	String station_type = null;
	String date1 = null;
	String date2 = null;
	String area_id =null;
	String valley_id = null;
	List stationIdList = null;
	List list1 = null;
	List list2 = null;
	Map stationMap = null;
	String sql = null;
	
	String station_name = null;
	String tmp = null;
	Map map = null;
	
	double[] arrGross = null;
	double[] arrTotal = null;
	int colNum = 0;
	int j =0;
	
	
	
	
	station_type = req.getParameter("station_type");
	date1 = req.getParameter("date1");
	date2 = req.getParameter("date2");
	area_id = req.getParameter("area_id");
	valley_id = req.getParameter("valley_id");
	
	 stationIdList = getStationIdByAreaAndValleyId(
				cn,station_type,
				area_id,valley_id,req);
	 
	 sql = "select station_id,station_desc as station_name ";
	 sql=sql+" from t_cfg_station_info ";
	 sql=sql+"where station_type='"+station_type+"'";
	 
	 stationMap = DBUtil.getMap(cn,sql);
	 
	 list1 = getGrossInfectant(cn,station_type);
	 list2 = getGrossVolumn(cn,station_type);
	 
	 num = stationIdList.size();
	 colNum = list1.size();
	 arrTotal = new double[colNum];
	 for(i=0;i<colNum;i++){
		 arrTotal[i]=0;
		 
	 }
	 
	 for(i=0;i<num;i++){
		 station_id = (String)stationIdList.get(i);
		 station_name = (String)stationMap.get(station_id);
		 sql = getGrossSql(list1,list2,
					station_type,station_id,
					date1,date2);
		 
		 //tmp = getGross(cn,list1,list2,station_id,date1,date2);
		 arrGross=getGrossValue(cn,list1,list2,station_id,date1,date2);
		 tmp = "";
		 for(j=0;j<colNum;j++){
			 arrTotal[j]=arrTotal[j]+arrGross[j];
			tmp=tmp+"<td>"+StringUtil.round(arrGross[j],3)+"</td>"; 
		 }
		 
		 s=s+"<tr class=tr"+i%2+">\n";
		 s=s+"<td>"+station_name+"</td>";
		 s=s+tmp+"</tr>\n";
		 
	 }
	 
	 
	 String tt = "";
	 
	 num = list1.size();
	 for(i=0;i<num;i++){
		 map=(Map)list1.get(i);
		 tt=tt+"<td>"+map.get("infectant_name")+"<br>\n";
		 tt=tt+map.get("infectant_unit")+"</td>";
		 tt=tt+"</td>";
	 }
	s=tt+"</tr>\n"+s;
	
	String totalStr = "";
	
	for(i=0;i<colNum;i++){
		totalStr = totalStr+"<td>"+StringUtil.round(arrTotal[i],3)+"</td>";
	}
	
	totalStr = "<tr class=\"gross\"><td>合计</td>\n"+totalStr+"</tr>";
	
	s=s+totalStr;
	 return s;
	}
	
	public static String getGross(HttpServletRequest req)
	throws Exception{
		Connection cn = null;
		try{
		cn=DBUtil.getConn(req);
		return getGross(cn,req);
		}catch(Exception e){
			throw e;
		}finally{DBUtil.close(cn);}
	}
	
}
