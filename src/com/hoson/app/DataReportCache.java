package com.hoson.app;

import com.hoson.*;
import java.util.*;
import java.sql.*;
import com.hoson.util.*;


public class DataReportCache extends Cache{
	
	public Object getObject(Map map)
	throws Exception{
	
		Connection cn = null;
		Map mm = new HashMap();
		
	
		try{
		
		
		cn = DBUtil.getConn();
		mm.put("minute",JspPageUtil.getMinuteDataReportMap(cn));
		mm.put("hour",JspPageUtil.getHourDataReportMap(cn));
		
		
		return mm;
		}catch(Exception e){
			throw e;
		}finally{DBUtil.close(cn);}
	}
}