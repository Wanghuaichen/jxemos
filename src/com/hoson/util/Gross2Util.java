package com.hoson.util;

import java.util.List;

import javax.servlet.http.*;
import com.hoson.*;

import java.util.*;
import java.sql.*;
public class Gross2Util{
	


	
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
		
		if(f.eq(station_type,"2")){
			grossDataList = getGrossDataGas(grossDataList,infectantList);
		}
		
		
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
		String cols2 = "";
		String[]arr = null;
		
		
		num = infectantList.size();
		for(i=0;i<num;i++){
			m=(Map)infectantList.get(i);
			col = (String)m.get("infectant_column");
			grosscol = (String)m.get("gross_vol_col");
			cols2 = cols2+","+col+","+grosscol;
			
			
		}
		//System.out.println(cols2);
		cols2 = cols2.toLowerCase();
		arr=cols2.split(",");
		num = arr.length;
		for(i=0;i<num;i++){
			col = arr[i];
			if(f.empty(col)){continue;}
			flag=(String)colMap.get(col);
			if(f.empty(flag)){
				cols=cols+","+col;
				colMap.put(col,"1");
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
		List qColList = null;
		Double qobj = null;
		
		qColList = getQColList(infectantList);
		
		//System.out.println(debug_qcollist(qColList));
		
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
			qobj = getGrossValQ(qColList,stationDataList);
			row.put("q",qobj);
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
	 
	 
	 static  Double getGrossValQ(String col,List list){
			double gross = 0;
			Double qobj = null;
			double qv = 0;
			Map m = null;
			int i,num=0;
			String s = null;
			
			
			
			num = list.size();
			for(i=0;i<num;i++){
			 m=(Map)list.get(i);
			 //System.out.println(m);
			 s = (String)m.get(col);
			 s=f.v(s);
			 qobj = f.getDoubleObj(s, null);
			 
			
			 
			 if(qobj==null ){continue;}
			 qv = qobj.doubleValue();
			 
			 gross=gross+qv;
			 //mg/l  m3/h
			 //g/m3  
			 
			}
			
			return new Double(gross);
		}
	 
	 static  Double getGrossValQ(List qColList,List list){
			double gross = 0;
			
			double qv = 0;
			int i,num=0;
			String col = null;
			
			
			num = qColList.size();
			for(i=0;i<num;i++){
				col = (String)qColList.get(i);
				qv = getGrossValQ(col,list).doubleValue();
				gross=gross+qv;
				
			}
			
	
			
			return new Double(gross);
		}
	 
	 
	
	 static  Map getGrossValRow(List list,List infectantList){
		int i,num=0;
		String col,gcol = null;
		Double gross = null;
		Map m = null;
		Map row = new HashMap();
		String[]gcolarr = null;
		String gcols = null;
		int j,gcolnum=0;
		double sum = 0;
		
		num = infectantList.size();
		for(i=0;i<num;i++){
			m = (Map)infectantList.get(i);
			col = (String)m.get("infectant_column");
			//gcol = (String)m.get("gross_vol_col");
			gcols = (String)m.get("gross_vol_col");
			//gcols  qcol1,qcol2
			
			
			if(f.empty(col) ||f.empty(gcols)){continue;}
			col = col.toLowerCase();
			
			
			gcolarr = gcols.split(",");
			
			gcolnum = gcolarr.length;
			
			sum=0;
			
			for(j=0;j<gcolnum;j++){
				gcol = gcolarr[j];
				if(f.empty(gcol)){continue;}
			gcol = gcol.toLowerCase();
			
			gross = getGrossVal(col,gcol,list);
			sum = sum+gross.doubleValue();
			}
			
			
			
			gross = new Double(sum);
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
			double q = 0;
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
			
			q = getGrossTotalVal(list,"q");
			row.put("q",q+"");
			
			//System.out.println(row);
			return row;
	  }
	  
	  
	  public static List getQColList(List infectantList)throws Exception{
		  List list = new ArrayList();
		  int i,num=0;
		  Map qm = new HashMap();
		  Map m = null;
		  String cols,col = null;
		  String[]arr = null;
		  int j,colnum=0;
		  
		  Object flag = null;
		  
		  num = infectantList.size();
			for(i=0;i<num;i++){
				m = (Map)infectantList.get(i);
				
				cols = (String)m.get("gross_vol_col");
				if(f.empty(cols)){continue;}
				
				arr=cols.split(",");
				colnum = arr.length;
				
				for(j=0;j<colnum;j++){
				col = arr[j];
				if(f.empty(col)){continue;}
				col = col.toLowerCase();
				flag = qm.get(col);
				if(flag==null){
					qm.put(col,"1");
					list.add(col);
					
				}
				}//end for j


			}//end for i 
		  
		  return list;
		  
	  }
	  
	 static String debug_qcollist(List qColList){
		  int i,num=0;
		  String s = "";
		  num = qColList.size();
		  
		  for(i=0;i<num;i++){
			  s=s+qColList.get(i)+",";
		  }
		  return num+","+s;
		 
	 }
	 
	 static List getGrossColList(List infectantList){
		 List list = new ArrayList();
		 int i,num=0;
		Map m = null;
			String col,gcols = null;
			
			
			num = infectantList.size();
			for(i=0;i<num;i++){
				m = (Map)infectantList.get(i);
				col = (String)m.get("infectant_column");
				//gcol = (String)m.get("gross_vol_col");
				gcols = (String)m.get("gross_vol_col");
				//gcols  qcol1,qcol2
				if(f.empty(col)){continue;}
				if(f.empty(gcols)){continue;}
				col=col.toLowerCase();
				list.add(col);
				
				
			}
				
		 
		 
		 return list;
	 }
	  
	 public static List getGrossDataGas(List list,List infectantList)throws Exception{
		 List colList = null;
		 Map m = null;
		 int i,num=0;
		 int j,colnum=0;
		 String col = null;
		 Double vobj = null;
		 double v = 0;
		 
		 
		 colList = getGrossColList(infectantList);
		 colnum=colList.size();
		 num = list.size();
		 for(i=0;i<num;i++){
			 m = (Map)list.get(i);
			 for(j=0;j<colnum;j++){
				 col = (String)colList.get(j);
				 vobj = (Double)m.get(col);
				 if(vobj==null){continue;}
				 v = vobj.doubleValue();
				 v=v/1000;
				 m.put(col,new Double(v));
				 
			 }
			 
		 }
		 
		
		 
		 
		 return list;
		 
	 }
	  
}