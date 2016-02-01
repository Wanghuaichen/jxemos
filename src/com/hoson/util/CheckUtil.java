package com.hoson.util;

import java.util.*;
import java.sql.*;
import com.hoson.app.*;

import javax.servlet.http.*;

import com.hoson.*;

public class CheckUtil{
	
	public static String getStationType(
			Connection cn,String station_id)throws Exception{
		
		String sql = null;
		String station_type = null;
		Map map = null;
		String msg = null;
		
		sql = "select station_type,station_desc from t_cfg_station_info ";
		sql=sql+" where station_id='"+station_id+"' ";
		
		map = DBUtil.queryOne(cn,sql,null);
		if(map==null){
			msg = "请指定站位类型,station_id="+station_id;
			throw new Exception(msg);
		}
		
		station_type = (String)map.get("station_type");
		
		
		
		return station_type;
	}
	
	
	
	public static String getCheckQuerySql(Connection cn,
			Map model)throws Exception{
		String station_type = null;
		String data_type = null;
		String station_id = null;
		String date1 = null;
		String date2 = null;
		int i =0;
		int num =0;
		String sql = null;
		String table = null;
		List list = null;
		String msg = null;
		
		String title = "";
		String cols = "";
		Map map = null;
		
		station_id=(String)model.get("station_id");
		station_type= getStationType(cn,station_id);
		list = JspPageUtil.getStationInfectantList(cn,station_id);
		
		num = list.size();
		
		if(num<1){
			
			msg = "请为该站位配置监测指标,station_id="+station_id;
			throw new Exception(msg);
		}
		
		for(i=0;i<num;i++){
			
			map = (Map)list.get(i);
			if(i>0){
				cols=cols+","+map.get("infectant_column");
			}else{
				
				cols=cols+map.get("infectant_column");
			}
			title=title+"<td>"+map.get("infectant_name")+map.get("infectant_unit")+"</td>\n";
			
		}
		
		model.put("title",title);
		model.put("station_type",station_type);
		model.put("cols",cols);
	
		table = "t_monitor_real_hour";
		
		date1=(String)model.get("date1");
		date2=(String)model.get("date2");
		date2=date2+" 23:59:59";
		
		sql="select m_time,"+cols+" from "+table+" where ";
		sql=sql+" station_id='"+station_id+"' ";
		sql=sql+" and m_time>='"+date1+"' ";
		sql=sql+" and m_time<='"+date2+"' ";
		
		sql=sql+" order by m_time desc";
	
		
		
		return sql;
	}
	
	public static String getDataTable(List list,String cols)
	throws Exception{
		
		String s = "";
		StringBuffer sb = new StringBuffer();
		String v = null;
		Map map = null;
		String []arr=null;
		int icol =0;
		int irow =0;
		int col_num =0;
		int row_num = 0;
		
		arr=cols.split(",");
		col_num = arr.length;
		row_num = list.size();
		
		for(irow=0;irow<row_num;irow++){
			
			map  =(Map)list.get(irow);
			
			sb.append("<tr class=tr").append(irow%2).append(">\n");
			
			for(icol=0;icol<col_num;icol++){
				
			v = (String)map.get(arr[icol]);
			v=App.getValueStr(v);
			if(icol<1){
			sb.append("<td>").append(v).append("</td>\n");
			}else{
				sb.append("<td onclick=f_click(this)>").append(v).append("</td>\n");
				
			}
				
			}//end for icol
			
			sb.append("<tr>\n");
			
			
		}//end for irow
		
		
		
		
		
		
		return sb.toString();
			
	}
	
}