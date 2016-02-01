package com.hoson.util;


import com.hoson.*;
import java.util.*;
import java.sql.*;
import javax.servlet.http.*;



public class SqlUtil{
	

	public static List getStationInfoMapList(Connection cn,
			String station_id)throws Exception{
		
		List list = null;
		String sql = null;
		String msg = null;
		if(StringUtil.isempty(station_id)){
			throw new Exception("站位编号不能为空");
		}
		
		sql = "select a.infectant_id,a.infectant_name,a.infectant_unit,b.infectant_column ";
		sql=sql+" from t_cfg_infectant_base a,t_cfg_monitor_param b ";
		sql=sql+" where a.infectant_id=b.infectant_id and b.station_id='"+station_id+"'";
		sql = sql +"  order by infectant_order";
		list = DBUtil.query(cn,sql,null);
		
		return list;
		
	}
	
	public static String getStationDataQuerySql(Connection cn,
			String station_id,
			List list,HttpServletRequest req
	)throws Exception{
		
		String s = null;
		int i =0;
		int num =0;
		String msg = "请为站位 "+station_id +" 配置监测指标";
		String title = "";
		String cols ="";
		String infectant_column = null;
		String infectant_name = null;
		String infectant_unit = null;
		String date1 = null;
		String date2 = null;
		String data_table = null;
		
		Map map = null;
		
		date1 = req.getParameter("date1");
		date2 = req.getParameter("date2");
		date2 = date2+" 23:59:59";
		
		
		data_table = req.getParameter("data_table");
		
		num = list.size();
		if(num<1){
			throw new Exception(msg);
		}
		
		for(i=0;i<num;i++){
			
			map = (Map)list.get(i);
			infectant_column = (String)map.get("infectant_column");
			infectant_name = (String)map.get("infectant_name");
			infectant_unit = (String)map.get("infectant_unit");
			
			cols=cols+","+infectant_column;
			title = title+"<td>"+infectant_name+"<br> "+infectant_unit+"</td>\n";
			
					}
		
		
		s = "select m_time"+cols+" from "+data_table;
		s=s+" where station_id='"+station_id+"' ";
		s=s+" and m_time>='"+date1+"' ";
		s=s+" and m_time<='"+date2+"' ";
		s=s+"order by m_time desc";
		
		req.setAttribute("title",title);
		
		return s;
		
	}
	
	public static String getStationDataQuerySql(Connection cn,
			String station_id,
			HttpServletRequest req
	)throws Exception{
		
		List list = getStationInfoMapList(cn,station_id);
		return getStationDataQuerySql(cn,station_id,list,req);
		
	}
	
	
	
	
	
}