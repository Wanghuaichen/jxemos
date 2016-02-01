package com.hoson.zdxupdate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.hoson.XBean;
import com.hoson.f;
public class ReportUpdate
{
	public static void report_index(HttpServletRequest request) throws Exception
	{
		Map model = f.model(request);
		XBean b = new XBean(model);
		String station_type,area_id,ctl_type,valley_id,trade_id,type;
		String stationTypeOption,areaOption,ctlOption,valleyOption,tradeOption,hourOption1,hourOption2;
		List paramList;
		String date1,date2;
		station_type = b.get("station_type");
		area_id = b.get("area_id");
		ctl_type = b.get("ctl_type");
		valley_id = b.get("valley_id");
		trade_id = b.get("trade_id");
		type = b.get("type");
		String station_ids = b.get("stOption");
		
		date1 = b.get("date3");
		date2 = b.get("date4");
		if(f.empty(date1))
		{
			date1 = b.get("date1");
			date2 = b.get("date2");
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
		if(f.empty(station_type))
		{
			station_type = f.getDefaultStationType();
		}
		if(type.equals("tj_zl")&&Integer.parseInt(station_type)>2)
		{
			station_type = "1";
		}
		if(f.empty(area_id))
		{
			area_id = f.getDefaultAreaId();
		}
		
		List hourList = new ArrayList();
		for(int i=0;i<24;i++)
		{
			Map mp = new HashMap();
			mp.put("v_k",i+"");
			mp.put("t_k",i+"");
			hourList.add(mp);
		}
		areaOption = f.getAreaOption(area_id);
		ctlOption = f.getCtlTypeOption(ctl_type);
		valleyOption = f.getValleyOption(valley_id);
		tradeOption = f.getTradeOption(trade_id);
		hourOption1 = f.getOption(hourList,"v_k","t_k",null);
		hourOption2 = f.getOption(hourList,"v_k","t_k","6");
		String typeOption = ReportUtil.getTypeOption(type);
		if(!f.empty(type)&&type.equals("tj_zl"))
		{
			paramList = ReportUtil.getTotalParamList(station_type);
			stationTypeOption = ReportUtil.getStationTypeOption(station_type);
		}
		else
		{
			paramList = ReportUtil.getParamList(station_type);
			stationTypeOption = f.getStationTypeOption(station_type);
		}
		
		request.setAttribute("stationTypeOption",stationTypeOption);
		request.setAttribute("areaOption",areaOption);
		request.setAttribute("tradeOption",tradeOption);
		request.setAttribute("valleyOption",valleyOption);
		request.setAttribute("ctlTypeOption",ctlOption);
		request.setAttribute("hourOption1",hourOption1);
		request.setAttribute("hourOption2",hourOption2);
		request.setAttribute("typeOption",typeOption);
		request.setAttribute("paramList",paramList);
		request.setAttribute("station_type",station_type);
		request.setAttribute("area_id",area_id);
		request.setAttribute("stations",station_ids);
		request.setAttribute("type",type);
		request.setAttribute("ctl_type",ctl_type);
		request.setAttribute("valley_id",valley_id);
		request.setAttribute("trade_id",trade_id);
	}
	
	public static void getStationList(HttpServletRequest req) throws Exception
	{
		List stationList = ReportUtil.getStationList(req);
		req.setAttribute("stationList",stationList);
	}
	
	
	public static void getData(HttpServletRequest req) throws Exception
	{
		Map model = f.model(req);
		XBean b = new XBean(model);
		String stations = b.get("stations");
		List stationList = ReportUtil.getStationListById(stations);
		String station_type,date1,date2;
		station_type = b.get("station_type");
		date1 = b.get("date3");
		date2 = b.get("date4");
		if(f.empty(date1))
		{
			date1 = f.today();
		}
		if(f.empty(date2))
		{
			date2 = f.today();
		}
		req.setAttribute("date1",date1);
		req.setAttribute("date2",date2);
		date1 = date1 + " 00:00:00";
		date2 = date2 + " 23:59:59";
		String[] paramArray = req.getParameterValues("col");
		List paramList = new ArrayList();
		String col_col = "";
		for(int i=0;i<paramArray.length;i++)
		{
			String col = paramArray[i].toUpperCase();
			String sql = "select infectant_column,infectant_name,infectant_unit from t_cfg_infectant_base where infectant_column='"+col+"' and (infectant_type='1' or infectant_type='2') and station_type='"+station_type+"'";
			Map mm = f.queryOne(sql,null);
			Map m1 = new HashMap();
			m1.put("infectant_column",mm.get("infectant_column"));
			m1.put("infectant_unit",mm.get("infectant_unit"));
			m1.put("infectant_name",mm.get("infectant_name"));
			if(mm.get("infectant_name").equals("流量"))
			{
				col_col = mm.get("infectant_column").toString();
			}
			paramList.add(m1);
		}
		List dataList = ReportUtil.getDataList(stationList,date1,date2,paramList);
		dataList = ReportUtil.getAvgData(dataList,paramList);
		req.setAttribute("dataList",dataList);
		if(station_type.equals("1")||station_type.equals("5"))
		{
			Map m2 = new HashMap();
			m2.put("infectant_column","t_"+col_col);
			m2.put("infectant_unit","m<sup>3</sup>");
			m2.put("infectant_name","累计流量");
			paramList.add(m2);
		}
		req.setAttribute("paramList",paramList);
	}
	
	
	public static void real_hour(HttpServletRequest req) throws Exception
	{
		Map model = f.model(req);
		XBean b = new XBean(model);
		String station_type,date1,date2,stOption;
		station_type = b.get("station_type");
		date1 = b.get("date1");
		date2 = b.get("date2");
		String hour1 = b.get("hour1");
		String hour2 = b.get("hour2");
		String stations = b.get("stations");
		if(f.empty(date1))
		{
			date1 = f.today();
		}
		if(f.empty(date2))
		{
			date2 = f.today();
		}
		date1 = date1 + " "+hour1+":00:00";
		date2 = date2 + " "+hour2+":00:00";
		req.setAttribute("date1",date1);
		req.setAttribute("date2",date2);
		List stationList = ReportUtil.getStationListById(stations);
		List datalist = ReportUtil.getRealHour(stationList,req,date1,date2);
		datalist = ReportUtil.getNewDataList(datalist,req);
		List paramlist = ReportUtil.getParamListByArray(req,station_type);
		req.setAttribute("datalist",datalist);
		req.setAttribute("paramlist",paramlist);
	}
	
	public static void real_md(HttpServletRequest req) throws Exception
	{
		Map model = f.model(req);
		XBean b = new XBean(model);
		String station_type,date1,date2;
		station_type = b.get("station_type");
		String table = b.get("type");
		String bb_name = "";
		if(table.equals("real_day"))
		{
			table = "t_monitor_real_day";
			bb_name="日均值报表";
		}
		if(table.equals("real_month"))
		{
			table = "t_monitor_real_month";
			bb_name="月均值报表";
		}
		date1 = b.get("date3");
		date2 = b.get("date4");
		String stations = b.get("stations");
		if(f.empty(date1))
		{
			date1 = f.today();
		}
		if(f.empty(date2))
		{
			date2 = f.today();
		}
		req.setAttribute("date1",date1);
		req.setAttribute("date2",date2);
		date1 = date1 + " 00:00:00";
		date2 = date2 + " 23:59:59";
		List stationList = ReportUtil.getStationListById(stations);
		List datalist = ReportUtil.getRealMD(stationList,req,date1,date2,table);
		datalist = ReportUtil.getNewDataList(datalist,req);
		List paramlist = ReportUtil.getParamListByArray(req,station_type);
		req.setAttribute("datalist",datalist);
		req.setAttribute("paramlist",paramlist);
		req.setAttribute("bb_name",bb_name);
	}
	
	public static List real_state(HttpServletRequest req) throws Exception
	{
		Map model = f.model(req);
		XBean b = new XBean(model);
		String station_type,date1,date2;
		station_type = b.get("station_type");
		String stations = b.get("stations");
		String table = b.get("type");
		if(table.equals("tj_up"))
		{
			table = "1";
		}
		if(table.equals("tj_yc"))
		{
			table = "0";
		}
		date1 = b.get("date3");
		date2 = b.get("date4");
		if(f.empty(date1))
		{
			date1 = f.today();
		}
		if(f.empty(date2))
		{
			date2 = f.today();
		}
		date1 = date1 + " 00:00:00";
		date2 = date2 + " 23:59:59";
		List stationList = ReportUtil.getStationListById(stations);
		List datalist = ReportUtil.getRealState(stationList,req,date1,date2,table);
		return datalist;
	}
	
	public static void real_yc(HttpServletRequest req) throws Exception
	{
		Map model = f.model(req);
		XBean b = new XBean(model);
		String table = b.get("type");
		String station_type,date1,date2;
		station_type = b.get("station_type");
		String bb_name = "";
		if(table.equals("tj_up"))
		{
			table = "1";
			bb_name="超标统计报表";
		}
		if(table.equals("tj_yc"))
		{
			table = "0";
			bb_name="异常统计报表";
		}
		date1 = b.get("date3");
		date2 = b.get("date4");
		if(f.empty(date1))
		{
			date1 = f.today();
		}
		if(f.empty(date2))
		{
			date2 = f.today();
		}
		req.setAttribute("date1",date1);
		req.setAttribute("date2",date2);
		List list = real_state(req);
		List paramlist = ReportUtil.getParamListByArray(req,station_type);
		req.setAttribute("datalist",list);
		req.setAttribute("paramlist",paramlist);
		req.setAttribute("bb_name",bb_name);
	}
	
	public static void real_up(HttpServletRequest req) throws Exception
	{
		Map model = f.model(req);
		XBean b = new XBean(model);
		String table = b.get("type");
		String station_type,date1,date2;
		station_type = b.get("station_type");
		String bb_name = "";
		if(table.equals("tj_up"))
		{
			table = "1";
			bb_name="超标统计报表";
		}
		if(table.equals("tj_yc"))
		{
			table = "0";
			bb_name="异常统计报表";
		}
		date1 = b.get("date3");
		date2 = b.get("date4");
		if(f.empty(date1))
		{
			date1 = f.today();
		}
		if(f.empty(date2))
		{
			date2 = f.today();
		}
		req.setAttribute("date1",date1);
		req.setAttribute("date2",date2);
		List list = real_state(req);
		list = ReportUtil.getNewUpDataList(list,req);
		List paramlist = ReportUtil.getParamListByArray(req,station_type);
		req.setAttribute("datalist",list);
		req.setAttribute("paramlist",paramlist);
		req.setAttribute("bb_name",bb_name);
	}
	
	public static String getValueDisplay(String type) throws Exception
	{
		String style = "";
		if(!f.empty(type)&&(type.equals("tj_yc")||type.equals("tj_zl")||type.equals("tj_zh")))
		{
			style = "none";
		}
		else
		{
			style = "block";
		}
		return style;
	}
	
	public static void zl_tj(HttpServletRequest req) throws Exception
	{
		Map model = f.model(req);
		XBean b = new XBean(model);
		String station_type = b.get("station_type");
		List paramList = ReportUtil.getParamListByArray(req,station_type);
		String stations = b.get("stations");
		List stationList = ReportUtil.getStationListById(stations);
		String date1,date2;
		date1 = b.get("date3");
		date2 = b.get("date4");
		if(f.empty(date1))
		{
			date1 = f.today();
		}
		if(f.empty(date2))
		{
			date2 = f.today();
		}
		req.setAttribute("date1",date1);
		req.setAttribute("date2",date2);
		date1 = date1+" 00:00:00";
		date2 = date2+" 23:59:59";
		if(station_type.equals("1"))
		{
			stationList = ReportUtil.getTotalDataWS(stationList,paramList,date1,date2);
		}
		else
		{
			stationList = ReportUtil.getTotalDataYQ(stationList,paramList,date1,date2);
		}
		req.setAttribute("stationList",stationList);
		req.setAttribute("paramList",paramList);
	}
}