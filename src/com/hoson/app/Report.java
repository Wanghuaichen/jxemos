package com.hoson.app;
import com.hoson.*;
import java.sql.*;
import java.util.*;
import com.hoson.util.*;
import javax.servlet.http.*;

public class Report{
	
	//so2,no2,pm
	//ph,do,ec,tb,imn,nh3n,toc
	
	public static String getValue(String s){
		return App.getValueStr(s);
	}
	
	public static double getDouble(String s){
		return StringUtil.getDouble(s,0);
	}
	
	
	public static Map getStationInfo(Connection cn,String station_type,String area_id,
			HttpServletRequest req)throws Exception{
		
		Map map = null;
		String sql = "select station_id,station_desc from t_cfg_station_info ";
		sql = sql+" where station_type='"+station_type+"' ";
		sql=sql+" and area_id like '"+area_id+"%' ";
		sql = sql+DataAclUtil.getStationIdInString(req,station_type,"station_id");


		
		return DBUtil.getMap(cn,sql);
		
	}
	
	
	public static String getWaterReportSql(String m_time,String area_id,String tableName)
	throws Exception{
		
		String sql = "select station_id,val02 as ph,val03 as m_do,val04 as ec,val05 as tb,val06 as imn,val07 as nh3n,val10 as toc  from "+tableName
			+ " where m_time='"+m_time+"' and station_id in("
		+"select station_id from t_cfg_station_info where 2>1 and  station_type='5' and area_id like "
		+" '"+area_id+"%')";
		//System.out.println(sql);
		
		
		return sql;
	}
	
	
	public static String getAirReportSql(String m_time,String area_id,String tableName)
	throws Exception{
		
		String sql = "select station_id,val01 as so2,val02 as no2,val03 as pm from "+tableName
			+ " where m_time='"+m_time+"' and station_id in("
		+"select station_id from t_cfg_station_info where 2>1 and station_type='6' and area_id like "
		+" '"+area_id+"%')";
		
		return sql;
	}
	
	
	public static String getAirReport(String m_time,String area_id,
			HttpServletRequest req)
    throws Exception{
		
		String sql = null;
		Connection cn = null;
		Statement stmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();
		Map map = null;
		String station_id = null;
		String station_name = null;
		Map row = null;
		
		int i=0;
		
		
		
		try{
		cn = DBUtil.getConn();
		
		
		
		stmt = cn.createStatement();
		String tableName = req.getParameter("tableName"); 
		if(tableName.equals("t_monitor_real_hour_v")){
			tableName = "t_monitor_real_day_v";
		}else{
			tableName = "t_monitor_real_day";
		}
		sql = getAirReportSql(m_time,area_id,tableName);
		rs = stmt.executeQuery(sql);
		map = getStationInfo(cn,"6",area_id,req);
		//System.out.println(map);
		while(rs.next()){
			row = getAirReportMap(rs,map);
			i++;
			
			if(row==null){continue;}
			sb.append("<tr>\n");
			//sb.append("<td>").append(i).append("</td>\n");
			sb.append("<td>").append(row.get("station_name")).append("</td>\n");
			sb.append("<td>").append(row.get("api")).append("</td>\n");
			sb.append("<td>").append(row.get("p")).append("</td>\n");
			sb.append("<td>").append(row.get("lvl")).append("</td>\n");
			sb.append("<td>").append(row.get("desc")).append("</td>\n");
			sb.append("</tr>\n");
		}
		return sb.toString();
		
		}catch(Exception e){
			
			throw e;
		}finally{
			DBUtil.close(rs,stmt,cn);
			
		}
	}

	
		public static String getWaterReport(String m_time,String area_id,
				HttpServletRequest req)
	    throws Exception{
			
			String sql = null;
			Connection cn = null;
			Statement stmt = null;
			ResultSet rs = null;
			StringBuffer sb = new StringBuffer();
			Map map = null;
			String station_id = null;
			String station_name = null;
			int i =0;
			Map row = null;
			String tableName = req.getParameter("tableName"); 
			if(tableName.equals("t_monitor_real_hour_v")){
				tableName = "t_monitor_real_day_v";
			}
			sql = getWaterReportSql(m_time,area_id,tableName);
			try{
			cn = DBUtil.getConn();
			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);
			map = getStationInfo(cn,"5",area_id,req);
			//System.out.println(map);
			
			while(rs.next()){
				
				row = getWaterReportMap(rs,map);
				if(row==null){continue;}
				sb.append("<tr>\n");
				//sb.append("<td>").append(i).append("</td>\n");
				sb.append("<td rowspan=2>").append(row.get("station_name")).append("</td>\n");
				sb.append("<td>").append(row.get("ph")).append("</td>\n");
				sb.append("<td>").append(row.get("do")).append("</td>\n");
				sb.append("<td>").append(row.get("ec")).append("</td>\n");
				sb.append("<td>").append(row.get("tb")).append("</td>\n");
				sb.append("<td>").append(row.get("imn")).append("</td>\n");
				sb.append("<td>").append(row.get("nh3n")).append("</td>\n");
				sb.append("<td>").append(row.get("toc")).append("</td>\n");
				sb.append("<td rowspan=2>").append(row.get("type")).append("</td>\n");
				sb.append("</tr>\n");
				
				sb.append("<tr>\n");
				//sb.append("<td rowspan=2>").append(row.get("station_name")).append("</td>\n");
				sb.append("<td>").append(row.get("ph_type")).append("</td>\n");
				sb.append("<td>").append(row.get("do_type")).append("</td>\n");
				sb.append("<td>").append(row.get("ec_type")).append("</td>\n");
				sb.append("<td>").append(row.get("tb_type")).append("</td>\n");
				sb.append("<td>").append(row.get("imn_type")).append("</td>\n");
				sb.append("<td>").append(row.get("nh3n_type")).append("</td>\n");
				sb.append("<td>").append(row.get("toc_type")).append("</td>\n");
				//sb.append("<td rowspan=2>").append(row.get("type")).append("</td>\n");
				sb.append("</tr>\n");
				
				
			}
			return sb.toString();
			
			}catch(Exception e){
				
				throw e;
			}finally{
				DBUtil.close(rs,stmt,cn);
				
			}
			
		
		
		
		
	}
	
		public static Map getAirReportMap(ResultSet rs,Map stationInfo)
		throws Exception{
			String station_id = null;
			String station_name = null;
			int api_so2 = 0;
			int api_no2 = 0;
			int api_pm = 0;
			String so2 = null;
			String no2 = null;
			String pm = null;
			int api = 0;
			String p = null;
			String lvl = null;
			String desc = null;
			
			station_id = rs.getString(1);
			station_name = (String)stationInfo.get(station_id);
			if(StringUtil.isempty(station_name)){return null;}
			Map map = new HashMap();
			map.put("station_id",station_id);
			map.put("station_name",station_name);
			so2 = rs.getString(2);
			no2 = rs.getString(3);
			pm = rs.getString(4);
			
			so2 = getValue(so2);
			no2 = getValue(no2);
			pm = getValue(pm);
			
			api_so2 = AirReport.get_so2_api(getDouble(so2));
			api_no2 = AirReport.get_no2_api(getDouble(no2));
			api_pm = AirReport.get_pm_api(getDouble(pm));
			
			api = AirReport.getMaxInt(api_so2,api_no2, api_pm);
			p =  AirReport.getPolution(api_so2,api_no2,api_pm);
			String[]arr=AirReport.getLevelAndDesc(api);
			lvl = arr[0];
			desc = arr[1];
			map.put("api",api+"");
			map.put("p",p);
			map.put("lvl",lvl);
			map.put("desc",desc);
		
			return map;
		}
		
		public static Map getWaterReportMap(ResultSet rs,Map stationInfo)
		throws Exception{
			String station_id = null;
			String station_name = null;
			int lvl_ph = 0;
			int lvl_do = 0;
			int lvl_imn = 0;
			int lvl_nh3n =0;
			int lvl = 0;
			String sph = null;
			String sdo = null;
			String sec = null;
			String stb = null;
			String simn = null;
			String snh3n = null;
			String stoc = null;
			String type = null;
			
			station_id = rs.getString(1);
			station_name = (String)stationInfo.get(station_id);
			if(StringUtil.isempty(station_name)){return null;}
			Map map = new HashMap();
			map.put("station_id",station_id);
			map.put("station_name",station_name);
			sph = rs.getString(2);
			sdo = rs.getString(3);
			sec = rs.getString(4);
			stb = rs.getString(5);
			simn = rs.getString(6);
			snh3n = rs.getString(7);
			stoc = rs.getString(8);
			
			sph = App.getValueStr(sph);
			sdo = App.getValueStr(sdo);
			sec = App.getValueStr(sec);
			stb = App.getValueStr(stb);
			simn = App.getValueStr(simn);
			snh3n = App.getValueStr(snh3n);
			stoc =  App.getValueStr(stoc);
			lvl_ph = WaterReport.get_ph_lvl(sph);
			lvl_do = WaterReport.get_do_lvl(sdo);
			lvl_imn = WaterReport.get_imn_lvl(simn);
			lvl_nh3n = WaterReport.get_nh3n_lvl(snh3n);
			lvl = WaterReport.getWaterLevel(lvl_ph,lvl_do,lvl_imn,lvl_nh3n);
			type = WaterReport.getDesc(lvl);
			
			map.put("type",type);
			map.put("ph",sph);
			map.put("do",sdo);
			map.put("ec",sec);
			map.put("tb",stb);
			map.put("imn",simn);
			map.put("nh3n",snh3n);
			map.put("toc",stoc);
			
			map.put("ph_type",WaterReport.getDesc(lvl_ph));
			map.put("do_type",WaterReport.getDesc(lvl_do));
			map.put("imn_type",WaterReport.getDesc(lvl_imn));
			map.put("nh3n_type",WaterReport.getDesc(lvl_nh3n));
			
			map.put("ec_type","");
			map.put("tb_type","");
			map.put("toc_type","");
			
			
			return map;
		}
	
	
	
}