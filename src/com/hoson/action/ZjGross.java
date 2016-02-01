package com.hoson.action;
import com.hoson.util.*;

import java.util.*;
import com.hoson.app.*;
import com.hoson.*;
import java.sql.*;

import javax.servlet.http.HttpServletRequest;


public class ZjGross extends BaseAction{

	
	  public  String gross()throws Exception{
			String area_id =p("area_id");
			String station_type=p("station_type");
			List stationList = null;

			List list = null;
			
		
			
			list=CacheUtil.getGrossDataList();

			stationList = ZjGrossUtil.getStationList(station_type,area_id,request);

			 
			
			
			ZjGrossUtil.makeData(stationList,list);
			
			seta("data",stationList);
			
			
			return null;
		}
		
	  
	  
	
	
   public  String rpt_water()throws Exception{
		String area_id =p("area_id");
		List stationList = null;
		String date1 = p("date1");
		String date2 = p("date2");
		Timestamp t1 = f.time(date1);
		Timestamp t2 = f.time(date2+" 23:59:59");
		List list = null;
		int groupsize=5;
		
		
		//System.out.println(date1+","+date2);
		//System.out.println(t1+","+t2);
		
		getConn();
		 stationList = ZjGrossUtil.getStationList(conn,"1",area_id,request);
		 
		list = ZjGrossUtil.getWaterData(conn,t1,t2,stationList,groupsize);
		
		ZjGrossUtil.makeData(stationList,list);
		
		seta("data",stationList);
		
		
		return null;
	}
	
   public  String rpt_gas()throws Exception{
		
		
	   String area_id =p("area_id");
		List stationList = null;
		String date1 = p("date1");
		String date2 = p("date2");
		Timestamp t1 = f.time(date1);
		Timestamp t2 = f.time(date2+" 23:59:59");
		List list = null;
		int groupsize=5;
		
		getConn();
		 stationList = ZjGrossUtil.getStationList(conn,"2",area_id,request);
		 
		list = ZjGrossUtil.getGasData(conn,t1,t2,stationList,groupsize);
		
		ZjGrossUtil.makeData(stationList,list);
		
		seta("data",stationList);
		
		
		return null;
		
	
	}
	
	
	
}