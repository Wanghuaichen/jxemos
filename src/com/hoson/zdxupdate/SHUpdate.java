package com.hoson.zdxupdate;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.hoson.XBean;
import com.hoson.f;
import com.hoson.DBUtil;
import com.hoson.JspUtil;
import java.util.Properties;
public class SHUpdate
{
	public static void sh_index(HttpServletRequest request) throws Exception
	{
		Map model = f.model(request);
		XBean b = new XBean(model);
		String station_type,area_id,ctl_type,valley_id,trade_id,station_id,station_name,style_id;
		String stationTypeOption,areaOption,ctlOption,valleyOption,tradeOption,stationOption,styleOption;
		String date1,date2;
		
		station_type = b.get("station_type");
		area_id = b.get("area_id");
		ctl_type = b.get("ctl_type");
		valley_id = b.get("valley_id");
		trade_id = b.get("trade_id");
		station_id = b.get("station_id");
		station_name = b.get("station_name");
		style_id = b.get("sh_style");
		
		
		date1 = b.get("date1");
		date2 = b.get("date2");
		
		if(f.empty(station_type))
		{
			station_type = f.getDefaultStationType();
		}
		if(f.empty(area_id))
		{
			area_id = f.getDefaultAreaId();
		}
		if(f.empty(date1))
		{
			date1 = f.today();
		}
		if(f.empty(date2))
		{
			date2 = f.today();
		}
		request.setAttribute("date1",date1);
		request.setAttribute("date2",date2);
		date1 = date1 + " 00:00:00";
		date2 = date2 + " 23:59:59";
		
		stationTypeOption = f.getStationTypeOption(station_type);
		areaOption = f.getAreaOption(area_id);
		ctlOption = f.getCtlTypeOption(ctl_type);
		valleyOption = f.getValleyOption(valley_id);
		tradeOption = f.getTradeOption(trade_id);
		stationOption = SHUtil.getStationOption(b);
		styleOption = SHUtil.getSHStyle(station_type,style_id);
		
		request.setAttribute("stationTypeOption",stationTypeOption);
		request.setAttribute("areaOption",areaOption);
		request.setAttribute("tradeOption",tradeOption);
		request.setAttribute("valleyOption",valleyOption);
		request.setAttribute("ctlTypeOption",ctlOption);
		request.setAttribute("stationOption",stationOption);
		request.setAttribute("styleOption",styleOption);
		request.setAttribute("station_name",station_name);
	}
	
	public static void query(HttpServletRequest req) throws Exception
	{
		String station_type,style,station_id;
		List uselessList = new ArrayList();
		HttpSession session = req.getSession();
		session.setAttribute("uselessList",uselessList);
		Map model = f.model(req);
		XBean b = new XBean(model);
		station_type = b.get("station_type");
		style = b.get("sh_style");
		station_id = b.get("station_id");
		
		List paramsList;
		Map stationList;
		
		paramsList = SHUtil.queryParameter(station_type);
		stationList = SHUtil.queryStation_HOUR(req,paramsList);
		Map mp = SHUtil.getStyleMap(station_type,style);
		session.setAttribute("style",mp);
		Map map = SHUtil.getStandardMap(station_type,station_id);
		session.setAttribute("standard",map);
		
		req.setAttribute("paramsList",paramsList);
		req.setAttribute("data",stationList.get("data"));
		req.setAttribute("bar",stationList.get("bar"));
		req.setAttribute("styleBean",mp);
		req.setAttribute("model",model);
	}
	
	public static void data_sh(HttpServletRequest req) throws Exception
	{
		Map model = f.model(req);
		XBean b = new XBean(model);
		String mark = b.get("mark");
		Map data = new HashMap();
		if(mark.equals("0")||mark.equals("2"))
		{
		    data = SHUtil.query_sh0(b);
		}
		if(mark.equals("1"))
		{
			data = SHUtil.query_sh1(b);
		}
		data.put("mark",mark);
		req.setAttribute("data",data);
	}
	
	public static void data_update(HttpServletRequest req) throws Exception
	{
		Map model = f.model(req);
		XBean b = new XBean(model);
		String mark = b.get("mark");
		if(mark.equals("0"))
		{
			update1(req);
		}
		if(mark.equals("1")||mark.equals("2"))
		{
			update2(req);
		}
	}
	
	
	public static void update1(HttpServletRequest req) throws Exception
	{
		Map model = f.model(req);
		XBean b = new XBean(model);
		String station_id = b.get("station_id");
		String m_time = b.get("m_time");
		String infectant_col = b.get("infectant_name");
		String sh_data = b.get(infectant_col);
		sh_data = sh_data+","+sh_data+","+sh_data;
		String jc_data = b.get("jc_data");
		jc_data = jc_data+","+jc_data+","+jc_data;
		String sh_bz = b.get("sh_bz");
		
		String sql ="update t_monitor_real_hour set V_"+infectant_col.toUpperCase()+"='1',sh_bz='"+sh_bz+"' where station_id='"+station_id+"' and m_time='"+m_time+"'";
		f.update(sql,null);
		Properties prop = JspUtil.getReqProp(req);
		prop.setProperty("station_id",station_id);
		prop.setProperty("m_time",m_time);
		prop.setProperty("infectant_name",infectant_col);
		prop.setProperty("sh_value",sh_data);
		prop.setProperty("sh_time",f.time().toString().substring(0,19));
		Connection con = DBUtil.getConn();
		DBUtil.insert(con,"t_monitor_real_hour_sh","station_id,m_time,infectant_name,sh_value,sh_time",prop);
		con.close();
	}
	
	public static void update2(HttpServletRequest req) throws Exception
	{
		Map model = f.model(req);
		XBean b = new XBean(model);
		String station_id = b.get("station_id");
		String m_time = b.get("m_time");
		String infectant_col = b.get("infectant_name");
		String sh_data = b.get(infectant_col);
		sh_data = sh_data+","+sh_data+","+sh_data;
		String jc_data = b.get("jc_data");
		jc_data = jc_data+","+jc_data+","+jc_data;
		String sh_bz = b.get("sh_bz");
		
		String sql ="update t_monitor_real_hour set V_"+infectant_col.toUpperCase()+"='1',sh_bz='"+sh_bz+"' where station_id='"+station_id+"' and m_time='"+m_time+"'";
		f.update(sql,null);
		Connection con = DBUtil.getConn();
		sql = "update t_monitor_real_hour_sh set sh_value='"+sh_data+"' where station_id='"+station_id+"' and m_time='"+m_time+"' and infectant_name='"+infectant_col.toUpperCase()+"'";
		f.update(sql,null);
		con.close();
	}
	
	public static String getJC_data(String station_id,String m_time,String col) throws Exception
	{
		String jc_data="";
		String sql = "select SH_VALUE from t_monitor_real_hour_sh where station_id='"+station_id+"' and m_time='"+m_time+"' and infectant_name='"+col+"'";
		Map mp = f.queryOne(sql,null);
		Object obj = mp.get("sh_value");
		if(obj!=null)
		{
			jc_data = obj.toString();
		}
		return f.v(jc_data);
	}
	
	public static void querySh_style(HttpServletRequest req) throws Exception
	{
		Map model = f.model(req);
		XBean b = new XBean(model);
		String station_type = b.get("station_type");
		String style_name = b.get("style_name");
		String style_id = b.get("style_id");
		List list = SHUtil.getStyleList(station_type,style_id);
		req.setAttribute("style_id",style_id);
		req.setAttribute("station_type",station_type);
		req.setAttribute("styleList",list);
		req.setAttribute("style_name",style_name);
	}
	
	public static void style_update(HttpServletRequest req) throws Exception
	{
		Map model = f.model(req);
		XBean b = new XBean(model);
		String station_type = b.get("station_type");
		String style_id = b.get("style_id");
		List paramList = SHUtil.queryParameter(station_type);
		Connection con = DBUtil.getConn();
		for(int i=0;i<paramList.size();i++)
		{
			Map mp = (Map)paramList.get(i);
			String col = mp.get("infectant_column").toString().toLowerCase();
			String style_lo_value = b.get("style_lo_value_"+col);
			String style_hi_value = b.get("style_hi_value_"+col);
			String det_id = b.get("det_id_"+col);
			String sql = "update t_sh_style_detail set style_lo_value=?,style_hi_value=? where det_id=?";
			String[] str = new String[]{style_lo_value,style_hi_value,det_id};
			f.update(con,sql,str);
		}
		String style_name = b.get("style_name");
		String sql = "update t_sh_style set style_name='"+style_name+"' where style_id='"+style_id+"'";
		f.update(con,sql,null);
		con.close();
	}
	
	
	public static void style_add(HttpServletRequest req) throws Exception
	{
		Map model = f.model(req);
		XBean b = new XBean(model);
		String station_type = b.get("station_type");
		List paramList = SHUtil.queryParameter(station_type);
		int style_id = SHUtil.getStyleid();
		Connection con = DBUtil.getConn();
		for(int i=0;i<paramList.size();i++)
		{
			Map mp = (Map)paramList.get(i);
			String col = mp.get("infectant_column").toString().toLowerCase();
			String style_lo_value = b.get("style_lo_value_"+col);
			String style_hi_value = b.get("style_hi_value_"+col);
			int det_id = SHUtil.getDetid();
			Properties prop = JspUtil.getReqProp(req);
			prop.clear();
			prop.setProperty("det_id",det_id+"");
			prop.setProperty("style_lo_value",style_lo_value);
			prop.setProperty("style_hi_value",style_hi_value);
			prop.setProperty("style_column",col);
			prop.setProperty("style_id",style_id+"");
			DBUtil.insert(con,"t_sh_style_detail","det_id,style_lo_value,style_hi_value,style_column,style_id",prop);
		}
		String style_name = b.get("style_name");
		Properties prop = JspUtil.getReqProp(req);
		prop.clear();
		prop.setProperty("style_id",style_id+"");
		prop.setProperty("style_name",style_name);
		prop.setProperty("station_type",station_type);
		DBUtil.insert(con,"t_sh_style","style_id,style_name,station_type",prop);
		con.close();
	}
	
	public static String get_css(String col,String value,String m_time,String station_id,HttpServletRequest req) throws Exception
	{
		HttpSession session = req.getSession();
		Map standard = (Map)session.getAttribute("standard");
		Map style = (Map)session.getAttribute("style");
		List uselessList = (List)session.getAttribute("uselessList");
		Map map1 = new HashMap();
		String css = "";
		if(style==null||style.get(col)==null) return "";
		else if(f.empty(value)) { return "useless";}
		else if(!value.equals("")&&Double.parseDouble(value)==0d){css="useless";}
		else if(standard!=null)
		{
			Map stMap = (Map)standard.get(col);
			Map styleMap = (Map)style.get(col);
			if(stMap!=null)
			{
				Object obj1 = stMap.get("hihi");
				Object obj2 = stMap.get("lolo");
				String v_obj1 = "";
				String v_obj2 = "";
				if(obj1!=null&&!f.empty(obj1.toString())&&Double.parseDouble(obj1.toString())!=0d)
				{
					v_obj1 = obj1.toString();
					double v1 = Double.parseDouble(v_obj1);
					double s_v1 = Double.parseDouble(styleMap.get("style_hi_value").toString());
					double sv1 = v1*s_v1;
					if(Double.parseDouble(value)>=sv1) css="useless";
				}
				if(obj2!=null&&!f.empty(obj2.toString())&&Double.parseDouble(obj2.toString())!=0d)
				{
					v_obj2 = obj2.toString();
					double v2 = Double.parseDouble(v_obj2);
					double s_v2 = Double.parseDouble(styleMap.get("style_lo_value").toString());
					double sv2 = v2*s_v2;
					if(Double.parseDouble(value)<=sv2) css="useless";
				}
				if(css.equals(""))
				{
					if(obj1!=null&&!f.empty(obj1.toString())&&Double.parseDouble(obj1.toString())!=0d)
					{
						v_obj1 = obj1.toString();
						double v1 = Double.parseDouble(v_obj1);
						if(Double.parseDouble(value)>=v1) css="up";
					}
					if(obj2!=null&&!f.empty(obj2.toString())&&Double.parseDouble(obj2.toString())!=0d)
					{
						v_obj2 = obj2.toString();
						double v2 = Double.parseDouble(v_obj2);
						if(Double.parseDouble(value)<=v2) css="up";
					}
				}
			}
		}
		if(css.equals("useless"))
		{
			map1.put("station_id",station_id);
			map1.put("m_time",m_time);
			map1.put("infectant_name",col);
			uselessList.add(map1);
		}
		session.setAttribute("uselessList",uselessList);
		return css;
	}
	
	public static void style_delete(HttpServletRequest req) throws Exception
	{
		Map model = f.model(req);
		XBean b = new XBean(model);
		String style_id = b.get("style_id");
		String sql = "delete from t_sh_style where style_id='"+style_id+"'";
		f.update(sql,null);
		sql = "delete from t_sh_style_detail where style_id='"+style_id+"'";
		f.update(sql,null);
	}
	
	public static void useless_delete(HttpServletRequest req) throws Exception
	{
		Connection con = DBUtil.getConn();
		List uselessList = (List)req.getSession().getAttribute("uselessList");
		for(int i=0;i<uselessList.size();i++)
		{
			Map map = (Map)uselessList.get(i);
			Properties prop = JspUtil.getReqProp(req);
			prop.setProperty("station_id",map.get("station_id").toString());
			prop.setProperty("m_time",map.get("m_time").toString());
			prop.setProperty("infectant_name",map.get("infectant_name").toString().toUpperCase());
			prop.setProperty("sh_time",f.time().toString().substring(0,19));
			DBUtil.insert(con,"t_monitor_real_hour_sh","station_id,m_time,infectant_name,sh_time",prop);
			
			String sql = "update t_monitor_real_hour set V_"+map.get("infectant_name").toString().toUpperCase()+"='2' where station_id='"+map.get("station_id").toString()+"' and m_time='"+map.get("m_time").toString()+"'";
			f.update(sql,null);
		}
		con.close();
	}
}