package com.hoson.zdxupdate;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.hoson.DBUtil;
import com.hoson.JspUtil;
import com.hoson.StringUtil;
import com.hoson.XBean;
import com.hoson.f;
import com.hoson.app.App;
import com.hoson.util.Query;

public class SHUtil 
{
	public static String getStationOption(XBean b) throws Exception
	{
		String station_type,area_id,ctl_type,valley_id,trade_id,station_id,station_name;
		
		station_type = b.get("station_type");
		area_id = b.get("area_id");
		ctl_type = b.get("ctl_type");
		valley_id = b.get("valley_id");
		trade_id = b.get("trade_id");
		station_id = b.get("station_id");
		station_name = b.get("station_name");
		if(f.empty(station_type))
		{
			station_type = f.getDefaultStationType();
		}
		if(f.empty(area_id))
		{
			area_id = f.getDefaultAreaId();
		}
		String sql = "select station_id,station_desc from t_cfg_station_info where station_type='"+station_type+"' and area_id like'"+area_id+"%'";
		if(!f.empty(ctl_type))
		{
			sql = sql + " and ctl_type='"+ctl_type+"'";
		}
		if(!f.empty(valley_id))
		{
			sql = sql + " and valley_id='"+valley_id+"'";
		}
		if(!f.empty(trade_id))
		{
			sql = sql + " and trade_id='"+trade_id+"'";
		}
		if(!f.empty(station_name))
		{
			sql = sql + " and station_desc like '%"+station_name+"%'";
		}
		String stationOption = f.getOption(sql,station_id);
		return stationOption;
	}
	
	public static List queryParameter(String station_type) throws Exception
	{
		List params = null;
		String sql = "select infectant_name,infectant_unit,infectant_column from t_cfg_infectant_base where station_type='"+station_type+"' and (infectant_type='1' or infectant_type='2') order by infectant_order";
		params = f.query(sql,null);
		return params;
	}
	
	public static Map queryStation_HOUR(HttpServletRequest req,List paramsList) throws Exception
	{
		String params ="";
		Map stationList=null;
		Map model = f.model(req);
		XBean b = new XBean(model);
		String date1 = b.get("date1");
		String date2 = b.get("date2");
		if(f.empty(date1))
		{
			date1 = f.today();
		}
		if(f.empty(date2))
		{
			date2 = f.today();
		}
		date1 = date1+" 00:00:00";
		date2 = date2+" 23:59:59";
		for(int i=0;i<paramsList.size();i++)
		{
			Map map = (Map)paramsList.get(i);
			String col = map.get("infectant_column").toString();
			if(i==0&&!col.equals("流量2"))
			{
				params = col;
				params = params+",V_"+col;
			}
			if(i>0&&!col.equals("流量2"))
			{
				params = params + "," +col;
				params = params + "," +"V_"+col;
			}
		}
		String sql = "select station_id,m_time,"+params+",sh_bz from t_monitor_real_hour where station_id='"+b.get("station_id")+"'";
		sql = sql + " and m_time between '"+date1+"'";
		sql = sql + " and '"+date2+"' order by m_time";
		Connection con = DBUtil.getConn();
		stationList = f.checkQuery(con,sql,null,req);
		con.close();
		return stationList;
	}
	
	public static Map query_sh0(XBean b) throws Exception
	{
		Map dataMap = new HashMap();
		String station_id,m_time,infectant_name,station_type,sql;
		station_id = b.get("station_id");
		m_time = b.get("m_time");
		infectant_name = b.get("param");
		station_type = b.get("station_type");
		sql = "select "+infectant_name.toUpperCase()+",sh_bz from t_monitor_real_hour where station_id='"+station_id+"' and m_time='"+m_time+"'";
		dataMap = f.queryOne(sql,null);
		sql = "select infectant_name from t_cfg_infectant_base where infectant_column='"+infectant_name+"' and station_type='"+station_type+"'";
		Map m = f.queryOne(sql,null);
		sql = "select station_desc from t_cfg_station_info where station_id='"+station_id+"'";
		Map mp = f.queryOne(sql,null);
		Timestamp ts1 = f.time(m_time);
		Timestamp ts2 = f.dateAdd(ts1,"month",-1);
		sql = "select "+infectant_name.toUpperCase()+" from t_monitor_real_month where station_id='"+station_id+"' and (m_time between '"+ts1+"' and '"+ts2+"')";
		Map m1 = f.queryOne(sql,null);
		ts1 = f.time(m_time);
		ts2 = f.dateAdd(ts1,"day",-1);
		sql = "select "+infectant_name.toUpperCase()+" from t_monitor_real_day where station_id='"+station_id+"' and (m_time between '"+ts1+"' and '"+ts2+"')";
		Map d = f.queryOne(sql,null);
		sql = "select top 1 "+infectant_name.toUpperCase()+" from t_monitor_real_hour where m_time<'"+f.time(m_time)+"' and station_id='"+station_id+"' order by m_time desc";
		Map h = f.queryOne(sql,null);
		dataMap.put("pre_hour",h.get(infectant_name));
		if(d!=null)
		{
			dataMap.put("pre_day",d.get(infectant_name));
		}
		if(m1!=null)
		{
			dataMap.put("pre_month",m1.get(infectant_name));
		}
		dataMap.put("infectant_col",infectant_name);
		dataMap.put("infectant_desc",m.get("infectant_name"));
		dataMap.put("station_id",station_id);
		dataMap.put("station_desc",mp.get("station_desc"));
		dataMap.put("m_time",m_time);
		return dataMap;
	}
	
	public static Map query_sh1(XBean b) throws Exception
	{
		Map dataMap = new HashMap();
		String station_id,m_time,infectant_name,station_type,sql;
		station_id = b.get("station_id");
		m_time = b.get("m_time");
		infectant_name = b.get("param");
		station_type = b.get("station_type");
		sql = "select sh_bz from t_monitor_real_hour where station_id='"+station_id+"' and m_time='"+m_time+"'";
		dataMap = f.queryOne(sql,null);
		sql = "select sh_value from t_monitor_real_hour_sh where station_id='"+station_id+"' and m_time='"+m_time+"' and infectant_name='"+infectant_name.toUpperCase()+"'";
		Map m0 = f.queryOne(sql,null);
		dataMap.put(infectant_name.toLowerCase(),m0.get("sh_value"));
		sql = "select infectant_name from t_cfg_infectant_base where infectant_column='"+infectant_name+"' and station_type='"+station_type+"'";
		Map m = f.queryOne(sql,null);
		sql = "select station_desc from t_cfg_station_info where station_id='"+station_id+"'";
		Map mp = f.queryOne(sql,null);
		Timestamp ts1 = f.time(m_time);
		Timestamp ts2 = f.dateAdd(ts1,"month",-1);
		sql = "select "+infectant_name.toUpperCase()+" from t_monitor_real_month where station_id='"+station_id+"' and (m_time between '"+ts1+"' and '"+ts2+"')";
		Map m1 = f.queryOne(sql,null);
		ts1 = f.time(m_time);
		ts2 = f.dateAdd(ts1,"day",-1);
		sql = "select "+infectant_name.toUpperCase()+" from t_monitor_real_day where station_id='"+station_id+"' and (m_time between '"+ts1+"' and '"+ts2+"')";
		Map d = f.queryOne(sql,null);
		sql = "select top 1 "+infectant_name.toUpperCase()+" from t_monitor_real_hour where m_time<'"+f.time(m_time)+"' and station_id='"+station_id+"' order by m_time desc";
		Map h = f.queryOne(sql,null);
		dataMap.put("pre_hour",h.get(infectant_name));
		if(d!=null)
		{
			dataMap.put("pre_day",d.get(infectant_name));
		}
		if(m1!=null)
		{
			dataMap.put("pre_month",m1.get(infectant_name));
		}
		dataMap.put("infectant_col",infectant_name);
		dataMap.put("infectant_desc",m.get("infectant_name"));
		dataMap.put("station_id",station_id);
		dataMap.put("station_desc",mp.get("station_desc"));
		dataMap.put("m_time",m_time);
		return dataMap;
	}
	
	public static String getSHStyle(String station_type,String style) throws Exception
	{
		String styleOption = "";
		String sql = "select style_id,style_name from t_sh_style where station_type='"+station_type+"'";
		styleOption = f.getOption(sql,style);
		return styleOption;
	}
	
	public static Map getStyleMap(String station_type,String style_id) throws Exception
	{
		Map mp = new HashMap();
		String sql = "select infectant_column from t_cfg_infectant_base where station_type='"+station_type+"' and (infectant_type='1' or infectant_type='2') and infectant_name!='流量2'";
		List list = f.query(sql,null);
		if(!f.empty("style_id")&&!style_id.equals("null"))
		{
			for(int i=0;i<list.size();i++)
			{
				Map colMap = (Map)list.get(i);
				String col = colMap.get("infectant_column").toString();
				sql = "select * from t_sh_style_detail where style_column='"+col+"' and style_id='"+style_id+"'";
				Map style = f.queryOne(sql,null);
				Map m1 = new HashMap();
				if(style!=null)
				{
					m1.put("style_lo_value",style.get("style_lo_value"));
					m1.put("style_hi_value",style.get("style_hi_value"));
					mp.put(col.toLowerCase(),m1);
				}
			}
		}
		return mp;
	}
	
	public static List getStyleList(String station_type,String style_id) throws Exception
	{
		Map map = new HashMap();
		String sql = "select a.*,b.infectant_name as column_name from (t_sh_style_detail a left outer join t_cfg_infectant_base b on b.infectant_column=a.style_column) where a.style_id='"+style_id+"' and b.station_type='"+station_type+"' and (b.infectant_type='1' or b.infectant_type='2')";
		List list = f.query(sql,null);
		return list;
	}
	
	public static int getStyleid() throws Exception
	{
		String sql = "select max(style_id) as style_id from t_sh_style";
		Map mp = f.queryOne(sql,null);
		String style_id = "1";
		if(mp!=null&&mp.get("style_id")!=null&&!f.empty(mp.get("style_id").toString()))
		{
			style_id = mp.get("style_id").toString();
		}
		int styleid = Integer.parseInt(style_id)+1;
		return styleid;
	}
	
	public static int getDetid() throws Exception
	{
		String sql = "select max(det_id) as det_id from t_sh_style_detail";
		Map mp = f.queryOne(sql,null);
		String det_id = "1";
		if(mp!=null&&mp.get("det_id")!=null&&!f.empty(mp.get("det_id").toString()))
		{
			det_id = mp.get("det_id").toString();
		}
		int detid = Integer.parseInt(det_id)+1;
		return detid;
	}
	
	public static Map getStandardMap(String station_type,String station_id) throws Exception
	{
		Map map = new HashMap();
		List paramList = SHUtil.queryParameter(station_type);
		for(int i=0;i<paramList.size();i++)
		{
			Map paramMap = (Map)paramList.get(i);
			String col = paramMap.get("infectant_column").toString();
			String sql = "select hihi,lolo from t_cfg_monitor_param where infectant_column='"+col.toUpperCase()+"' and station_id='"+station_id+"'";
			Map m = f.queryOne(sql,null);
			map.put(col.toLowerCase(),m);
		}
		return map;
	}
}
