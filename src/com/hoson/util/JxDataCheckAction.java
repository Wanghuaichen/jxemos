package com.hoson.util;

import com.hoson.*;

import java.sql.*;
import java.util.*;

import com.hoson.app.*;

import javax.servlet.http.*;




public class JxDataCheckAction{
	
	static int max_rows = 1000;
	
	public static void minute_form(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		String station_type = null;
		String stationTypeOption = null;
		String factorOption = null;
		Connection cn = null;
		String date1 = null;
		String date2 = null;
		String now = StringUtil.getNowDate()+"";
		
		String default_station_type = App.get("default_station_type","1");
		station_type = JspUtil.getParameter(request,"station_type",default_station_type);
		date1 = JspUtil.getParameter(request,"date1",now);
		date2 = JspUtil.getParameter(request,"date2",now);
		
	
		String vs = "t_monitor_real_hour,t_monitor_real_day,t_monitor_real_month,t_monitor_real_year";
		String ls = "时均值,日均值,月均值,年均值";
		
	
		String table = JspUtil.getParameter(request,"data_table","t_monitor_real_hour");
		String tableOption = JspUtil.getOption(vs,ls,table);
		
		
		
		JspAction.jx_query_form(request);
		request.setAttribute("tableOption",tableOption);
		
		try{
		cn = DBUtil.getConn();
		stationTypeOption = JspPageUtil.getStationTypeOption(cn,station_type);
		factorOption = JxDataCheckUtil.getFactorOption(cn,station_type);
		request.setAttribute("date1",date1);
		request.setAttribute("date2",date2);
		request.setAttribute("stationTypeOption",stationTypeOption);
		request.setAttribute("factorOption",factorOption);
		
		
		}catch(Exception e){
			throw e;
		}finally{DBUtil.close(cn);}
		
		
		
		
	}
	
	
	public static void minute(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		 String station_id = request.getParameter("station_id");
		 String infectant_id = request.getParameter("infectant_id");
		 String date1 = request.getParameter("date1");
		 String date2 = request.getParameter("date2");
		 String date3 = date2+" 23:59:59";
		 String sql = null;
		 
		 List list = null;
		 Connection cn = null;
		 
		 if(StringUtil.isempty(station_id)){
			 throw new Exception("请选择站位");
		 }
		 
		 if(StringUtil.isempty(infectant_id)){
			 throw new Exception("请选择监测指标");
		 }
		 
		 
		 int flag = JspUtil.getInt(request,"flag",0);
		 if(flag>0){
			 
			 minute_del(request);
		 }
		 
		 
		 sql = "select * from t_monitor_real_minute where station_id=? and infectant_id=? and m_time>=? and m_time<=?";
		 Object[]p=new Object[]{station_id,infectant_id,date1,date3};
		 try{
		 cn = DBUtil.getConn();
		 
		 
		 list = DBUtil.query(cn,sql,p,max_rows);
		 
		 }catch(Exception e){
			 throw e;
		 }finally{DBUtil.close(cn);}
		 
		 int i,num = 0;
		 StringBuffer sb = new StringBuffer();
		 num = list.size();
		 Map map = null;
		 String m_time = null;
		 String m_value = null;
		 
		 for(i=0;i<num;i++){
			 map=(Map)list.get(i);
			 m_time = (String)map.get("m_time");
			 m_value = (String)map.get("m_value");
			 sb.append("<tr>\n");
			 sb.append("<td>").append("<input type=checkbox name=m_time value='").append(m_time).append("'>");
			 sb.append("</td>\n");
			 sb.append("<td>").append(i+1).append("</td>\n");
			 
			 sb.append("<td>").append(m_time).append("</td>\n");
			 sb.append("<td>").append(m_value).append("</td>\n");
			 
			 sb.append("</tr>\n");
			 
		 }
		 String hide = JspPageUtil.getHideHtml(request);
		 request.setAttribute("hide",hide);
		 request.setAttribute("data",sb+"");
		 
		 
	}
		
	
	
	public static void avg(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		

		String sql = null;
		String station_id = null;
		String []arr=null;
		String data = null;
		String bar = null;
		Connection conn = DBUtil.getConn();
		station_id = request.getParameter("station_id");
		
		if(StringUtil.isempty(station_id)){
			
			//return NULL;
			throw new Exception("请选择站位");
		}
		
		 
		 int flag = JspUtil.getInt(request,"flag",0);
		 if(flag>0){
			 
			 avg_del(request);
		 }
		 
		
		
		conn = DBUtil.getConn();
		sql = SqlUtil.getStationDataQuerySql(conn,station_id,request);
		//System.out.println(sql);
		sql = sql.substring(6);
		
		sql = "select m_time as objectid,"+sql;
		arr=AppPagedUtil.query(conn,sql,request,1);
		
		
		
		data=arr[0];
		bar = arr[1];
		request.setAttribute("data",data);
		request.setAttribute("bar",bar);
		
		 String hide = JspPageUtil.getHideHtml(request);
		 request.setAttribute("hide",hide);
		
		
		
	}
		
	
	public static void minute_del(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		 String station_id = request.getParameter("station_id");
		 String infectant_id = request.getParameter("infectant_id");
		 
		 if(StringUtil.isempty(station_id)){return;}
		 if(StringUtil.isempty(infectant_id)){return;}
		 String[]arr=request.getParameterValues("m_time");
		 if(arr==null){return;}
		 int i,num=0;
		 num=arr.length;
		 if(num<1){return;}
		 
		 String sql = "delete from t_monitor_real_minute where station_id=? and infectant_id=? and m_time=?";
		 
		 Timestamp m_time = null;
		 
		 Object[]p=new Object[]{station_id,infectant_id,null};
		 
		 Connection cn = null;
		 
		 try{
		 cn = DBUtil.getConn();
		 for(i=0;i<num;i++){
			 m_time = StringUtil.getTimestamp(arr[i],null);
			 if(m_time==null){continue;}
			 p[2]=m_time;
			 DBUtil.update(cn,sql,p);
			 
		 }
		 
		 }catch(Exception e){
			 throw e;
		 }finally{DBUtil.close(cn);}
		
	}
	

	public static void avg_del(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		
		 String station_id = request.getParameter("station_id");
		 String data_table = request.getParameter("data_table");
		 
		 if(StringUtil.isempty(station_id)){return;}
		 if(StringUtil.isempty(data_table)){return;}
		 String[]arr=request.getParameterValues("objectid");
		 if(arr==null){return;}
		 int i,num=0;
		 num=arr.length;
		 if(num<1){return;}
		 
		 String sql = "delete from "+data_table+" where station_id=? and m_time=?";
		 
		 Timestamp m_time = null;
		 
		 Object[]p=new Object[]{station_id,null};
		 
		 Connection cn = null;
		 
		 try{
		 cn = DBUtil.getConn();
		 for(i=0;i<num;i++){
			 m_time = StringUtil.getTimestamp(arr[i],null);
			 if(m_time==null){continue;}
			 p[1]=m_time;
			 DBUtil.update(cn,sql,p);
			 
		 }
		 
		 }catch(Exception e){
			 throw e;
		 }finally{DBUtil.close(cn);}
		
		
	}
	
	
}