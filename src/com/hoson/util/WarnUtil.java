package com.hoson.util;

import com.hoson.*;

import java.sql.*;
import java.util.*;

import com.hoson.app.*;

import javax.servlet.http.*;
import com.hoson.ErrorMsg;




public class WarnUtil{
	
	private static String msg = null;
	private static String msg2 = "";
	
	public static String getMsg(){
		return msg;
	}
	
	public static String getCols(Connection cn)throws Exception{
		String cols="station_id,m_time";
		String sql = "select distinct infectant_column  from t_cfg_infectant_base where infectant_type in ('1','2') order by infectant_column";
		List list = null;
		int i,num=0;
		Map m = null;
		String col = null;
		
		list = f.query(sql,null);
		num = list.size();
		if(num<1){ErrorMsg.infectant_id_empty();}
		for(i=0;i<num;i++){
			m=(Map)list.get(i);
			col=(String)m.get("infectant_column");
			if(f.empty(col)){continue;}
			
			cols=cols+","+col;
			
		}
		
		cols=cols.toLowerCase();
		return cols;
		
	}
	
	public static List getInfectantList(Connection cn)throws Exception{
		List list = null;
		String sql = "select station_id,infectant_id,infectant_column,lolo,hihi from t_cfg_monitor_param";
		
		sql = "select a.infectant_id,a.infectant_name,a.infectant_unit,a.infectant_column,";
		sql=sql+"b.station_id,b.lolo,b.hihi ";
		sql=sql+" from t_cfg_infectant_base a,t_cfg_monitor_param b ";
		sql=sql+" where a.infectant_id=b.infectant_id";
		
		Map m = null;
		int i,num=0;
		String s = null;
		double dv = 0;
		Double dvobj = null;
		
		List list2 = new ArrayList();
		list = f.query(cn,sql,null);
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			s = (String)m.get("lolo");
			dvobj=f.getDoubleObj(s,null);
			if(dvobj!=null){
				dv=dvobj.doubleValue();
				if(dv==0){dvobj=null;}
			}
			m.put("lolo",dvobj);
			
			
			s = (String)m.get("hihi");
			dvobj=f.getDoubleObj(s,null);
			if(dvobj!=null){
				dv=dvobj.doubleValue();
				if(dv==0){dvobj=null;}
			}
			m.put("hihi",dvobj);
			
			s = (String)m.get("infectant_column");
			if(f.empty(s)){continue;}
			s=s.toLowerCase();
			m.put("col",s);
			
			list2.add(m);
			
			
		}
		
		
		
		return list2;
	}
	
	 public  static List getInfectantList(Connection cn,String station_id)throws Exception{
	    	List list = null;
	    	String sql = null;
	    	Map m = null;
	    	int i,num=0;
	    	String v = null;
	    	double dv = 0;
	    	Double dvobj = null;
	    	List list2 = new ArrayList();
	    	
	    	
	    	sql = "select a.infectant_name,a.infectant_unit,b.* from t_cfg_infectant_base a,t_cfg_monitor_param b ";
	    	sql=sql+" where a.infectant_id=b.infectant_id ";
	    	sql=sql+" and b.station_id='"+station_id+"'";
	    	sql=sql+" order by a.infectant_order ";
	    	
	    	list = f.query(cn,sql,null);
	    	num = list.size();
	    	for(i=0;i<num;i++){
	    		m = (Map)list.get(i);
	    		v = (String)m.get("infectant_column");
	    		if(f.empty(v)){continue;}
	    		v = v.toLowerCase();
	    		m.put("infectant_column",v);
	    		
	    		v = (String)m.get("lolo");
	    		dvobj = f.getDoubleObj(v,dvobj);
	    		if(dvobj!=null){
	    			dv = dvobj.doubleValue();
	    			//if(dv==0){dvobj = null;}//黄宝注释
	    		}
	    		m.put("lolo",dvobj);
	    		
	    		
	    		v = (String)m.get("hihi");
	    		dvobj = f.getDoubleObj(v,dvobj);
	    		if(dvobj!=null){
	    			dv = dvobj.doubleValue();
	    			//if(dv==0){dvobj = null;}//黄宝注释
	    		}
	    		m.put("hihi",dvobj);
	    		list2.add(m);
	    		//System.out.println(m);
	    	}
	    	
	    	
	    	return list2;
	    }
	   
	  
	
	public static Map getDataMap(Connection cn,String date1,String date2)
	throws Exception{
		Map data = null;
		List list = null;
		String sql = "select "+getCols(cn)+" from t_monitor_real_hour ";
		sql=sql+" where m_time>='"+date1+"' ";
		sql=sql+" and m_time<='"+date2+"'";
		
		data = f.getListMap(list,"station_id");
		
		
		return data;
		
	}
	
	public static Map getDataMap(Connection cn)
	throws Exception{
		Map data = null;
		List list = null;
		String now = StringUtil.getNowDate()+"";
		String sql = "select "+getCols(cn)+" from t_monitor_real_hour ";
		sql=sql+" where m_time>='"+now+"' ";
		sql=sql+" and m_time<='"+now+" 23:59:59'";
		//f.sop(sql);
		//list = f.query(cn,sql,null);
		
		msg2 = "";
		msg2 = msg2+","+f.time()+"";
		list = f.query(cn,sql,null);
		msg2 = msg2+","+f.time()+"";
		
		msg2 = msg2+",hour data size="+list.size();
		msg2 = msg2+","+sql;
		msg=msg2;
		
		data = f.getListMap(list,"station_id");
		
		
		return data;
		
	}
	
	//根据开始时间和结束时间查询报警数据
	public static Map getDataMap2(Connection cn,String date1 ,String date2)
	throws Exception{
		Map data = null;
		List list = null;
		String now = StringUtil.getNowDate()+"";
		String sql = "select "+getCols(cn)+" from t_monitor_real_hour ";
		sql=sql+" where m_time>='"+date1+"' ";
		sql=sql+" and m_time<='"+date2+" 23:59:59'";
		//f.sop(sql);
		//list = f.query(cn,sql,null);
		
		msg2 = "";
		msg2 = msg2+","+f.time()+"";
		list = f.query(cn,sql,null);
		msg2 = msg2+","+f.time()+"";
		
		msg2 = msg2+",hour data size="+list.size();
		msg2 = msg2+","+sql;
		msg=msg2;
		
		data = f.getListMap(list,"station_id");
		
		
		return data;
		
	}
	
	public static Map getWarnNumData()throws Exception{
		Map m = new HashMap();
		Map data = null;
		Connection cn = null;
		List infectantList =  null;
		int i,num=0;
		List stationIdList = null;
		String station_id = null;
		List list = null;
		Map row = null;
		Map infectantListMap = null;
		List stationInfectantList = null;
		try{
		cn = f.getConn();
		data = getDataMap(cn);//时均值数据t_monitor_real_hour
		infectantList = getInfectantList(cn);//查询出监测站所包含的监测因子
		f.close(cn);
		stationIdList = f.getMapKey(data);
		infectantListMap = f.getListMap(infectantList,"station_id");
		
		
		num = stationIdList.size();
		for(i=0;i<num;i++){
			station_id = (String)stationIdList.get(i);
			list = (List)data.get(station_id);
			if(list==null){continue;}
			stationInfectantList = (List)infectantListMap.get(station_id);
			if(stationInfectantList==null){
				stationInfectantList=new ArrayList();
				}
			
			//row = getWarnNumDataRow(station_id,list,infectantList);
			row = getWarnNumDataRow(station_id,list,stationInfectantList);
			m.put(station_id,row);
			
		}
		
		
		
		return m;
		}catch(Exception e){
			throw e;
		}finally{f.close(cn);}
		
	}
	
	//根据开始时间和结束时间查询报警数据
	public static Map getWarnNumData(String date1 , String date2)throws Exception{
		Map m = new HashMap();
		Map data = null;
		Connection cn = null;
		List infectantList =  null;
		int i,num=0;
		List stationIdList = null;
		String station_id = null;
		List list = null;
		Map row = null;
		Map infectantListMap = null;
		List stationInfectantList = null;
		try{
		cn = f.getConn();
		data = getDataMap2(cn,date1,date2);//时均值数据t_monitor_real_hour
		infectantList = getInfectantList(cn);//查询出监测站所包含的监测因子
		f.close(cn);
		stationIdList = f.getMapKey(data);
		infectantListMap = f.getListMap(infectantList,"station_id");
		
		
		num = stationIdList.size();
		for(i=0;i<num;i++){
			station_id = (String)stationIdList.get(i);
			list = (List)data.get(station_id);
			if(list==null){continue;}
			stationInfectantList = (List)infectantListMap.get(station_id);
			if(stationInfectantList==null){
				stationInfectantList=new ArrayList();
				}
			
			//row = getWarnNumDataRow(station_id,list,infectantList);
			row = getWarnNumDataRow(station_id,list,stationInfectantList);
			m.put(station_id,row);
			
		}
		
		
		
		return m;
		}catch(Exception e){
			throw e;
		}finally{f.close(cn);}
		
	}
	
	
	public static Map getWarnNumDataRow(String station_id,List list,
			List infectantList)throws Exception{
		Map data = new HashMap();
		int i,num=0;
		String col = null;
		Map m = null;
		int warnnum = 0;
		int totalnum = 0;
		
		num = infectantList.size();
		
		for(i=0;i<num;i++){
			m = (Map)infectantList.get(i);
			col = (String)m.get("col");
			if(f.empty(col)){continue;}
			
			warnnum = getWarnNum(list,m);
			totalnum = totalnum+warnnum;
			/*
			if(f.eq(station_id,"3301015003")){
				System.out.println(warnnum+","+col);
				}
				*/
			data.put(col,warnnum+"");
		}
		data.put("total",totalnum+"");
		data.put("station_id",station_id);
		//System.out.println(data);
		/*
		if(f.eq(station_id,"3301015003")){
			System.out.println(data);
			}
		*/
		return data;		
	}
	
	public static int getWarnNum(List list,Map infectant)throws Exception{
		int warnnum=0;
		int i,num=0;
		Map m = null;
	
		String v,col = null;
		
		col = (String)infectant.get("col");
		
		num = list.size();
		
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			v = (String)m.get(col);
			v=f.v(v);
			if(iswarn(v,infectant)){warnnum++;}
			
		}
		
		
		
		return warnnum;		
	}
	
	
	   public static boolean iswarn(String s,Map m){
	    	if(f.empty(s)){return false;}
	    	boolean b = false;
	    	Double obj = null;
	    	Double lo,hi = null;
	    	double lov,hiv,v = 0;
	    	
	    	obj = f.getDoubleObj(s,null);
	    	if(obj==null){return false;}
	    	
	    	v = obj.doubleValue();
	    	
	    	
	    	
	    	lo = (Double)m.get("lolo");
	    	hi = (Double)m.get("hihi");
	    	
	    	
	    	
	    	if(lo!=null){
	    		lov = lo.doubleValue();
	    		if(v>0 && v<lov){b=true;}
	    	}
	    	
	    	if(hi!=null){
	    		hiv = hi.doubleValue();
	    		if(v>0 && v>hiv){b=true;}
	    	}//黄宝修改
	    	
	    	/*//黄宝添加
	    	if(lo !=null && hi !=null){
	    		lov = lo.doubleValue();
	    		hiv = hi.doubleValue();
	    		
	    		if(lov == 0.0 && hiv == 0.0){return false;}
	    		
	    		if(v>0 && v<lov){b=true;}
	    		if(v>0 && v>hiv){b=true;}
	    	}*/
	    	
	    	
	    	//System.out.println(v+","+lo+","+hi+","+b+","+m);
	    	return b;
	    }
	   
	   public static boolean iswarnview(String s,Map m){
	    	if(f.empty(s)){return false;}
	    	boolean b = false;
	    	Double obj = null;
	    	Double lo,hi = null;
	    	double lov,hiv,v = 0;
	    	if(s !=null && !"".equals(s)){
	    		s = s.split(";")[0];
	    	}
	    	obj = f.getDoubleObj(s,null);
	    	if(obj==null){
	    		return false;
	    	}
	    	
	    	v = obj.doubleValue();
	    	
	    	
	    	
	    	lo = (Double)m.get("lolo");
	    	hi = (Double)m.get("hihi");
	    	
	    	
	    	
	    	/*if(lo!=null){
	    		lov = lo.doubleValue();
	    		if(v>0 && v<lov){b=true;}
	    	}
	    	
	    	if(hi!=null){
	    		hiv = hi.doubleValue();
	    		if(v>0 && v>hiv){b=true;}
	    	}*///黄宝修改
	    	
	    	//黄宝添加
	    	if(lo !=null && hi !=null){
	    		lov = lo.doubleValue();
	    		hiv = hi.doubleValue();
	    		
	    		if(lov == 0.0 && hiv == 0.0){return false;}
	    		
	    		if(v>0 && v<lov){b=true;}
	    		if(v>0 && v>hiv){b=true;}
	    	}
	    	
	    	
	    	//System.out.println(v+","+lo+","+hi+","+b+","+m);
	    	return b;
	    }
	   
	   public static List getWarnDataList(List list,List infectantList){
	    	List list2 = new ArrayList();
	    	int i,num=0;
	    	int j,fnum=0;
	    	Map m1,m2,m3 = null;
	    	String col = null;
	    	String v = null;
	    	String t = null;
	    	int warnnum = 0;
	    	boolean b = false;
	    	num = list.size();
	    	fnum = infectantList.size();
	    	for(i=0;i<num;i++){
	    		
	    		warnnum=0;
	    		m3 = new HashMap();
	    		
	    		
	    		m1 = (Map)list.get(i);
	    		
	    		m3.put("station_id",m1.get("station_id"));
	    		m3.put("m_time",m1.get("m_time"));
	    		//System.out.println(m1);
	    		
	    		for(j=0;j<fnum;j++){
	    			m2 = (Map)infectantList.get(j);
	    			//System.out.println(m2);
	    			col = (String)m2.get("infectant_column");
	    			if(f.empty(col)){continue;}
	    			
	    			//下面的都是原始的
	    			/*v = (String)m1.get(col);	    			
	    			v = f.v(v);
	    			b = iswarn(v,m2);
	    			if(b){
	    				m3.put(col,v);
	    				warnnum++;
	    			}*/
	    			//下面的是重新修改的
	    			v = (String)m1.get(col);
	    			t = v;//多加了个变量
	    			v = f.v(v);
	    			b = iswarnview(v,m2);
	    		
	    			if(b){
	    				m3.put(col,t);
	    				warnnum++;
	    			}
	    			
	    			
	    		}//end for j
	    		//System.out.println(warnnum+","+m3);
	    		if(warnnum>0){list2.add(m3);}
	    	}//end for i
	    	
	    	
	    	
	    	
	    	return list2;
	    	
	    }
	   public static Map getWarnDataRow(Map data,List stationInfectantList){
		   Map row = new HashMap();
		   int warnnum = 0;
	       boolean b = false;
	       int i,num=0;
	       Map m = null;
	       String col,v = null;
	       String station_id = null;
	       
	       station_id = (String)data.get("station_id");
	       
	       num = stationInfectantList.size();
	       
	       for(i=0;i<num;i++){
	    	   m = (Map)stationInfectantList.get(i);
	    	  // col = (String)m.get("infectant_column");
	    	   col = (String)m.get("col");
   			if(f.empty(col)){continue;}
   			v = (String)data.get(col);
   			
   			//System.out.println(col+","+v);
   			
   			v = f.v(v);
   			/*
   			if(f.eq(station_id,"3301015003")){
   				f.debug(col+","+v+","+m );
   			}
   			*/
   			
   			b = iswarn(v,m);
   			if(b){
   				row.put(col,v);
   				warnnum++;
   			}
	    	   
	       }
	       
	       if(warnnum<1){return null;}
		   row.put("station_id",data.get("station_id"));
		   row.put("m_time",data.get("m_time"));
		   return row;
		   
	   }
	    
	
}