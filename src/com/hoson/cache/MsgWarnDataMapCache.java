package com.hoson.cache;

import com.hoson.f;
import java.util.*;
import java.sql.*;
import com.hoson.util.*;
import com.hoson.app.Cache;
import com.hoson.msg.*;



public class MsgWarnDataMapCache extends Cache{
	
	
	public Object getObject(Map map)
	throws Exception{
		List list = null;
		Connection cn = null;
		Map warnDataMap = null;
		
		
		try{
		
		
		cn = f.getConn();
		

		//list = getRealDataListOracle(cn);
		list = MsgUtil.getWarnDataList(cn);
		warnDataMap = f.getMap(list,"station_id");
		
		return warnDataMap;

		
		
		}catch(Exception e){
			throw e;
		}finally{f.close(cn);}
	}
	
	
	
}