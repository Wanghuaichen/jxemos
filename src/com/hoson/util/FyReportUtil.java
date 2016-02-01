package com.hoson.util;

import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.hoson.*;
import java.util.*;
import java.sql.*;


public class FyReportUtil{
	
	public static List getStationList(
			Connection cn,String station_type,
			String area_id,String valley_id
			,HttpServletRequest req
			)throws Exception{
				List list = null;
				
				String sql = null;
				sql = "select * from "
					+" t_cfg_station_info where station_type='"+station_type+"' "
					
					;
				

				sql = sql+DataAclUtil.getStationIdInString(req,station_type,"station_id");
					
				
				if(!StringUtil.isempty(area_id)){
					sql=sql+" and area_id like '"+area_id+"%' ";
				}
				
				if(!StringUtil.isempty(valley_id)){
					sql=sql+" and valley_id like '"+valley_id+"%' ";
				}
				sql = sql+" order by area_id,station_desc";
				list = DBUtil.query(cn,sql,null);
				
				return list;
				
			}
	
	
	public static List getStationList(
			String station_type,
			String area_id,String valley_id
			,HttpServletRequest req
			)throws Exception{
		Connection cn = null;
		try{
		cn = f.getConn();
		return getStationList(cn,station_type,area_id,valley_id,req);
		}catch(Exception e){
			throw e;
		}finally{f.close(cn);}
		
	}
		
	public static List decodeDataList(List list)throws Exception{
		List list2 = new ArrayList();
		int i,num = 0;
		Timestamp ts = null;
		String s = null;
		Double dobj = null;
		Map m = null;
		
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			
			s = (String)m.get("m_time");
			ts = f.time(s,null);
			if(ts==null){continue;}
			m.put("m_time",ts);
			
			
			s = (String)m.get("codv");
			s = f.v(s);
			//System.out.println("cod="+s);
			dobj = f.getDoubleObj(s,null);
			if(dobj==null){continue;}
			m.put("codv",dobj);
			
			s = (String)m.get("qv");
			s = f.v(s);
			//System.out.println("q="+s);
			dobj = f.getDoubleObj(s,null);
			if(dobj==null){continue;}
			m.put("qv",dobj);
			list2.add(m);
		}
		
		
		
		
		return list2;
		
	}
	
	public static void decodeDataList(List list,String col)throws Exception{
		if(list==null){return;}
		int i,num=0;
		Map m = null;
		String s = null;
		Double obj = null;
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			s=(String)m.get(col);
			if(!f.empty(s)){s=f.v(s);}
			obj=f.getDoubleObj(s,null);
			m.put(col,obj);
			
		}
		
		
		
		
		
	}
	
	
	
	
	public static List decodeDataListNotgz(List list)throws Exception{
		List list2 = new ArrayList();
		int i,num = 0;
		Timestamp ts = null;
		String s = null;
		Double dobj = null;
		Map m = null;
		String is_gz = null;
		
		
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			
			is_gz = (String)m.get("is_gz");
			if(f.eq(is_gz,"1")){continue;}
			
		
			list2.add(m);
		}
		
		
		
		
		return list2;
		
	}
	
	public static Double avg(List list,String col){
		if(list==null){list=new ArrayList();}
		Double sumobj = null;
		int i,num=0;
		int num2 = 0;
		double sum = 0;
		Double vobj = null;
		Map m = null;
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			vobj = (Double)m.get(col);
			if(vobj==null){continue;}
			sum=sum+vobj.doubleValue();
			num2++;
		}
		if(num2<1){return null;}
		
		double avg = sum/num2;
		
		return new Double(avg);
		
	}
	
	public static Double sum(List list,String col){
		if(list==null){list=new ArrayList();}
		Double sumobj = null;
		int i,num=0;
		int num2 = 0;
		double sum = 0;
		Double vobj = null;
		Map m = null;
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			vobj = (Double)m.get(col);
			if(vobj==null){continue;}
			sum=sum+vobj.doubleValue();
			num2++;
		}
		if(num2<1){return null;}
		sumobj = new Double(sum);
		return sumobj;
	}
	
	public static Double avgHigh(List list,String col,double high){
		if(list==null){list=new ArrayList();}
		Double sumobj = null;
		int i,num=0;
		int num2 = 0;
		double sum = 0;
		Double vobj = null;
		Map m = null;
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			vobj = (Double)m.get(col);
			if(vobj==null){continue;}
			
			if(vobj.doubleValue()<=high){continue;}
			
			sum=sum+vobj.doubleValue();
			num2++;
		}
		if(num2<1){return null;}
		
		double avg = sum/num2;
		
		return new Double(avg);
		
	}
	
	public static Double sumHigh(List list,String col,double high){
		if(list==null){list=new ArrayList();}
		Double sumobj = null;
		int i,num=0;
		int num2 = 0;
		double sum = 0;
		Double vobj = null;
		Map m = null;
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			vobj = (Double)m.get(col);
			if(vobj==null){continue;}
			
			if(vobj.doubleValue()<=high){continue;}
			
			sum=sum+vobj.doubleValue();
			num2++;
		}
		if(num2<1){return null;}
		sumobj = new Double(sum);
		return sumobj;
	}
	
	public static Integer countHigh(List list,String col,double high){
		if(list==null){list=new ArrayList();}
		Double sumobj = null;
		int i,num=0;
		int num2 = 0;
		double sum = 0;
		Double vobj = null;
		Map m = null;
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			vobj = (Double)m.get(col);
			if(vobj==null){continue;}
			
			if(vobj.doubleValue()<=high){continue;}
			
			sum=sum+vobj.doubleValue();
			num2++;
		}
		if(num2<1){return null;}
		return new Integer(num2);
	}
	
	//----------
	public static Double avgLow(List list,String col,double low){
		if(list==null){list=new ArrayList();}
		Double sumobj = null;
		int i,num=0;
		int num2 = 0;
		double sum = 0;
		Double vobj = null;
		Map m = null;
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			vobj = (Double)m.get(col);
			if(vobj==null){continue;}
			
			if(vobj.doubleValue()>=low){continue;}
			
			sum=sum+vobj.doubleValue();
			num2++;
		}
		if(num2<1){return null;}
		
		double avg = sum/num2;
		
		return new Double(avg);
		
	}
	
	public static Double sumLow(List list,String col,double high){
		if(list==null){list=new ArrayList();}
		Double sumobj = null;
		int i,num=0;
		int num2 = 0;
		double sum = 0;
		Double vobj = null;
		Map m = null;
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			vobj = (Double)m.get(col);
			if(vobj==null){continue;}
			
			if(vobj.doubleValue()>=high){continue;}
			
			sum=sum+vobj.doubleValue();
			num2++;
		}
		if(num2<1){return null;}
		sumobj = new Double(sum);
		return sumobj;
	}
	
	public static Integer countLow(List list,String col,double low){
		if(list==null){list=new ArrayList();}
		Double sumobj = null;
		int i,num=0;
		int num2 = 0;
		double sum = 0;
		Double vobj = null;
		Map m = null;
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			vobj = (Double)m.get(col);
			if(vobj==null){continue;}
			
			if(vobj.doubleValue()>=low){continue;}
			
			sum=sum+vobj.doubleValue();
			num2++;
		}
		if(num2<1){return null;}
		return new Integer(num2);
	}
	
	//----------
	public static Double avg(List list,String col,double low,double high){
		if(list==null){list=new ArrayList();}
		Double sumobj = null;
		int i,num=0;
		int num2 = 0;
		double sum = 0;
		Double vobj = null;
		double dv = 0;
		
		Map m = null;
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			vobj = (Double)m.get(col);
			if(vobj==null){continue;}
			
			dv = vobj.doubleValue();
			if(dv<low && dv>high ){continue;}
			
			sum=sum+vobj.doubleValue();
			num2++;
		}
		if(num2<1){return null;}
		
		double avg = sum/num2;
		
		return new Double(avg);
		
	}
	
	public static Double sum(List list,String col,double low,double high){
		if(list==null){list=new ArrayList();}
		Double sumobj = null;
		int i,num=0;
		int num2 = 0;
		double sum = 0;
		Double vobj = null;
		double dv = 0;
		Map m = null;
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			vobj = (Double)m.get(col);
			if(vobj==null){continue;}
			
			
			dv = vobj.doubleValue();
			if(dv<low && dv>high ){continue;}
			
			sum=sum+vobj.doubleValue();
			num2++;
		}
		if(num2<1){return null;}
		sumobj = new Double(sum);
		return sumobj;
	}
	
	public static Integer count(List list,String col,double low,double high){
		if(list==null){list=new ArrayList();}
		Double sumobj = null;
		int i,num=0;
		int num2 = 0;
		double sum = 0;
		Double vobj = null;
		double dv = 0;
		Map m = null;
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			vobj = (Double)m.get(col);
			if(vobj==null){continue;}
			
			
			dv = vobj.doubleValue();
			if(dv<low && dv>high ){continue;}
			
			sum=sum+vobj.doubleValue();
			num2++;
		}
		if(num2<1){return null;}
		return new Integer(num2);
	}
	
	
	public static Map getDataRow(String station_id,List stationDataList,
			double yc_v,double gz_v,double cod_std_v){
		
		if(stationDataList==null){
			stationDataList = new ArrayList();
		}
		
		
		Map m = new HashMap();
		Double avg_cod = null;
		Double sum_q = null;
		Double avg_q = null;
		Double avg_cod_over = null;
		Integer count_cod_over = null;
		double dv,low,high = 0;
		
		avg_cod = avg(stationDataList,"codv");
		sum_q = sum(stationDataList,"qv");
		avg_q = avg(stationDataList,"qv");
		avg_cod_over = avgHigh(stationDataList,"codv",cod_std_v);
		count_cod_over = countHigh(stationDataList,"codv",cod_std_v);
		
		m.put("avg_cod",avg_cod);
		m.put("sum_q",sum_q);
		m.put("avg_cod_over",avg_cod_over);
		m.put("count_cod_over",count_cod_over);
		
		if(avg_q==null){return m;}
		dv = avg_q.doubleValue();
		if(dv<=0){return m;}
		
		m.put("avg_q",avg_q);
		
		
		low = dv*yc_v;
		high = dv*gz_v;
		/*
		if(f.eq(station_id,"3302011004")){
			System.out.println("qavg="+dv);
			System.out.println("yc="+yc_v+",gz="+gz_v);
			System.out.println("low="+low+",hight="+high);
			
		}
		*/
		
		m.put("sum_q_zc",sum(stationDataList,"qv",low,high));
		m.put("avg_q_zc",avg(stationDataList,"qv",low,high));
		m.put("count_q_zc",count(stationDataList,"qv",low,high));
		
		
		m.put("sum_q_yc",sumLow(stationDataList,"qv",low));
		m.put("avg_q_yc",avgLow(stationDataList,"qv",low));
		m.put("count_q_yc",countLow(stationDataList,"qv",low));
		
		m.put("sum_q_gz",sumHigh(stationDataList,"qv",high));
		m.put("avg_q_gz",avgHigh(stationDataList,"qv",high));
		m.put("count_q_gz",countHigh(stationDataList,"qv",high));
		
		
		
		
		
		
		return m;
		
	}
	
	public static void makeDataRow(Map row,String station_id,List stationDataListAll,
			double gz_v,int dayNum){
		if(stationDataListAll==null){
			stationDataListAll = new ArrayList();
		}
		Map dataMap = new HashMap();
		Map m = null;
		int i,num=0;
		int date = 0;
		int gznum=0;
		List gzdateList = new ArrayList();
	    Double avg_q = null;
	    double avg_q_v = 0;
	    String s = null;
	    Double qvobj = null;
	    double qv = 0;
	    
	    String ss = "";
	    
	    
		Timestamp ts = null;
		num = stationDataListAll.size();
		for(i=0;i<num;i++){
			m = (Map)stationDataListAll.get(i);
			ts = (Timestamp)m.get("m_time");
			date = ts.getDate();
			dataMap.put(date+"",m);
			
		}
		avg_q = (Double)row.get("avg_q");
		
		for(i=1;i<=dayNum;i++){
			date=i;
			m = (Map)dataMap.get(i+"");
			if(m==null){
				gznum++;
				gzdateList.add(new Integer(date));
				
				continue;
			}
			s = (String)m.get("is_gz");
			if(f.eq(s,"1")){
				gznum++;
				gzdateList.add(new Integer(date));
				continue;
			}
			
			if(avg_q==null){continue;}
			qvobj = (Double)m.get("qv");
			if(qvobj==null){continue;}
			qv = qvobj.doubleValue();
			if(qv>avg_q.doubleValue()*gz_v){
				gznum++;
				gzdateList.add(new Integer(date));
				continue;
				
			}
			
			
			
			
			
		}
		
		s = "";
		num = gzdateList.size();
		for(i=0;i<num;i++){
			if(i>0){s=s+",";}
			s=s+gzdateList.get(i);
		}
		
		row.put("gznum_all",new Integer(gznum));
		row.put("gz_date",s);
		
		
	}
	
	
	public static List getDataList(List stationList,Map dataMap,
			double yc_v,double gz_v,double cod_std_v){
		List list = new ArrayList();
		int i,num=0;
		Map m,row = null;
		String id,name = null;
		List stationDataList = null;
		
		num = stationList.size();
		for(i=0;i<num;i++){;
			m = (Map)stationList.get(i);
			id = (String)m.get("station_id");
			name = (String)m.get("station_desc");
			stationDataList = (List)dataMap.get(id);
			row = getDataRow(id,stationDataList,yc_v,gz_v,cod_std_v);
			//row.put("station_id",id);
			//row.put("station_name",name);
			row.putAll(m);
			
			//System.out.println(row);
			
			list.add(row);
		}
		
		
		
		
		return list;
		
	}
	
	
	public static List getDataList(List stationList,Map dataMap,Map dataMapAll,
			double yc_v,double gz_v,double cod_std_v,int dayNum){
		List list = new ArrayList();
		int i,num=0;
		Map m,row = null;
		String id,name = null;
		List stationDataList = null;
		List stationDataListAll = null;
		num = stationList.size();
		for(i=0;i<num;i++){;
			m = (Map)stationList.get(i);
			id = (String)m.get("station_id");
			name = (String)m.get("station_desc");
			stationDataList = (List)dataMap.get(id);
			row = getDataRow(id,stationDataList,yc_v,gz_v,cod_std_v);
			//row.put("station_id",id);
			//row.put("station_name",name);
			row.putAll(m);
			stationDataListAll = (List)dataMapAll.get(id);
			makeDataRow(row,id,stationDataListAll,
					gz_v,dayNum);
			
			list.add(row);
		}
		
		
		
		
		return list;
		
	}
	
	
	public static Map getStationColMap()throws Exception{
		String sql = "select * from t_cfg_station_col order by col_id";
	    List list = null;
	    list = f.query(sql,null);
	    Map m = null;
	    m = f.getMap(list,"col_id");
	    return m;
	
	}
	public static String getStationColName(Map m,String id)throws Exception{
		Map m2 = null;
		String def = "╣з"+id+"ап";
		m2 = (Map)m.get(id);
		if(m2==null){return def;}
		
		String col_name = null;
		col_name=(String)m2.get("col_name");
		if(f.empty(col_name)){
			return def;
		}
		return col_name;
	
	}
	
	public static String getStationColCheckBox()throws Exception{
		Map m = getStationColMap();
		int i,num=0;
		String s="";
		num = 9;
		for(i=1;i<=num;i++){
			s=s+"<input type=checkbox name=station_col_id value="+i+">";
			s=s+getStationColName(m,i+"")+"  \n";
		}
		
			return s;
	}
	
	
	
}