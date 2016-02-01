package com.hoson.action;
import com.hoson.util.*;

import java.util.*;

import com.hoson.*;
import java.sql.*;


public class FyReport extends BaseAction{
	
	public String rpt01()throws Exception{
		String cod_col = p("cod_col");
		String date1 = p("date1");
		String cod_std = p("cod_std");
		String cod_std2 = p("cod_std2");
		String station_type=p("station_type");
		String station_id=p("station_id");
		Map timeMap = SiteReportUtil.getMonthReportTimeInfo(date1);
		String start,end = null;
		Map m = null;
		String station_name = null;
		String sql = null;
		List list = null;
		int i,num=0;
		double cod_std_v = 0;
		double cod_std2_v = 0;
		Timestamp ts = null;
		String s = null;
		List list2 = new ArrayList();
		Map m2 = null;
		int idate,ihour = 0;
		Map dataMap = new HashMap();
		List dateList =new ArrayList();
		String key = null;
		List dataList = new ArrayList();
		int yy,mm = 0;
		
		ts = f.time(date1);
		yy = ts.getYear()+1900;
		mm=ts.getMonth()+1;
		
		
		double d = 0;
		double d2 = 0;
		d = f.getDouble(cod_std,0);
		d2= f.getDouble(cod_std2, 0);
		if(d<10){d=10;}
		if(d2>10000){d2=10000;}
		cod_std_v = d;
		cod_std2_v = d2;
		
		if(f.empty(station_id)){
			throw new Exception("请选择站位");
		}
		start = (String)timeMap.get("start");
		end = (String)timeMap.get("end");
		
		sql = "select station_id,station_desc from t_cfg_station_info where station_id=?";
		m = f.queryOne(sql,new Object[]{station_id});
		if(m==null){throw new Exception("站位不存在");}
		station_name = (String)m.get("station_desc");
		
		sql = "select m_time,"+cod_col+" as codv from "+request.getParameter("tableName")+" where station_id='"+station_id+"' and m_time>='"+start+"' ";
		sql=sql+" and m_time<='"+end+"' order by m_time";
		
		list = f.query(sql,null);
		
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			s = (String)m.get("m_time");
			ts = f.time(s,null);
			if(ts==null){continue;}
		    s = (String)m.get("codv");
		    s = f.v(s);
		    d =f.getDouble(s,0);
		    //if(d<cod_std_v){continue;}
		    if(cod_std_v>d || d >cod_std2_v){continue;}
		    
		    m2 = new HashMap();
		    m2.put("m_time",ts);
		    m2.put("codv",new Double(d));
		    idate = ts.getDate();
		    ihour = ts.getHours();
		    key = idate+"";
		    
		    m = (Map)dataMap.get(key);
		    if(m==null){
		    	m = new HashMap();
		    	m.put("date",key);
		    	dataMap.put(key,m);
		    	dateList.add(key);
		    	dataList.add(m);
		    }
		    m.put(ihour+"",d+"");
			
		}
		
		num = dataList.size();
		for(i=0;i<num;i++){
			m = (Map)dataList.get(i);
			m.put("avg",avg(m));
		}
		
		
		
		seta("station_name",station_name);
		seta("yy",yy+"");
		seta("mm",mm+"");
		seta("dataList",dataList);
		seta("avg",avg2(dataList));
		seta("std",cod_std_v+"");
		seta("std2",cod_std2_v+"");
		
		
		return null;
	}
    public String rpt02()throws Exception{
    	String area_id = p("area_id");
    	String q_col = p("q_col");
    	String cod_col = p("cod_col");
		String date1 = p("date1");
		String cod_std = p("cod_std");
		String station_type=p("station_type");
		String yc_v_s = p("yc_v");
		String gz_v_s = p("gz_v");
		double cod_std_v = f.getDouble(cod_std,0);
		if(cod_std_v<=0){cod_std_v=1000;}
		double yc_v = f.getDouble(yc_v_s,0);
		if(yc_v<=0){yc_v=0.2;}
		
		double gz_v = f.getDouble(gz_v_s,0);
		if(gz_v<=0){gz_v=0.2;}
		
        int yy,mm = 0;
        Timestamp ts = null;
		
		ts = f.time(date1);
		yy = ts.getYear()+1900;
		mm=ts.getMonth()+1;
		
		Map timeMap = SiteReportUtil.getMonthReportTimeInfo(date1);
    	String sql = null;
    	Map m = null;
    	String station_name = null;
    	String start,end = null;
    	List list = null;
    	List stationList = null;
    	Map dataMap,dataMapAll = null;
    	
    	int i,num=0;
    	List list2 = null;
    	int dayNum = StdReportUtil.getMonthDayNum(date1);
    	
    	
    
		
		start = (String)timeMap.get("start");
		end = (String)timeMap.get("end");
		
		String tableName = "t_monitor_real_day";
    	if(request.getParameter("tableName").equals("t_monitor_real_hour_v")){
    		tableName = "t_monitor_real_day_v";
    	}
		
		sql = "select station_id,m_time,"+cod_col+" as codv,"+q_col+" as qv,is_gz from "+tableName+" where  m_time>='"+start+"' ";
		sql=sql+" and m_time<='"+end+"' ";
		sql=sql+" and station_id in(";
		sql=sql+"select station_id from t_cfg_station_info ";
		sql=sql+" where station_type='"+station_type+"' ";
		sql=sql+" and area_id like '"+area_id+"%') ";
		sql = sql+DataAclUtil.getStationIdInString(request,station_type,"station_id");
		
		sql=sql+" order by station_id,m_time ";
		
		
		list = f.query(sql,null);
		
    	sql = "select * from t_cfg_station_info where ";
    	sql=sql+" station_type='"+station_type+"' ";
    	
    	stationList = FyReportUtil.getStationList(station_type,area_id,null,request);
    	
    	
    	//num = list.size();
    	
    	list = FyReportUtil.decodeDataList(list);
    	dataMapAll = f.getListMap(list,"station_id");
    	
    	list =  FyReportUtil.decodeDataListNotgz(list);
    	
    	dataMap = f.getListMap(list,"station_id");
    	
    	
    	//System.out.println(dataMap);
    	/*
    	list = FyReportUtil.getDataList(stationList, dataMap,
    			yc_v,gz_v,cod_std_v);
    			*/
    	
    	list = FyReportUtil.getDataList(stationList, dataMap,dataMapAll,
    			yc_v,gz_v,cod_std_v,dayNum);
    	
    	
    
    	
    	seta("list",list);
    	seta("cod_std",cod_std_v+"");
		seta("yy",yy+"");
		seta("mm",mm+"");
		return null;
	}
    
    public String rpt05()throws Exception{
    	String area_id = p("area_id");
    	String q_col = p("q_col");
		String date1 = p("date1");
		String station_type=p("station_type");
		
    	String sql = null;
    	Map m = null;
    	String start = date1;
    	String end = date1+" 23:59:59";
    	List list = null;
    	List stationList = null;
    	int i,num=0;
    	Map dataMap = null;
    	String station_id = null;
    	List stationDataList = null;
    	
		
		sql = "select station_id,m_time,"+q_col+" from "+request.getParameter("tableName")+" where  m_time>='"+start+"' ";
		sql=sql+" and m_time<='"+end+"' ";
		sql=sql+" and station_id in(";
		sql=sql+"select station_id from t_cfg_station_info ";
		sql=sql+" where station_type='"+station_type+"' ";
		sql=sql+" and area_id like '"+area_id+"%') ";
		sql = sql+DataAclUtil.getStationIdInString(request,station_type,"station_id");
		
		sql=sql+" order by station_id,m_time ";
		//System.out.println("q_col="+q_col);
		//System.out.println(sql);
		
		list = f.query(sql,null);
		//System.out.println(list.size());
		
		FyReportUtil.decodeDataList(list,q_col);
		
		//System.out.println(list.size());
		
		dataMap = f.getListMap(list,"station_id");
		
    
    	stationList = FyReportUtil.getStationList(station_type,area_id,null,request);
    	num=stationList.size();
    	for(i=0;i<num;i++){
    		m = (Map)stationList.get(i);
    		station_id = (String)m.get("station_id");
    		stationDataList = (List)dataMap.get(station_id);
    		if(stationDataList==null){continue;}
    		
    		//SxReportUtil.printlist(stationDataList);
    		
    		StdReportUtil.hztj(stationDataList,q_col,m);
    		
    		//System.out.println(m.get(q_col+"_count")+","+m.get(q_col+"_sum"));
    		
    		
    	}
    	seta("data",stationList);
    	seta("q_col",q_col);
    	//num = list.size();
    	
		return null;
	}
    
    public String dataList()throws Exception{
    	String date1 = p("date1");
    	
    	String station_id=p("station_id");
    	//System.out.println("11tableName===="+request.getParameter("tableName"));
    	String tableName = "t_monitor_real_day";
    	if(request.getParameter("tableName").equals("t_monitor_real_hour_v")){
    		tableName = "t_monitor_real_day_v";
    	}
		Map timeMap = SiteReportUtil.getMonthReportTimeInfo(date1);
		String sql = null;
		String start,end = null;
		List infectantList,dataList = null;
		
		if(f.empty(station_id)){
			throw new Exception("请选择站位");
		}
		start = (String)timeMap.get("start");
		end = (String)timeMap.get("end");
		sql = "select * from "+tableName+" where station_id='"+station_id+"'";
		sql=sql+" and m_time>='"+start+"' ";
		sql=sql+" and m_time<='"+end+"'";
		sql=sql+" order by m_time asc";
		
		getConn();
		infectantList = f.getInfectantListByStationId(conn,station_id);
		dataList = f.query(conn,sql,null);
		close();
    	
		seta("infectantList",infectantList);
		seta("dataList",dataList);
		seta("station_id",station_id);
		seta("start",start);
		seta("end",end);
    	return null;
    }
    
    public String update()throws Exception{
    	
    	String station_id=p("station_id");
		String sql = null;
		String start = p("start");
		String end = p("end");
		
		String m_time = null;
		Timestamp t = null;
		Object[]ps = new Object[2];
		String errormsg = "";
		
		String[]times = request.getParameterValues("m_time");
		if(times==null){times=new String[0];}
		int i,num=0;
		
		if(f.empty(station_id)){
			throw new Exception("请选择站位");
		}
		
		sql = "update t_monitor_real_day set is_gz='0' ";
		sql=sql+" where station_id='"+station_id+"'";
		sql=sql+" and m_time>='"+start+"' ";
		sql=sql+" and m_time<='"+end+"' ";
		sql=sql+" and is_gz='1'";
		//start();
		getConn();
		f.update(conn,sql,null);
		num = times.length;
		ps[0] = station_id;
		sql = "update t_monitor_real_day set is_gz='1' where station_id=? and m_time=?";
	
		for(i=0;i<num;i++){
			m_time = times[i];
			if(f.empty(m_time)){continue;}
			t = f.time(m_time,null);
			if(t==null){continue;}
			ps[1]=t;
			try{
			f.update(conn,sql,ps);
			}catch(Exception ee){
				errormsg = ee+"";
			}
			
		}
		
		if(!f.empty(errormsg)){
			throw new Exception(errormsg);
		}
    	
    	return null;
    }
    
    public static String avg(Map m)throws Exception{
		int i,num=0;
	
		String v = null;
		Double d = null;
		double sum=0;
		int idatanum = 0;
		
		for(i=0;i<24;i++){
			v = (String)m.get(i+"");
			d = f.getDoubleObj(v,null);
			if(d==null){continue;}
			sum = sum+d.doubleValue();
			num++;
		}
    	if(num<1){return "";}
    	double avg = sum/num;
		return avg+"";
	}
    public static String avg2(List list)throws Exception{
		int i,num=0;
	
		String v = null;
		Double d = null;
		double sum=0;
		int idatanum = 0;
		Map m = null;
		
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			
			v = (String)m.get("avg");
			d = f.getDoubleObj(v,null);
			if(d==null){continue;}
			sum = sum+d.doubleValue();
			idatanum++;
		}
    	if(idatanum<1){return "";}
    	double avg = sum/idatanum;
		return avg+"";
	}
	
    public String data()throws Exception{
        String m_time = p("m_time");
    	
    	String station_id=p("station_id");

		String sql = null;
		String start,end = null;
		List infectantList,dataList = null;
		
		if(f.empty(station_id)){
			throw new Exception("请选择站位");
		}
		start = m_time;
		end = m_time+" 23:59:59";
		sql = "select * from t_monitor_real_hour where station_id='"+station_id+"'";
		sql=sql+" and m_time>='"+start+"' ";
		sql=sql+" and m_time<='"+end+"'";
		sql=sql+" order by m_time asc";
		
		getConn();
		infectantList = f.getInfectantListByStationId(conn,station_id);
		dataList = f.query(conn,sql,null);
		close();
    	
		seta("infectantList",infectantList);
		seta("dataList",dataList);
		seta("station_id",station_id);
		seta("start",start);
		seta("end",end);
   
    	return null;
    }
    public String rpt06()throws Exception{
    	String area_id = p("area_id");
    
    	String cod_col = p("cod_col");
		String date1 = p("date1");
		String cod_std = p("cod_std");
		String station_type=p("station_type");
		
		double cod_std_v = f.getDouble(cod_std,0);
		if(cod_std_v<=0){cod_std_v=1000;}
    	
		Map timeMap = SiteReportUtil.getMonthReportTimeInfo(date1);
    	String sql = null;
    	Map m = null;
    	String station_name = null;
    	String start,end = null;
    	List list = null;
    	List stationList = null;
    	Map dataMap,dataMapAll = null;
    	
    	int i,num=0;
    	List list2 = null;
    	int dayNum = StdReportUtil.getMonthDayNum(date1);
    	
    	
    
		
		start = (String)timeMap.get("start");
		end = (String)timeMap.get("end");
		
		
		
		sql = "select station_id,m_time,"+cod_col+" as codv from "+request.getParameter("tableName")+" where  m_time>='"+start+"' ";
		sql=sql+" and m_time<='"+end+"' ";
		sql=sql+" and station_id in(";
		sql=sql+"select station_id from t_cfg_station_info ";
		sql=sql+" where station_type='"+station_type+"' ";
		sql=sql+" and area_id like '"+area_id+"%') ";
		sql = sql+DataAclUtil.getStationIdInString(request,station_type,"station_id");
		
		//sql=sql+" order by station_id,m_time ";
		
		
		list = f.query(sql,null);
	
    	stationList = FyReportUtil.getStationList(station_type,area_id,null,request);
    	
    	
    	//num = list.size();
    	
    	//list = FyReportUtil.decodeDataList(list);
		list = FyReportUtil.decodeDataListNotgz(list);
		FyReportUtil.decodeDataList(list,"codv");
		
		dataMap = getCodOverDataMap(list,cod_std_v);
		
		seta("stationList",stationList);
		seta("dataMap",dataMap);
		seta("daynum",new Integer(dayNum));
		
    	return null;
    }
    
    static Map getCodOverDataMap(List list,double cod_std)throws Exception{
    	
    	Map data = new HashMap();
    	if(list==null){return data;}
    	Map m = null;
    	int i,num=0;
    	String station_id,m_time = null;
    	Timestamp time = null;
    	int dd =0;
    	String key = null;
    	Double dvobj = null;
    	
    	
    	num=list.size();
    	for(i=0;i<num;i++){
    		m=(Map)list.get(i);
    		station_id = (String)m.get("station_id");
    		m_time = (String)m.get("m_time");
    		dvobj=(Double)m.get("codv");
    		if(dvobj==null){continue;}
    		if(f.empty(station_id)||f.empty(m_time)){continue;}
    		time=f.time(m_time,null);
    		if(time==null){continue;}
    		dd=time.getDate();
    		key = station_id+"_dd_"+dd;
    		
    		if(dvobj.doubleValue()>cod_std){
    			data.put(key,"1");
    		}
    		
    		
    	}
    	
    	
    	
    	return data;
    }
    
    
 static List getCodOverDataList(List list,double cod_std,List stationList)throws Exception{
    	
    	Map data = new HashMap();
    	if(list==null){return stationList;}
    	Map m = null;
    	int i,num=0;
    	String station_id,m_time = null;
    	Timestamp time = null;
    	int dd =0;
    	String key = null;
    	Double dvobj = null;
    	List dataList = new ArrayList();
    	Map m2 = null;
    	int hh = 0;
    	
    	
    	
    	num=list.size();
    	for(i=0;i<num;i++){
    		m=(Map)list.get(i);
    		station_id = (String)m.get("station_id");
    		m_time = (String)m.get("m_time");
    		dvobj=(Double)m.get("codv");
    		if(dvobj==null){continue;}
    		if(f.empty(station_id)||f.empty(m_time)){continue;}
    		time=f.time(m_time,null);
    		if(time==null){continue;}
    		//dd=time.getDate();
    	    hh = time.getHours();
    	    
    	    
    	    
    		
    		if(dvobj.doubleValue()>cod_std){
    			m2 = new HashMap();
    			m2.put("station_id",station_id);
    			m2.put("hh",hh+"");
    			dataList.add(m2);  
    			}
    		
    		
    	}
    	
    	
    	data = f.getListMap(dataList,"station_id");
    	num = stationList.size();
    	
    	int j,hnum=0;
    	String s="";
    	
    	for(i=0;i<num;i++){
    		m=(Map)stationList.get(i);
    		station_id = (String)m.get("station_id");
    		list = (List)data.get(station_id);
    		if(list==null){continue;}
    		m.put("num",list.size()+"");
    		s="";
    		hnum=list.size();
    		for(j=0;j<hnum;j++){
    			m2=(Map)list.get(j);
    			if(j>0){s=s+",";}
    			s=s+m2.get("hh");
    		}
    		m.put("hh",s);
    		
    	}
    	
    	
    	
    	
    	return stationList;
    }
    
    
    
    public String rpt07()throws Exception{
    	String area_id = p("area_id");
    
    	String cod_col = p("cod_col");
		String date1 = p("date1");
		String cod_std = p("cod_std");
		String station_type=p("station_type");
		String dd = p("dd");
		double cod_std_v = f.getDouble(cod_std,0);
		if(cod_std_v<=0){cod_std_v=1000;}
    	
		Map timeMap = SiteReportUtil.getMonthReportTimeInfo(date1);
    	String sql = null;
    	Map m = null;
    	String station_name = null;
    	String start,end = null;
    	List list = null;
    	List stationList = null;
    	Map dataMap,dataMapAll = null;
    	
    	int i,num=0;
    	List list2 = null;
    	int dayNum = StdReportUtil.getMonthDayNum(date1);
    	
    	
        String date2 = getDate(date1,dd);
		
		//start = (String)timeMap.get("start");
		//end = (String)timeMap.get("end");
		start = date2;
		end=date2+" 23:59:59";
		
		
		
		sql = "select station_id,m_time,"+cod_col+" as codv from "+request.getParameter("tableName")+" where  m_time>='"+start+"' ";
		sql=sql+" and m_time<='"+end+"' ";
		sql=sql+" and station_id in(";
		sql=sql+"select station_id from t_cfg_station_info ";
		sql=sql+" where station_type='"+station_type+"' ";
		sql=sql+" and area_id like '"+area_id+"%') ";
		sql = sql+DataAclUtil.getStationIdInString(request,station_type,"station_id");
		
		//sql=sql+" order by station_id,m_time ";
		
		
		list = f.query(sql,null);
	
    	stationList = FyReportUtil.getStationList(station_type,area_id,null,request);
    	
    	
    	//num = list.size();
    	
    	//list = FyReportUtil.decodeDataList(list);
		list = FyReportUtil.decodeDataListNotgz(list);
		FyReportUtil.decodeDataList(list,"codv");
		
		//dataMap = getCodOverDataMap(list,cod_std_v);
		
		list = getCodOverDataList(list,cod_std_v,stationList);
		seta("data",list);
		
		
		
    	return null;
    }
    
    static String getDate(String date1,String dd){
         int pos = 0;
		
		pos = date1.lastIndexOf("-");
		
		String s = date1.substring(0,pos);
		s = s+"-"+dd;
		return s;
    }
    
    
    public String rpt08()throws Exception{
    	String area_id = p("area_id");
    
    	String cod_col = p("cod_col");
		String date1 = p("date1");
		String cod_std = p("cod_std");
		String station_type=p("station_type");
		String station_id=p("station_id");
		
		double cod_std_v = f.getDouble(cod_std,0);
		if(cod_std_v<=0){cod_std_v=1000;}
    	
		Map timeMap = SiteReportUtil.getMonthReportTimeInfo(date1);
    	String sql = null;
    	Map m = null;
    	String station_name = null;
    	String start,end = null;
    	List list = null;
    	List stationList = null;
    	Map dataMap,dataMapAll = null;
    	
    	int i,num=0;
    	List list2 = null;
    	//int dayNum = StdReportUtil.getMonthDayNum(date1);
    	
    	
    
		
		start = (String)timeMap.get("start");
		end = (String)timeMap.get("end");
		
		sql = "select station_desc from t_cfg_station_info where station_id='"+station_id+"'";
		m = f.queryOne(sql,null);
		if(m==null){throw new Exception("站位不存在");}
		station_name = (String)m.get("station_desc");
		
		sql = "select station_id,m_time,"+cod_col+" as codv from "+request.getParameter("tableName")+" where  m_time>='"+start+"' ";
		sql=sql+" and m_time<='"+end+"' ";
		sql=sql+" and station_id='"+station_id+"'";
		
		/*
		sql=sql+" and station_id in(";
		sql=sql+"select station_id from t_cfg_station_info ";
		sql=sql+" where station_type='"+station_type+"' ";
		sql=sql+" and area_id like '"+area_id+"%') ";
		sql = sql+DataAclUtil.getStationIdInString(request,station_type,"station_id");
		*/
		//sql=sql+" order by station_id,m_time ";
		sql=sql+" order by m_time";
		
		
		list = f.query(sql,null);
	
    	//stationList = FyReportUtil.getStationList(station_type,area_id,null,request);
    	
    	
    	//num = list.size();
    	
    	//list = FyReportUtil.decodeDataList(list);
		list = FyReportUtil.decodeDataListNotgz(list);
		FyReportUtil.decodeDataList(list,"codv");
		
		//System.out.println("before getStationCodOverList size="+list.size());
		
		list =  getStationCodOverList(list,cod_std_v);
		//dataMap = getCodOverDataMap(list,cod_std_v);
		
		seta("data",list);
		//seta("dataMap",dataMap);
		//seta("daynum",new Integer(dayNum));
		seta("station_name",station_name);
    	return null;
    }
    
    static List getStationCodOverList(List list,double cod_std)
    throws Exception{
    	List dataList = new ArrayList();
    	Map m1,m2,m3 = null;
    	int i,num=0;
    	String s,m_time = null;
    	Timestamp time = null;
    	Double codvobj = null;
    	int dd,hh = 0;
    	Map dataMap = null;
    	List ddList = null;
    	String key = null;
    	List list1,list2 = null;
    	int j,hhnum=0;
    	list2=new ArrayList();
    	Set ddSet = new HashSet();
    	Map ddMap = new HashMap();
    	Object flag = null;
    	ddList = new ArrayList();
    	num=list.size();
    	
    	//System.out.println("data list,size="+num);
    	
    	
    	for(i=0;i<num;i++){
    		m1=(Map)list.get(i);
    		m_time = (String)m1.get("m_time");
    		time=f.time(m_time,null);
    		if(time==null){continue;}
    		codvobj = (Double)m1.get("codv");
    		if(codvobj==null){continue;}
    		if(codvobj.doubleValue()<=cod_std){continue;}
    		
    		 dd = time.getDate();
    		 hh=time.getHours();
    		 
    		 m2 = new HashMap();
    		 m2.put("dd",dd+"");
    		 m2.put("hh",hh+"");
    		 m2.put("v",codvobj);
    		 //ddSet.add(dd+"");
    		 flag = ddMap.get(dd+"");
    		 if(flag==null){
    			 ddMap.put(dd+"","1");
    			 ddList.add(dd+"");
    		 }
    		 
    		dataList.add(m2);
    		//System.out.println("data list,size="+num);
    	}
    	
    	
    	dataMap = f.getListMap(dataList,"dd");
    	
    	//ddList = f.getMapKey(dataMap);
    	
    	
    	//ddList.addAll(ddSet);
    	num = ddList.size();
    	for(i=0;i<num;i++){
    		key = (String)ddList.get(i);
    		list1 = (List)dataMap.get(key);
    		if(list1==null){continue;}
    		hhnum=list1.size();
    		if(hhnum<1){continue;}
    		
    		m1 = new HashMap();
    		
    		m1.put("dd",key);
    		m1.put("max",max(list1,"v"));
    		m1.put("avg",avg(list1,"v"));
    		
    		for(j=0;j<hhnum;j++){
    			m2=(Map)list1.get(j);
    			key = (String)m2.get("hh");
    			m1.put(key,m2.get("v"));
    		}
    		list2.add(m1);
    		
    		
    	}
    	
    	
    	
    	
    	
    	
    	
    	
    	//return dataList;
    	return list2;
    }
    
    static Double max(List list,String col)throws Exception{
    	   if(list==null){return null;}
    	double v,maxv = 0;
    	    Double vobj = null;
    	    int i,num=0;
    	    int inum=0;
    	    num=list.size();
    	    Map m = null;
    	    for(i=0;i<num;i++){
    	    	m=(Map)list.get(i);
    	    	vobj=(Double)m.get(col);
    	    	if(vobj==null){continue;}
    	    	v = vobj.doubleValue();
    	    	if(v<=maxv){continue;}
    	    	
    	    	maxv=v;
    	    	inum++;
    	    	
    	    }
    	    
    	   return new Double(maxv); 
    	    
    }
    static Double avg(List list,String col)throws Exception{
    	if(list==null){return null;}
    	double v,sumv = 0;
	    Double vobj = null;
	    int i,num=0;
	 
	    num=list.size();
	    Map m = null;
	    for(i=0;i<num;i++){
	    	m=(Map)list.get(i);
	    	vobj=(Double)m.get(col);
	    	if(vobj==null){continue;}
	    	v = vobj.doubleValue();
	    	sumv=sumv+v;
	    	
	    }
	    if(num<1){return null;}
    	double avg = 0;
    	avg=sumv/num;
    	return new Double(avg);
    	
    }
    
}