package com.hoson.util;

import java.sql.*;

import com.hoson.*;

import javax.servlet.http.*;

import java.util.*;

public class AreaReport{
	
	
	public static String getStationTypeOption(String station_type)throws Exception{
		String s = null;
		String vs = "1,2";
		String ts = "污染源废水,污染源烟气";
		
		s = JspUtil.getOption(vs,ts,station_type);
		
		
		return s;
		
	}
	
	public static String getReportTypeOption(String report_type)throws Exception{
		String s = null;
		String vs = "day,month,year";
		String ts = "日报表,月报表,年报表";
		
		s = JspUtil.getOption(vs,ts,report_type);
		
		
		return s;
		
	}
	
	public static Map getGasSql(HttpServletRequest req,Map model)throws Exception{
		Map map = new HashMap();
		String sql1,sql2 = null;
		XBean b = new XBean(model);
		String station_type = b.get("station_type");
		String date1 = b.get("date1");
		String area_id = b.get("area_id");
		String so2 = b.get("g_so2");
		String pm = b.get("g_pm");
		String nox = b.get("g_nox");
		String q = b.get("g_q");
		String report_type = b.get("report_type");
		String cols = so2+","+pm+","+nox+","+q;
		Map timeMap = null;
		String start,end = null;
		String sqlWhereStr = "";
		String table1,table2 = null;
		table1 = "t_monitor_real_hour";
		table2 = "t_monitor_real_day";
		
		if(f.eq(report_type,"month")){
			table1 = "t_monitor_real_day";
			table2 = "t_monitor_real_month";
		}
		
		if(f.eq(report_type,"year")){
			table1 = "t_monitor_real_month";
			table2 = "t_monitor_real_year";
		}
		if(req.getParameter("tableName").equals("t_monitor_real_hour_v")){
			 table1 = table1+"_v";
			 table2 = table2+"_v";
		 }
		
		timeMap = StdReportUtil.getStartAndEndTime(date1,report_type);
		
		
		start = (String)timeMap.get("start");
		end = (String)timeMap.get("end");
		
		
		
		sql1 = " select station_id,m_time,"+cols+" from  "+table1;
		sql2 = " select station_id,m_time,"+cols+" from  "+table2;
		
		sqlWhereStr=sqlWhereStr+"  m_time>='"+start+"' and m_time<'"+end+"' ";
		sqlWhereStr=sqlWhereStr+" and station_id in(select station_id from t_cfg_station_info ";
		sqlWhereStr=sqlWhereStr+" where station_type='"+station_type+"' and area_id like '"+area_id+"%') ";
		sqlWhereStr=sqlWhereStr+ DataAclUtil.getStationIdInString(req,station_type,"station_id");
		
		
		sql1 = sql1+" where "+sqlWhereStr;
		sql2 = sql2+" where "+sqlWhereStr;
		
		map.put("sql1",sql1);
		map.put("sql2",sql2);
		
		return map;
		
	}
	public static Map getWaterSql(HttpServletRequest req,Map model)throws Exception{
		Map map = new HashMap();
		String sql1,sql2 = null;
		XBean b = new XBean(model);
		String station_type = b.get("station_type");
		String date1 = b.get("date1");
		String area_id = b.get("area_id");
		String cod = b.get("w_cod");
		String ph = b.get("w_ph");
	
		String q = b.get("w_q");
		String report_type = b.get("report_type");
		String cols = cod+","+ph+","+q;
		
		Map timeMap = null;
		String start,end = null;
		String sqlWhereStr = "";
		String table1,table2 = null;
		table1 = "t_monitor_real_hour";
		table2 = "t_monitor_real_day";
		
		if(f.eq(report_type,"month")){
			table1 = "t_monitor_real_day";
			table2 = "t_monitor_real_month";
		}
		
		if(f.eq(report_type,"year")){
			table1 = "t_monitor_real_month";
			table2 = "t_monitor_real_year";
		}
		 if(req.getParameter("tableName").equals("t_monitor_real_hour_v")){
			 table1 = table1+"_v";
			 table2 = table2+"_v";
		 }
		timeMap = StdReportUtil.getStartAndEndTime(date1,report_type);
		
		
		start = (String)timeMap.get("start");
		end = (String)timeMap.get("end");
		
		
		
		sql1 = " select station_id,m_time,"+cols+" from  "+table1;
		sql2 = " select station_id,m_time,"+cols+" from  "+table2;
		
		sqlWhereStr=sqlWhereStr+"  m_time>='"+start+"' and m_time<'"+end+"' ";
		sqlWhereStr=sqlWhereStr+" and station_id in(select station_id from t_cfg_station_info ";
		sqlWhereStr=sqlWhereStr+" where station_type='"+station_type+"' and area_id like '"+area_id+"%') ";
		sqlWhereStr=sqlWhereStr+ DataAclUtil.getStationIdInString(req,station_type,"station_id");
		
		
		sql1 = sql1+" where "+sqlWhereStr;
		sql2 = sql2+" where "+sqlWhereStr;
		
		map.put("sql1",sql1);
		map.put("sql2",sql2);
		
		return map;
		
	}
	
	public static List getStationList(Connection cn,String station_type,
			String area_id,HttpServletRequest req)throws Exception{
				List list = null;
				Map areaMap = null;
				int i,num=0;
				Map m = null;
				String id = null;
				
				String sql = null;
				sql = "select station_id,station_desc,area_id from "
					+" t_cfg_station_info where station_type='"+station_type+"' "
					
					;
				

				sql = sql+DataAclUtil.getStationIdInString(req,station_type,"station_id");
					
				
				if(!StringUtil.isempty(area_id)){
					sql=sql+" and area_id like '"+area_id+"%' ";
				}
			
				
				sql = sql+" order by area_id,station_desc";
				list = DBUtil.query(cn,sql,null);
				
				sql = "select area_id,area_name from t_cfg_area where area_id like '"+area_id+"%'";
				areaMap = f.getMap(cn,sql);
				num = list.size();
				
				for(i=0;i<num;i++){
					m = (Map)list.get(i);
					id = (String)m.get("area_id");
					m.put("area_name",areaMap.get(id));
					
				}
				
				
				return list;
				
			}
			
	     public static Map getInfectantInfo(Connection cn,String station_type,
	    		 String area_id,HttpServletRequest req)throws Exception{
	    	 Map info = new HashMap();
	    	 String sql = null;
	    	 String station_id,infectant_column = null;
	    	 List list = null;
	    	 int i,num=0;
	    	 Map m = null;
	    	 String key = null;
	    	 sql = "select * from t_cfg_monitor_param where station_id in(";
	    	 sql=sql+"select station_id from t_cfg_station_info where station_type='"+station_type+"'";
	    	 sql=sql+" and area_id like '"+area_id+"%') ";
             sql = sql+DataAclUtil.getStationIdInString(req,station_type,"station_id");
			 list = f.query(cn,sql,null);
			 num = list.size();
			 for(i=0;i<num;i++){
				 m  =(Map)list.get(i);
				 station_id = (String)m.get("station_id");
                infectant_column = (String)m.get("infectant_column");
                if(f.empty(infectant_column)){continue;}
                infectant_column = infectant_column.toLowerCase();
                key = station_id+"_"+infectant_column;
                info.put(key,m);
				 
			 }
	    	 
	    	 
	    	 
	    	 
	    	 
	    	 return info;
	    	 
	     }
	   public static void decodeDataList(List list,String col)throws Exception{
		   int i,num=0;
		   Map m = null;
		   String s = null;
		   Double v = null;
		   
		   num = list.size();
		   for(i=0;i<num;i++){
			   m = (Map)list.get(i);
			   s = (String)m.get(col);
			   s = f.v(s);
			   v = f.getDoubleObj(s,null);
			   m.put(col,v);
		   }
		   
		   
	   }
	   public static void decodeDataLists(List list,String cols)throws Exception{
		  String[]arr = cols.split(",");
		  int i,num=0;
		  
		  num = arr.length;
		  for(i=0;i<num;i++){
			  decodeDataList(list,arr[i]);
		  }
		   
		  ZeroAsNull.make(list,cols);
		  
	   }
	  
	   public static void rpt(HttpServletRequest req)throws Exception{
		   Connection cn = null;
		   Map model = null;
		   String station_type = f.p(req,"station_type");
		   String report_type = f.p(req,"report_type");
		   String area_id = f.p(req,"area_id");
		   Map m = null;
		   String sql = null;
		   String area_name = null;
		   String date1 = f.p(req,"date1");
		   String report_name = null;
		   
		   
		   
		   report_name = getReportName(station_type,report_type);
		   
		   req.setAttribute("report_name",report_name);
		   
		   try{
			   model = f.model(req);
			   cn = f.getConn();
			 
			   sql = "select * from t_cfg_area where area_id='"+area_id+"'";
			   m = f.queryOne(cn,sql,null);
			   
			   
			   if(f.eq(station_type,"1")){
				   water_report(cn,model,req);
			   }else{gas_report(cn,model,req);}
			   
			   
			   if(m!=null){area_name = (String)m.get("area_name");}
			   req.setAttribute("area_name",area_name);
			   Timestamp time = f.time(date1);
			   req.setAttribute("time",time);
			   
			   
		   }catch(Exception e){
			   throw e;
		   }finally{f.close(cn);}
		   
	   }
	   
	   public static void gas_report(
			   Connection cn,Map model,HttpServletRequest req)throws Exception{
		   XBean b = new XBean(model);
			String station_type = b.get("station_type");
			String date1 = b.get("date1");
			String area_id = b.get("area_id");
			String so2 = b.get("g_so2");
			String pm = b.get("g_pm");
			String nox = b.get("g_nox");
			String q = b.get("g_q");
			String report_type = b.get("report_type");
			
			List list1,list2 = null;
			String sql1,sql2 = null;
			Map sqlMap = null;
			List stationList = null;
			Map infectantInfo = null;
			String cols = so2+","+pm+","+nox+","+q;
			Map dataMap1,dataMap2 = null;
			int i,num=0;
			String grosscols = so2+","+pm+","+nox;
		
		
			
			sqlMap = getGasSql(req,model);
			sql1 = (String)sqlMap.get("sql1");
			sql2 = (String)sqlMap.get("sql2");
			
			list1 = f.query(cn,sql1,null);
			list2 = f.query(cn,sql2,null);
			
			
			
			
			stationList = getStationList(cn,station_type,area_id,req);
			infectantInfo = getInfectantInfo(cn,station_type,area_id,req);
			f.close(cn);
			
			decodeDataLists(list1,cols);
			decodeDataLists(list2,cols);
			
			
			//ZeroAsNull.make(list1,cols);
			//ZeroAsNull.make(list2,cols);
			
			dataMap1 = f.getListMap(list1,"station_id");
			dataMap2 = f.getMap(list2,"station_id");
			
			makeDataReportData(stationList,dataMap2,grosscols,q);
			makeDataNum(stationList,cols,dataMap1);
			makeOverDataNum(stationList,cols,dataMap1,infectantInfo);
		    req.setAttribute("data",stationList);
		    req.setAttribute("infectantInfo",infectantInfo);
		    req.setAttribute("sql1",sql1);
		    req.setAttribute("sql2",sql2);
	   }
	   
	   public static void water_report(
			   Connection cn,Map model,HttpServletRequest req)throws Exception{
		   XBean b = new XBean(model);
			String station_type = b.get("station_type");
			String date1 = b.get("date1");
			String area_id = b.get("area_id");
			String cod = b.get("w_cod");
			String ph = b.get("w_ph");
			
			String q = b.get("w_q");
			String report_type = b.get("report_type");
			
			List list1,list2 = null;
			String sql1,sql2 = null;
			Map sqlMap = null;
			List stationList = null;
			Map infectantInfo = null;
			String cols = cod+","+ph+","+q;
			Map dataMap1,dataMap2 = null;
			int i,num=0;
			String grosscols = cod+","+ph;
		
		
			
			sqlMap = getWaterSql(req,model);
			sql1 = (String)sqlMap.get("sql1");
			sql2 = (String)sqlMap.get("sql2");
			
			list1 = f.query(cn,sql1,null);
			list2 = f.query(cn,sql2,null);
			
			
			
			
			stationList = getStationList(cn,station_type,area_id,req);
			infectantInfo = getInfectantInfo(cn,station_type,area_id,req);
			f.close(cn);
			
			decodeDataLists(list1,cols);
			decodeDataLists(list2,cols);
			
			dataMap1 = f.getListMap(list1,"station_id");
			dataMap2 = f.getMap(list2,"station_id");
			
			makeDataReportData(stationList,dataMap2,grosscols,q);
			makeDataNum(stationList,cols,dataMap1);
			makeOverDataNum(stationList,cols,dataMap1,infectantInfo);
		    req.setAttribute("data",stationList);
		    req.setAttribute("infectantInfo",infectantInfo);
		    req.setAttribute("sql1",sql1);
		    req.setAttribute("sql2",sql2);
	   }
	
	   public static Double pv(String col,String qcol,Map data){
		   Double d,d1,d2 = null;
		   double dv = 0;
		   
		   d1 = (Double)data.get(col);
		   d2 = (Double)data.get(qcol);
		   if(d1==null){return null;}
		   if(d2==null){return null;}
		   dv = d1.doubleValue()*d2.doubleValue();
		   d = new Double(dv);
		   return d;
	   }
	   
	   public static void makeDataReportData(List stationList,Map dataMap,
			   String cols,String qcol){
		   int i,num=0;
		   String station_id = null;
		   Map m1,m2 = null;
		   int j,colnum = 0;
		   String[]arr=cols.split(",");
		   String col = null;
		   Double v = null;
		   
		   colnum = arr.length;
		   num = stationList.size();
		   for(i=0;i<num;i++){
			   m1 = (Map)stationList.get(i);
			   station_id = (String)m1.get("station_id");
			   m2 = (Map)dataMap.get(station_id);
			   if(m2==null){continue;}
			   for(j=0;j<colnum;j++){
				   col = arr[j];
				   m1.put(col,m2.get(col));
				   v = pv(col,qcol,m2);
				   m1.put(col+"_q",v);
				   
			   }
			   m1.put(qcol,m2.get(qcol));
		   }
		   
	   }
	   
	   public static void makeDataNum(List stationList,
			   String cols,Map stationDataListMap)throws Exception{
		 List dataList = null;
		 Map stationMap = null;
		 int i,num = 0;
		 String station_id = null;
		 
		 num = stationList.size();
		 
		 for(i=0;i<num;i++){
			 stationMap = (Map)stationList.get(i);
			 station_id = (String)stationMap.get("station_id");
			 dataList = (List)stationDataListMap.get(station_id);
			 if(dataList==null){dataList=new ArrayList();}
			 getDataNum(stationMap,cols,dataList);
			 
		 }
		 
		   
	   }
	   public static Integer getDataNum(String col,List dataList)throws Exception{
		   Integer numobj = null;
		   int i,num=0;
		   int dnum=0;
		   Map m = null;
		   Double d = null;
		   String v = null;
		   
		   
		   num = dataList.size();
		   for(i=0;i<num;i++){
			   m = (Map)dataList.get(i);
			   d = (Double)m.get(col);
			   if(d!=null){dnum++;}
		   }
		   
		   
		   numobj = new Integer(dnum);
		   
		   return numobj;
	   }
	   
	   public static void getDataNum(Map stationMap,String cols,List dataList)throws Exception{
		   String[]arr = cols.split(",");
		   int i,num = 0;
		   String col = null;
		   Integer dnum = null;
		   num  =arr.length;
		   
		   for(i=0;i<num;i++){
			   col  =arr[i];
			   dnum = getDataNum(col,dataList);
			   stationMap.put(col+"_num",dnum);
			   
		   }
		   
		   
	   }
	   
	   
	   
	   
	   public static Integer getOverDataNum(String station_id,String col,List dataList,Map infectantInfo)throws Exception{
		   Integer numobj = null;
		   int i,num=0;
		   int dnum=0;
		   Map m = null;
		   Double d = null;
		   String v = null;
		   boolean b = false;
		   
		   num = dataList.size();
		   for(i=0;i<num;i++){
			   m = (Map)dataList.get(i);
			   d = (Double)m.get(col);
			   b = isOver(station_id,col,d,infectantInfo);
			   if(b){dnum++;}
		   }
		   
		   
		   numobj = new Integer(dnum);
		   
		   return numobj;
	   }
	   public static boolean isOver(String station_id,String col,Double v,Map infectantInfo)throws Exception{
		   if(v==null){return false;}
		   
		   boolean b  =false;
		   String slolo,shihi = null;
		   double lolo,hihi = 0;
		   String key = station_id+"_"+col;
		   Map m = null;
		   double dv = v.doubleValue();
		   m = (Map)infectantInfo.get(key);
		   
		   if(m==null){return false;}
		   
		   slolo = (String)m.get("lolo");
		   shihi = (String)m.get("hihi");
		   lolo = f.getDouble(slolo,0);
		   hihi = f.getDouble(shihi,0);
		   
		   if(lolo>0 && dv<lolo){return true;}
		   if(hihi>0 && dv>hihi){return true;}
		 
		   return b;
		   
	   }
	   public static void getOverNum(Map stationMap,String cols,List dataList,Map infectantInfo)throws Exception{
		   String[]arr = cols.split(",");
		   int i,num = 0;
		   String col = null;
		   Integer dnum = null;
		   String station_id = (String)stationMap.get("station_id");
		   num  =arr.length;
		   
		   for(i=0;i<num;i++){
			   col  =arr[i];
			   dnum = getOverDataNum(station_id,col,dataList,infectantInfo);
			   stationMap.put(col+"_over_num",dnum);
			   
		   }
		   
		   
	   }
	   public static void makeOverDataNum(List stationList,
			   String cols,Map stationDataListMap,Map infectantInfo)throws Exception{
		 List dataList = null;
		 Map stationMap = null;
		 int i,num = 0;
		 String station_id = null;
		 
		 num = stationList.size();
		 
		 for(i=0;i<num;i++){
			 stationMap = (Map)stationList.get(i);
			 station_id = (String)stationMap.get("station_id");
			 dataList = (List)stationDataListMap.get(station_id);
			 if(dataList==null){dataList=new ArrayList();}
			 //getDataNum(stationMap,cols,dataList);
			 getOverNum(stationMap,cols,dataList,infectantInfo);
		 }
		 
		   
	   }
	   
	   
	   public static String getReportName(String station_type,String report_type){
		   String s = "水污染源在线监测日报表";
		   
		   if(f.eq(station_type,"1") &&f.eq(report_type,"month")){
			   s = "水污染源在线监测月报表";
		   }
		   
		   if(f.eq(station_type,"1") &&f.eq(report_type,"year")){
			   s = "水污染源在线监测年报表";
		   }
		   
		   
		   
		   if(f.eq(station_type,"2") &&f.eq(report_type,"day")){
			   s = "大气污染源在线监测月报表";
		   }
		   
		   if(f.eq(station_type,"2") &&f.eq(report_type,"year")){
			   s = "大气污染源在线监测年报表";
		   }
		   if(f.eq(station_type,"2") &&f.eq(report_type,"month")){
			   s = "大气污染源在线监测月报表";
		   }
		   
		  
		   
		   
		   return s;
		   
		   
	   }
	   
	   public static String sum(List dataList,String col,double v,String format)
	   throws Exception{
		   String s = null;
		   int i,num=0;
		   Double sumobj = null;
		   Double vobj = null;
		   Map m = null;
		   
		   double dv = 0;
		   num =dataList.size();
		   for(i=0;i<num;i++){
			   m = (Map)dataList.get(i);
			   //s = (String)m.get(col);
			   //vobj = f.getDoubleObj(s,null);
			   vobj = (Double)m.get(col);
			   if(vobj==null){continue;}
			   if(sumobj==null){
				   sumobj=vobj;
				   }else{
					   dv = sumobj.doubleValue()+vobj.doubleValue();
					   sumobj=new Double(dv);
				   }
			   
			   
		   }
		   
		   
		   if(sumobj==null){return "";}
		   dv = sumobj.doubleValue();
		   dv = dv/v;
		   s = f.format(dv+"",format);
		   
		   
		   return s;
		   
	   }
	   
	   
	   public static String v(String s,double v,String format)
	   throws Exception{
		  
		   Double vobj = f.getDoubleObj(s,null);
		   if(vobj==null){return "";}
		   
		   v = vobj.doubleValue()/v;
		   
		   s = f.format(v+"",format);
		   
		   return s;
		   
		   
		   
	   }
	   
	   
	   
	   public static String percentv(String s1,String s2,String format)
	   throws Exception{
		   String s = null;
		   double v,v1,v2 = 0;
		   
		   v1 = f.getDouble(s1,0);
		   v2 = f.getDouble(s2,0);
		   
		   if(v2==0){return "";}
		   
		   
		   v = v1*100/v2;
		   
		   s = f.format(v+"",format);
		   
		   
		   return s;
		   
	   }
	   
	   public static String percentv(String s1,String s2)
	   throws Exception{
		   return percentv(s1,s2,"0.##");
	   }
	   
	   public static String flag(String s,String station_id,
			   String col,Map infectantInfo){
		   String s2 = null;
		   String key = station_id+"_"+col;
		   Object obj = null;
		   
		   obj = infectantInfo.get(key);
		   if(obj==null){return "△";}
		   
		   
		   return s;
	   }
	   public static String flag(String s,String station_id,
			   String col,String col2,Map infectantInfo){
		   String s2 = null;
		   String key1 = station_id+"_"+col;
		   String key2 = station_id+"_"+col2;
		   Object obj1,obj2 = null;
		   
		   obj1 = infectantInfo.get(key1);
		   obj2 = infectantInfo.get(key2);
		   
		   if(obj1==null||obj2==null){return "△";}
		   
		   return s;
	   }
	   
	public static int getTotalNum(HttpServletRequest req)throws Exception{
		int num = 24;
		String report_type = req.getParameter("report_type");
		if(f.eq(report_type,"day")){return 24;}
		if(f.eq(report_type,"year")){return 12;}
		String date1 = req.getParameter("date1");
		return StdReportUtil.getMonthDayNum(date1);
		
		
		//return num;
		
	}
}