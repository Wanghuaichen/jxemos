package com.hoson.util;

import com.hoson.DBUtil;
import com.hoson.StringUtil;
import com.hoson.f;
import java.sql.*;
import java.util.*;

import javax.servlet.http.*;



public class SxReportUtil{
	
	public static String sql(String station_type,String area_id,
			String date1,String date2,
			String table,String cols,HttpServletRequest req)throws Exception{
		String sql = null;
		
		String h1 = req.getParameter("h1");
		String h2 = req.getParameter("h2");
		
		if(!f.empty(h1)){
			date1=date1+" "+h1+":0:0";
		}
		if(!f.empty(h2)){
			date2=date2+" "+h2+":59:59";
		}else{
			date2 = date2+" 23:59:59";
		}
		
		
		sql = "select "+cols+" from  "+table+" where ";
		sql=sql+"m_time>='"+date1+"' ";
		sql=sql+" and m_time<='"+date2+"' ";
		
		sql=sql+" and station_id in(";
		sql=sql+"select station_id from t_cfg_station_info ";
		sql=sql+" where station_type='"+station_type+"' and area_id like '"+area_id+"%'";
		sql=sql+" ) ";
		sql=sql+DataAclUtil.getStationIdInString(req,station_type,"station_id");
		
		
		
		return sql;
		
	}
	
	public static List getStationList(
			Connection cn,String cols,String station_type,
			String area_id,String valley_id,String station_desc,
			HttpServletRequest req
			)throws Exception{
				List list = null;
				
				String sql = null;
				sql = "select "+cols+" from "
					+" t_cfg_station_info where station_type='"+station_type+"' "
					
					;
				

				sql = sql+DataAclUtil.getStationIdInString(req,station_type,"station_id");
					
				
				if(!StringUtil.isempty(area_id)){
					sql=sql+" and area_id like '"+area_id+"%' ";
				}
				
				if(!StringUtil.isempty(valley_id)){
					sql=sql+" and valley_id like '"+valley_id+"%' ";
				}
				if(!StringUtil.isempty(station_desc)){
					sql=sql+" and station_desc like '%"+station_desc+"%' ";
				}
				
				sql = sql+" order by area_id,station_desc";
				list = DBUtil.query(cn,sql,null);
				
				return list;
				
			}
			
	
	public static List getStationList(
			Connection cn,String station_type,
			String area_id,HttpServletRequest req
			)throws Exception{
		return getStationList(cn,"station_id,station_desc",station_type,area_id,null,null,req);
	}
	
	
	public static void getDataList(List list,String cols)throws Exception{
		int i,num = 0;
		Map m = null;
		String[]arr=cols.split(",");
		int j,colnum=0;
		String col  =null;
		String s = null;
		Double vobj  =null;
		colnum=arr.length;
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			for(j=0;j<colnum;j++){
				col = arr[j];
				if(f.empty(col)){continue;}
				s = (String)m.get(col);
				//if(f.empty(s)){m.put(col,null);}
				//s = f.v(s);//黄宝修改
				
				//黄宝修改后的
			   /*if (s.indexOf(",") >= 0) {
		       		String[] arrs = s.split(",");
		       			s = arrs[0];
		       }else{
		       		s=f.v(s);
		       }*/
			   
			   if (s.indexOf(",") >= 0) {
					String[] arr2 = s.split(",");

		       		//这个是原始的
		       		//if(arr.length>=2){
		       			//v = arr[0]+"["+arr[1]+"]";
		       			//flag = 1;
		       		//}else{
		       			//v = arr[0];
		       		//}
		       		 if(arr2.length>=1){
			           s=arr2[0];
			           s = s.split(";")[0];
			           s = f.v(s);
			         }
		       }else{
		       		s=f.v(s);
		       }
				
				
				
				vobj = f.getDoubleObj(s,null);
				m.put(col,vobj);
				
			}//end for j
			
			
		}//end for i
		
	}
	
	public static void printlist(List list)throws Exception{
		if(list==null){list=new ArrayList();}
		int i,num=0;
		num = list.size();
	    for(i=0;i<num;i++){
	    	System.out.println(list.get(i));
	    }
	}
	
	public static void over(List list,Map m,
			String q_col,String col,Map stdMap)throws Exception{
		if(list==null){list=new ArrayList();}
		double stdv = 0;
		String station_id = (String)m.get("station_id");
		if(f.empty(station_id)||f.empty(col)){return;}
		Double std = (Double)stdMap.get(station_id+"_"+col);
		
		
		if(std==null){stdv=1000000000;}else{stdv=std.doubleValue();}
		int i,num=0;
		int over_num,ok_num=0;
		int over_q_num,ok_q_num=0;
		double over_q,ok_q,p=0;
		Double qobj,cobj = null;
		double q,c = 0;
		Map row = null;
		double over_p,ok_p = 0;
		double over_c_sum,ok_c_sum = 0;
		over_c_sum=0;
		over_num=0;
		over_q_num = 0;
		over_p = 0;
		over_q = 0;
		ok_q = 0;
		ok_p =0;
		
		num = list.size();
		for(i=0;i<num;i++){
			row = (Map)list.get(i);
			qobj = (Double)row.get(q_col);
			cobj = (Double)row.get(col);
			if(qobj==null ||cobj==null){continue;}
			
			c = cobj.doubleValue();
			q = qobj.doubleValue();
				if(c>stdv){
						over_q_num++;
						//p = p+c*q;
						over_q=over_q+q;
						over_p = over_p+q*c;
						over_c_sum=over_c_sum+c;
				}else{
						ok_q_num++;
						//p = p+c*q;
						ok_q=ok_q+q;
						ok_p = ok_p+q*c;	
						
						ok_c_sum=ok_c_sum+c;
						
					}					
		}//end for
		
		q = ok_q+over_q;
		p = ok_p+over_p;
		double r = 0;
		if(ok_q_num>0){
			m.put(col+"_q_ok",new Double(ok_q));
			m.put(col+"_p_ok",new Double(ok_p));
			
			m.put(col+"_avg_c_ok",new Double(ok_c_sum/ok_q_num));
			
			
			if(p>0){
				r = ok_p*100/p;
				m.put(col+"_ok_r",new Double(r));
			}
			
		}
		if(over_q_num>0){
			m.put(col+"_q_over",new Double(over_q));
			m.put(col+"_p_over",new Double(over_p));
			m.put(col+"_avg_c_over",new Double(over_c_sum/over_q_num));
			if(p>0){
				r = over_p*100/p;
				m.put(col+"_over_r",new Double(r));
			}
			
		}
		m.put(col+"_std",std);
		if(ok_q_num>0 ||over_q_num>0){
			m.put(col+"_q",new Double(q));
		}
		
		
	}
	
	

	public static void over(List list,Map m,
			String q_col,String col,String col2,Map stdMap)throws Exception{
		if(list==null){list=new ArrayList();}
		double stdv = 0;
		String station_id = (String)m.get("station_id");
		if(f.empty(station_id)||f.empty(col)){return;}
		Double std = (Double)stdMap.get(station_id+"_"+col);
		
		
		if(std==null){stdv=1000000000;}else{stdv=std.doubleValue();}
		int i,num=0;
		int over_num,ok_num=0;
		int over_q_num,ok_q_num=0;
		double over_q,ok_q,p=0;
		Double qobj,cobj = null;
		Double c2obj = null;
		
		double q,c = 0;
		double c2 = 0;
		
		Map row = null;
		double over_p,ok_p = 0;
		
		over_num=0;
		over_q_num = 0;
		over_p = 0;
		over_q = 0;
		ok_q = 0;
		ok_p =0;
		
		num = list.size();
		for(i=0;i<num;i++){
			row = (Map)list.get(i);
			qobj = (Double)row.get(q_col);
			cobj = (Double)row.get(col);
			c2obj = (Double)row.get(col2);
			if(qobj==null ||cobj==null){continue;}
			if(c2obj==null){continue;}
			
			c = cobj.doubleValue();
			c2 = c2obj.doubleValue();
			q = qobj.doubleValue();
			
				if(c>stdv){
						over_q_num++;
						//p = p+c*q;
						over_q=over_q+q;
						//over_p = over_p+q*c;
						over_p = over_p+q*c2;
				}else{
						ok_q_num++;
						//p = p+c*q;
						ok_q=ok_q+q;
						//ok_p = ok_p+q*c;
						//over_p = over_p+q*c2;
						ok_p = ok_p+q*c2;
						
					}					
		}//end for
		
		q = ok_q+over_q;
		p = ok_p+over_p;
		
		double r = 0;
		if(ok_q_num>0){
			m.put(col+"_q_ok",new Double(ok_q));
			m.put(col+"_p_ok",new Double(ok_p));
			if(p>0){
				r = ok_p*100/p;
				m.put(col+"_ok_r",new Double(r));
			}
			
		}
		if(over_q_num>0){
			m.put(col+"_q_over",new Double(over_q));
			m.put(col+"_p_over",new Double(over_p));
			
			if(p>0){
				r = over_p*100/p;
				m.put(col+"_over_r",new Double(r));
			}
			
		}
		m.put(col+"_std",std);
		if(ok_q_num>0 ||over_q_num>0){
			m.put(col+"_q",new Double(q));
		}
		
		
	}
	
	
	
	public static Map std(Connection cn,String station_type,
			String area_id,HttpServletRequest req)throws Exception{
		Map std = new HashMap();
		String sql = null;
		List list = null;
		Map m = null;
		String s = null;
		double v =0;
		int i,num=0;
		String id,col = null;
		
		sql = "select station_id,infectant_column,standard_value from t_cfg_monitor_param ";
		sql=sql+" where station_id in(";
		sql=sql+"select station_id from t_cfg_station_info ";
		sql=sql+" where station_type='"+station_type+"' ";
		sql=sql+" and area_id like '"+area_id+"%'";
		sql=sql+") ";
		sql=sql+DataAclUtil.getStationIdInString(req,station_type,"station_id");
		list = f.query(cn,sql,null);
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			id = (String)m.get("station_id");
			col = (String)m.get("infectant_column");
			if(f.empty(id)||f.empty(col)){continue;}
			col=col.toLowerCase();
			s = (String)m.get("standard_value");
			v =f.getDouble(s,0);
			if(v<=0){continue;}
			std.put(id+"_"+col,new Double(v));
			
		}
		
		return std;
	}
	
	public static void sum(List list,String col,Map map){
		int i,num=0;
		double sum = 0;
		Double vobj = null;
		double v = 0;
		int num2 = 0;
		Map m = null;
		
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			vobj = (Double)m.get(col);
			if(vobj==null){continue;}
			v =vobj.doubleValue();
			sum=sum+v;
			num2++;
			
		}
		if(num2>0){
			map.put(col+"_sum",new Double(sum));
			
		}
	}
	
	public static void count(List list,String col,Map map){
		int i,num=0;
		Double vobj = null;
		int num2 = 0;
		Map m = null;
		
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			vobj = (Double)m.get(col);
			if(vobj==null){continue;}
			
			num2++;
			
		}
		map.put(col+"_num",new Integer(num2));
	}
	
	public static String getTitleTime(HttpServletRequest request)throws Exception{
		String date1 = request.getParameter("date1");
		String date2 = request.getParameter("date2");
	    
		String h1 = request.getParameter("h1");
		String h2 = request.getParameter("h2");
		String s = null;
		
		Timestamp t1,t2 = null;
		
		t1 =f.time(date1);
		t2 = f.time(date2);
		
		
		date1 = f.sub(t1+"",0,10);
		date2 = f.sub(t2+"",0,10);
		
		if(!f.empty(h1)){date1=date1+" "+h1;}
		if(!f.empty(h2)){date2=date2+" "+h2;}
		
		if(f.eq(date1,date2)){
			s=date1;
		}else{
			s=date1+"至"+date2;
		}
		
		
		
		
		return s;
		
	}
	//20090420
	
	
	public static List stationInfectantList(Connection cn,String station_type,
			String area_id,String station_name,HttpServletRequest req)throws Exception{
		//Map map = new HashMap();
		List flist = new ArrayList();
		
		List list = null;
		int i,num=0;
		Map m = null;
		Double vobj = null;
		String station_id = null;
		String infectant_id,infectant_column;
		String s = null;
		
		
		
		String sql = "select station_id,infectant_id,infectant_column,standard_value,lo,hi,lolo,hihi";
		sql=sql+" from t_cfg_monitor_param where station_id in(";
		sql=sql+"select station_id from t_cfg_station_info  where 2>1 ";
		if(!f.empty(station_type)){
			sql=sql+" and station_type='"+station_type+"'";
		}
		if(!f.empty(area_id)){
			sql=sql+" and area_id like '"+area_id+"%'";
		}
		
		if(!f.empty(station_name)){
			sql=sql+" and  station_desc like '%"+station_name+"%'";
		}
		
		sql=sql+")";
		
		req.setAttribute("sql",sql);
		
		//f.sop(sql);
		
		list = f.query(cn,sql,null);
		num=list.size();
		//f.sop("num="+num);
		for(i=0;i<num;i++){
			m=(Map)list.get(i);
			//f.sop(m);
			station_id = (String)m.get("station_id");
			infectant_id = (String)m.get("infectant_id");
			infectant_column = (String)m.get("infectant_column");
			if(f.empty(station_id)){continue;}
			if(f.empty(infectant_id)){continue;}
			if(f.empty(infectant_column)){continue;}
			
			infectant_column = infectant_column.toLowerCase();
			
			m.put("infectant_column",infectant_column);
			
			make_infectant_map(m,"lo");
			make_infectant_map(m,"li");
			
			make_infectant_map(m,"lolo");
			make_infectant_map(m,"hihi");
			//f.sop(m);
			flist.add(m);
			
		}
		
		
		
		
		
		
		return flist;
	}
	
	public static void make_infectant_map(Map m,String col){
		String s = (String)m.get(col);
		
		
		Double vobj = null;
		
		vobj=f.getDoubleObj(s,null);
		if(vobj!=null){
		if(vobj.doubleValue()==0){vobj=null;}
		}
		m.put(col,vobj);
	}
	
	public static Map stationInfectantMap(List list,String key_col)throws Exception{
		Map map = new HashMap();
		Map m = null;
		int i,num=0;
		String station_id = null;
		String key2 = null;
		String key = null;
		
		num=list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			station_id = (String)m.get("station_id");
			key2 = (String)m.get(key_col);
			if(f.empty(station_id)){continue;}
			if(f.empty(key2)){continue;}
			key = station_id+"_"+key2;
			map.put(key,m);
			
			
		}
		return map;
	}
	
	
	public static Map stationInfectantMapById(List list)throws Exception{
		return stationInfectantMap(list,"infectant_id");
	}
	

	public static Map stationInfectantMapByColumn(List list)throws Exception{
		return stationInfectantMap(list,"infectant_column");
	}
	
	public static void over_count(String station_id,List list,String col,Map map,Map fmap){
		
		//if(fmap==null){fmap=new HashMap();}
		
		int i,num=0;
		Double vobj = null;
		int num2 = 0;
		Map m = null;
		Double lolo,hihi = null;
		Map m2 = null;
		
		num = list.size();
		m2 = (Map)fmap.get(station_id+"_"+col);
		if(m2==null){m2=new HashMap();}
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			vobj = (Double)m.get(col);
			if(vobj==null){continue;}
			
			lolo = (Double)m2.get("lolo");
			hihi = (Double)m2.get("hihi");
			/*
			if(f.eq(station_id,"3311010006")&&f.eq(col,"val03")){
				f.sop("v="+vobj+",lolo="+lolo+",hihi="+hihi);
			}
			*/
			
			if(is_ok(vobj,lolo,hihi)){num2++;}
			//num2++;
			
		}
		map.put(col+"_num_ok",new Integer(num2));
	}
	
	public static boolean is_ok(Double v,Double lo,Double hi){
		 if(v==null){return true;}
		 if(lo!=null){
			 
			 if(v.doubleValue()<lo.doubleValue()){return false;}
		 }
		 
         if(hi!=null){
			 
			 if(v.doubleValue()>hi.doubleValue()){return false;}
		 }
		 return true;
	}
}