package com.hoson.app;

import java.sql.*;
import java.io.*;
import java.util.*;

import com.hoson.*;

import javax.servlet.http.*;


public class RealData{
	
	
	static List data = null;
	static long update_time = 0;
	static int read_flag = 0;
	
	
	public static String getSqlMinute(){
		
		String sql = null;

		sql = "select a.* from v_view_real a,"
			  +" (select station_id,max(m_time) as m_time from v_view_real group by station_id) b "
		      +"  where a.station_id=b.station_id and a.m_time=b.m_time order by a.station_id";
		    return sql;
	}
	
	public static String getSqlHour(){
		
		String sql = null;
		
		sql = "select a.* from v_view_hour a,"
			+"(select station_id,max(m_time) as m_time from v_view_hour group by station_id) b "
			+" where a.station_id=b.station_id and a.m_time=b.m_time";

		return sql;
	}

	public static String getPageBar(int num,
			HttpServletRequest req)
	throws Exception{
		
		int page = JspUtil.getInt(req,"page",1);
		int page_size = JspUtil.getInt(req,"page_size",10);
		
		if(page<1){page=1;}
		if(page_size<5){page_size=5;}
		
		int page_num = 0;
		int i =0;
		String s="";
		if(num<1){
			return "<input type=hidden name=page value=1>";
		}
		
		
		
		
		int m = 0;
		String flag = " ";
		int ipage = 0;
		
		m = num%page_size;
		if(m==0){
			page_num=num/page_size;
			
		}else{
			page_num=((num-m)/page_size)+1;
		}
		
		for(i=0;i<page_num;i++){
			ipage=i+1;
			/*
			if(page==ipage){
				flag=" selected";
				}else{
					flag=" ";
				}
			s=s+"<option value="+ipage+flag+">"+ipage+"</option>\n";
			*/
			
			if(page==ipage){
				s=s+"<b>"+ipage+"</b>\n";
			}else{
			
			s=s+"<a href=javascript:go2page("+ipage+")>"+ipage+"</a>\n";
			}
			
		}
		
		//s="<select name=page onchange='f_reload()'>\n"+s+"</select>\n";
		
		//s="共"+num+"条记录 第"+s+"页";
		s="共<b> "+num+" </b>条记录 "+s;
		return s;
	}
	

	public static String getPageBar2(int num,
			HttpServletRequest req)
	throws Exception{
		
		int page = JspUtil.getInt(req,"page",1);
		int page_size = JspUtil.getInt(req,"page_size",10);
		
		if(page<1){page=1;}
		if(page_size<5){page_size=5;}
		
		int page_num = 0;
		int i =0;
		String s="";
		if(num<1){
			return "<input type=hidden name=page value=1>";
		}
		
		
		
		
		int m = 0;
		String flag = " ";
		int ipage = 0;
		
		m = num%page_size;
		if(m==0){
			page_num=num/page_size;
			
		}else{
			page_num=((num-m)/page_size)+1;
		}
		
		for(i=0;i<page_num;i++){
			ipage=i+1;
			/*
			if(page==ipage){
				flag=" selected";
				}else{
					flag=" ";
				}
			s=s+"<option value="+ipage+flag+">"+ipage+"</option>\n";
			*/
			
			if(page==ipage){
				s=s+"<b>"+ipage+"</b>\n";
			}else{
			
			s=s+"<a href=javascript:go2page("+ipage+")>"+ipage+"</a>\n";
			}
			s="";
			if(page>1){
				s=s+"<a href=javascript:go2page(1)>第一页</a>\n";
				s=s+"<a href=javascript:go2page("+(page-1)+")>上一页</a>\n";
				
			}
			
			if(page<page_num){
				
				s=s+"<a href=javascript:go2page("+(page+1)+")>下一页</a>\n";
				s=s+"<a href=javascript:go2page("+page_num+")>最后页</a>\n";
			}
			
			
			
			
			
		}
		
		//s="<select name=page onchange='f_reload()'>\n"+s+"</select>\n";
		
		//s="共"+num+"条记录 第"+s+"页";
		s="共<b> "+num+" </b>条记录 "+s;
		return s;
	}
	
	
	
	public  static List getRealData(long cache)throws Exception{
		if(!isOld(cache)&&data!=null){
			return data;
		}
		if(isOld(cache)&& read_flag>0 && data!=null){
			return data;
		}
		if(isOld(cache)&& read_flag<1){
			return  getRealDataInternal(cache);
		}
		
		while( isOld(cache) && read_flag>0 &&data==null){
			
			Thread.sleep(1000);
			if(read_flag==0){break;}
			
		}
		
		return  getRealDataInternal(cache);
		
	
		
	}
	
	public synchronized static List getRealDataInternal(long cache)throws Exception{
		
		
		
		
		
		
		String sql = null;
		Connection cn = null;
		List list = null;
		
		try{
			
			if(!isOld(cache)&&data!=null){
				return data;
			}
		read_flag=1;
		
		sql="select  station_id,infectant_id,m_value,m_time from v_view_real ";
		sql=sql+"where (station_id,infectant_id,m_time) in ";
		sql=sql+"(select station_id,infectant_id,max(m_time) as  m_time from v_view_real ";
		sql=sql+"group by station_id,infectant_id)";
		
		cn = DBUtil.getConn();
		list = DBUtil.query(cn,sql);
		data = list;
		update_time = getTime();
		return list;
		}catch(Exception e){
			throw e;
		}finally{
			read_flag=0;
			DBUtil.close(cn);
		}
	}
	
	public static Map getDataMap(List list)throws Exception{
		
		Map map = new HashMap();
		Map value = new HashMap();
		Map hasData = new HashMap();
		map.put("value",value);
		map.put("hasData",hasData);
		if(list==null){return map;}
		int i =0;
		int num = 0;
		Map tmp = null;
		String station_id = null;
		String infectant_id = null;
		String m_value = null;
		String m_time = null;
		String key = null;
		String v = null;
		
		num = list.size();
		for(i=0;i<num;i++){
			
			tmp = (Map)list.get(i);
			
			station_id =(String)tmp.get("station_id");
			infectant_id =(String)tmp.get("infectant_id");
			m_value =(String)tmp.get("m_value");
			m_time =(String)tmp.get("m_time");
			if(StringUtil.isempty(station_id)){continue;}
			if(StringUtil.isempty(infectant_id)){continue;}
			key=station_id+infectant_id;
			value.put(key,m_value+";"+m_time);
			
			hasData.put(station_id,"0");
			
		}
		return map;
		
	}
	static long getTime(){
		return System.currentTimeMillis();
	}
	
	static boolean isOld(long cache){
		
		if(cache<1000){cache=1000;}
		
		long now = getTime();
		long diff = now-update_time;
		if(diff<0){diff=0-diff;}
		if(cache>diff){
			return false;
			}else{
				return true;
			}
		
	}
	
	
	public static List getRealDataList(Connection cn)throws Exception{
		
		List list = null;
		List list2 = null;
		Map map = null;
		Map m = null;
		String sql = null;
		String station_id = null;
		String infectant_id = null;
		String m_time = null;
		String m_value;
		
		//String m_time0 = null;
		String station_id0 = null;
		
		int i =0;
		int num =0;
		
		sql = getSqlMinute();
		
		list = DBUtil.query(cn,sql,null);
		num = list.size();
		list2 = new ArrayList();
		for(i=0;i<num;i++){
			map = (Map)list.get(i);
			station_id = (String)map.get("station_id");
			m_time = (String)map.get("m_time");
			infectant_id = (String)map.get("infectant_id");
			m_value = (String)map.get("m_value");
			
			if(!StringUtil.equals(station_id,station_id0)){
				m = new HashMap();
				m.put("station_id",station_id);
				m.put("m_time",m_time);
				station_id0=station_id;
				list2.add(m);
			}
			m.put(infectant_id,m_value);
			//m.put("m_value",m_value);
		}
		
		return list2;
	}
	
	public static List getRealDataList()throws Exception{
		Connection cn = null;
		try{
		cn = DBUtil.getConn();
		return getRealDataList(cn);
		}catch(Exception e){
			throw e;
		}finally{DBUtil.close(cn);}
	}
	
	
	public static Map getRealDataTable(Connection cn,List stationIdList,
		Map stationInfoMap	,String station_type,List realDataList
	)throws Exception{
		
		List infectantList = null;
		String sql = null;
		List infectantIdList = null;
		List titleList = null;
		
		int i =0;
		int num =0;
		Map map = null;
		String titles="";
		int stationNum = 0;
		int realDataRowNum = 0;
		int infectantIdNum =0;
		int j =0;
		String station_id = null;
		String station_name = null;
		String infectant_id = null;
		String v = null;
		int seq = 0;
		String data = "";
		String m_time = null;
		/*
		sql = "select infectant_id,infectant_name,infectant_unit "
		    +" from t_cfg_infectant_base where station_type='"+station_type+"'";
		
		    infectantList = DBUtil.query(cn,sql,null);
		    num = infectantList.size();
		    //System.out.println(num);
		    for(i=0;i<num;i++){
		    	map = (Map)infectantList.get(i);
		    	infectantIdList.add(map.get("infectant_id"));
		    	titles = titles+"<td>"+map.get("infectant_name")+" "
		    	+ map.get("infectant_unit")+"</td>\n";
		    	
		    	
		    }
		    */
		
		map = AppPage.getInfectantIdAndTitle(cn,station_type);
		      titleList=(List)map.get("title");
		      infectantIdList = (List)map.get("id");
		      
		      num =  titleList.size();
		      
		      for(i=0;i<num;i++){
		    	  titles=titles+"<td>"+titleList.get(i)+"</td>\n";
		      }
		      
		    
		    realDataRowNum = realDataList.size();
		    infectantIdNum = infectantIdList.size();
		    if(infectantIdNum<1){
		    	throw new Exception("请为指定的监测类型配置监测指标,station_type="+station_type);
		    	
		    }
		   //System.out.println("data row="+realDataRowNum);
		   //System.out.println(stationInfoMap);
		    for(i=0;i<realDataRowNum;i++){
		    	
		    map = (Map)realDataList.get(i);
		    station_id=(String)map.get("station_id");
		    station_name=(String)stationInfoMap.get(station_id);
		    
		    if(StringUtil.isempty(station_name)){continue;}
		    	
		    	seq ++;
		    	m_time = (String)map.get("m_time");
		    	m_time = getRealTime(m_time);
		    	data = data+"<tr class=tr"+(seq%2)+">\n"
		    	+ "<td>"+seq+"</td>\n"
		    	+ "<td>" + station_name+"</td>\n"
		    	+ "<td>" + m_time+"</td>\n";
		    	
		    	 for(j=0;j<infectantIdNum;j++){
		    		 
		    		 infectant_id=(String)infectantIdList.get(i);
		    		 v = (String)map.get(infectant_id);
		    		 if(v==null){v="";}
		    		 data=data+"<td>"+v+"</td>\n";
		    		 
		    		 
		    	 }//end for j
		    	
		    	
		    	data=data+"</tr>\n";
		    	
		    	
		    }//end for i
		    
		    
		    Map result = new HashMap();
		    result.put("title",titles);
		    result.put("data",data);
		    return result;
		
		//return null;
	}
	
	
	public static Map getRealDataTable(HttpServletRequest req
		)throws Exception{
		
		String station_ids = null;
		String station_names = null;
		Map model = null;
		Map map = new HashMap();
		List list = new ArrayList();
		String station_type = null;
		Connection cn = null;
		
		model = JspUtil.getRequestModel(req);
		station_type = (String)model.get("station_type");
		if(StringUtil.isempty(station_type)){
			throw new Exception("请选择监测类型");
		}
		
		station_ids = (String)model.get("station_ids");
		station_names = (String)model.get("station_names");
		
		if(StringUtil.isempty(station_ids)){
			throw new Exception("请选择站位");
		}
		
		String[]arrId = station_ids.split(",");
		String[]arrName = station_names.split(",");
		int i =0;
		int num =0;
		num = arrId.length;
		
		if(arrName.length!=num){
			throw new Exception("编号与名称不匹配");
		}
		
		for(i=0;i<num;i++){
			list.add(arrId[i]);
			map.put(arrId[i],arrName[i]);
			
		}
		
		
		List realDataList = null;
		
		try{
		cn = DBUtil.getConn();
		
		realDataList = getRealDataList(cn);
		
		return getRealDataTable(cn,list,map	,station_type,realDataList);
		}catch(Exception e){
			throw e;
		}finally{
			DBUtil.close(cn);
		}
		
	}
	
	
	public static Map getHourRealDataTable(Connection cn,List stationIdList,
			Map stationInfoMap	,String station_type,List realDataList
		)throws Exception{
			
			List infectantList = null;
			String sql = null;
			List infectantIdList = null;
			List titleList = null;
			
			int i =0;
			int num =0;
			Map map = null;
			String titles="";
			int stationNum = 0;
			int realDataRowNum = 0;
			int infectantIdNum =0;
			int j =0;
			String station_id = null;
			String station_name = null;
			String infectant_id = null;
			String v = null;
			int seq = 0;
			String data = "";
			String m_time = null;
			/*
			sql = "select infectant_id,infectant_name,infectant_unit "
			    +" from t_cfg_infectant_base where station_type='"+station_type+"'";
			
			    infectantList = DBUtil.query(cn,sql,null);
			    num = infectantList.size();
			    //System.out.println(num);
			    for(i=0;i<num;i++){
			    	map = (Map)infectantList.get(i);
			    	infectantIdList.add(map.get("infectant_id"));
			    	titles = titles+"<td>"+map.get("infectant_name")+" "
			    	+ map.get("infectant_unit")+"</td>\n";
			    	
			    	
			    }
			    */
			
			map = AppPage.getInfectantIdAndTitle(cn,station_type);
			      titleList=(List)map.get("title");
			      //infectantIdList = (List)map.get("id");
			      infectantIdList = (List)map.get("column");
			      num =  titleList.size();
			      
			      for(i=0;i<num;i++){
			    	  titles=titles+"<td>"+titleList.get(i)+"</td>\n";
			      }
			      
			    
			    realDataRowNum = realDataList.size();
			    infectantIdNum = infectantIdList.size();
			    if(infectantIdNum<1){
			    	throw new Exception("请为指定的监测类型配置监测指标,station_type="+station_type);
			    	
			    }
			   //System.out.println("data row="+realDataRowNum);
			   //System.out.println(stationInfoMap);
			    for(i=0;i<realDataRowNum;i++){
			    	
			    map = (Map)realDataList.get(i);
			    station_id=(String)map.get("station_id");
			    station_name=(String)stationInfoMap.get(station_id);
			    
			    if(StringUtil.isempty(station_name)){continue;}
			    	
			    	seq ++;
			    	m_time = (String)map.get("m_time");
			    	m_time = getHourRealTime(m_time);
			    	data = data+"<tr class=tr"+(seq%2)+">\n"
			    	+ "<td>"+seq+"</td>\n"
			    	+ "<td>" + station_name+"</td>\n"
			    	+ "<td>" + m_time+"</td>\n";
			    	
			    	 for(j=0;j<infectantIdNum;j++){
			    		 
			    		 infectant_id=(String)infectantIdList.get(i);
			    		 v = (String)map.get(infectant_id);
			    		 if(v==null){v="";}
			    		 data=data+"<td>"+v+"</td>\n";
			    		 
			    		 
			    	 }//end for j
			    	
			    	
			    	data=data+"</tr>\n";
			    	
			    	
			    }//end for i
			    
			    
			    Map result = new HashMap();
			    result.put("title",titles);
			    result.put("data",data);
			    return result;
			
			//return null;
		}
		
		
		public static Map getHourRealDataTable(HttpServletRequest req
			)throws Exception{
			
			String station_ids = null;
			String station_names = null;
			Map model = null;
			Map map = new HashMap();
			List list = new ArrayList();
			String station_type = null;
			Connection cn = null;
			
			model = JspUtil.getRequestModel(req);
			station_type = (String)model.get("station_type");
			if(StringUtil.isempty(station_type)){
				throw new Exception("请选择监测类型");
			}
			
			station_ids = (String)model.get("station_ids");
			station_names = (String)model.get("station_names");
			
			if(StringUtil.isempty(station_ids)){
				throw new Exception("请选择站位");
			}
			
			String[]arrId = station_ids.split(",");
			String[]arrName = station_names.split(",");
			int i =0;
			int num =0;
			num = arrId.length;
			
			if(arrName.length!=num){
				throw new Exception("编号与名称不匹配");
			}
			
			for(i=0;i<num;i++){
				list.add(arrId[i]);
				map.put(arrId[i],arrName[i]);
				
			}
			
			
			List realDataList = null;
			
			try{
			cn = DBUtil.getConn();
			
			realDataList = getRealDataList(cn);
			
			return getRealDataTable(cn,list,map	,station_type,realDataList);
			}catch(Exception e){
				throw e;
			}finally{
				DBUtil.close(cn);
			}
			
		}
		
	static String getRealTime(String s){
		
		if(s==null){return "";}
		int start = 0;
		int end = 0;
		start =s.indexOf(" ");
		end = s.indexOf(".");
		
		if(end>start && start>0){
			return s.substring(start,end);
		}else{
			return s;
		}
		
		
	}
	
	static String getHourRealTime(String s){
		
		if(s==null){return "";}
		int start = 0;
		int end = 0;
		//start =s.indexOf(" ");
		end = s.indexOf(".");
		
		if(end>0){
			return s.substring(0,end);
		}else{
			return s;
		}
	}
	
}