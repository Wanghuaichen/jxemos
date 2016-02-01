package com.hoson.app;

import com.hoson.*;
import java.util.*;
import java.sql.*;
import com.hoson.util.*;


public class RealDataCache extends Cache{
	/*
	public Object getObject(Map map)
	throws Exception{
		List list = null;
		Connection cn = null;
		String sql;
		Map mm = new HashMap();
		Map m = null;
		
		try{
		
		//sql = RealData.getSqlMinute();
		
			
			sql = "select * from v_view_real a,tmp_real b "
				+" where a.station_id = b.station_id "
				 +" and a.m_time = b.m_time "
				 +" order by a.station_id "
				 ;
			//sql = f.getRealSql();	 
			
		cn = DBUtil.getConn();
		
		//dropRealTmpTable(cn);
		//createRealTmpTable(cn);
		
		//getRealTmpTable(cn);
		
		list = DBUtil.query(cn,sql,null);
		
		list = SupportUtil.dataCheck(list);
		
		
		//sql = "select distinct station_id,count(1) as row_num from view_minute_today group by station_id,infectant_id ";
		//m = DBUtil.getMap(cn,sql);
		//m = JspPageUtil.getDataReportMap();
		//m=(Map)m.get("minute");
		//System.out.println(m);
		mm.put("data",list);
		//mm.put("count",m);
		
		//return list;
		return mm;
		}catch(Exception e){
			throw e;
		}finally{DBUtil.close(cn);}
	}
	
	*/
	
	
	public Object getObject(Map map)
	throws Exception{
		List list = null;
		Connection cn = null;
		String sql;
		Map mm = new HashMap();
		Map m = null;
		
		try{
		
		//sql = RealData.getSqlMinute();
		
		
				 
			
		cn = DBUtil.getConn();
		
		//dropRealTmpTable(cn);
		//createRealTmpTable(cn);
		
		// start old
		
		
		
		// end old
		//list = getRealDataListOracle(cn);
		list = getRealDataListByOneSql(cn);
		
		//list = SupportUtil.dataCheck(list);
		
		
		//sql = "select distinct station_id,count(1) as row_num from view_minute_today group by station_id,infectant_id ";
		//m = DBUtil.getMap(cn,sql);
		//m = JspPageUtil.getDataReportMap();
		//m=(Map)m.get("minute");
		//System.out.println(m);
		mm.put("data",list);
		//mm.put("count",m);
		
		//return list;
		return mm;
		}catch(Exception e){
			throw e;
		}finally{DBUtil.close(cn);}
	}
	
	
	
	
	/*
	static void createRealTmpTable(Connection cn)throws Exception{
		String sql = null;
		
		sql = "create table   tmp_real as "
		+" select station_id, max(m_time) as m_time "
        +" from v_view_real "
        +"group by station_id"
        ;
		DBUtil.update(cn,sql,null);
		
	}
	
	static void dropRealTmpTable(Connection cn){
		String sql = null;
		
		sql = "drop table   tmp_real  ";
		try{
		DBUtil.update(cn,sql,null);
		}catch(Exception e){}
	}
	*/
	static void createRealTmpTable(Connection cn)throws Exception{
		String sql = null;
		
		sql = "insert into tmp_real(station_id,m_time) select station_id, max(m_time) as m_time  from v_view_real group by station_id";
		
		DBUtil.update(cn,sql,null);
		
	}
	
	static void dropRealTmpTable(Connection cn){
		String sql = null;
		
		sql = "create table   tmp_real(station_id varchar(20),m_time date) "
			
	        
	        ;
		try{
			DBUtil.update(cn,sql,null);
		}catch(Exception e){}
		
		sql = "truncate table   tmp_real  ";
		try{
		DBUtil.update(cn,sql,null);
		}catch(Exception e){}
	}
	
	
	 synchronized  static void getRealTmpTable(Connection cn)throws Exception{
		 dropRealTmpTable(cn);
		 createRealTmpTable(cn);
		
	}
	
	 
	 public static List getRealDataListByOneSql(Connection cn)throws Exception{
		  String sql = null;
		  List list = null;
		  Timestamp t = null;
		  Object[]ps=null;
		  
		 sql = "select * from t_monitor_real_minute a,(select station_id,max(m_time) as m_time_max from t_monitor_real_minute where m_time>=? group by station_id,m_time) b ";
         sql=sql+"  where a.station_id=b.station_id and a.m_time=b.m_time_max and m_time>=?  ";
       
         t = getRealStartTime();
         ps = new Object[]{t,t};
         
         list = f.query(cn,sql,ps);
		 
		   return list;
	 }
	 
	 public static List getRealDataListOracle(Connection cn)throws Exception{
		 
		 String sql = "select * from v_view_real a,tmp_real b "
				+" where a.station_id = b.station_id "
				 +" and a.m_time = b.m_time "
				 +" order by a.station_id "
				 ;
		 getRealTmpTable(cn);
			
			List list = DBUtil.query(cn,sql,null);
			return list;
	 }
	 
	 
	 public static Timestamp getRealStartTime()throws Exception{
		 
		 String real_hour_s = f.cfg("real_hour","6");
		 int real_hour = f.getInt(real_hour_s,6);
		 String real_start_time_s = f.cfg("real_start_time","");
		 Timestamp real_start_time = null;
		 real_start_time = f.time(real_start_time_s,null);
		 
		 if(real_start_time!=null){return real_start_time;}
		 real_hour = 0-real_hour;
		 real_start_time = f.dateAdd(f.time(),"hour",real_hour);
		 return real_start_time;

		 
		 
	 }
	
}