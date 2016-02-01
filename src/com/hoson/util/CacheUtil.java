package com.hoson.util;

import java.util.*;

import com.hoson.app.*;
import javax.servlet.http.*;
import com.hoson.cache.*;

public class CacheUtil{
	
	public static Map getRealDataMap()
	throws Exception{
		
		Cache cache = new RealDataCache();
		Map map = (Map)cache.get(50,null);
		return map;
	}
	
	public static Map getRealHourDataMap()
	throws Exception{
		
		Cache cache = new RealHourDataMapCache();
		Map map = (Map)cache.get(50,null);
		return map;
	}
	
	
	
	public static Map getRealDataMapNew()
	throws Exception{
		
		Cache cache = new RealDataMapCache();
		Map map = (Map)cache.get(50,null);
		return map;
	}
	
	
	public static Map getDataReportMap()
	throws Exception{
		
		Cache cache = new DataReportCache();
		Map map = (Map)cache.get(50,null);
		return map;
	}
	
	public static Map getAreaInfoDataMap()
	throws Exception{
		
		Cache cache = new AreaInfoDataCache();
		Map map = (Map)cache.get(50,null);
		return map;
	}
	
	public static Map getWarnDataMap()
	throws Exception{
		
		Cache cache = new WarnCache();
		Map map = (Map)cache.get(300,null);
		return map;
	}
	
	public static List getGrossDataList()
	throws Exception{
		
		Cache cache = new GrossDataCache();
	
		List list = (List)cache.get(5*60*60,null);
		return list;
	}
	
	public static Map getMsgWarnDataMap()
	throws Exception{
		
		Cache cache = new MsgWarnDataMapCache();
	
		Map m  = (Map)cache.get(2*60*60,null);
		return m;
	}
	
	
}