package com.hoson.util;

import java.util.*;
import java.sql.*;
import com.hoson.app.*;
import javax.servlet.http.*;
import java.lang.String;

import com.hoson.StringUtil;
import com.hoson.f;

public class AreaInfo{
	
	/*!
	 * ����map��listֵ��ü��������ѻ�������������������¼����ʵʱ��������ʱ��ֵ��¼����������map���Ϸ���
	 */
	public static Map getAreaInfo(Map map,List list)
	throws Exception{
		int i,num=0;
		int warnNum,hourNum,minuteNum =0;
		int warnCount=0;
		int hourCount=0;
		int minuteCount=0;
		int onNum=0;
		int offNum =0;
		
		Map warn,minute,hour=null;
		String id = null;
		Map m =new HashMap();
		
		
		warn = (Map)map.get("warn");
		minute = (Map)map.get("minute");
		hour = (Map)map.get("hour");
		
		num = list.size();
		
		for(i=0;i<num;i++){
			id=(String)list.get(i);
			if(StringUtil.isempty(id)){continue;}
			
			warnNum = StringUtil.getInt(warn.get(id)+"",0);
			minuteNum = StringUtil.getInt(minute.get(id)+"",0);
			hourNum = StringUtil.getInt(hour.get(id)+"",0);
			
			if(warnNum>0 || minuteNum>0 || hourNum>0){
				onNum++;
			}else{
				offNum++;
			}
			warnCount = warnCount+warnNum;
			hourCount = hourCount+hourNum;
			minuteCount = minuteCount+minuteNum;
		}
		
		/*
		s = s + "������ " + num + "<br>\n"
		+ "�ѻ��� " + offNum + "<br>\n"
		+ "������ " + onNum + "<br>\n"
		+ "������¼�� " + warnCount + "<br>\n"
		+ "ʵʱ��¼�� " + minuteCount + "<br>\n"
		+ "ʱ��ֵ��¼�� " + hourCount + "<br>\n"
		;
		return s;
		*/
		m.put("station",num+"");
		m.put("off",offNum+"");
		m.put("on",onNum+"");
		
		m.put("minute",minuteCount+"");
		m.put("hour",hourCount+"");
		m.put("warn",warnCount+"");
		return m;
		
	}
	
	/*!
	 * ����map��stationIdMap���ϣ�վλ���ͣ�������Ų�ѯ������Ϣ������map����
	 */
	public static Map getAreaInfo(Map map,Map stationIdMap,String station_type,String area_id)
	throws Exception{
		    List list = null;
		    String key = station_type+"_"+area_id;
		    list = (List)stationIdMap.get(key);
		    if(list==null){list=new ArrayList();}
		    return getAreaInfo(map,list);
	}
	/*!
	 * ����map��stationIdMap���ϣ�վλ���ͣ������б��ѯ������Ϣ������map����
	 */
	public static Map getAreaInfo(Map map,Map stationIdMap,String station_type,List areaList)
	throws Exception{
		   int i,num=0;
		   num=areaList.size();
		   String area_id,key;
		   Map m = null;
		   Map data = new HashMap();
		   
		   
		   for(i=0;i<num;i++){
			   m = (Map)areaList.get(i);
			   area_id = (String)m.get("area_id");
			   m = getAreaInfo(map,stationIdMap,station_type,area_id);
			   key = station_type+"_"+area_id;
			   data.put(key,m);
		   }
		    return data;
	}
	/*!
	 * ����map��stationIdMap���ϣ�վλ���ͣ������б��ѯ������Ϣ������map����
	 */
	public static Map getAreaInfos(Map map,Map stationIdMap,String station_types,List areaList)
	throws Exception{
		  String[]arr=station_types.split(",");
		  int i,num=0;
		  num=arr.length;
		  String station_type = null;
		  Map m=null;
		  Map data = new HashMap();
		  for(i=0;i<num;i++){
			  station_type = arr[i];
		  m = getAreaInfo(map,stationIdMap,station_type,areaList);
		  data.putAll(m);
		  }
		  
		return data;
		
	}
	/*!
	 * ����map��ѯ������Ϣ������map����
	 */
	public static Map getAreaInfos(Map map)
	throws Exception{
		String station_types="1,2,3,4,5,6";
		String area_id = f.getTopAreaId();
		String sql = "select area_id,area_name from t_cfg_area where area_pid='"+area_id+"'";
		List areaList = f.query(sql,null);
		Map stationIdMap = getStationIdMap();
		return getAreaInfos(map,stationIdMap,station_types,areaList);
	}
	/*!
	 * ���վλ��Ϣ
	 */
	public static Map getStationIdMap()throws Exception{
		String sql = "select station_id,station_type,area_id from t_cfg_station_info";
		int i,num=0;
		List stationList = null;
		Map m = null;
		Map map = new HashMap();
		String top_area_id = f.getTopAreaId();
		List areaList = getAreaList(top_area_id);
		String area_id = null;
		
		stationList = f.query(sql,null);
		
		num = areaList.size();
		
		for(i=0;i<num;i++){
			m=(Map)areaList.get(i);
			area_id=(String)m.get("area_id");
			getAreaStationIdMap(map,stationList,area_id);
		}
		return map;
	}
	/*!
	 * ����requestֵ��ȡ������Ϣ������request��
	 */
	public static void area_info(HttpServletRequest req)throws Exception{
		String station_type = f.p(req,"station_type");
		if(f.empty(station_type)){
			station_type = f.getDefaultStationType();
		}
		String area_id = f.getTopAreaId();
		List areaList = null;
		String sql = null;
		Map areaInfoMap = (Map)CacheUtil.getAreaInfoDataMap();
		Map m = null;
		List list = null;
		
		sql = "select area_id,area_name from t_cfg_area where area_pid='"+area_id+"' order by area_id";
		areaList = f.query(sql,null);
		
		m = (Map)areaInfoMap.get("all");
		
		list = getAreaInfoList(m,areaList,station_type);
		req.setAttribute("list",list);
	}
	/*!
	 * ����request�������е�������Ϣ������request��
	 */
	public static void area_info_all(HttpServletRequest req)throws Exception{
		
		String area_id = f.getTopAreaId();
		List areaList = null;
		String sql = null;
		
		areaList = getAreaList(area_id);
		getAllAreaInfoList(req,areaList);
		Map m = getStationTypeMap();
		req.setAttribute("map",m);
		
	}
	/*!
	 * ����map��areaList���ϣ�վλ����station_type����ѯ������Ϣ������list����
	 */
	public static List getAreaInfoList(Map map,List areaList,String station_type)throws Exception{
       int num = areaList.size();
		int i=0;
		Map m = null;
		String key,area_id;
		Map m1,m2 ;
		List list = new ArrayList();
	
		for(i=0;i<num;i++){
			m = (Map)areaList.get(i);
			area_id = (String)m.get("area_id");
			key = station_type+"_"+area_id;
			m1 = (Map)map.get(key);
			
			if(m1==null){m1=new HashMap();}
			m2 = new HashMap();
			m2.putAll(m);
			m2.putAll(m1);
			list.add(m2);
		}
		return list;
	}
	/*!
	 * ����request��areaList���ϲ�ѯ������Ϣ������ѯֵ����request����
	 */
	public static void getAllAreaInfoList(HttpServletRequest req,List areaList)throws Exception{
		Map areaInfoMap = (Map)CacheUtil.getAreaInfoDataMap();
		int i,num=0;
		Map m = null;
		String station_types=req.getParameter("station_types");
		if(f.empty(station_types)){station_types="1,2,3,4,5,6";}
		String[]arr=station_types.split(",");
		String station_type = null;
		List list = null;
		
		num=arr.length;
		
		m = (Map)areaInfoMap.get("all");
		
			for(i=0;i<num;i++){
				station_type=arr[i];
				list = getAreaInfoList(m,areaList,station_type);
				req.setAttribute("list_"+station_type,list);
			}
		}
	/*!
	 * ��������monitor_type��ѯt_cfg_parameter��,����map��Ϣ
	 */	
	public static Map getStationTypeMap()throws Exception{
		String sql = null;
		Map m = null;
		sql = "select parameter_value,parameter_name from t_cfg_parameter  where parameter_type_id='monitor_type' ";
		m = f.getMap(sql);
		return m;
	}
	/*!
	 * ���ݸ��ڵ��Ų�ѯ������Ϣ
	 */
	public static List getAreaList(String pid)throws Exception{
		String sql = "select * from t_cfg_area where area_pid='"+pid+"'";
		List list = f.query(sql,null);
		return list;
	}
	/*!
	 * ����map��stationList���ϣ��������area_id��ѯվλ��Ϣ
	 */
	public static void getAreaStationIdMap(Map map,List stationList,String area_id)throws Exception{
		String station_id,station_type,area_id2;
		List idList = null;
		String key = null;
		int i,num=0;
		Map m;
		boolean b=false;
		num = stationList.size();
		
		for(i=0;i<num;i++){
			m=(Map)stationList.get(i);
			area_id2=(String)m.get("area_id");
			if(f.empty(area_id2)){continue;}
			b = area_id2.startsWith(area_id);
			if(!b){continue;}
			
			station_id=(String)m.get("station_id");
			station_type=(String)m.get("station_type");
			if(f.empty(station_id)){continue;}
			if(f.empty(station_type)){continue;}
			
			key = station_type+"_"+area_id;
			idList = (List)map.get(key);
			if(idList==null){
				idList = new ArrayList();
				map.put(key,idList);
			}
			idList.add(station_id);
		}
	}
}