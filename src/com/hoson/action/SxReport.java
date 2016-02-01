package com.hoson.action;
import com.hoson.util.*;

import java.util.*;

import com.hoson.*;
import java.sql.*;

import javax.servlet.http.HttpServletRequest;


public class SxReport extends BaseAction{
	
	/*!
	 * 根据2个日期计算中间的天数
	 */
	static long getDayNum(String date1,String date2)throws Exception{
		long num=0;
		Timestamp t1 = f.time(date1);
		Timestamp t2 = f.time(date2);
		t2 = f.dateAdd(t2,"day",1);
		long dif = t2.getTime()-t1.getTime();
		
		
		num = dif/(60*60*24*1000);
		if(num<0){
			throw new Exception("结束时间不能小于开始时间");
		}
		
		return num;
	}
	/*!
	 * 获得配置文件的value_zero_string值
	 */
	public String rpt01()throws Exception{
		String sql = null;
		String area_id = request.getParameter("area_id");
		String station_type = request.getParameter("station_type");
		String date1 = request.getParameter("date1");
		String date2 = request.getParameter("date2");
		Map m1,m2 = null;
		List list = null;
		int i,num=0;
		long daynum=getDayNum(date1,date2);
		String station_id = null;
		String r_s = null;
		double r = 0;
		
		
		sql = "select station_id,count(1) as hour_data_num from "+request.getParameter("tableName");
		sql=sql+" where m_time>='"+date1+"' and m_time<='"+date2+" 23:59:59' ";
		sql=sql+" and station_id in(";
		sql=sql+"select station_id from t_cfg_station_info ";
		sql=sql+" where station_type='"+station_type+"' and area_id like '"+area_id+"%'";
		sql=sql+" ) ";
		sql=sql+DataAclUtil.getStationIdInString(request,station_type,"station_id");
		
		getConn();
		m1 = f.getMap(conn,sql);
		
		sql = "select station_id,station_desc from t_cfg_station_info ";
		sql=sql+" where station_type='"+station_type+"' ";
		sql=sql+" and area_id like '"+area_id+"%'";
		sql=sql+" order by area_id,station_desc ";
		list = f.query(conn,sql,null);
		close();
		
		num = list.size();
		for(i=0;i<num;i++){
			m2=(Map)list.get(i);
			station_id = (String)m2.get("station_id");
			r_s = (String)m1.get(station_id);
			if(r_s==null){continue;}
			r = f.getDouble(r_s,0);
			
			r = r*100/(daynum*24);
			
			m2.put("r",r+"");
			
		}
		
		seta("data",list);
		seta("daynum",daynum+"");
		
		
		return null;
	}
	/*!
	 * 废水在线监控监测数据报表
	 */
	public String rpt02()throws Exception{
		String sql = null;
		String area_id = request.getParameter("area_id");
		String station_type = request.getParameter("station_type");
		String date1 = request.getParameter("date1");
		String date2 = request.getParameter("date2");
		String q_col = p("q_col");
		String cod_col = p("cod_col");
		String ph_col = p("ph_col");
		String cols = p("cols");
		String sqlcols = "station_id,"+cols;
		String table = request.getParameter("tableName");
		List list = null;
		List stationList = null;
		Map stationDataListMap = null;
		String station_id = null;
		int i,num=0;
		Map m = null;
		sql = SxReportUtil.sql(station_type, area_id,
				date1,date2,
				table,sqlcols,request);
		getConn();
		list = f.query(conn,sql,null);
		stationList = SxReportUtil.getStationList(conn,station_type,area_id,request);
		close();
		SxReportUtil.getDataList(list,cols);
		
		StdReportUtil.q(list,q_col,cod_col);
		
		stationDataListMap = f.getListMap(list,"station_id");
		num = stationList.size();
		String tjcols = cols+","+cod_col+"_q";
		for(i=0;i<num;i++){
			m = (Map)stationList.get(i);
			station_id = (String)m.get("station_id");
			list = (List)stationDataListMap.get(station_id);
			if(list==null){continue;}
			StdReportUtil.hztjs(list,tjcols,m);
			
		}
		
		seta("data",stationList);
		
		return null;
	}
	/*!
	 * 废气在线监控监测数据报表
	 */
	public String rpt03()throws Exception{
		String sql = null;
		String area_id = request.getParameter("area_id");
		String station_type = request.getParameter("station_type");
		String date1 = request.getParameter("date1");
		String date2 = request.getParameter("date2");
		String q_col = p("q_col");
		String so2_col = p("so2_col");
		String nox_col = p("nox_col");
		String pm_col = p("pm_col");
		String cols = p("cols");
		
		String sqlcols = "station_id,"+cols;
		String table = request.getParameter("tableName");
		List list = null;
		List stationList = null;
		Map stationDataListMap = null;
		String station_id = null;
		int i,num=0;
		Map m = null;
		sql = SxReportUtil.sql(station_type, area_id,
				date1,date2,
				table,sqlcols,request);
		getConn();
		list = f.query(conn,sql,null);
		stationList = SxReportUtil.getStationList(conn,station_type,area_id,request);
		close();
		SxReportUtil.getDataList(list,cols);
		
		StdReportUtil.q(list,q_col,so2_col);
		StdReportUtil.q(list,q_col,pm_col);
		StdReportUtil.q(list,q_col,nox_col);
		
		stationDataListMap = f.getListMap(list,"station_id");
		num = stationList.size();
		String tjcols = cols+","+so2_col+"_q,"+nox_col+"_q,"+pm_col+"_q";
		for(i=0;i<num;i++){
			m = (Map)stationList.get(i);
			station_id = (String)m.get("station_id");
			list = (List)stationDataListMap.get(station_id);
			if(list==null){continue;}
			StdReportUtil.hztjs(list,tjcols,m);
			
		}
		seta("data",stationList);
		
		return null;
	}
	/*!
	 * 废水在线监测点COD浓度分段统计报表
	 */
	public String rpt04()throws Exception{
		String sql = null;
		String area_id = request.getParameter("area_id");
		String station_type = request.getParameter("station_type");
		String date1 = request.getParameter("date1");
		String date2 = request.getParameter("date2");
		
		String q_col = p("q_col");
		String cod_col = p("cod_col");
		String cols = p("cols");
		
		String sqlcols = "station_id,"+cols;
		String table = request.getParameter("tableName");
		List list = null;
		List stationList = null;
		Map stationDataListMap = null;
		String station_id = null;
		int i,num=0;
		Map m = null;
		Map stdMap = null;
		
		sql = SxReportUtil.sql(station_type, area_id,
				date1,date2,
				table,sqlcols,request);
		getConn();
		list = f.query(conn,sql,null);
		stationList = SxReportUtil.getStationList(conn,station_type,area_id,request);
		stdMap = SxReportUtil.std(conn,station_type,area_id,request);
		close();
		SxReportUtil.getDataList(list,cols);
		stationDataListMap = f.getListMap(list,"station_id");
		num = stationList.size();
		for(i=0;i<num;i++){
			m = (Map)stationList.get(i);
			station_id = (String)m.get("station_id");
			list = (List)stationDataListMap.get(station_id);
			if(list==null){continue;}
			//StdReportUtil.hztjs(list,tjcols,m);
			SxReportUtil.over(list,m,q_col,cod_col,stdMap);
			SxReportUtil.sum(list,q_col,m);
		}
		seta("data",stationList);
		
		return null;
	}
	/*!
	 * 废气在线监测点SO2、Nox、烟尘排放in浓度分段统计排放统计报表
	 */
	public String rpt05()throws Exception{
		String sql = null;
		String area_id = request.getParameter("area_id");
		String station_type = request.getParameter("station_type");
		String date1 = request.getParameter("date1");
		String date2 = request.getParameter("date2");
		String q_col = p("q_col");
		
		String so2_col = p("so2_col");
		String nox_col = p("nox_col");
		String pm_col = p("pm_col");
		
		String so22_col = p("so22_col");
		String nox2_col = p("nox2_col");
		String pm2_col = p("pm2_col");
		
		String cols = p("cols");
		
		String sqlcols = "station_id,"+cols;
		String table = request.getParameter("tableName");
		List list = null;
		List stationList = null;
		Map stationDataListMap = null;
		String station_id = null;
		int i,num=0;
		Map m = null;
		Map stdMap = null;
		
		sql = SxReportUtil.sql(station_type, area_id,
				date1,date2,
				table,sqlcols,request);
		getConn();
		list = f.query(conn,sql,null);
		stationList = SxReportUtil.getStationList(conn,station_type,area_id,request);
		stdMap = SxReportUtil.std(conn,station_type,area_id,request);
		close();
		SxReportUtil.getDataList(list,cols);
		stationDataListMap = f.getListMap(list,"station_id");
		num = stationList.size();
		for(i=0;i<num;i++){
			m = (Map)stationList.get(i);
			station_id = (String)m.get("station_id");
			list = (List)stationDataListMap.get(station_id);
			if(list==null){continue;}
			
			SxReportUtil.over(list,m,q_col,so2_col,so22_col,stdMap);
			SxReportUtil.over(list,m,q_col,nox_col,nox2_col,stdMap);
			SxReportUtil.over(list,m,q_col,pm_col,pm2_col,stdMap);
			
			SxReportUtil.sum(list,q_col,m);
			
		}
		seta("data",stationList);
		return null;
	}
	
	/*!
	 * 废水在线监测点完好率统计报表
	 */
	public String rpt06()throws Exception{
		String sql = null;
		String area_id = request.getParameter("area_id");
		String station_type = request.getParameter("station_type");
		String date1 = request.getParameter("date1");
		String date2 = request.getParameter("date2");
		String q_col = p("q_col");
		String toc_col = p("toc_col");
		String cod_col = p("cod_col");
		String ph_col = p("ph_col");
		String cols = p("cols");
		String sqlcols = "station_id,"+cols;
		String table = request.getParameter("tableName");
		List list = null;
		List stationList = null;
		Map stationDataListMap = null;
		String station_id = null;
		int i,num=0;
		Map m = null;
		long daynum = getDayNum(date1,date2);
		
		
		sql = SxReportUtil.sql(station_type, area_id,
				date1,date2,
				table,sqlcols,request);
		getConn();
		list = f.query(conn,sql,null);
		stationList = SxReportUtil.getStationList(conn,station_type,area_id,request);
		close();
		SxReportUtil.getDataList(list,cols);
		
		stationDataListMap = f.getListMap(list,"station_id");
		num = stationList.size();

		for(i=0;i<num;i++){
			m = (Map)stationList.get(i);
			station_id = (String)m.get("station_id");
			list = (List)stationDataListMap.get(station_id);
			if(list==null){
				//continue;
				list=new ArrayList();
			}
			SxReportUtil.count(list,q_col,m);
			SxReportUtil.count(list,ph_col,m);
			SxReportUtil.count(list,toc_col,m);
			SxReportUtil.count(list,cod_col,m);
			
			rpt06_num(m,q_col,daynum);
			rpt06_num(m,toc_col,daynum);
			rpt06_num(m,cod_col,daynum);
			rpt06_num(m,ph_col,daynum);
			rpt06_r_avg(m,q_col+","+ph_col+","+toc_col+","+cod_col);
			
		}
		seta("data",stationList);
		
		return null;
	}
	/*!
	 * 废气在线监控监测数据报表
	 */
	static void rpt06_num(Map m,String col,long daynum)throws Exception{
		Integer numobj = null;
		int num=0;
		long num_all = 0;
		long num_no = 0;
		double r = 0;
		
		
		
		
		numobj = (Integer)m.get(col+"_num");
		if(numobj==null){
			numobj=new Integer(0);
			m.put(col+"_num",numobj);
		}
		num = numobj.intValue();
		num_all = daynum*24;
		
		m.put(col+"_num_all",new Long(num_all));
		num_no = num_all-num;
		m.put(col+"_num_no",new Long(num_no));
		r = num*100.0/num_all;
		m.put(col+"_r",new Double(r));
		
		
		numobj = (Integer)m.get(col+"_num_ok");
		if(numobj==null){
			numobj=new Integer(0);
			m.put(col+"_num_ok",numobj);
		}
		num = numobj.intValue();
		r = num*100.0/num_all;
		
		m.put(col+"_r_ok",new Double(r));
		
		
	}
	/*!
	 * 废气在线监控监测数据报表
	 */
	static void rpt06_r_avg(Map m,String cols)throws Exception{
		String[]arr=cols.split(",");
		int i,num=0;
		Double robj = null;
		String col = null;
		double r,rsum = 0;
		
		
		num=arr.length;
		for(i=0;i<num;i++){
			col=arr[i];
			robj = (Double)m.get(col+"_r");
			if(robj==null){robj=new Double(0);}
			r=robj.doubleValue();
			rsum=rsum+r;
		}
		r = rsum/num;
		m.put("r_avg",new Double(r));
	}
	/*!
	 * 废气在线监控监测数据报表
	 */
	static void r_ok_avg(Map m,String cols)throws Exception{
		String[]arr=cols.split(",");
		int i,num=0;
		Double robj = null;
		String col = null;
		double r,rsum = 0;
		
		num=arr.length;
		for(i=0;i<num;i++){
			col=arr[i];
			robj = (Double)m.get(col+"_r_ok");
			if(robj==null){robj=new Double(0);}
			r=robj.doubleValue();
			rsum=rsum+r;
		}
		r = rsum/num;
		m.put("r_ok_avg",new Double(r));
	}
	/*!
	 * 废气在线监测点完好率统计报表
	 */
	public String rpt07()throws Exception{
		String sql = null;
		String area_id = request.getParameter("area_id");
		String station_type = request.getParameter("station_type");
		String date1 = request.getParameter("date1");
		String date2 = request.getParameter("date2");
		String v_col = p("v_col");
		String so2_col = p("so2_col");
		String nox_col = p("nox_col");
		String pm_col = p("pm_col");
		String o2_col = p("o2_col");
		
		String cols = p("cols");
		String sqlcols = "station_id,"+cols;
		String table = request.getParameter("tableName");
		List list = null;
		List stationList = null;
		Map stationDataListMap = null;
		String station_id = null;
		int i,num=0;
		Map m = null;
		long daynum = getDayNum(date1,date2);

		Map fmap=null;
		
		sql = SxReportUtil.sql(station_type, area_id,
				date1,date2,
				table,sqlcols,request);
		getConn();
		list = f.query(conn,sql,null);
		stationList = SxReportUtil.getStationList(conn,station_type,area_id,request);

		close();
		SxReportUtil.getDataList(list,cols);
		
		stationDataListMap = f.getListMap(list,"station_id");
		
		num = stationList.size();
	
		for(i=0;i<num;i++){
			m = (Map)stationList.get(i);
			station_id = (String)m.get("station_id");
			list = (List)stationDataListMap.get(station_id);
			if(list==null){
				list=new ArrayList();
			}
			SxReportUtil.count(list,v_col,m);
			SxReportUtil.count(list,so2_col,m);
			SxReportUtil.count(list,nox_col,m);
			SxReportUtil.count(list,pm_col,m);
			SxReportUtil.count(list,o2_col,m);
			
			rpt06_num(m,v_col,daynum);
			rpt06_num(m,so2_col,daynum);
			rpt06_num(m,nox_col,daynum);
			rpt06_num(m,pm_col,daynum);
			rpt06_num(m,o2_col,daynum);
			
			rpt06_r_avg(m,cols);
		}
		seta("data",stationList);
		return null;
	}
	/*!
	 * 废水在线监测点完好率统计报表2
	 */
	public String rpt08()throws Exception{
		String sql = null;
		String area_id = request.getParameter("area_id");
		String station_type = request.getParameter("station_type");
		String date1 = request.getParameter("date1");
		String date2 = request.getParameter("date2");
		String q_col = p("q_col");
		String toc_col = p("toc_col");
		String cod_col = p("cod_col");
		String ph_col = p("ph_col");
		
		String cols = p("cols");
		String sqlcols = "station_id,"+cols;
		String table = request.getParameter("tableName");
		List list = null;
		List stationList = null;
		Map stationDataListMap = null;
		String station_id = null;
		int i,num=0;
		Map m = null;
		long daynum = getDayNum(date1,date2);
		List stationInfectantList = null;
		Map  stationInfectantMap = null;

		sql = SxReportUtil.sql(station_type, area_id,
				date1,date2,
				table,sqlcols,request);
		getConn();
		list = f.query(conn,sql,null);
		stationList = SxReportUtil.getStationList(conn,station_type,area_id,request);
		
		stationInfectantList = SxReportUtil.stationInfectantList(conn,station_type,area_id,null,request);
		
		close();
		SxReportUtil.getDataList(list,cols);
		
		stationDataListMap = f.getListMap(list,"station_id");
		num = stationList.size();

		stationInfectantMap = SxReportUtil.stationInfectantMapByColumn(stationInfectantList);
		
		for(i=0;i<num;i++){
			m = (Map)stationList.get(i);
			station_id = (String)m.get("station_id");
			list = (List)stationDataListMap.get(station_id);
			if(list==null){
				list=new ArrayList();
			}
			SxReportUtil.count(list,q_col,m);
			SxReportUtil.count(list,ph_col,m);
			SxReportUtil.count(list,toc_col,m);
			SxReportUtil.count(list,cod_col,m);
			
			SxReportUtil.over_count(station_id,list,q_col,m,stationInfectantMap);
			SxReportUtil.over_count(station_id,list,ph_col,m,stationInfectantMap);
			SxReportUtil.over_count(station_id,list,toc_col,m,stationInfectantMap);
			SxReportUtil.over_count(station_id,list,cod_col,m,stationInfectantMap);
			
			rpt06_num(m,q_col,daynum);
			rpt06_num(m,toc_col,daynum);
			rpt06_num(m,cod_col,daynum);
			rpt06_num(m,ph_col,daynum);
			
			rpt06_r_avg(m,q_col+","+ph_col+","+toc_col+","+cod_col);
			r_ok_avg(m,q_col+","+ph_col+","+toc_col+","+cod_col);
			
		}
		seta("data",stationList);
		return null;
	}
	/*!
	 * 废气在线监测点完好率统计报表2
	 */
	public String rpt09()throws Exception{
		String sql = null;
		String area_id = request.getParameter("area_id");
		String station_type = request.getParameter("station_type");
		String date1 = request.getParameter("date1");
		String date2 = request.getParameter("date2");
		String v_col = p("v_col");
		String so2_col = p("so2_col");
		String nox_col = p("nox_col");
		String pm_col = p("pm_col");
		String o2_col = p("o2_col");
		String p_col = p("p_col");
		
		String cols = p("cols");
		String sqlcols = "station_id,"+cols;
		String table = request.getParameter("tableName");
		List list = null;
		List stationList = null;
		Map stationDataListMap = null;
		String station_id = null;
		int i,num=0;
		Map m = null;
		long daynum = getDayNum(date1,date2);
		List stationInfectantList = null;
		Map  stationInfectantMap = null;
	
		sql = SxReportUtil.sql(station_type, area_id,
				date1,date2,
				table,sqlcols,request);
		getConn();
		list = f.query(conn,sql,null);
		stationList = SxReportUtil.getStationList(conn,station_type,area_id,request);
		stationInfectantList = SxReportUtil.stationInfectantList(conn,station_type,area_id,null,request);
		close();
		SxReportUtil.getDataList(list,cols);
		
		stationDataListMap = f.getListMap(list,"station_id");
		
		num = stationList.size();
		stationInfectantMap = SxReportUtil.stationInfectantMapByColumn(stationInfectantList);
		
		for(i=0;i<num;i++){
			m = (Map)stationList.get(i);
			station_id = (String)m.get("station_id");
			list = (List)stationDataListMap.get(station_id);
			if(list==null){
				list=new ArrayList();
			}
			
			SxReportUtil.count(list,v_col,m);
			SxReportUtil.count(list,so2_col,m);
			SxReportUtil.count(list,nox_col,m);
			SxReportUtil.count(list,pm_col,m);
			SxReportUtil.count(list,o2_col,m);
			SxReportUtil.count(list,p_col,m);

			SxReportUtil.over_count(station_id,list,v_col,m,stationInfectantMap);
			SxReportUtil.over_count(station_id,list,so2_col,m,stationInfectantMap);
			SxReportUtil.over_count(station_id,list,nox_col,m,stationInfectantMap);
			SxReportUtil.over_count(station_id,list,pm_col,m,stationInfectantMap);
			SxReportUtil.over_count(station_id,list,o2_col,m,stationInfectantMap);
			SxReportUtil.over_count(station_id,list,p_col,m,stationInfectantMap);
			
			rpt06_num(m,v_col,daynum);
			rpt06_num(m,so2_col,daynum);
			rpt06_num(m,nox_col,daynum);
			rpt06_num(m,pm_col,daynum);
			rpt06_num(m,o2_col,daynum);
			rpt06_num(m,p_col,daynum);
			rpt06_r_avg(m,cols);
			r_ok_avg(m,cols);
		}
		
		seta("data",stationList);
		return null;
	}
	
	
}