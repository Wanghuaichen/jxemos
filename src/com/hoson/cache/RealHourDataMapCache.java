package com.hoson.cache;

import com.hoson.f;
import java.util.*;
import java.sql.*;
import com.hoson.util.*;
import com.hoson.app.Cache;


public class RealHourDataMapCache extends Cache{
	
	
	public Object getObject(Map map)
	throws Exception{
		String date1 = f.today();
		Timestamp t1,t2 = null;
		List list = null;
		Map dataMap = null;
		
		//date1 = "2008-10-13";
		
		date1 = f.cfg("real_hour_start",f.today());
		
		String sql = "select a.* from t_monitor_real_hour a,(select station_id,max(m_time) as m_time2 from t_monitor_real_hour where m_time>=? and m_time<=? group by station_id) b ";
	    sql = sql+" where a.station_id=b.station_id and a.m_time=b.m_time2 and a.m_time>=?  and m_time<=?";
		
	    t1 = f.time(date1);
	    date1 = date1+" 23:59:59";
	    t2 = f.time(date1);
	    Object[]ps = new Object[]{t1,t2,t1,t2};
	    
	    //f.sop(t1+","+t2);
	    
	    list = f.query(sql,ps);
	    
	    dataMap = f.getMap(list,"station_id");
	    
	    
		
		return dataMap;
	}
	
	
	
	
	
	
	
}