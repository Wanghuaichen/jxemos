package com.hoson.util;

import java.util.List;

import javax.servlet.http.*;
import com.hoson.*;

import java.util.*;
import java.sql.*;
public class GrossUtil{
	


	
//总量配置	
	public static  void config(
			HttpServletRequest request, HttpServletResponse response)
	throws Exception{
		
		//String areaOption = null;
		Map model = new HashMap();
		//String stationTypeOption = null;
		String station_type = request.getParameter("station_type");
		List list = null;
		String sql = null;
		
	
			sql = "select infectant_id,infectant_name,infectant_column,gross_vol_col ";
			sql=sql+" from t_cfg_infectant_base where station_type='"+station_type+"'";
			sql=sql+" order by infectant_order";
			
			//list = Util.list(sql, null);
			list = getInfectantList(station_type);
			request.setAttribute("infectantList", list);
			
	
	}
	
	//进行总量计算
	public  static void gross(
			HttpServletRequest request, HttpServletResponse response)
	throws Exception{
		
		String sql = null;
		List infectantList = new ArrayList();
		List list = null;
		String station_type = request.getParameter("station_type");
		String area_id = request.getParameter("area_id");
		String data_table = request.getParameter("data_table");
		String date1 = request.getParameter("date1");
		String date2 = request.getParameter("date2");
		date2 = date2+" 23:59:59";
		List stationList = null;
		int i,num=0;
		Map m = null;
		String gross_vol_col = null;
		String col = null;
		Connection cn = null;
		Map total = null;
		
		try{
			cn = f.getConn();
		list = getInfectantList(cn,station_type);
		num = list.size();
		if(num<1){
			throw new Exception("请配置监测指标");
		}
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			col = (String)m.get("infectant_column");
			gross_vol_col = (String)m.get("gross_vol_col");
			if(f.empty(gross_vol_col)){continue;}
			if(f.eq(col, gross_vol_col)){continue;}
			infectantList.add(m);
		}
		num = infectantList.size();
		if(num<1){
			throw new Exception("请配置进行总量计算的监测指标");
		}
		sql = getSql(station_type,area_id,data_table,infectantList,request);
		Object[]p=new Object[]{f.time(date1),f.time(date2)};
		
		list = f.query(cn,sql,p);
		//System.out.println(list.size()+"//////////////////");
		stationList = JspPageUtil.getStationList(cn,station_type, area_id, null, request);
		f.close(cn);
		
		List grossDataList = getGrossData(list,infectantList,stationList);
		
		total = getGrossTotal(grossDataList,infectantList);
		
		request.setAttribute("infectant", infectantList);
		request.setAttribute("gross", grossDataList);
		request.setAttribute("total", total);
		
		//System.out.println(total);
		
			
		
		} catch (Exception error) {

			throw error;
		}finally{f.close(cn);}
	}
	
  
	
	//总量原始数据查询sql
	 static  String getSql(String station_type,String area_id,String data_table,
			List infectantList,HttpServletRequest req){
		String sql = "";
		Map m = null;
		Map colMap = new HashMap();
		List colList = new ArrayList();
		int i,num=0;
		String col,grosscol = null;
		String flag = null;
		String cols = "";
		
		num = infectantList.size();
		for(i=0;i<num;i++){
			m=(Map)infectantList.get(i);
			col = (String)m.get("infectant_column");
			grosscol = (String)m.get("gross_vol_col");
			
			flag = (String)colMap.get(col);
			if(f.empty(flag)){
				colMap.put(col,"1");
				//colList.add(col);
				cols=cols+","+col;
			}
			flag = (String)colMap.get(grosscol);
			if(f.empty(flag)){
				colMap.put(grosscol,"1");
				//colList.add(col);
				cols=cols+","+grosscol;
			}
			
			
		}
		
		sql="select station_id,m_time";
		
		sql=sql+cols;
		
		sql = sql+" from "+data_table;
		sql=sql+" where m_time>=? and m_time<=? ";
		sql=sql+" and station_id in (";
		sql=sql+" select station_id from t_cfg_station_info ";
		sql=sql+" where station_type='"+station_type+"' ";
		sql=sql+" and area_id like '"+area_id+"%'";
		sql=sql+") ";
		
		
		//System.out.println(sql);
		
		return sql;
	}
	
	 static  List getGrossData(List list,List infectantList,List stationList)
	throws Exception{
		List dataList = new ArrayList();
		Map data = new HashMap();
		List list2 = null;
		int i,num=0;
		Map m = null;
		String station_id = null;
		Map row = null;
		List stationDataList = null;
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			station_id = (String)m.get("station_id");
			list2 = (List)data.get(station_id);
			if(list2==null){
				list2=new ArrayList();
				data.put(station_id,list2);
				
			}
			list2.add(m);
		}
		//System.out.println(data);
		num = stationList.size();
		for(i=0;i<num;i++){
			m = (Map)stationList.get(i);
			station_id = (String)m.get("station_id");
			stationDataList = (List)data.get(station_id);
			if(stationDataList==null){
				stationDataList = new ArrayList();
			}
			row = getGrossValRow(stationDataList,infectantList);
			row.put("station_id",station_id);
			row.put("station_desc",m.get("station_desc"));
			dataList.add(row);
			//System.out.println(row);
		}
		
		
		
		
		return dataList;
	}
	
	 static  Double getGrossVal(String col,String grosscol,List list){
		double gross = 0;
		Double colvobj,gcolvobj = null;
		double colv,gcolv = 0;
		Map m = null;
		int i,num=0;
		String s = null;
		
		
		
		num = list.size();
		for(i=0;i<num;i++){
		 m=(Map)list.get(i);
		 //System.out.println(m);
		 s = (String)m.get(col);
		 s=f.v(s);
		 colvobj = f.getDoubleObj(s, null);
		 
		 s = (String)m.get(grosscol);
		 s=f.v(s);
		 gcolvobj = f.getDoubleObj(s, null);
		 
		 if(colvobj==null || gcolvobj==null){continue;}
		 colv = colvobj.doubleValue();
		 gcolv = gcolvobj.doubleValue();
		 
		 //gross=gross+colv*gcolv;
		 gross=gross+colv*gcolv/1000;
		 //mg/l  m3/h
		 //g/m3  
		 
		}
		
		return new Double(gross);
	}
	
	 static  Map getGrossValRow(List list,List infectantList){
		int i,num=0;
		String col,gcol = null;
		Double gross = null;
		Map m = null;
		Map row = new HashMap();
		num = infectantList.size();
		for(i=0;i<num;i++){
			m = (Map)infectantList.get(i);
			col = (String)m.get("infectant_column");
			gcol = (String)m.get("gross_vol_col");
			
			if(f.empty(col) ||f.empty(gcol)){continue;}
			col = col.toLowerCase();
			gcol = gcol.toLowerCase();
			
			gross = getGrossVal(col,gcol,list);
			row.put(col,gross);
			
		}
		//System.out.println(row);
		return row;
	}
	
	 public static List getInfectantList(Connection cn,String station_type) throws Exception {
		List list = null;
		String sql = null;

		sql = "select * from t_cfg_infectant_base where station_type='"
				+ station_type + "'";
		//sql = sql + " and infectant_type in('1','2')";
		sql = sql + " order by infectant_order ";

		
		list = f.query(cn,sql, null);

		return list;

	}
	
	  public static List getInfectantList(String station_type) throws Exception {
		Connection cn= null;
		
		try{
			cn = f.getConn();
			return getInfectantList(cn,station_type);
		}catch(Exception e){
			throw e;
		}finally{f.close(cn);}
	}
	
	//
	  static  double getGrossTotalVal(List list,String col)
		throws Exception{
		  double dv = 0;
		  Map m = null;
		  Double obj = null;
		  String s = null;
		  
		  int i,num=0;
		  
		  num = list.size();
		  for(i=0;i<num;i++){
			  m = (Map)list.get(i);
			  //s = (String)m.get(col);
			  //obj = f.getDoubleObj(s,null);
			  obj = (Double)m.get(col);
			  if(obj==null){continue;}
			  dv=dv+obj.doubleValue();
			  
		  }
		  
		  
		  return dv;
		  
	  }
	  
	  static  Map getGrossTotal(List list,List infectantList)
		throws Exception{
		  int i,num=0;
			String col,gcol = null;
			double gross = 0;
			Map m = null;
			Map row = new HashMap();
			num = infectantList.size();
			for(i=0;i<num;i++){
				m = (Map)infectantList.get(i);
				col = (String)m.get("infectant_column");
				gcol = (String)m.get("gross_vol_col");
				
				if(f.empty(col) ||f.empty(gcol)){continue;}
				col = col.toLowerCase();
				gcol = gcol.toLowerCase();
				
				gross = getGrossTotalVal(list,col);
				row.put(col,gross+"");
				
			}
			//System.out.println(row);
			return row;
	  }
	  
	  
}