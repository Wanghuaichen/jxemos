package com.hoson.util;

import com.hoson.*;
import com.hoson.StringUtil;
import com.hoson.f;
import java.sql.*;
import java.util.*;

import javax.servlet.http.*;



public class ZjGrossUtil{
	

	public static Timestamp get_start(){
		

		Timestamp t = f.time();
		int yy = t.getYear();
		java.util.Date d = new java.util.Date(yy,0,1);
		t = new Timestamp(d.getTime());
		
		return t;
	}
	
	
	public static String get_water_q_col(){
		return "val04";
	}
	public static String get_gas_q_col(){
		return "val11";
	}
	
	public static String get_cod_col(){
		return "val02";
	}
	public static String get_so2_col(){
		return "val05";
	}
	public static String get_nox_col(){
		return "val07";
	}
	
	public static String get_water_sql(){
		String sql = "";
		String q = get_water_q_col();
		String cod = get_cod_col();
		
		//sql = "station_id,m_time,"+q+","+cod;
		sql = "station_id,"+q+","+cod;
		sql = "select "+sql+" from t_monitor_real_hour where ";
		sql=sql+"  m_time>=? and m_time<=? ";
		
		//System.out.println("get_water_sql(),"+sql);
		
		return sql;
		
	}
	
	public static String get_gas_sql(){
		String sql = "";
		String q = get_gas_q_col();
		String so2 = get_so2_col();
		String nox = get_nox_col();
		sql = "station_id,"+q+","+so2+","+nox;
		sql = "select "+sql+" from t_monitor_real_hour where ";
		sql=sql+" m_time>=? and m_time<=? ";
		

		
		return sql;
		
	}
	
	public static List getStationIdList(List stationList,int size){
		List list1,list2 = null;
		int i,num=0;
		Map m = null;
		String id = null;
		
		list1 = new ArrayList();
		
		num=stationList.size();
		for(i=0;i<num;i++){
			m = (Map)stationList.get(i);
			id=(String)m.get("station_id");
			if(i%size==0){
				list2=new ArrayList();
				list1.add(list2);
			}
			list2.add(id);
			
		}
		//System.out.println("station id list size="+list1.size());
		return list1;
		
	}
	
	public static String in_str(List list){
		int i,num=0;
		String s="";
		String id = null;
		num=list.size();
		for(i=0;i<num;i++){
			id = (String)list.get(i);
			if(i>0){s=s+",";}
			s=s+"'"+id+"'";
		}
		s=" and station_id in("+s+")";
		
		//System.out.println(s);
		
		return s;
	}
	
	
	public static List getData(List list,String qcol,String cols)throws Exception{
		String[]arr = null;
		int i,num=0;
		int j,colnum=0;
		String col = null;
		Map m,m2 = null;
		Double obj = null;
		String s = null;
		List dataList = new ArrayList();
		double v = 0;
		String station_id = null;
		
		arr=cols.split(",");
		colnum=arr.length;
		
		num=list.size();
		
		//System.out.println("getData,qcol="+qcol+",cols="+cols+",colnum="+colnum+",list size="+num);
		
		
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			station_id = (String)m.get("station_id");
			/*
			System.out.println(station_id);
			if(f.eq(station_id,"3302011001")||f.eq(station_id,"3302252025")){
	    		System.out.println(m);
	    	}
	    	*/
	    	
			
			//System.out.println(m);
			s = (String)m.get(qcol);
			//System.out.println("qcol="+qcol+",v="+s);
			if(f.empty(qcol)){continue;}
			s=f.v(s);
			obj = f.getDoubleObj(s,null);
			if(obj==null){continue;}
			m2 = new HashMap();
			m2.put(qcol,obj);
			
			m2.put("station_id",station_id);
			
			dataList.add(m2);
			
			v = obj.doubleValue();
			
			for(j=0;j<colnum;j++){
				col=arr[j];
				if(f.empty(col)){continue;}
				s=(String)m.get(col);
				if(f.empty(s)){continue;}
				s=f.v(s);
				obj = f.getDoubleObj(s,null);
				if(obj==null){continue;}
				m2.put(col,obj);
				
				v = v*obj.doubleValue();
				//m2.put(col+"_q",new Double(v));
				m2.put(col,new Double(v));
				
				
			}//end for j
			/*
			if(f.eq(station_id,"3302011001")||f.eq(station_id,"3302252025")){
	    		System.out.println(m2);
	    	}
			*/
		}//end for i 
		
		
		
		
		return dataList;
		
		
		
	}
	
	public static Double sum(List list,String col)throws Exception{
		 int i,num=0;
		 Map m = null;
		 Double obj = null;
		 double sum=0;
		 int num2=0;
		 
		 //System.out.println("sum");
		 
		 num=list.size();
		 for(i=0;i<num;i++){
			 m = (Map)list.get(i);
			 obj = (Double)m.get(col);
			 if(obj==null){continue;}
			 sum=sum+obj.doubleValue();
			 num2++;
		 }
		 if(num2<1){return null;}
		 return new Double(sum);
		
	}
	
	public static List getData(List dataList,List stationIdList,String cols)throws Exception{
		    String station_id = null;
		    Map m = null;
		    Map dataMap = null;
		    int i,idnum=0;
		    List stationDataList = null;
		    List list = new ArrayList();
		    int num=0;
		    String[]arr=cols.split(",");
		    int j,colnum=arr.length;
		    String col = null;
		    Double obj = null;
		    
		    //System.out.println("data list size "+dataList.size());
		    //println(dataList);
		    
		    dataMap = f.getListMap(dataList,"station_id");
		    idnum = stationIdList.size();
		    
		    //System.out.println("getData,stationidnum="+idnum+","+idnum+",cols="+cols);
		    
		    for(i=0;i<idnum;i++){
		    	station_id = (String)stationIdList.get(i);
		    	stationDataList = (List)dataMap.get(station_id);
			    //System.out.println(station_id+","+stationDataList);
		    	
		    	if(stationDataList==null){continue;}
		    	/*
		    	if(f.eq(station_id,"3302011001")||f.eq(station_id,"3302252025")){
		    		SxReportUtil.printlist(stationDataList);
		    	}
		    	*/
		    	
		    	num = stationDataList.size();
		    	m = new HashMap();
		    	m.put("station_id",station_id);
		    	m.put("num",new Integer(num));
		    	
		    	for(j=0;j<colnum;j++){
		    		col=arr[j];
		    		if(f.empty(col)){continue;}
		    		obj = sum(stationDataList,col);
		    		m.put(col,obj);
		    	}
		    	/*
		    	if(f.eq(station_id,"3302011001")||f.eq(station_id,"3302252025")){
		    		System.out.println(m);
		    	}
		    	*/
		    	
		    	list.add(m);
		    	
		    }
		    
		    
		    return list;
		
		
	}
	
	public static List getWaterData(Connection cn,Timestamp t1,Timestamp t2,
			List stationIdList)throws Exception{
		List list = new ArrayList();
		int num=0;
		String sql = null;
		num=stationIdList.size();
		//System.out.println("getWaterData stationIdList size"+num);
		
		if(num<1){return list;}
		sql = get_water_sql()+in_str(stationIdList);
		
		//System.out.println("getWaterData sql="+sql);
		
		String qcol = get_water_q_col();
		String cols = get_cod_col();
		
		List dataList = f.query(cn,sql,new Object[]{t1,t2});
		//System.out.println("getWaterData,t1 t2 "+t1+","+t2);
		
		//System.out.println("getWaterData,datalist size "+dataList.size());
		//println2(dataList);
		dataList = getData(dataList,qcol,cols);
		
		//System.out.println("getWaterData,datalist2 size "+dataList.size());
		
		//println2(dataList);
		
		cols=qcol+","+cols;
		list = getData(dataList,stationIdList,cols);
		
		//System.out.println("getWaterData,datalist3 size "+list.size());
		
		return list;
	}
	
	public static List getGasData(Connection cn,Timestamp t1,Timestamp t2,
			List stationIdList)throws Exception{
		//System.out.println("getGasData by stationIdList");
		List list = new ArrayList();
		int num=0;
		String sql = null;
		num=stationIdList.size();
		if(num<1){return list;}
		
		sql = get_gas_sql()+in_str(stationIdList);
		
		//System.out.println("getGasData sql="+sql);
		
		String qcol = get_gas_q_col();
		String cols = get_so2_col()+","+get_nox_col();
		
		List dataList = f.query(cn,sql,new Object[]{t1,t2});
		
		//System.out.println("getGasData dataList size "+dataList.size());
		
		dataList = getData(dataList,qcol,cols);
		//System.out.println("getGasData dataList2 size "+dataList.size());
		cols=qcol+","+cols;
		list = getData(dataList,stationIdList,cols);
		//System.out.println("getGasData dataList3 size "+list.size());
		return list;
	}
	
	public static List getWaterData(Connection cn,Timestamp t1,Timestamp t2,
			List stationList,int groupsize)throws Exception{
		List list = null;
		List list2,list3 = null;
		list2 = new ArrayList();
		int i,num=0;
		List stationIdList = null;
		
		list = getStationIdList(stationList,groupsize);
		
		num = list.size();
		
		for(i=0;i<num;i++){
			stationIdList = (List)list.get(i);
		list3 = getWaterData(cn,t1,t2,stationIdList);
		
		list2.addAll(list3);
		
		}
		
		return list2;
		
	}
	
	public static List getGasData(Connection cn,Timestamp t1,Timestamp t2,
			List stationList,int groupsize)throws Exception{
		List list = null;
		List list2,list3 = null;
		list2 = new ArrayList();
		int i,num=0;
		List stationIdList = null;
		
		
		list = getStationIdList(stationList,groupsize);
		num = list.size();
		for(i=0;i<num;i++){
			stationIdList = (List)list.get(i);
		list3 = getGasData(cn,t1,t2,stationIdList);
		
		list2.addAll(list3);
		}
		
		return list2;
	}
	
	public static List getStationList(Connection cn,String station_type,String area_id,
			HttpServletRequest req)throws Exception{
		String cols = "station_id,station_desc,gross_q,gross_cod,gross_so2,gross_nox";
		List list =SxReportUtil.getStationList(cn,cols,station_type,area_id,null,null,req);
		return list;
	}
	public static List getStationList(String station_type,String area_id,
			HttpServletRequest req)throws Exception{
		Connection cn = null;
		try{
			cn = f.getConn();
			return getStationList(cn,station_type, area_id,req);
		}catch(Exception e){
			throw e;
		}finally{f.close(cn);}
	}
	
	public static List getGrossData(Connection cn,int groupsize)throws Exception{
		//List waterStationList = getStationList(cn,"1",null,req);
		//List gasStationList = getStationList(cn,"2",null,req);
		
		List waterStationList = getStationList(cn,"1");
		List gasStationList = getStationList(cn,"2");
		
		//System.out.println("water="+waterStationList.size()+",gas="+gasStationList.size());
		
		List list1,list2 = null;
		list1 = new ArrayList();
		Timestamp t1 = get_start();
		Timestamp t2 = f.time();
		
		//System.out.println(t1+","+t2);
		
		list2 = getWaterData(cn,t1,t2,waterStationList,groupsize);
		list1.addAll(list2);
		list2 = getGasData(cn,t1,t2,gasStationList,groupsize);
		list1.addAll(list2);
		
		return list1;
	
		
	}
	
	
	
	public static List getGrossData()throws Exception{
		Connection cn = null;
		int groupsize =5;
		try{
		cn = f.getConn();
		return getGrossData(cn,groupsize);
		}catch(Exception e){
			throw e;
		}finally{f.close(cn);}
	
		
	}
	
	public static void makeData(List stationList,List list)throws Exception{
		Map data,m,m2=null;
		int i,num=0;
		String id = null;
		
		data = f.getMap(list,"station_id");
		num=stationList.size();
		for(i=0;i<num;i++){
			m = (Map)stationList.get(i);
			id=(String)m.get("station_id");
			if(f.empty(id)){continue;}
			m2 = (Map)data.get(id);
			if(m2==null){continue;}
			m.putAll(m2);
			
			
		}
		
		
	}
	
	public static void println(List list)throws Exception{
		if(list==null){list=new ArrayList();}
		int i,num=0;
		Map m = null;
		String id = null;
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			id = (String)m.get("station_id");
			if(f.eq(id,"3302011001")||f.eq(id,"3302252025")){
	    		System.out.println(m);
	    	}
			
		}
		
		
	}
	public static void println2(List list)throws Exception{
		if(list==null){list=new ArrayList();}
		int i,num=0;
		Map m = null;
		String id = null;
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			id = (String)m.get("station_id");
			//if(f.eq(id,"3302011001")||f.eq(id,"3302252025")){
	    		System.out.println(m);
	    	//}
			
		}
		
		
	}
	
	public static List getStationList(Connection cn,String station_type)throws Exception{
		String sql = "select station_id from t_cfg_station_info where station_type='"+station_type+"'";
		List list = f.query(cn,sql,null);
		return list;
	}
	public static String css(RowSet rs,String col,String std_col)throws Exception{
		String s1,s2 = null;
		
		s1=rs.get(col);
		s2=rs.get(std_col);
		
		if(f.empty(s1)){return "gross_ok";}
		if(f.empty(s2)){return "gross_ok";}
		
		double v1,v2 = 0;
		
		v1 = f.getDouble(s1,0);
		v2 = f.getDouble(s2,0);
		
		if(v2>0 && v1>v2){return "gross_alert";}
		
		return "gross_ok";
		
		
		
		
	}
}