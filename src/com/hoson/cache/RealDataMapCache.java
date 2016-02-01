package com.hoson.cache;

import com.hoson.DBUtil;
import com.hoson.f;
import java.util.*;
import java.sql.*;
import com.hoson.util.*;
import com.hoson.app.Cache;


public class RealDataMapCache extends Cache{
	
	
	public Object getObject(Map map)
	throws Exception{
		List list = null;
		Connection cn = null;
		Map realDataMap = null;
		
		
		try{
		
		
		cn = f.getConn();
		

		//list = getRealDataListOracle(cn);
		list = getRealDataListByOneSql(cn);
		realDataMap = RealDataUtil.getRealDataListMap(list);
		
		return realDataMap;

		}catch(Exception e){
			throw e;
		}finally{f.close(cn);}
	}
	
	
	
	
	
	static void createRealTmpTable(Connection cn)throws Exception{
		String sql = null;
		
		sql = "insert into tmp_real(station_id,m_time) select station_id, max(m_time) as m_time  from v_view_real group by station_id";
		
		f.update(cn,sql,null);
		
	}
	
	static void dropRealTmpTable(Connection cn){
		String sql = null;
		
		sql = "create table   tmp_real(station_id varchar(20),m_time date) ";
		try{
			f.update(cn,sql,null);
		}catch(Exception e){}
		
		sql = "truncate table   tmp_real  ";
		try{
		f.update(cn,sql,null);
		}catch(Exception e){}
	}
	
	
	 synchronized  static void getRealTmpTable(Connection cn)throws Exception{
		 dropRealTmpTable(cn);
		 createRealTmpTable(cn);
		
	}
	
	 /**
	  * 实时监控中--获取实时数据
	  * @param cn
	  * @return
	  * @throws Exception
	  */
	 public static List getRealDataListByOneSql(Connection cn)throws Exception{
		  String sql = null;
		  List list = null;
		  Timestamp t = null;
		  Object[]ps=null;
		  
		 sql = "select a.station_id,a.infectant_id,a.m_time,a.m_value from t_monitor_real_minute a,(select station_id,max(m_time) as m_time_max from t_monitor_real_minute where m_time>=? group by station_id) b ";
         //sql=sql+"  where a.station_id=b.station_id and a.m_time=b.m_time_max and m_time>=?  ";//黄宝修改
		 sql=sql+"  where a.station_id=b.station_id and a.m_time=b.m_time_max and m_time>=?";
         t = getRealStartTime();
         ps = new Object[]{t,t};
         
         list = f.query(cn,sql,ps);
		 //f.sop(sql);
		  return list;
	 }
	 
	 public static List getRealDataListOracle(Connection cn)throws Exception{
		 
		 String sql = "select * from v_view_real a,tmp_real b "
				+" where a.station_id = b.station_id "
				 +" and a.m_time = b.m_time "
				 +" order by a.station_id "
				 ;
		 List list = null;
		 try{
			 getRealTmpTable(cn);
			list= f.query(cn,sql,null);
		 }	
			catch (Exception e) {
				throw e;
			} finally {
				DBUtil.close( cn);
			}
			return list;
	 }
	 
	 
	 public static Timestamp getRealStartTime()throws Exception{
		 
		 //String real_hour_s = f.cfg("real_hour","6");黄宝修改
		 //int real_hour = f.getInt(real_hour_s,6);黄宝修改
		 //String real_hour_s = f.cfg("real_hour","6");
		 //int real_hour = f.getInt(real_hour_s,6);
		 String real_hour_s = f.cfg("real_hour","1");
		 int real_hour = f.getInt(real_hour_s,1);
		 String real_start_time_s = f.cfg("real_start_time","");
		 Timestamp real_start_time = null;
		 real_start_time = f.time(real_start_time_s,null);
		 
		 if(real_start_time!=null){return real_start_time;}
		 real_hour = 0-real_hour;
		 real_start_time = f.dateAdd(f.time(),"hour",real_hour);
		 return real_start_time;

		 
		 
	 }
	
}