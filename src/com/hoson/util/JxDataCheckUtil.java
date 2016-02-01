package com.hoson.util;

import com.hoson.*;
import java.sql.*;
import java.util.*;

import com.hoson.app.*;

import javax.servlet.http.*;




public class JxDataCheckUtil{
	static int max_rows = 1000;
	
	public static String getFactorOption(Connection cn
			,String station_type)throws Exception{
		String sql = null;
		
		sql = "select infectant_id,infectant_name from t_cfg_infectant_base  "
			
			+" where station_type='"+station_type+"' "
			+" and infectant_type='1' "
			+" order by infectant_order"
			;
		
		
		return JspUtil.getOption(cn,sql,null);
	}
	
	
	
	public static void q(HttpServletRequest request)
	throws Exception{
		
		String station_id = request.getParameter("station_id");
		if(StringUtil.isempty(station_id)){
			throw new Exception("请选择站位");
		}
		String sql = null;
		String data_table = request.getParameter("data_table");
		String check_flag = request.getParameter("check_flag");
		String date1 = request.getParameter("date1");
		String date2 = request.getParameter("date1");
		String col =  request.getParameter("infectant_id");
		String s = null;
		String btn = null;
		String[] m_times = request.getParameterValues("m_time");
		String ss = null;
		
		if(StringUtil.equals(check_flag,"1")){
			 btn = "审核不通过";
			 ss = "";
		}else{
			btn = "审核通过";
			ss = "_old ";
		}
		
		request.setAttribute("btn",btn);
		
		
		
		if(StringUtil.isempty(col)){
			throw new Exception("请选择监测指标");
		}
		if(StringUtil.equals(data_table,"t_monitor_real_minute")){
			col = col.split(",")[0];
			
			if(StringUtil.equals(check_flag,"0")){
				s=" m_value is null and m_value_old is not null ";
			}else{
				s = " m_value is not null";
			}
					
			sql = "select m_time,m_value"+ss+" as m_value from "+data_table 
			+" where infectant_id='"+col+"' "
			+" and station_id='"+station_id+"' "
			+" and m_time>='"+date1+"' "
			+" and m_time<'"+date1+" 23:59:59' "
			+" and "+s
			+" order by m_time desc "
			;
			
			
			
			
		}else{
			col = col.split(",")[1];
			

			if(StringUtil.equals(check_flag,"0")){
				s=col+" is null and "+col+"_old is not null ";
			}else{
				s = col + "  is not null";
			}
			
	
			
			
			
			sql = "select m_time,"+col+ss+" as m_value from "+data_table 
			//+" where infectant_id='"+col+"' "
			+ " where 2>1 "
			+" and station_id='"+station_id+"' "
			+" and m_time>='"+date1+"' "
			+" and m_time<'"+date2+" 23:59:59' "
			
			+" and "+s
			
			+" order by m_time desc "
			;
			
		}
		//System.out.println(sql);
		Connection cn = null;
		List list = null;
		
		try{
		cn = DBUtil.getConn();
		
		c(cn,check_flag,data_table,station_id,col,m_times);
		
		list = DBUtil.query(cn,sql,(Object[])null,max_rows);
		
		request.setAttribute("data",list);
		
		}catch(Exception e){
			
			throw e;
		}finally{DBUtil.close(cn);}
	}
	
	
	
	public static void minute_check(Connection cn,String station_id,
			String col,String[]m_times)throws Exception{
		if(m_times==null){return;}
	
		Timestamp t = null;

		String sql = null;
		
		int i,num=0;
		num = m_times.length;
		
		
		sql = "update t_monitor_real_minute set m_value=m_value_old,m_value_old=null where m_value is null and m_value_old is not null ";
		sql = sql +" and station_id=? and infectant_id=? and m_time=?";
		Object[]p=new Object[]{station_id,col,null};
		for(i=0;i<num;i++){
			t = StringUtil.getTimestamp(m_times[i],null);
			if(t==null){continue;}
			p[2]=t;
			DBUtil.update(cn,sql,p);
			
			
		}
		
		
	}
	

	public static void minute_uncheck(Connection cn,String station_id,
			String col,String[]m_times)throws Exception{
		if(m_times==null){return;}
		
		
		Timestamp t = null;

		String sql = null;
		
		int i,num=0;
		num = m_times.length;
		
		
		sql = "update t_monitor_real_minute set m_value_old=m_value,m_value=null where m_value is not null and m_value_old is  null ";
		sql = sql +" and station_id=? and infectant_id=? and m_time=?";
		Object[]p=new Object[]{station_id,col,null};
		for(i=0;i<num;i++){
			t = StringUtil.getTimestamp(m_times[i],null);
			if(t==null){continue;}
			p[2]=t;
			DBUtil.update(cn,sql,p);
			
			
		}
		
		
	}
	
	public static void avg_check(Connection cn,String data_table,String station_id,
			String col,String[]m_times)throws Exception{
		if(m_times==null){return;}
		String sql = null;
		
		sql = "update "+data_table+" set "+col+"="+col+"_old, "+col+"_old=null "
		+" where "+col+" is null and "+col+"_old is not null "
		+" and station_id=? and m_time=?"
		;
		int i,num=0;
		num = m_times.length;
		Timestamp t = null;
		Object[]p=new Object[]{station_id,null};
		for(i=0;i<num;i++){
			t = StringUtil.getTimestamp(m_times[i],null);
			if(t==null){continue;}
			p[1]=t;
			DBUtil.update(cn,sql,p);
		}
		
		
		
	}
	

	public static void avg_uncheck(Connection cn,String data_table,String station_id,
			String col,String[]m_times)throws Exception{
		if(m_times==null){return;}
String sql = null;
		
		sql = "update "+data_table+" set "+col+"_old="+col+", "+col+"=null "
		+" where "+col+" is not null and "+col+"_old is  null "
		+" and station_id=? and m_time=?"
		;
		int i,num=0;
		num = m_times.length;
		Timestamp t = null;
		Object[]p=new Object[]{station_id,null};
		for(i=0;i<num;i++){
			t = StringUtil.getTimestamp(m_times[i],null);
			if(t==null){continue;}
			p[1]=t;
			DBUtil.update(cn,sql,p);
		}
		
	}
	
	public static void c(Connection cn,
			String check_flag,
			String data_table,
			String station_id,String col,String[]m_times)throws Exception{
		if(m_times==null){return;}
		if(StringUtil.equals(check_flag,"0")){
			
			if(StringUtil.equals(data_table,"t_monitor_real_minute")){
				         minute_check(cn,station_id,col,m_times);
			}else{
				         avg_check(cn,data_table,station_id,col,m_times);
				
			}
			
			
		}else{
			

			if(StringUtil.equals(data_table,"t_monitor_real_minute")){
				         minute_uncheck(cn,station_id,col,m_times);
			}else{
				         avg_uncheck(cn,data_table,station_id,col,m_times);
				
			}
			
		}
		
		

	}
	
}