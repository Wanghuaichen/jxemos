package com.hoson.app;

import java.sql.*;
import java.io.*;
import java.util.*;
import java.text.*;
import com.hoson.*;
import javax.servlet.http.*;
import com.hoson.util.*;



public class SiteCompute{
	
	static String avg_table = "t_monitor_real_day";
	

	//----------
	public static List getInfectantInfoList(Connection cn,String station_type)
	throws Exception{
		List list = null;
		String sql = null;
	    
		
		sql = "select infectant_id,infectant_name,infectant_column,infectant_unit from t_cfg_infectant_base ";
		sql=sql+"where station_type='"+station_type+"' and ";
		sql=sql+"(infectant_type='1' or infectant_type='2') order by infectant_order asc";
		list = DBUtil.query(cn,sql,null);
		//System.out.println(sql);
		return list;		
	}
	
//----------
	public static double getAvg(Connection cn,String sql)throws Exception{
		String s = null;
		Statement stmt = null;
		ResultSet rs = null;
		try{
		stmt = cn.createStatement();
		rs=stmt.executeQuery(sql);
		rs.next();
		s=rs.getString(1);
		double d = StringUtil.getDouble(s,0);
		return d;
		}catch(Exception e){throw e;}finally{
			
			DBUtil.close(rs);
			DBUtil.close(stmt);
		}
		
	}
//------------
	public static String getAreaSqlIn(Connection cn,String area_id)
	throws Exception{
		if(StringUtil.isempty(area_id)){return "";}
		String s = null;
		List areaIdList = App.getSiteIdList(cn,area_id);
		s = StringUtil.list2str(areaIdList,"','");
		s="'"+s+"'";
		
		return s;
	} 
	
	
//------------------
//	------------
	public static String getValleySqlIn(Connection cn,String valley_id)
	throws Exception{
		if(StringUtil.isempty(valley_id)){return "";}
		String s = null;
		List valleyIdList = App.getValleyIdList(cn,valley_id);
		s = StringUtil.list2str(valleyIdList,"','");
		s="'"+s+"'";
		
		return s;
	} 
	
	
//------------------
	public static String getSiteState(Connection cn,String station_id)
	throws Exception{
		String s1 = "联机";
		String s2 = "脱机";
		String s = null;
		String dateNow=StringUtil.getNowDate()+"";
		int minuteNum = 0;
		int hourNum = 0;
		int alertNum = 0;
				
				
		
		String alertSql = "select count(*) from t_monitor_warning_real ";
		alertSql=alertSql+"where station_id='"+station_id+"' and ";
		alertSql=alertSql+"start_time>='"+dateNow+"' ";
		alertNum = DBUtil.getCountNum(cn,alertSql);
		
		String minuteSql = "select count(*) from t_monitor_real_minute ";
		minuteSql=minuteSql+"where station_id='"+station_id+"' and ";
		minuteSql=minuteSql+"m_time>='"+dateNow+"' ";
		minuteNum = DBUtil.getCountNum(cn,minuteSql);
		
		String hourSql = "select count(*) from t_monitor_real_hour ";
		hourSql=hourSql+"where station_id='"+station_id+"' and ";
		hourSql=hourSql+"m_time>='"+dateNow+"' ";			
		hourNum = DBUtil.getCountNum(cn,hourSql);
		
		
		if(minuteNum>0 || hourNum>0 || alertNum>0){
			s=s1;
			}else{
				s=s2;				
			}
		
		return s;
	}
	
	
	
//-------------
	public static String getSiteState(String station_id,HttpServletRequest req)
	throws Exception{
		
		Connection cn = null;
		try{
		cn = DBUtil.getConn(req);
		return getSiteState(cn,station_id);
		}catch(Exception e){throw e;}finally{DBUtil.close(cn);}
		
	}
	//---------------
	public static Map getMinuteMap(Connection cn,String station_type)
	throws Exception{
	Map map = null;
	String dateNow = StringUtil.getNowDate()+"";
	String sql = null;
	sql = "select station_id,count(*) from t_monitor_real_minute ";
	sql=sql+"where  m_time>='"+dateNow+"' group by station_id";
//	System.out.println(sql);
	map = DBUtil.getMap(cn,sql);
	return map;
	}
//	----------
	public static Map getHourMap(Connection cn,String station_type)
	throws Exception{
	Map map = null;
	String dateNow = StringUtil.getNowDate()+"";
	String sql = null;
	sql = "select station_id,count(*) from t_monitor_real_hour ";
	sql=sql+"where  m_time>='"+dateNow+"'  group by station_id";
	map = DBUtil.getMap(cn,sql);
	return map;
	}
//	----------
	public static Map getAlertMap(Connection cn,String station_type)
	throws Exception{
	Map map = null;
	String dateNow = StringUtil.getNowDate()+"";
	String sql = null;
	sql = "select station_id,count(*) from t_monitor_warning_real ";
	sql=sql+"where   start_time>='"+dateNow+"'  group by station_id";
	map = DBUtil.getMap(cn,sql);
	return map;
	}
//	----------
	
	public static List getStationIdListByAreaId(Connection cn,String station_type,String area_id)
	throws Exception{
	List list = new ArrayList();	
	String sql = null;
	String areaIds = null;	
	String station_id = null;
	sql = "select station_id from t_cfg_station_info ";
    sql=sql+"where station_type='"+station_type+"' ";	
	List areaIdList = App.getSiteIdList(cn,area_id);
	areaIds = StringUtil.list2str(areaIdList,"','");
	areaIds="'"+areaIds+"'";
	sql = sql+" and station_id in(";
	sql=sql+"select station_id from t_cfg_station_info where ";
	sql=sql+"area_id in("+areaIds+")) ";
	
	
		Statement stmt = null;
		ResultSet rs = null;
		
		try{
		stmt = cn.createStatement();
		rs = stmt.executeQuery(sql);
		while(rs.next()){
			station_id=rs.getString(1);
			list.add(station_id);
	    }
	
	return list;
		}catch(Exception e){
			throw e;
			}
		finally{
			DBUtil.close(rs);
			DBUtil.close(stmt);
			}
	}
	
	//------------------
	public static int[]getOffAndOnLineNum(Connection cn,String station_type,String area_id)
	throws Exception{
	int[]arr=new int[2];	
	Map alertMap = null;
	Map minuteMap = null;
	Map hourMap = null;
	List list = null;
	int i =0;
	int num = 0;
	String station_id = null;
	int alertNum =0;
	int minuteNum = 0;
	int hourNum = 0;
	int offNum = 0;
	int onNum = 0;
	
	
	
	list = getStationIdListByAreaId(cn,station_type,area_id);
	alertMap=getAlertMap(cn,station_type);
	minuteMap=getMinuteMap(cn,station_type);
	hourMap=getHourMap(cn,station_type);
	num=list.size();
	
	for(i=0;i<num;i++){
		station_id=(String)list.get(i);
		if(station_id==null){station_id="";}
		alertNum=StringUtil.getInt((String)alertMap.get(station_id),0);
		minuteNum=StringUtil.getInt((String)minuteMap.get(station_id),0);
		hourNum=StringUtil.getInt((String)hourMap.get(station_id),0);
		
		if(alertNum>0 || minuteNum>0 || hourNum>0){			
			onNum++;
		}else{
			offNum++;			
		}
				
	}
	arr[0]=offNum;
	arr[1]=onNum;
	return arr;
	}
	//-------------
	
	//--------------from area_info.jsp
	
//	-------------
	public static int getAlertNum(Connection cn,String station_type,
	List areaIdList)throws Exception{
	int num =0;
	String sql  =null;
	String dateNow = StringUtil.getNowDate()+"";
	String sqlIn = null;


	sqlIn = StringUtil.list2str(areaIdList,"','");
	sqlIn = "'"+sqlIn+"'";


	sql="select count(*) from t_monitor_warning_real a,t_cfg_station_info b ";
	sql=sql+"where a.start_time>='"+dateNow+"' and ";
	sql=sql+" a.station_id=b.station_id and b.station_type='"+station_type+"' and ";
	sql=sql+"b.area_id in("+sqlIn+")";

	num = App.getCountNum(cn,sql);

	return num;
	}
//	---------------
	public static int getMinuteNum(Connection cn,String station_type,
	List areaIdList)throws Exception{
	int num =0;
	String sql  =null;
	String dateNow = StringUtil.getNowDate()+"";
	String sqlIn = null;


	sqlIn = StringUtil.list2str(areaIdList,"','");
	sqlIn = "'"+sqlIn+"'";


	sql="select count(*) from t_monitor_real_minute a,t_cfg_station_info b ";
	sql=sql+"where a.m_time>='"+dateNow+"' and ";
	sql=sql+" a.station_id=b.station_id and b.station_type='"+station_type+"' and ";
	sql=sql+"b.area_id in("+sqlIn+")";

	num = App.getCountNum(cn,sql);

	return num;
	}
//	---------------
	public static int getHourNum(Connection cn,String station_type,
	List areaIdList)throws Exception{
	int num =0;
	String sql  =null;
	String dateNow = StringUtil.getNowDate()+"";
	String sqlIn = null;


	sqlIn = StringUtil.list2str(areaIdList,"','");
	sqlIn = "'"+sqlIn+"'";


	sql="select count(*) from t_monitor_real_hour a,t_cfg_station_info b ";
	sql=sql+"where a.m_time>='"+dateNow+"' and ";
	sql=sql+" a.station_id=b.station_id and b.station_type='"+station_type+"' and ";
	sql=sql+"b.area_id in("+sqlIn+")";

	num = App.getCountNum(cn,sql);

	return num;
	}
//	---------------
	public static String getAreaStationInfo(Connection cn,String station_type,String area_id)
	throws Exception{
		String msg="";
		List areaIdList = null;
		int[]arr=null;
		Map map = null;
		String sql = null;
		String area_name = null;
		
		int alertNum = 0;
		int minuteNum = 0;
		int hourNum = 0;
		int offNum=0;
		int onNum = 0;
		int num =0;
		String strAlertNum=null;
		
		sql = "select area_name from t_cfg_area where area_id='"+area_id+"'";
		map = DBUtil.queryOne(cn,sql,null);
		if(map==null){area_name="";}
		
		//2006-06-30  java.lang.NullPointException
		if(map==null){
			msg="<br>没有编号为["+area_id+"]的地区数据 ";
			//msg=msg+"<br>请检查表t_cfg_area的数据内容";
			return msg;
		}
		
		
		area_name=(String)map.get("area_name");
		if(area_name==null){area_name="";}
		
		
		areaIdList = App.getSiteIdList(cn,area_id);
		alertNum=getAlertNum(cn,station_type,areaIdList);
		minuteNum=getMinuteNum(cn,station_type,areaIdList);
		hourNum=getHourNum(cn,station_type,areaIdList);
		arr=getOffAndOnLineNum(cn,station_type,area_id);
		offNum=arr[0];
		onNum=arr[1];
		num=offNum+onNum;
		

		//msg = "环境质量地表水<br>\n";
		msg = msg+"地区名称 "+area_name+"<br>\n";
		msg = msg+"站位数 "+num+"<br>\n";
		msg = msg+"脱机数 "+offNum+"<br>\n";
		msg = msg+"连机数 "+onNum+"<br>\n";
		
		if(alertNum>0){
		strAlertNum="<font color=red>"+alertNum+"</font>";
		}else{
		strAlertNum=alertNum+"";
		}

		msg = msg+"报警记录数 "+strAlertNum+"<br>\n";
		msg = msg+"实时记录数 "+minuteNum+"<br>\n";
		msg = msg+"时均值记录数 "+hourNum+"<br>\n";
		
		
		
		return msg;		
	}
//---------------------------	
	public static String getAreaStationInfo(String station_type,String area_id,HttpServletRequest req)
	throws Exception{
		
		Connection cn = null;
		try{
		cn = DBUtil.getConn(req);
		return getAreaStationInfo(cn,station_type,area_id);
		}catch(Exception e){throw e;}finally{DBUtil.close(cn);}
		
	}
	//----------------
	//--------------new station compute--
	
	
	
	
	
	
	
	
	
//	---------------
	public static Map getAreaStationInfoMap(Connection cn,String station_type,String area_id)
	throws Exception{
		String msg="";
		List areaIdList = null;
		int[]arr=null;
		Map map = null;
		String sql = null;
		String area_name = null;
		
		int alertNum = 0;
		int minuteNum = 0;
		int hourNum = 0;
		int offNum=0;
		int onNum = 0;
		int num =0;
		String strAlertNum=null;
		Map map2 = new HashMap();
		
		sql = "select area_name from t_cfg_area where area_id='"+area_id+"'";
		map = DBUtil.queryOne(cn,sql,null);
		if(map==null){area_name="";}
		
		//2006-06-30  java.lang.NullPointException
		if(map==null){
			msg="<br>没有编号为["+area_id+"]的地区数据 ";
			//msg=msg+"<br>请检查表t_cfg_area的数据内容";
			
			map2.put("area_name","");
			map2.put("info",msg);
			
			return map2;
		}
		
		
		area_name=(String)map.get("area_name");
		if(area_name==null){area_name="";}
		
		
		areaIdList = App.getSiteIdList(cn,area_id);
		alertNum=getAlertNum(cn,station_type,areaIdList);
		minuteNum=getMinuteNum(cn,station_type,areaIdList);
		hourNum=getHourNum(cn,station_type,areaIdList);
		arr=getOffAndOnLineNum(cn,station_type,area_id);
		offNum=arr[0];
		onNum=arr[1];
		num=offNum+onNum;
		

		//msg = "环境质量地表水<br>\n";
		//msg = msg+"地区名称 "+area_name+"<br>\n";
		//msg = msg+"监测点(位)数 "+num+"<br>\n";
		
		
		
		msg = msg+"脱机数 "+offNum+"<br>\n";
		msg = msg+"连机数 "+onNum+"<br>\n";
		
		if(alertNum>0){
		strAlertNum="<font color=red>"+alertNum+"</font>";
		}else{
		strAlertNum=alertNum+"";
		}

		msg = msg+"报警记录数 "+strAlertNum+"<br>\n";
		msg = msg+"实时记录数 "+minuteNum+"<br>\n";
		msg = msg+"时均值记录数 "+hourNum+"<br>\n";
		
		map2.put("station_num",num+"");
		map2.put("area_name",area_name);
		map2.put("info",msg);
		return map2;		
	}
//---------------------------	
	public static Map getAreaStationInfoMap(String station_type,String area_id,HttpServletRequest req)
	throws Exception{
		
		Connection cn = null;
		try{
		cn = DBUtil.getConn(req);
		return getAreaStationInfoMap(cn,station_type,area_id);
		}catch(Exception e){throw e;}finally{DBUtil.close(cn);}
		
	}
	//----------------
	
	
	
	
	
	
	
	
	
	
	//-------------
	public static String getAvgReport(Connection cn,Map infectantMap,
			String station_type,
			String date1,String date2,
			String area_id,String valley_id,
			HttpServletRequest req
	)
	throws Exception{
		String s = "";
		String name = (String)infectantMap.get("infectant_name");
		String col = (String)infectantMap.get("infectant_column");
		String unit = (String)infectantMap.get("infectant_unit");
		String sql = null;
		List list = new ArrayList();
		
		Statement stmt = null;
		ResultSet rs = null;
		String ss = null;
        double dval = 0;
        double addVal =0;
        int valNum = 0;
        double avgVal =0;
        String date3 = null;
        
        date3 = StringUtil.getNextDay(java.sql.Date.valueOf(date2))+"";
        
        
		sql="select "; 
		//sql=sql+"avg("+col+") ";
		sql=sql+col;
		sql=sql+" from t_monitor_real_hour a,";
		sql=sql+"t_cfg_station_info b ";
		sql=sql+"where "; 
		//sql=sql+col+">0 ";
		sql=sql+"a.station_id=b.station_id ";
		sql=sql+"and b.station_type='"+station_type+"' ";
		sql=sql+"and m_time>='"+date1+"' ";
		//sql=sql+"and m_time<='"+date2+"' ";
		sql=sql+"and m_time<'"+date3+"' ";

		if(!StringUtil.isempty(area_id)){
		sql=sql+"and b.area_id like '"+area_id+"%' ";
		}
		if(!StringUtil.isempty(valley_id)){
		sql=sql+"and b.valley_id like '"+valley_id+"%' ";
		}
		sql = sql+DataAclUtil.getStationIdInString(req,station_type,"a.station_id");
		
		
		/*
		double d = getAvg(cn,sql);
		s = name+" "+d+" "+unit;
		*/
		//System.out.println(sql);
		
		try{
		stmt=cn.createStatement();
		rs=stmt.executeQuery(sql);
		while(rs.next()){
			ss = rs.getString(1);
			ss=AppPagedUtil.getValueStr(ss);
			dval=StringUtil.getDouble(ss,0);
			if(dval>0){
              addVal = addVal+dval;
              valNum++;
			}
			
		}
		
		if(valNum<1){
			avgVal=0;
			}else{
			avgVal=addVal/valNum;
		}
		
		String sAvgVal = null;
		sAvgVal=App.round(avgVal,2);
		//s =s +" "+name+" "+sAvgVal+" "+unit;
		s = name+" "+unit+";;"+sAvgVal;
		return s;	
		}catch(Exception e){throw e;}finally{DBUtil.close(rs);DBUtil.close(stmt);}
	}
	//--------------------
	public static String getAvgReport(Connection cn,List list,
			String station_type,
			String date1,String date2,
			String area_id,String valley_id,
			HttpServletRequest req
	)
	throws Exception{
		String s = "";
	
		Map map = null;
		
		int i =0;
		int num = 0;
		num = list.size();
		if(num<1){
			return "";
			}
		int flag = 0;
		String[]arr = null;
		String title = "";
		String data = "";
		String str = null;
		for(i=0;i<num;i++){
			
			map=(Map)list.get(i);
			/*
			s=s+" "+getAvgReport(cn,map,
					station_type,
					date1,date2,
					area_id,valley_id
			)+" ";
			flag++;
			if(flag%5==0){s=s+"<br>";flag=0;}
			*/
			str = getAvgReport(cn,map,
					station_type,
					date1,date2,
					area_id,valley_id,req
			);
			arr=str.split(";;");
			title = title+"<td>"+arr[0]+"</td>\n";
			data=data+"<td>"+arr[1]+"</td>\n";
		}
		
		s="<tr class=title>"+title+"</tr>\n"+"<tr>"+data+"</tr>";
		return s;
		
	}
	//----------------
	
	
//	----------
	public static List getStationListAll(Connection cn,String station_type,
	String date1,String date2,
	String areaSqlIn,String valleySqlIn)throws Exception{
	List list = new ArrayList();
	String sql = null;
	Statement stmt = null;
	ResultSet rs = null;
	String station_id = null;
     String station_name = null;
     
     
     
	sql="select "; 
	//sql=sql+"distinct a.station_id as station_id";
	sql=sql+"distinct b.station_desc ";
	sql=sql+"from t_monitor_real_hour a,";
	sql=sql+"t_cfg_station_info b ";
	sql=sql+"where "; 
	sql=sql+"a.station_id=b.station_id ";
	sql=sql+"and b.station_type='"+station_type+"' ";
	sql=sql+"and m_time>='"+date1+"' ";
	sql=sql+"and m_time<='"+date2+"' ";

	if(!StringUtil.isempty(areaSqlIn)){
	sql=sql+"and a.station_id in(select station_id from t_cfg_station_info where area_id in("+areaSqlIn+")) ";
	}
	if(!StringUtil.isempty(valleySqlIn)){
	sql=sql+"and a.station_id in(select station_id from t_cfg_station_info where valley_id in("+valleySqlIn+")) ";
	}
	
	
	//System.out.println(sql);
	try{
	stmt = cn.createStatement();
	rs=stmt.executeQuery(sql);
	while(rs.next()){
	station_name=rs.getString(1);
	if(station_name==null){station_name="";}
	list.add(station_name);
	}

	return list;
	}catch(Exception e){throw e;}finally{
	DBUtil.close(rs);
	DBUtil.close(stmt);
	}
	}
//	-------------------
	
//	----------
	public static List getStationList(Connection cn,String station_type,
	String date1,String date2,
	String areaSqlIn,String valleySqlIn)throws Exception{
	List list = new ArrayList();
	String sql = null;
	Statement stmt = null;
	ResultSet rs = null;
	String station_id = null;
     String station_name = null;
     
     
     
	sql="select "; 
	//sql=sql+"distinct a.station_id as station_id";
	sql=sql+"distinct b.station_desc ";
	sql=sql+"from t_monitor_real_hour a,";
	sql=sql+"t_cfg_station_info b ";
	sql=sql+"where "; 
	sql=sql+"a.station_id=b.station_id ";
	sql=sql+"and b.station_type='"+station_type+"' ";
	sql=sql+"and m_time>='"+date1+"' ";
	sql=sql+"and m_time<='"+date2+"' ";

	if(!StringUtil.isempty(areaSqlIn)){
	sql=sql+"and a.station_id in(select station_id from t_cfg_station_info where area_id in("+areaSqlIn+")) ";
	}
	if(!StringUtil.isempty(valleySqlIn)){
	sql=sql+"and a.station_id in(select station_id from t_cfg_station_info where valley_id in("+valleySqlIn+")) ";
	}
	
	
	//System.out.println(sql);
	try{
	stmt = cn.createStatement();
	rs=stmt.executeQuery(sql);
	while(rs.next()){
	station_name=rs.getString(1);
	if(station_name==null){station_name="";}
	list.add(station_name);
	}

	return list;
	}catch(Exception e){throw e;}finally{
	DBUtil.close(rs);
	DBUtil.close(stmt);
	}
	}
//	-------------------
//--------------------station_id----
//	----------
	public static List getStationIdList(Connection cn,String station_type,
	String date1,String date2,
	String areaSqlIn,String valleySqlIn)throws Exception{
	List list = new ArrayList();
	String sql = null;
	Statement stmt = null;
	ResultSet rs = null;
	String station_id = null;
     String station_name = null;
     
     
     
	sql="select "; 
	sql=sql+"distinct a.station_id as station_id ";
	//sql=sql+"distinct b.station_desc ";
	sql=sql+"from t_monitor_real_hour a,";
	sql=sql+"t_cfg_station_info b ";
	sql=sql+"where "; 
	sql=sql+"a.station_id=b.station_id ";
	sql=sql+"and b.station_type='"+station_type+"' ";
	sql=sql+"and m_time>='"+date1+"' ";
	sql=sql+"and m_time<='"+date2+"' ";

	if(!StringUtil.isempty(areaSqlIn)){
	sql=sql+"and a.station_id in(select station_id from t_cfg_station_info where area_id in("+areaSqlIn+")) ";
	}
	if(!StringUtil.isempty(valleySqlIn)){
	sql=sql+"and a.station_id in(select station_id from t_cfg_station_info where valley_id in("+valleySqlIn+")) ";
	}
	
	//System.out.println(sql);
	//System.out.println(sql);
	try{
	stmt = cn.createStatement();
	rs=stmt.executeQuery(sql);
	while(rs.next()){
	station_name=rs.getString(1);
	if(station_name==null){station_name="";}
	list.add(station_name);
	}

	return list;
	}catch(Exception e){throw e;}finally{
	DBUtil.close(rs);
	DBUtil.close(stmt);
	}
	}
//	-------------------
	
	public static List getStationIdListAll(Connection cn,String station_type,
			
			String areaSqlIn,String valleySqlIn)throws Exception{
			List list = new ArrayList();
			String sql = null;
			Statement stmt = null;
			ResultSet rs = null;
			String station_id = null;
		     String station_name = null;
		     
		     
		     
			sql="select "; 
			sql=sql+"distinct station_id from ";
			//sql=sql+"distinct b.station_desc ";
			//sql=sql+"from t_monitor_real_hour ";
			sql=sql+"t_cfg_station_info  ";
			sql=sql+"where "; 
			//sql=sql+"a.station_id=b.station_id ";
			sql=sql+" station_type='"+station_type+"' ";
			//sql=sql+"and m_time>='"+date1+"' ";
			//sql=sql+"and m_time<='"+date2+"' ";

			if(!StringUtil.isempty(areaSqlIn)){
			sql=sql+"and station_id in(select station_id from t_cfg_station_info where area_id in("+areaSqlIn+")) ";
			}
			if(!StringUtil.isempty(valleySqlIn)){
			sql=sql+"and station_id in(select station_id from t_cfg_station_info where valley_id in("+valleySqlIn+")) ";
			}
			
			//System.out.println(sql);
			//System.out.println(sql);
			try{
			stmt = cn.createStatement();
			rs=stmt.executeQuery(sql);
			while(rs.next()){
			station_name=rs.getString(1);
			if(station_name==null){station_name="";}
			list.add(station_name);
			}

			return list;
			}catch(Exception e){throw e;}finally{
			DBUtil.close(rs);
			DBUtil.close(stmt);
			}
			}
//--------------------
	//---------
	public static List getStationNoData(Connection cn,String station_type,
			String date1,String date2,
			String areaSqlIn,String valleySqlIn)throws Exception{
		List list = new ArrayList();
		List listNoDataId = new ArrayList();
		Map map = null;
		Map stationMap = null;
		String sql = null;
		String name = null;
		String id = null;
		int i =0;
		int num = 0;
		String[]arrHasData = null;
		String[]arrNoData = null;
		String[]arrAll=null;
		
		List listHasData = getStationIdList(cn,station_type,
				date1,date2,
				areaSqlIn,valleySqlIn);
		List listAll=getStationIdListAll(cn,station_type,
				//date1,date2,
				areaSqlIn,valleySqlIn);
		sql = "select station_id,station_desc as station_name from ";
		sql=sql+"t_cfg_station_info where station_type='"+station_type+"'";
		stationMap = DBUtil.getMap(cn,sql);
		num = listAll.size();
		arrAll=new String[num];
		for(i=0;i<num;i++){
			id=(String)listAll.get(i);
			arrAll[i]=id;
		}
		num = listHasData.size();
		arrHasData=new String[num];
		for(i=0;i<num;i++){
			id=(String)listHasData.get(i);
			arrHasData[i]=id;
		}
		
		num = arrAll.length;
		for(i=0;i<num;i++){
			id = arrAll[i];
			if(StringUtil.containsValue(arrHasData,id)<1){
				listNoDataId.add(id);
			}
			
		}
		
		//System.out.println(listNoDataId.size());
		num = listNoDataId.size();
		for(i=0;i<num;i++){
			id = (String)listNoDataId.get(i);
			name=(String)stationMap.get(id);
			map=new HashMap();
			map.put("station_id",id);
			map.put("station_name",name);
			list.add(map);
		}
		
		return list;
	}
	
	//---------------
	//-------------
	public static String getNoDataStationReport(Connection cn,String station_type,
			String date1,String date2,
			String areaSqlIn,String valleySqlIn)throws Exception{
	String s="";	
	
	List list = null;
	
	list = getStationNoData(cn,station_type,
			date1,date2,
			areaSqlIn,valleySqlIn);
	int i =0;
	int num =0;
	num = list.size();
	Map map = null;
	String id = null;
	String name = null;
	for(i=0;i<num;i++){
		map = (Map)list.get(i);
		name = (String)map.get("station_name");
		s = s+" "+name+" ";
	}
	
	return s;	
	}
	
	//-----------

	
	public static Map getAlertCountMap(Connection cn,String station_type,
			String date1,String date2,
			String areaSqlIn,String valleySqlIn)throws Exception{
		Map map = null;
		String sql = null;

		sql="select "; 

		sql=sql+"a.infectant_id,";
		sql=sql+"count(*) ";

		sql=sql+"from ";
		sql=sql+"t_monitor_warning_real a,";
		sql=sql+"t_cfg_station_info b ";
		sql=sql+"where  ";
		sql=sql+"a.station_id = b.station_id ";
		sql=sql+"and b.station_type='"+station_type+"' ";
		sql=sql+"and a.start_time>='"+date1+"' ";
		sql=sql+"and a.start_time<='"+date2+"' ";
		if(!StringUtil.isempty(areaSqlIn)){
			sql=sql+"and a.station_id in(select station_id from t_cfg_station_info where area_id in("+areaSqlIn+")) ";
			}
			if(!StringUtil.isempty(valleySqlIn)){
			sql=sql+"and a.station_id in(select station_id from t_cfg_station_info where valley_id in("+valleySqlIn+")) ";
			}

		sql=sql+" group by a.infectant_id";
		//System.out.println(sql);
		map = DBUtil.getMap(cn,sql);
		return map;
	}
	
	
//-------------
//	-------------------
	public static String  getAlertReport(Connection cn,String station_type,
			String date1,String date2,
			String areaSqlIn,String valleySqlIn)throws Exception{
		String s = "";
		Map alertMap = null;
		Map map = null;
		String name = null;
		String col = null;
		String id = null;
		int i =0;
		int num =0;
		int alertNum =0;
		
		List infectantList = null;
		alertMap = getAlertCountMap(cn,station_type,
				date1,date2,
				areaSqlIn,valleySqlIn);
		
		infectantList = getInfectantInfoList(cn,station_type);
		
		num = infectantList.size();
		if(num<1){return "";}
		int flag =0;
		
		for(i=0;i<num;i++){
			map = (Map)infectantList.get(i);
			name=(String)map.get("infectant_name");
			col=(String)map.get("infectant_column");
			id=(String)map.get("infectant_id");
			alertNum = StringUtil.getInt((String)alertMap.get(id),0);
			flag++;
			s = s+" "+name+" " + alertNum+" ";
			if(flag%5==0){
				s=s+"<br>";
				flag=0;
				}
		}
		
		
		return s;
	}
	
	
//-------------
	
	public static String getStationReport(List list){
		String s="";
		String name = null;
		int i =0;
		int num = 0;
		if(list==null){return "";}
		num=list.size();
		for(i=0;i<num;i++){
			name=(String)list.get(i);
			if(name==null){name="";}
			s=s+"  "+name+" ";
			}
		return s;
	}
	//---------------
	//---------------new power sql---
	public static Map siteDataMap(Connection cn,String station_type,
			String date1,String date2,
			String area_id,String valley_id)throws Exception{
		String s = "";
		String sql = "";
		Map map = null;
		
		sql=sql+"select station_id,count(1) ";
		sql=sql+"from (select count(1), to_char(m_time, 'yyyymmdd') as m_time, station_id ";
		sql=sql+" from t_monitor_real_day ";
		sql=sql+" where station_id in (select station_id ";
		sql=sql+" from t_cfg_station_info ";
		sql=sql+" where station_type = '"+station_type+"'";
		if(!StringUtil.isempty(area_id)){
			sql=sql+" and area_id like '"+area_id+"%' ";			
		}
		if(!StringUtil.isempty(valley_id)){
			sql=sql+" and valley_id like '"+valley_id+"%' ";			
		}
		sql=sql+") ";
		sql=sql+" and m_time >= '"+date1+"' ";
		sql=sql+" and m_time <= '"+date2+"' ";
		sql=sql+" group by ";
		  
		sql=sql+" m_time,";
		sql=sql+"station_id";
		 sql=sql+" ) t_ddd";
		 sql=sql+" group by station_id";
		
	   map = DBUtil.getMap(cn,sql);
		
	   //System.out.println(sql);
		
		return map;
	}
	
	//-----------
public static List getStationListAll(Connection cn,String station_type,
			
			String area_id,String valley_id)throws Exception{
			List list = new ArrayList();
			String sql = null;
			Statement stmt = null;
			ResultSet rs = null;
			String station_id = null;
		     String station_name = null;
		     Map map = null;
		     
		     
			sql="select "; 
			sql=sql+"distinct station_id,station_desc from ";
			//sql=sql+"distinct b.station_desc ";
			//sql=sql+"from t_monitor_real_hour ";
			sql=sql+"t_cfg_station_info  ";
			sql=sql+"where "; 
			//sql=sql+"a.station_id=b.station_id ";
			sql=sql+" station_type='"+station_type+"' ";
			//sql=sql+"and m_time>='"+date1+"' ";
			//sql=sql+"and m_time<='"+date2+"' ";

			if(!StringUtil.isempty(area_id)){
			sql=sql+"and station_id in(select station_id from t_cfg_station_info where area_id like '"+area_id+"%') ";
			}
			if(!StringUtil.isempty(valley_id)){
			sql=sql+"and station_id in(select station_id from t_cfg_station_info where valley_id like '"+valley_id+"%') ";
			}
			
			//System.out.println(sql);
			//System.out.println(sql);
			try{
			stmt = cn.createStatement();
			rs=stmt.executeQuery(sql);
			while(rs.next()){
			station_id=rs.getString(1);
			station_name=rs.getString(2);
			map = new HashMap();
			map.put("station_id",station_id);
			map.put("station_name",station_name);
			list.add(map);
			}

			return list;
			}catch(Exception e){throw e;}finally{
			DBUtil.close(rs);
			DBUtil.close(stmt);
			}
			}
//--------------------
//--------------
	public static String getStationDataReport(Connection cn,String station_type,
			String date1,String date2,
			String area_id,String valley_id)throws Exception{
		
	String s = "";
	List list = null;
	Map map = null;
	Map dataMap = null;
	Map alertNumMap = null;
	list = getStationListAll(cn,station_type,			
			area_id,valley_id);
	dataMap = siteDataMap(cn,station_type,
			date1,date2,
			area_id,valley_id);
	
	alertNumMap = getAlertNumMap(cn,station_type,
			date1,date2,
			area_id,valley_id);
	
	
	
	int i =0;
	int num =0;
	num = list.size();
	String name = null;
	String id = null;
	int rowNum = 0;
	int alertNum = 0;
	String sAlertNum = null;
	String sNum = null;
	for(i=0;i<num;i++){
		map=(Map)list.get(i);
		id = (String)map.get("station_id");
		name=(String)map.get("station_name");
		rowNum=StringUtil.getInt((String)dataMap.get(id),0);
		sAlertNum=(String)alertNumMap.get(id);
		alertNum=StringUtil.getInt(sAlertNum,0);
		
		s =s +"<tr>\n";
		s=s+"<td>"+id+"</td>\n";
		s=s+"<td>"+name+"</td>\n";
		if(rowNum<1){
			sNum="<font color=red>"+rowNum+"</font>";
			}else{
				sNum=rowNum+"";
			}
		s=s+"<td>"+sNum+"</td>\n";
		if(alertNum>0){
			sNum="<font color=red>"+alertNum+"</font>";
			}else{
				
				sNum=alertNum+"";
			}
		s=s+"<td>"+sNum+"</td>\n";
		s=s+"</tr>\n";
	}
	

	
	
	return s;
		
	}
		
		
	//-------------------------------
	//---------------
	public static Map getAlertNumMap(Connection cn,String station_type,
			String date1,String date2,
			String area_id,String valley_id)throws Exception{
		Map map = null;
		String sql = "";
		
		sql=sql+"select a.station_id,count(1) from ";
		sql=sql+"t_monitor_warning_real a,";
		sql=sql+"t_cfg_station_info b ";
		sql=sql+"where ";
		sql=sql+"a.station_id=b.station_id ";
		sql=sql+"and b.station_type='"+station_type+"' ";
		sql=sql+"and a.start_time>='"+date1+"' ";
		sql=sql+"and a.start_time<='"+date2+"' ";
		
		if(!StringUtil.isempty(area_id)){
		sql=sql+"and b.area_id like '"+area_id+"%' ";
		}
		if(!StringUtil.isempty(area_id)){
		sql=sql+"and b.valley_id like '"+valley_id+"%' ";
		}
		sql=sql+"group by a.station_id";
		map=DBUtil.getMap(cn,sql);				
		return map;
		
	}
	//---------------
	//----------------060614--
	
	public static String getMapValue(Map map,String key){
		if(map==null){return "";}
		if(key==null){return "";}
		String v = null;
		v = (String)map.get(key);
		if(v==null){return "";}
		return v;
		
	}
	//-------------
	public static List getStationListByAreaAndValleyId(Connection cn,String station_type,
			//String date1,String date2,
			String area_id,String valley_id,
			HttpServletRequest req)throws Exception{
		List list = new ArrayList();
		String sql = null;
		
		sql="select ";
		sql=sql+"station_desc as station_name,";
		sql=sql+"area_id,";
		sql=sql+"valley_id ";
		sql=sql+"from ";
		sql=sql+"t_cfg_station_info ";
		sql=sql+"where station_type='"+station_type+"' ";
		

		if(!StringUtil.isempty(area_id)){
		sql=sql+"and area_id like '"+area_id+"%' ";
		}
		if(!StringUtil.isempty(valley_id)){
		sql=sql+"and valley_id like '"+valley_id+"%' ";
		}
		sql = sql+DataAclUtil.getStationIdInString(req,station_type,"station_id");
		//System.out.println(sql);
		list = DBUtil.query(cn,sql,null);
				
		
		return list;
	}
	//------------------------
	public static String  getStationDataTable(Connection cn,
			List stationList,String area_id)throws Exception{
	
		if(StringUtil.isempty(area_id)){
			return "";
		}
		
	String s = "";
	String sql = null;
	Map areaMap = null;
	Map valleyMap = null;
	int i =0;
	int num = 0;
	Map map = null;
	String station_name = null;
	String sarea_id =null;
	String area_name = null;
	String valley_id = null;
	String valley_name = null;
	//System.out.println("getStationDataTable");
	
	sql = "select area_id,area_name from t_cfg_area";	
	areaMap = DBUtil.getMap(cn,sql);
	//System.out.println(sql);
	sql = "select valley_id,valley_name from t_cfg_valley";
	valleyMap = DBUtil.getMap(cn,sql);
	num = stationList.size();
	//System.out.println(sql);
	//System.out.println(num);
	for(i=1;i<=num;i++){
		map=(Map)stationList.get(i-1);
		sarea_id = (String)map.get("area_id");
		valley_id = (String)map.get("valley_id");
		station_name = (String)map.get("station_name");
		area_name = getMapValue(areaMap,sarea_id);
		valley_name =getMapValue(valleyMap,valley_id);
		
		s = s+"<tr class=tr"+i%2+">\n";
		s=s+"<td>"+i+"</td>\n";
		s=s+"<td>"+station_name+"</td>\n";
		s=s+"<td>"+area_name+"</td>\n";
		s=s+"<td>"+valley_name+"</td>\n";
		s=s+"</tr>\n";
	}
	
	s = "<tr class=title>\n" +
	    "<td>序号</td>\n" +
	    "<td>站位名称</td>\n" +
	    "<td>地区</td>\n" +
	    "<td>流域</td>\n" + s;
	
	return s;
	}
	
	//--------------
	
}//end class