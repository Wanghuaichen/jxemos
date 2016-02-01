package com.hoson.util;

import java.sql.Connection;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.SortedSet;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.hoson.DBUtil;
import com.hoson.ErrorMsg;
import com.hoson.JspUtil;
import com.hoson.StringUtil;
import com.hoson.XBean;
import com.hoson.f;
import com.hoson.ww.RealDataQuery;

//20090226 中心平台升级改进

public class SwjUpdate {
	/*
	 * ! 获得重点源属性的下拉菜单值，type为选中值
	 */
	public static String getCtlTypeOption(String type) throws Exception {
		String vs = "0,1,2,3";
		String ts = "其他,市控,省控,国控";
		String s = JspUtil.getOption(vs, ts, type);
		// s = "<option value=''>\n"+s;
		return s;
	}

	/*
	 * ! 获得是否显示的下拉菜单值，flag为选中值
	 */
	public static String getShowOption(String flag) throws Exception {
		String vs = "1,0";
		String ts = "显示,不显示";
		String s = JspUtil.getOption(vs, ts, flag);
		return s;
	}

	/*
	 * ! 获得企业状态的下拉菜单值，flag为选中值
	 */
	public static String getqyStateOption(String flag) throws Exception {
		String vs = "0,1,2";
		String ts = "正常,停产,暂时停产";
		String s = JspUtil.getOption(vs, ts, flag);
		return s;
	}

	/*
	 * ! 获得审核状态的下拉菜单值，flag为选中值
	 */
	public static String getShState(String flag) throws Exception {
		String vs = "0,1";
		String ts = "原始数据,审核数据";
		String s = JspUtil.getOption(vs, ts, flag);
		return s;
	}

	/*
	 * ! 获得汇总报表类型的下拉菜单值，flag为选中值
	 */
	public static String gethzbbtype(String value) throws Exception {
		/*
		 * String vs = "area,trade,valley"; String ts = "按地区统计,按行业统计,按流域统计";
		 */
		String vs = "area,trade";
		String ts = "按地区统计,按行业统计";
		String s = JspUtil.getOption(vs, ts, value);
		return s;
	}

	/*
	 * ! 获得行业的下拉菜单值，trade_id为选中值
	 */
	public static String getTradeOption(String trade_id) throws Exception {
		String sql = "select TRADE_ID,TRACE_NAME from t_cfg_trade where parentnode = 'root' order by TRADE_ID";
		String s = null;
		s = f.getOption(sql, trade_id);
		return s;
	}

	/*
	 * ! 获得行业的下拉菜单值，trade_id为选中值,主要用于汇总报表
	 */
	public static String getHZBBTradeOption(String trade_id) throws Exception {
		String sql = "select TRADE_ID,TRACE_NAME from t_cfg_trade where parentnode = 'root' order by TRADE_ID";
		String s = null;
		s = f.getOption(sql, trade_id);
		return s;
	}

	/*
	 * ! 获得流域的下拉菜单值，valley_id为选中值
	 */
	public static String getValleyOption(String valley_id) throws Exception {
		Connection cn = null;
		try {
			cn = f.getConn();
			return JspPageUtil.getValleyOption(cn, valley_id);
		} catch (Exception e) {
			throw e;
		} finally {
			f.close(cn);
		}

	}

	/*
	 * ! 根据request值获得站位首页信息
	 */
	public static void station_index(HttpServletRequest req) throws Exception {
		Map model = f.model(req);
		XBean b = new XBean(model);
		String station_type, area_id, trade_id, valley_id, ctl_type, build_type;
		String stationTypeOption, areaOption, tradeOption, valleyOption, ctlTypeOption, buildTypeOption;
		List flist, stationList = null;
		String date1, date2, date3, hour1, hour2, hour3;
		String hour1Option, hour2Option;
		String now = f.today();
		String p_station_name = b.get("p_station_name");
		station_type = b.get("station_type");
		area_id = b.get("area_id");
		trade_id = b.get("trade_id");
		valley_id = b.get("valley_id");
		ctl_type = b.get("ctl_type");
		build_type = b.get("build_type");
		date1 = b.get("date1");
		date2 = b.get("date2");
		hour1 = b.get("hour1");
		hour2 = b.get("hour2");
		date3 = b.get("date3");
		hour3 = b.get("hour3");
		if (f.empty(station_type)) {
			station_type = f.getDefaultStationType();
		}
		if (f.empty(area_id)) {
			area_id = f.getDefaultAreaId();
		}
		if (f.empty(date1)) {
			date1 = now;
		}
		if (f.empty(date2)) {
			date2 = now;
		}
		if (f.empty(hour1)) {
			hour1 = "0";
		}
		if (f.empty(hour2)) {
			hour2 = "23";
		}

		model.put("station_type", station_type);
		model.put("area_id", area_id);
		model.put("cols", "*");
		model.put("order_cols", "station_id");
		if (!f.empty(p_station_name)) {
			model.put("station_desc", p_station_name);
		}

		stationList = f.getStationList(model, req);//
		flist = f.getInfectantList(station_type);// 查询站位类型为station_type的因子

		stationTypeOption = f.getStationTypeOption(station_type);

		// areaOption = f.getAreaOption(area_id);

		// 获得站位的地区信息
		Connection conn = null;
		areaOption = null;
		try {
			conn = DBUtil.getConn();

			areaOption = JspPageUtil.getAreaOption(conn, area_id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				DBUtil.close(conn);
				if (conn != null)
					conn.close();
				conn = null;
			}
		}

		// 获得站位的地区信息结束

		tradeOption = getTradeOption(trade_id);
		valleyOption = f.getValleyOption(valley_id);
		ctlTypeOption = getCtlTypeOption(ctl_type);
		buildTypeOption = f.getBuildTypeOption(build_type);

		hour1Option = f.getHourOption(hour1);
		hour2Option = f.getHourOption(hour2);

		req.setAttribute("date1", date1);
		req.setAttribute("date2", date2);
		req.setAttribute("station_type", station_type);

		req.setAttribute("stationTypeOption", stationTypeOption);
		req.setAttribute("areaOption", areaOption);
		req.setAttribute("tradeOption", tradeOption);
		req.setAttribute("valleyOption", valleyOption);
		req.setAttribute("ctlTypeOption", ctlTypeOption);
		req.setAttribute("hour1Option", hour1Option);
		req.setAttribute("hour2Option", hour2Option);
		req.setAttribute("buildTypeOption", buildTypeOption);

		req.setAttribute("stationList", stationList);
		req.setAttribute("flist", flist);
		req.setAttribute("p_station_name", p_station_name);

	}

	/*
	 * ! 根据request值获得站位首页信息
	 */
	public static void jdkh_index(HttpServletRequest req) throws Exception {
		Map model = f.model(req);
		XBean b = new XBean(model);
		String station_type, area_id, trade_id;
		String stationTypeOption, areaOption, tradeOption;
		String date1, date2;
		String now = f.today();
		station_type = b.get("station_type");
		area_id = b.get("area_id");
		date1 = b.get("date1");
		date2 = b.get("date2");
		trade_id = b.get("trade_id");
		if (f.empty(station_type)) {
			station_type = f.getDefaultStationType();
		}
		if (f.empty(area_id)) {
			area_id = f.getDefaultAreaId();
		}
		if (f.empty(date1)) {
			date1 = now;
		}
		if (f.empty(date2)) {
			date2 = now;
		}

		model.put("station_type", station_type);
		model.put("area_id", area_id);
		model.put("cols", "*");
		model.put("order_cols", "station_id");

		stationTypeOption = f.getStationTypeOption(station_type);

		// areaOption = f.getAreaOption(area_id);

		// 获得站位的地区信息
		Connection conn = null;
		areaOption = null;
		try {
			conn = DBUtil.getConn();
			tradeOption = getTradeOption(trade_id);
			areaOption = JspPageUtil.getAreaOption(conn, area_id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				DBUtil.close(conn);
				if (conn != null)
					conn.close();
				conn = null;
			}
		}

		// 获得站位的地区信息结束

		tradeOption = getTradeOption(trade_id);
		req.setAttribute("date1", date1);
		req.setAttribute("date2", date2);

		req.setAttribute("station_type", station_type);
		req.setAttribute("tradeOption", tradeOption);
		req.setAttribute("stationTypeOption", stationTypeOption);
		req.setAttribute("areaOption", areaOption);

	}

	public static void getWuXiao(HttpServletRequest req) throws Exception {
		String hour1 = "0";
		String hour2 = "23";
		String hour1Option = f.getHourOption(hour1);
		String hour2Option = f.getHourOption(hour2);
		req.setAttribute("hour1Option", hour1Option);
		req.setAttribute("hour2Option", hour2Option);
	}

	public static void ww_station_index(HttpServletRequest req)
			throws Exception {
		Map model = f.model(req);
		XBean b = new XBean(model);
		String station_type, area_id, trade_id, valley_id, ctl_type, build_type;
		List flist, stationList = null;
		String date1, date2, date3, hour1, hour2, hour3;
		String hour1Option, hour2Option;
		String now = f.today();
		String p_station_name = b.get("p_station_name");
		station_type = b.get("station_type");
		area_id = b.get("area_id");
		trade_id = b.get("trade_id");
		valley_id = b.get("valley_id");
		ctl_type = b.get("ctl_type");
		build_type = b.get("build_type");
		date1 = b.get("date1");
		date2 = b.get("date2");
		hour1 = b.get("hour1");
		hour2 = b.get("hour2");
		date3 = b.get("date3");
		hour3 = b.get("hour3");
		if (f.empty(station_type)) {
			station_type = f.getDefaultStationType();
		}
		if (f.empty(area_id)) {
			area_id = f.getDefaultAreaId();
		}
		if (f.empty(date1)) {
			date1 = now;
		}
		if (f.empty(date2)) {
			date2 = now;
		}
		if (f.empty(hour1)) {
			hour1 = "0";
		}
		if (f.empty(hour2)) {
			hour2 = "23";
		}

		model.put("station_type", station_type);
		model.put("area_id", area_id);
		model.put("cols", "*");
		model.put("order_cols", "station_id");
		if (!f.empty(p_station_name)) {
			model.put("station_desc", p_station_name);
		}

		stationList = RealDataQuery.getStationQuery(model, req);
		flist = f.getInfectantList(station_type);

		hour1Option = f.getHourOption(hour1);
		hour2Option = f.getHourOption(hour2);

		req.setAttribute("date1", date1);
		req.setAttribute("date2", date2);
		req.setAttribute("station_type", station_type);

		req.setAttribute("hour1Option", hour1Option);
		req.setAttribute("hour2Option", hour2Option);

		req.setAttribute("stationList", stationList);
		req.setAttribute("flist", flist);
		req.setAttribute("p_station_name", p_station_name);

	}

	/*
	 * ! 根据request值获得站位小时均值信息
	 */
	public static void his(HttpServletRequest req) throws Exception {
		String station_id, date1, date2, hour1, hour2;
		String data_table;
		Timestamp t1, t2 = null;
		List flist = null;
		int i, num = 0;
		String cols = null;
		String sql = null;
		Map m = null;

		station_id = req.getParameter("station_id");
		if (f.empty(station_id)) {
			f.error("请选择站位");
		}
		date1 = req.getParameter("date1");
		date2 = req.getParameter("date2");
		hour1 = req.getParameter("hour1");
		hour2 = req.getParameter("hour2");

		data_table = req.getParameter("data_table");

		String station_type = req.getParameter("station_type");
		// flist = f.getInfectantListByStationId(station_id); //MF修改 
		flist = f.getInfectantListByStationIdAndType(station_id, station_type);
		num = flist.size();
		if (num < 1) {
			f.error("请配置监测指标");
		}

		if (f.eq(data_table, "t_monitor_real_hour")
				|| f.eq(data_table, "t_monitor_real_hour_v")) {
			t1 = f.time(date1 + " " + hour1 + ":0:0");
			t2 = f.time(date2 + " " + hour2 + ":59:59");
		} else {
			t1 = f.time(date1);
			t2 = f.time(date2);
		}
		cols = getCols(flist);
		if (f.eq(data_table, "t_monitor_real_hour_v")) {
			// sql =
			// "select distinct station_id,m_time,v_desc,v_flag,operator,"+cols+" from "+data_table;
			sql = "select distinct station_id,m_time,v_desc,v_flag,operator,operator2,"
					+ cols + " from " + data_table;
		} else {
			sql = "select distinct station_id,m_time," + cols + " from "
					+ data_table;
		}
		sql = sql + " where station_id=? and m_time>=? and m_time<=?";
		sql = sql + " order by m_time desc ";

		Object[] p = new Object[] { station_id, t1, t2 };
		m = f.query(sql, p, req);

		List datalist = (List) m.get("data");
		List data = new ArrayList();
		for (int k = 0; k < datalist.size(); k++) {
			Map mp = (Map) datalist.get(k);
			XBean b = new XBean(mp);
			String val04 = b.get("VAL04");
			String val14 = b.get("VAL14");
			val04 = val04 + val14;
			mp.put("VAL04", val04);
			data.add(mp);
		}

		req.setAttribute("flist", flist);
		req.setAttribute("data", data);
		req.setAttribute("bar", m.get("bar"));
		req.setAttribute("sql", sql);
		req.setAttribute("t1", t1);
		req.setAttribute("t2", t2);

	}

	/*
	 * ! 系统监测点管理的数据、曲线使用
	 */
	public static void his_station(HttpServletRequest req) throws Exception {
		String station_id, date1, date2, hour1, hour2;
		String data_table;
		Timestamp t1, t2 = null;
		List flist = null;
		int i, num = 0;
		String cols = null;
		String sql = null;
		Map m = null;

		station_id = req.getParameter("station_id");
		if (f.empty(station_id)) {
			f.error("请选择站位");
		}
		date1 = req.getParameter("date1");
		date2 = req.getParameter("date2");
		hour1 = req.getParameter("hour1");
		hour2 = req.getParameter("hour2");

		data_table = req.getParameter("data_table");

		String sh_flag = req.getParameter("sh_flag_select");

		if (!"".equals(sh_flag) && sh_flag.equals("1")) {
			data_table = data_table + "_v";
		}

		flist = f.getInfectantListByStationId(station_id);
		num = flist.size();
		if (num < 1) {
			f.error("请配置监测指标");
		}

		if (f.eq(data_table, "t_monitor_real_hour")
				|| f.eq(data_table, "t_monitor_real_hour_v")
				|| f.eq(data_table, "T_MONITOR_REAL_TEN_MINUTE")
				|| f.eq(data_table, "T_MONITOR_REAL_TEN_MINUTE_v")) {
			t1 = f.time(date1 + " " + hour1 + ":0:0");
			t2 = f.time(date2 + " " + hour2 + ":59:59");
		} else {
			t1 = f.time(date1);
			t2 = f.time(date2);
		}
		cols = getCols(flist);
		if (f.eq(data_table, "t_monitor_real_hour_v")) {
			// sql =
			// "select distinct station_id,m_time,v_desc,v_flag,operator,"+cols+" from "+data_table;
			sql = "select distinct station_id,m_time,v_desc,v_flag,operator,"
					+ cols + " from " + data_table;
		} else {
			sql = "select distinct station_id,m_time," + cols + " from "
					+ data_table;
		}
		sql = sql + " where station_id=? and m_time>=? and m_time<=?";
		sql = sql + " order by m_time desc ";

		Object[] p = new Object[] { station_id, t1, t2 };
		m = f.query(sql, p, req);

		List datalist = (List) m.get("data");
		List data = new ArrayList();
		for (int k = 0; k < datalist.size(); k++) {
			Map mp = (Map) datalist.get(k);
			XBean b = new XBean(mp);
			String val04 = b.get("VAL04");
			String val14 = b.get("VAL14");
			val04 = val04 + val14;
			mp.put("VAL04", val04);
			data.add(mp);
		}

		req.setAttribute("flist", flist);
		req.setAttribute("data", data);
		req.setAttribute("bar", m.get("bar"));
		req.setAttribute("sql", sql);
		req.setAttribute("t1", t1);
		req.setAttribute("t2", t2);

	}

	public static void getShData(HttpServletRequest req) throws Exception {
		String station_id;
		String data_table;
		Timestamp t1 = null;
		List flist = null;
		int i, num = 0;
		String cols = null;
		String sql = null;
		Map m = null;

		station_id = req.getParameter("station_id");
		if (f.empty(station_id)) {
			f.error("请选择站位");
		}
		t1 = f.time(req.getParameter("m_time").toString());

		data_table = req.getParameter("data_table");
		String v_flag = req.getParameter("v_flag");

		flist = f.getInfectantListByStationId(station_id);
		num = flist.size();
		if (num < 1) {
			f.error("请配置监测指标");
		}

		cols = getCols(flist);
		sql = "select station_id,m_time,v_desc," + cols + " from " + data_table;
		sql = sql + " where station_id=? and m_time=? and v_flag=? ";
		sql = sql + " order by m_time desc ";

		Object[] p = new Object[] { station_id, t1, v_flag };
		m = f.query(sql, p, req);

		List datalist = (List) m.get("data");
		List data = new ArrayList();
		for (int k = 0; k < datalist.size(); k++) {
			Map mp = (Map) datalist.get(k);
			XBean b = new XBean(mp);
			String val04 = b.get("VAL04");
			String val14 = b.get("VAL14");
			val04 = val04 + val14;
			mp.put("VAL04", val04);
			data.add(mp);
		}
		Map model = f.model(req);
		XBean b = new XBean(model);
		String date1, date2, hour1, hour2;
		date1 = b.get("date1");
		date2 = b.get("date2");
		hour1 = b.get("hour1");
		hour2 = b.get("hour2");
		String now = f.today();
		if (f.empty(date1)) {
			date1 = now;
		}
		if (f.empty(date2)) {
			date2 = now;
		}
		if (f.empty(hour1)) {
			hour1 = "0";
		}
		if (f.empty(hour2)) {
			hour2 = "23";
		}
		String hour1Option = f.getHourOption(hour1);
		String hour2Option = f.getHourOption(hour2);

		req.setAttribute("date1", date1);
		req.setAttribute("date2", date2);
		req.setAttribute("hour1Option", hour1Option);
		req.setAttribute("hour2Option", hour2Option);
		req.setAttribute("flist", flist);
		req.setAttribute("data", data);

	}

	/*
	 * public static void getBulu(HttpServletRequest req)throws Exception{
	 * String station_id; // String data_table; // Timestamp t1 = null; List
	 * flist = null; int i,num=0; String cols = null; // String sql = null; //
	 * Map m = null;
	 * 
	 * station_id = req.getParameter("station_id");
	 * if(f.empty(station_id)){f.error("请选择站位");} // t1 =
	 * f.time(req.getParameter("m_time").toString());
	 * 
	 * // data_table = req.getParameter("data_table");
	 * 
	 * flist = f.getInfectantListByStationId(station_id); num = flist.size();
	 * if(num<1){f.error("请配置监测指标");}
	 * 
	 * cols=getCols(flist); // sql =
	 * "select station_id,m_time,v_desc,"+cols+" from "+data_table; //
	 * sql=sql+" where station_id=? and m_time=? "; //
	 * sql=sql+" order by m_time desc "; // // Object[]p = new
	 * Object[]{station_id,t1}; // m = f.query(sql,p,req); // // List datalist =
	 * (List)m.get("data"); // List data = new ArrayList(); // for(int
	 * k=0;k<datalist.size();k++) // { // Map mp = (Map)datalist.get(k); //
	 * XBean b = new XBean(mp); // String val04 = b.get("VAL04"); // String
	 * val14 = b.get("VAL14"); // val04 = val04+val14; // mp.put("VAL04",val04);
	 * // data.add(mp); // } Map model = f.model(req); XBean b = new
	 * XBean(model); String date1,date2,hour1,hour2; date1 = b.get("date1");
	 * date2 = b.get("date2"); hour1 = b.get("hour1"); hour2 = b.get("hour2");
	 * String now = f.today(); if(f.empty(date1)){date1 = now;}
	 * if(f.empty(date2)){date2 = now;} if(f.empty(hour1)){hour1 = "0";}
	 * if(f.empty(hour2)){hour2 = "23";} Timestamp t1 =
	 * f.time(date1+" "+hour1+":0:0"); Timestamp t2 =
	 * f.time(date2+" "+hour2+":59:59"); f.dateAdd(t1, "hour", 1);
	 * 
	 * // 数据库时间 String sql = "select m_time from t_monitor_real_hour_v";
	 * sql=sql+" where station_id=? and m_time>=? and m_time<=? ";//黄宝修改
	 * //sql=sql+
	 * " where station_id=? and m_time>=? and m_time<=? and (v_flag =6 or v_flag =7 or v_flag =8)"
	 * ; sql=sql+" order by m_time desc ";
	 * 
	 * Object[]p = new Object[]{station_id,t1,t2};
	 * 
	 * List datalist = f.query(sql,p);//查询已经存在的时间 String s = ""; for(int
	 * k=0;k<datalist.size();k++) { Map mp = (Map)datalist.get(k); XBean b1 =
	 * new XBean(mp); String m_time = b1.get("m_time"); s = s+m_time+","; }
	 * 
	 * //选择的时间 String dateOption = ""; int numHour =
	 * (int)((t2.getTime()-t1.getTime())/1000+1)/60/60; for(int
	 * m=0;m<numHour;m++){ String t = f.dateAdd(t1, "hour", m).toString();
	 * if(s.indexOf(t)==-1){
	 * dateOption=dateOption+"<option value='"+t+"'>"+t+"</option>\n"; }
	 * }//只补录不存在的数据,有时间段的数据，不能补录
	 * 
	 * 
	 * String hour1Option = f.getHourOption(hour1); String hour2Option =
	 * f.getHourOption(hour2);
	 * 
	 * req.setAttribute("date1",date1); req.setAttribute("date2",date2);
	 * req.setAttribute("hour1Option",hour1Option);
	 * req.setAttribute("hour2Option",hour2Option);
	 * req.setAttribute("flist",flist);
	 * req.setAttribute("dateOption",dateOption);
	 * 
	 * }
	 */

	public static void getBulu(HttpServletRequest req) throws Exception {
		String station_id;
		// String data_table;
		// Timestamp t1 = null;
		List flist = null;
		int i, num = 0;
		String cols = null;
		// String sql = null;
		// Map m = null;

		station_id = req.getParameter("station_id");
		if (f.empty(station_id)) {
			f.error("请选择站位");
		}
		// t1 = f.time(req.getParameter("m_time").toString());

		// data_table = req.getParameter("data_table");
		String station_type = req.getParameter("station_type");
		// flist = f.getInfectantListByStationId(station_id);
		flist = f.getInfectantListByStationIdAndType(station_id, station_type);
		num = flist.size();
		if (num < 1) {
			f.error("请配置监测指标");
		}

		cols = getCols(flist);
		// sql = "select station_id,m_time,v_desc,"+cols+" from "+data_table;
		// sql=sql+" where station_id=? and m_time=? ";
		// sql=sql+" order by m_time desc ";
		//
		// Object[]p = new Object[]{station_id,t1};
		// m = f.query(sql,p,req);
		//
		// List datalist = (List)m.get("data");
		// List data = new ArrayList();
		// for(int k=0;k<datalist.size();k++)
		// {
		// Map mp = (Map)datalist.get(k);
		// XBean b = new XBean(mp);
		// String val04 = b.get("VAL04");
		// String val14 = b.get("VAL14");
		// val04 = val04+val14;
		// mp.put("VAL04",val04);
		// data.add(mp);
		// }
		Map model = f.model(req);
		XBean b = new XBean(model);
		String date1, date2, hour1, hour2;
		date1 = b.get("date1");
		date2 = b.get("date2");
		hour1 = b.get("hour1");
		hour2 = b.get("hour2");

		String hour1Option = f.getHourOption(0);
		String hour2Option = f.getHourOption(23);

		req.setAttribute("date1", date1);
		req.setAttribute("hour1Option", hour1Option);
		req.setAttribute("hour2Option", hour2Option);
		req.setAttribute("flist", flist);

	}

	/*
	 * ! 根据request值获得站位实时数据信息
	 */
	public static void real(HttpServletRequest req) throws Exception {
		String station_id, date3, hour3;

		Timestamp t1, t2 = null;
		List flist = null;
		int i, num = 0;
		String cols = null;
		String sql = null;
		Map m = null;
		List datalist = null;

		station_id = req.getParameter("station_id");
		if (f.empty(station_id)) {
			f.error("请选择站位");
		}
		date3 = req.getParameter("date3");
		hour3 = req.getParameter("hour3");
		flist = f.getInfectantListByStationId(station_id);
		num = flist.size();
		if (num < 1) {
			f.error("请配置监测指标");
		}

		t1 = f.time(date3);
		t2 = f.time(date3 + " " + hour3 + ":59:59");

		sql = "select infectant_id,m_time,m_value from t_monitor_real_minute ";
		sql = sql + " where station_id=? ";
		sql = sql + " and m_time>=? ";
		sql = sql + " and m_time<=? ";
		sql = sql + " order by m_time desc ";

		datalist = f.query(sql, new Object[] { station_id, t1, t2 });

		datalist = getRealDataList(datalist);

		req.setAttribute("flist", flist);
		req.setAttribute("data", datalist);
		req.setAttribute("sql", sql);
		req.setAttribute("t1", t1);
		req.setAttribute("t2", t2);

	}

	/*
	 * ! 根据request值获得站位十分钟数据信息
	 */
	public static void real_ten(HttpServletRequest req) throws Exception {
		String station_id, date3, hour3;

		Timestamp t1, t2 = null;
		List flist = null;
		int i, num = 0;
		String cols = null;
		String sql = null;
		Map m = null;
		List datalist = null;

		station_id = req.getParameter("station_id");
		if (f.empty(station_id)) {
			f.error("请选择站位");
		}
		date3 = req.getParameter("date3");
		hour3 = req.getParameter("hour3");
		flist = f.getInfectantListByStationId(station_id);
		num = flist.size();
		if (num < 1) {
			f.error("请配置监测指标");
		}

		t1 = f.time(date3);
		t2 = f.time(date3 + " " + hour3 + ":59:59");

		sql = "select infectant_id,m_time,m_value from t_monitor_real_minute_sh ";
		sql = sql + " where station_id=? ";
		sql = sql + " and m_time>=? ";
		sql = sql + " and m_time<=? ";
		sql = sql + " order by m_time desc ";

		datalist = f.query(sql, new Object[] { station_id, t1, t2 });

		datalist = getRealDataList(datalist);

		req.setAttribute("flist", flist);
		req.setAttribute("data", datalist);
		req.setAttribute("sql", sql);
		req.setAttribute("t1", t1);
		req.setAttribute("t2", t2);

	}

	/*
	 * ! 根据request值获得站位信息
	 */
	public static void data(HttpServletRequest req) throws Exception {
		String station_id;
		String data_table;
		String sh_flag;
		String url = "his.jsp";
		String url_real = "real.jsp";
		String url_real_ten = "real_ten.jsp";
		String s = "station_id,data_table,date1,date2,date3,hour1,hour2,hour3";

		station_id = req.getParameter("station_id");
		String date1, date2, hour1, hour2;
		date1 = req.getParameter("date1");
		date2 = req.getParameter("date2");
		hour1 = req.getParameter("hour1");
		hour2 = req.getParameter("hour2");

		if (f.empty(station_id)) {
			f.error("请选择站位");
		}
		data_table = req.getParameter("data_table");
		if (f.eq(data_table, "t_monitor_real_minute")) {
			url = url_real;
		} else if (f.eq(data_table, "t_monitor_real_minute_sh")) {
			url = url_real_ten;
		}
		sh_flag = req.getParameter("sh_flag_select");
		url = url + "?station_id=" + station_id + "&date1=" + date1 + "&date2="
				+ date2 + "&hour1=" + hour1 + "&hour2=" + hour2
				+ "&data_table=" + data_table + "&sh_flag=" + sh_flag;
		s = f.hide(s, req);
		req.setAttribute("url", url);
		req.setAttribute("s", s);
	}

	public static void view(HttpServletRequest req) throws Exception {
		String station_id = null;
		String sql = null;
		Map m = null;
		String tradeOption, areaOption, valleyOption, showOption, ctlTypeOption, qyStateOption = null;
		XBean b = null;
		String s = null;

		station_id = f.p(req, "station_id");
		if (f.empty(station_id)) {
			f.error("station_id为空");
		}
		sql = "select * from t_cfg_station_info where station_id=?";
		m = f.queryOne(sql, new Object[] { station_id });
		if (m == null) {
			f.error("记录不存在");
		}
		b = new XBean(m);
		s = b.get("trade_id");

		tradeOption = getTradeOption(s);
		s = b.get("area_id");
		// areaOption = JspPageUtil.getAreaOption(s);
		areaOption = f.getAreaOption(s);
		s = b.get("valley_id");
		valleyOption = getValleyOption(s);
		s = b.get("show_flag");
		showOption = getShowOption(s);
		s = b.get("qy_state");
		qyStateOption = getqyStateOption(s);
		s = b.get("ctl_type");
		ctlTypeOption = getCtlTypeOption(s);
		req.setAttribute("data", m);
		req.setAttribute("tradeOption", tradeOption);
		req.setAttribute("areaOption", areaOption);
		req.setAttribute("valleyOption", valleyOption);
		req.setAttribute("showOption", showOption);
		req.setAttribute("ctlTypeOption", ctlTypeOption);
		req.setAttribute("qyStateOption", qyStateOption);

	}

	/*
	 * ! 根据request值获得站位信息
	 */
	public static void ww_data(HttpServletRequest req) throws Exception {
		String station_id;
		String data_table;
		String url = "ww_his.jsp";
		String url_real = "ww_real.jsp";
		String url_real_ten = "ww_real_ten.jsp";
		String s = "station_id,data_table,date1,date2,date3,hour1,hour2,hour3";

		station_id = req.getParameter("station_id");

		if (f.empty(station_id)) {
			f.error("请选择站位");
		}
		data_table = req.getParameter("data_table");
		if (f.eq(data_table, "t_monitor_real_minute")) {
			url = url_real;
		} else if (f.eq(data_table, "t_monitor_real_minute_sh")) {
			url = url_real_ten;
		}
		s = f.hide(s, req);
		req.setAttribute("url", url);
		req.setAttribute("s", s);
	}

	/*
	 * ! 根据flist值获得因子信息
	 */
	public static String getCols(List flist) throws Exception {
		String cols = "";
		int i, num = 0;
		Map m = null;
		String col = null;

		num = flist.size();
		for (i = 0; i < num; i++) {
			m = (Map) flist.get(i);
			col = (String) m.get("infectant_column");
			if (f.empty(col)) {
				f.error("infectant_column为空");
			}
			if (i > 0) {
				cols = cols + ",";
			}
			cols = cols + col;
		}
		return cols;
	}

	/*
	 * ! 根据list值返回实时数据集合list
	 */
	public static List getRealDataList(List list) throws Exception {
		List list2 = new ArrayList();
		Map dataMap = new HashMap();
		Map m = null;
		String m_time, id, m_value;
		Map row = null;
		List timeList = new ArrayList();

		int i, num = 0;
		num = list.size();
		for (i = 0; i < num; i++) {
			m = (Map) list.get(i);
			m_time = (String) m.get("m_time");
			id = (String) m.get("infectant_id");
			m_value = (String) m.get("m_value");
			if (f.empty(m_value)) {
				continue;
			}
			row = (Map) dataMap.get(m_time);
			if (row == null) {
				row = new HashMap();
				dataMap.put(m_time, row);
				row.put("m_time", m_time);
				timeList.add(m_time);
			}
			row.put(id, m_value);
		}
		num = timeList.size();
		for (i = 0; i < num; i++) {
			m_time = (String) timeList.get(i);
			row = (Map) dataMap.get(m_time);
			if (row == null) {
				continue;
			}
			list2.add(row);
		}
		return list2;
	}

	/*
	 * ! 根据request值返回一个站位的首页信息
	 */
	public static void station_one_index(HttpServletRequest req)
			throws Exception {
		Map model = f.model(req);
		XBean b = new XBean(model);
		String station_id, station_type, station_desc = null;
		List flist = null;
		Map m = null;
		String sql = null;

		String date1, date2, date3, hour1, hour2, hour3;
		String hour1Option, hour2Option, hour3Option;
		String now = f.today();
		String EntName = null;

		station_id = b.get("station_id");
		EntName = b.get("EntName");

		if (!f.empty(EntName)) {
			station_id = getStationIdByName(EntName);
		}

		if (f.empty(station_id)) {
			f.error("请选择站位");
		}

		date1 = b.get("date1");
		date2 = b.get("date2");
		hour1 = b.get("hour1");
		hour2 = b.get("hour2");
		date3 = b.get("date3");
		hour3 = b.get("hour3");

		if (f.empty(date1)) {
			date1 = now;
		}
		if (f.empty(date2)) {
			date2 = now;
		}
		if (f.empty(hour1)) {
			hour1 = "0";
		}
		if (f.empty(hour2)) {
			hour2 = "23";
		}

		sql = "select * from t_cfg_station_info where station_id=?";
		m = f.queryOne(sql, new Object[] { station_id });
		if (m == null) {
			f.error("记录不存在");
		}
		b = new XBean(m);
		station_type = b.get("station_type");
		station_desc = b.get("station_desc");

		flist = f.getInfectantListByStationId(station_id);

		hour1Option = f.getHourOption(hour1);
		hour2Option = f.getHourOption(hour2);

		req.setAttribute("date1", date1);
		req.setAttribute("date2", date2);
		req.setAttribute("station_type", station_type);

		req.setAttribute("hour1Option", hour1Option);
		req.setAttribute("hour2Option", hour2Option);

		req.setAttribute("flist", flist);
		req.setAttribute("station_type", station_type);
		req.setAttribute("station_id", station_id);
		req.setAttribute("station_desc", station_desc);
	}

	/*
	 * ! 根据request值返回实时数据值，并把值传到request
	 */
	public static void real_data(HttpServletRequest req) throws Exception {
		List flist, stationList;
		Map dataMap = null;
		Map model = f.model(req);
		String station_type = null;
		int i, num, fnum = 0;
		Map row = null;
		String station_id = null;
		Map m = null;
		String state = "";// 站位的状态类型

		station_type = (String) model.get("station_type");
		if (f.empty(station_type)) {
			f.error("请选择监测类型");
		}

		state = (String) model.get("state");

		dataMap = CacheUtil.getRealDataMapNew();

		model.put("cols", "station_id,station_desc,station_bz,link_surface");
		model.put("order_cols", "area_id,station_desc");

		stationList = f.getStationList(model, req);
		flist = f.getInfectantList(station_type);// 查询站位类型为station_type的因子
		flist = getInfectantList(flist, req.getParameterValues("infectant_id"));
		fnum = flist.size();

		if (fnum < 1) {
			f.error("请配置监测指标");
		}
		num = stationList.size();
		for (i = 0; i < num; i++) {
			row = (Map) stationList.get(i);
			station_id = (String) row.get("station_id");
			m = (Map) dataMap.get(station_id);
			if (m == null) {
				continue;
			}
			row.putAll(m);
		}
		m = getStationMonitorParam(model, req);
		req.setAttribute("flist", flist);
		req.setAttribute("list", stationList);
		req.setAttribute("m", m);
	}

	/*
	 * ! 根据request获得选中的实时数据值
	 */
	public static void select_real(HttpServletRequest req) throws Exception {
		List flist, stationList;
		Map dataMap = null;
		Map model = f.model(req);
		String station_type = null;
		int i, num, fnum = 0;
		Map row = null;
		String station_id = null;
		Map m = null;

		String station_ids = req.getParameter("station_ids");
		String[] arr = null;
		if (!StringUtil.isempty(station_ids)) {
			if (station_ids.indexOf(",") >= 0) {
				arr = station_ids.split(",");
			} else {
				arr = station_ids.split(";");
			}
		}

		station_type = (String) model.get("station_type");
		if (f.empty(station_type)) {
			f.error("请选择监测类型");
		}

		dataMap = CacheUtil.getRealDataMapNew();

		model.put("cols", "station_id,station_desc,station_bz,link_surface");
		model.put("order_cols", "area_id,station_desc");

		stationList = f.getStationList(model, req);
		flist = f.getInfectantList(station_type);
		flist = getInfectantList(flist, req.getParameterValues("infectant_id"));
		fnum = flist.size();

		if (fnum < 1) {
			f.error("请配置监测指标");
		}
		num = stationList.size();
		for (i = 0; i < num; i++) {
			row = (Map) stationList.get(i);
			station_id = (String) row.get("station_id");
			m = (Map) dataMap.get(station_id);
			if (m == null) {
				continue;
			}
			row.putAll(m);
		}
		m = getStationMonitorParam(model, req);
		req.setAttribute("flist", flist);
		req.setAttribute("list", stationList);
		req.setAttribute("m", m);
	}

	/*
	 * ! 根据request获得时均值数据
	 */
	public static void real_hour(HttpServletRequest req) throws Exception {
		List flist, stationList;
		Map dataMap = null;
		Map model = f.model(req);
		String station_type = null;
		int i, num, fnum = 0;
		Map row = null;
		String station_id = null;
		Map m = null;
		station_type = (String) model.get("station_type");
		if (f.empty(station_type)) {
			f.error("请选择监测类型");
		}

		dataMap = CacheUtil.getRealHourDataMap();

		model.put("cols", "station_id,station_desc,station_bz,link_surface");
		model.put("order_cols", "area_id,station_desc");

		stationList = f.getStationList(model, req);
		flist = f.getInfectantList(station_type);
		flist = getInfectantList(flist, req.getParameterValues("infectant_id"));
		fnum = flist.size();

		if (fnum < 1) {
			f.error("请配置监测指标");
		}
		num = stationList.size();
		for (i = 0; i < num; i++) {
			row = (Map) stationList.get(i);
			station_id = (String) row.get("station_id");
			m = (Map) dataMap.get(station_id);
			if (m == null) {
				continue;
			}
			row.putAll(m);
		}
		m = getStationMonitorParam(model, req);
		req.setAttribute("flist", flist);
		req.setAttribute("list", stationList);
		req.setAttribute("m", m);
	}

	/*
	 * ! 将集合m的col值传给moniterParam集合
	 */
	public static void getMonitorParam(Map monitorParam, Map m, String col) {
		if (m == null) {
			return;
		}
		if (f.empty(col)) {
			return;
		}
		String s = null;
		double v = 0;
		s = (String) m.get(col);
		if (f.empty(s)) {
			return;
		}
		v = f.getDouble(s, 0);
		if (v != 0) {
			monitorParam.put(col, new Double(v));
		}
	}

	/*
	 * ! 获得站位的监测数据
	 */
	public static Map getStationMonitorParam(Map params, HttpServletRequest req)
			throws Exception {
		Map map = new HashMap();
		String sql = null;
		String station_type, area_id, valley_id, station_desc = null;
		XBean b = new XBean(params);
		String ctl_type = null;
		String trade_id = null;
		List list = null;
		int i, num = 0;
		Map m, m2 = null;
		String station_id, infectant_id, infectant_column;
		String s = null;
		double v = 0;
		String key = null;

		station_type = b.get("station_type");
		area_id = b.get("area_id");
		valley_id = b.get("valley_id");
		trade_id = b.get("trade_id");
		station_desc = b.get("station_desc");
		ctl_type = b.get("ctl_type");

		sql = "select station_id,infectant_id,infectant_column,lo,lolo,hi,hihi from t_cfg_monitor_param where station_id in(";
		sql = sql + "select station_id from t_cfg_station_info where 2>1 ";
		if (!StringUtil.isempty(station_type)) {
			sql = sql + " and station_type = '" + station_type + "' ";
		}
		if (!StringUtil.isempty(area_id)) {
			sql = sql + " and area_id like '" + area_id + "%' ";
		}
		if (!StringUtil.isempty(valley_id)) {
			sql = sql + " and valley_id like '" + valley_id + "%' ";
		}
		if (!StringUtil.isempty(trade_id)) {
			sql = sql + " and trade_id = '" + trade_id + "' ";
		}
		if (!StringUtil.isempty(station_desc)) {
			sql = sql + " and station_desc like '%" + station_desc + "%' ";
		}
		if (!StringUtil.isempty(ctl_type)) {
			sql = sql + " and ctl_type ='" + ctl_type + "' ";
		}
		sql = sql
				+ DataAclUtil.getStationIdInString(req, station_type,
						"station_id");
		sql = sql + ")";
		list = f.query(sql, null);
		num = list.size();
		for (i = 0; i < num; i++) {
			m = (Map) list.get(i);
			station_id = (String) m.get("station_id");
			if (f.empty(station_id)) {
				continue;
			}
			infectant_id = (String) m.get("infectant_id");
			if (f.empty(infectant_id)) {
				continue;
			}
			infectant_column = (String) m.get("infectant_column");
			if (f.empty(infectant_column)) {
				continue;
			}
			infectant_column = infectant_column.toLowerCase();

			m2 = new HashMap();

			getMonitorParam(m2, m, "lo");// 将集合m的col值传给moniterParam集合
			getMonitorParam(m2, m, "lolo");
			getMonitorParam(m2, m, "hi");
			getMonitorParam(m2, m, "hihi");
			key = station_id + "_" + infectant_id;
			map.put(key, m2);
			key = station_id + "_" + infectant_column;
			map.put(key, m2);
		}
		return map;
	}

	/*
	 * ! 根据request获得小时均值的站位信息，并传到request中
	 */
	public static void offline(HttpServletRequest req) throws Exception {
		List stationList;
		Map dataMap = null;
		Map model = f.model(req);
		String station_type = null;
		int i, num, fnum = 0;
		Map row = null;
		String station_id = null;
		Map m = null;
		List yclist = new ArrayList();

		station_type = (String) model.get("station_type");
		if (f.empty(station_type)) {
			f.error("请选择监测类型");
		}

		dataMap = CacheUtil.getRealHourDataMap();

		model.put("cols", "station_id,station_desc,station_bz,link_surface");
		model.put("order_cols", "area_id,station_desc");

		stationList = f.getStationList(model, req);
		num = stationList.size();
		for (i = 0; i < num; i++) {
			row = (Map) stationList.get(i);
			station_id = (String) row.get("station_id");
			m = (Map) dataMap.get(station_id);
			if (m == null) {
				yclist.add(row);
			}
		}
		req.setAttribute("list", yclist);
	}

	/*
	 * ! 根据request获得报表信息，并传到request中
	 */
	public static void report_sj_index(HttpServletRequest req) throws Exception {
		Map model = f.model(req);
		XBean b = new XBean(model);
		String station_type, area_id, trade_id, valley_id, ctl_type;
		String stationTypeOption, areaOption, tradeOption, valleyOption, ctlTypeOption;
		List flist, stationList = null;
		String date1, date2, date3, hour1, hour2, hour3;
		String hour1Option, hour2Option;
		String now = f.today();
		String p_station_name = b.get("p_station_name");

		station_type = b.get("station_type");
		area_id = b.get("area_id");
		trade_id = b.get("trade_id");
		valley_id = b.get("valley_id");
		ctl_type = b.get("ctl_type");

		date1 = b.get("date1");
		date2 = b.get("date2");
		hour1 = b.get("hour1");
		hour2 = b.get("hour2");
		date3 = b.get("date3");
		hour3 = b.get("hour3");

		if (f.empty(station_type)) {
			station_type = "1";
		}
		if (f.empty(area_id)) {
			area_id = f.getDefaultAreaId();
		}

		if (f.empty(date1)) {
			date1 = now;
		}
		if (f.empty(date2)) {
			date2 = now;
		}
		if (f.empty(hour1)) {
			hour1 = "0";
		}
		if (f.empty(hour2)) {
			hour2 = "23";
		}

		model.put("station_type", station_type);
		model.put("area_id", area_id);
		model.put("cols", "*");
		model.put("order_cols", "station_no,area_id,station_desc");
		if (!f.empty(p_station_name)) {
			model.put("station_desc", p_station_name);
		}

		stationList = f.getStationList(model, req);
		flist = f.getInfectantList(station_type);

		stationTypeOption = f.getOption("1,2", "污染源污水,污染源烟气", station_type);
		areaOption = f.getAreaOption(area_id);
		tradeOption = getTradeOption(trade_id);
		valleyOption = f.getValleyOption(valley_id);
		ctlTypeOption = getCtlTypeOption(ctl_type);

		hour1Option = f.getHourOption(hour1);
		hour2Option = f.getHourOption(hour2);

		req.setAttribute("date1", date1);
		req.setAttribute("date2", date2);
		req.setAttribute("station_type", station_type);

		req.setAttribute("stationTypeOption", stationTypeOption);
		req.setAttribute("areaOption", areaOption);
		req.setAttribute("tradeOption", tradeOption);
		req.setAttribute("valleyOption", valleyOption);
		req.setAttribute("ctlTypeOption", ctlTypeOption);
		req.setAttribute("hour1Option", hour1Option);
		req.setAttribute("hour2Option", hour2Option);

		req.setAttribute("stationList", stationList);
		req.setAttribute("flist", flist);
		req.setAttribute("p_station_name", p_station_name);

	}

	/*
	 * 自定义烟气报表使用
	 * 
	 * @param req
	 * 
	 * @throws Exception
	 */
	public static void report_sj_index2(HttpServletRequest req)
			throws Exception {
		Map model = f.model(req);
		XBean b = new XBean(model);
		String station_type, area_id, trade_id, valley_id, ctl_type;
		String stationTypeOption, areaOption, tradeOption, valleyOption, ctlTypeOption;
		List flist, stationList = null;
		String date1, date2, date3, hour1, hour2, hour3;
		String hour1Option, hour2Option;
		String now = f.today();
		String p_station_name = b.get("p_station_name");

		station_type = b.get("station_type");
		area_id = b.get("area_id");
		trade_id = b.get("trade_id");
		valley_id = b.get("valley_id");
		ctl_type = b.get("ctl_type");

		date1 = b.get("date1");
		date2 = b.get("date2");
		hour1 = b.get("hour1");
		hour2 = b.get("hour2");
		date3 = b.get("date3");
		hour3 = b.get("hour3");

		if (f.empty(station_type)) {
			station_type = "2";
		}
		if (f.empty(area_id)) {
			area_id = f.getDefaultAreaId();
		}

		if (f.empty(date1)) {
			date1 = now;
		}
		if (f.empty(date2)) {
			date2 = now;
		}
		if (f.empty(hour1)) {
			hour1 = "0";
		}
		if (f.empty(hour2)) {
			hour2 = "23";
		}

		model.put("station_type", station_type);
		model.put("area_id", area_id);
		model.put("cols", "*");
		model.put("order_cols", "station_no,area_id,station_desc");
		if (!f.empty(p_station_name)) {
			model.put("station_desc", p_station_name);
		}

		stationList = f.getStationList(model, req);
		flist = f.getInfectantList(station_type);

		stationTypeOption = f.getOption("1,2", "污染源污水,污染源烟气", station_type);
		areaOption = f.getAreaOption(area_id);
		tradeOption = getTradeOption(trade_id);
		valleyOption = f.getValleyOption(valley_id);
		ctlTypeOption = getCtlTypeOption(ctl_type);

		hour1Option = f.getHourOption(hour1);
		hour2Option = f.getHourOption(hour2);

		req.setAttribute("date1", date1);
		req.setAttribute("date2", date2);
		req.setAttribute("station_type", station_type);

		req.setAttribute("stationTypeOption", stationTypeOption);
		req.setAttribute("areaOption", areaOption);
		req.setAttribute("tradeOption", tradeOption);
		req.setAttribute("valleyOption", valleyOption);
		req.setAttribute("ctlTypeOption", ctlTypeOption);
		req.setAttribute("hour1Option", hour1Option);
		req.setAttribute("hour2Option", hour2Option);

		req.setAttribute("stationList", stationList);
		req.setAttribute("flist", flist);
		req.setAttribute("p_station_name", p_station_name);

	}

	/*
	 * ! 根据request获得汇总报表信息，并传到request中
	 */
	public static void report_cm_index(HttpServletRequest req) throws Exception {
		Map model = f.model(req);
		XBean b = new XBean(model);
		String station_type, area_id, trade_id, valley_id;
		String stationTypeOption, areaOption, tradeOption, valleyOption;

		String date1, date2;

		String now = f.today();

		station_type = b.get("station_type");
		area_id = b.get("area_id");
		trade_id = b.get("trade_id");
		valley_id = b.get("valley_id");

		date1 = b.get("date1");
		date2 = b.get("date2");

		if (f.empty(station_type)) {
			station_type = "1";
		}
		if (f.empty(area_id)) {
			area_id = f.getDefaultAreaId();
		}

		if (f.empty(date1)) {
			date1 = now;
		}
		if (f.empty(date2)) {
			date2 = now;
		}

		model.put("station_type", station_type);
		model.put("area_id", area_id);

		stationTypeOption = f.getOption("1,2", "污染源污水,污染源烟气", station_type);

		areaOption = f.getHZBBAreaOption(area_id);

		tradeOption = getHZBBTradeOption(trade_id);

		valleyOption = f.getHZBBValleyOption(valley_id);

		req.setAttribute("date1", date1);
		req.setAttribute("date2", date2);
		req.setAttribute("station_type", station_type);

		req.setAttribute("stationTypeOption", stationTypeOption);
		req.setAttribute("areaOption", areaOption);
		req.setAttribute("tradeOption", tradeOption);
		req.setAttribute("valleyOption", valleyOption);

	}

	/*
	 * ! 根据list和ids获得因子列表信息
	 */
	public static List getInfectantList(List list, String[] ids)
			throws Exception {
		if (ids == null) {
			ErrorMsg.infectant_id_empty();
		}
		int i, num = 0;
		int j, idnum = 0;
		List list2 = new ArrayList();
		Map m = null;
		Map idmap = new HashMap();
		String id = null;
		String flag = null;

		idnum = ids.length;
		for (i = 0; i < idnum; i++) {
			idmap.put(ids[i], "1");
		}
		num = list.size();

		for (i = 0; i < num; i++) {
			m = (Map) list.get(i);
			id = (String) m.get("infectant_id");
			flag = (String) idmap.get(id);
			if (flag == null) {
				continue;
			}
			list2.add(m);

		}
		num = list2.size();
		if (num < 1) {
			ErrorMsg.infectant_id_empty();
		}
		return list2;
	}

	/*
	 * ! 根据站位名称获得站位编号
	 */
	public static String getStationIdByName(String station_name)
			throws Exception {
		String sql = "select station_id from t_cfg_station_info where station_desc like '%"
				+ station_name + "%'";
		Map m = null;
		m = f.queryOne(sql, null);
		if (m == null) {
			ErrorMsg.no_data();
		}
		String station_id = (String) m.get("station_id");
		return station_id;

	}

	/*
	 * ! 根据站位编号和session值获取站位收藏夹状态 2 未登录 0 不在收藏夹中 1 在收藏夹中
	 */
	public static String getStationFocusFlag(String station_id,
			HttpSession session) throws Exception {
		String user_id = f.getLoginUserId(session);
		if (f.empty(user_id)) {
			return "2";
		}
		String sql = "select station_id from  t_user_focus where station_id=? and user_id=?";
		Map m = null;
		Object[] ps = new Object[] { station_id, user_id };
		m = f.queryOne(sql, ps);
		if (m == null) {
			return "0";
		}
		return "1";
	}

	/*
	 * ! 根据request值添加收藏夹信息
	 */
	public static void focus_add(HttpServletRequest req) throws Exception {
		HttpSession session = req.getSession();
		String user_id = f.getLoginUserId(session);
		if (f.empty(user_id)) {
			ErrorMsg.no_login();
		}
		String station_id = req.getParameter("station_id");
		if (f.empty(station_id)) {
			ErrorMsg.station_id_empty();
		}
		String sql = "select station_id from t_user_focus where user_id=? and station_id=?";
		Object[] ps = new Object[] { user_id, station_id };
		String sqli = "insert into t_user_focus(user_id,station_id) values(?,?)";
		Map m = null;
		m = f.queryOne(sql, ps);
		if (m != null) {
			return;
		}
		f.update(sqli, ps);
	}

	/*
	 * ! 根据request值删除收藏夹信息
	 */
	public static void focus_del(HttpServletRequest req) throws Exception {
		HttpSession session = req.getSession();
		String user_id = f.getLoginUserId(session);
		if (f.empty(user_id)) {
			ErrorMsg.no_login();
		}
		String station_id = req.getParameter("station_id");
		if (f.empty(station_id)) {
			ErrorMsg.station_id_empty();
		}
		String sql = "delete from t_user_focus where user_id=? and station_id=?";
		Object[] ps = new Object[] { user_id, station_id };

		f.update(sql, ps);
	}

	/*
	 * ! 根据request值和list值获得收藏夹信息列表
	 */
	public static List getFocusList(HttpServletRequest req, List list)
			throws Exception {
		String focus_flag = req.getParameter("focus_flag");
		if (!f.eq(focus_flag, "1")) {
			return list;
		}
		HttpSession session = req.getSession();
		String user_id = f.getLoginUserId(session);
		if (f.empty(user_id)) {
			ErrorMsg.no_login();
		}
		List list2 = new ArrayList();
		String sql = "select station_id,user_id from t_user_focus where user_id="
				+ user_id;
		Map m = f.getMap(sql);
		int i, num = 0;
		Map m2 = null;
		String station_id = null;
		Object flag = null;

		num = list.size();
		for (i = 0; i < num; i++) {
			m2 = (Map) list.get(i);
			station_id = (String) m2.get("station_id");
			flag = m.get(station_id);
			if (flag != null) {
				list2.add(m2);
			}
		}
		return list2;
	}

	/*
	 * ! 根据request值返回本季度的数据传输率，并把值传到request
	 */
	public static void csyzlv_data(HttpServletRequest req) throws Exception {
		List stationList;

		List dataList = new ArrayList();
		List xchcList = new ArrayList();
		Map dataMap = null;
		Map tMap = null;
		Map model = f.model(req);
		String station_type = null;

		station_type = (String) model.get("station_type");
		if (f.empty(station_type)) {
			f.error("请选择监测类型");
		}

		String year = req.getParameter("year");// 年份
		String jidu = req.getParameter("jidu");// 季度

		// 根据上面的年份和季度得到开始时间和结束时间
		SimpleDateFormat fdf = new SimpleDateFormat("yyyy-MM-dd");
		String sds = fdf.format(f.getFirstDayOfQuarter(Integer.valueOf(year),
				Integer.valueOf(jidu)));// 季度的开始时间
		String fds = fdf.format(f.getLastDayOfQuarter(Integer.valueOf(year),
				Integer.valueOf(jidu)));// 季度的结束时间

		// 查询该地区的站位信息
		model.put("cols",
				"station_id,station_desc,station_bz,link_surface,content_flag");
		model.put("order_cols", "area_id,station_desc");
		stationList = f.getStationList2(model, req);

		Connection con = f.getConn();
		// 查询出在当前季度范围内的最新的现场核查记录
		String sql = "select id,qyid,sb_sbyzl,sb_sjcsl from t_xchc where hcrq>='"
				+ sds + "' and hcrq<='" + fds + "' order by hcrq desc";
		dataMap = f.query(con, sql, null, req);
		xchcList = (List) dataMap.get("data");

		int size = stationList.size();
		String sb_sbyzl = "";
		String sb_sjcsl = "";
		int tsize = 0;
		int i = 0;
		int j = 0;
		String station_id = "";
		String t_id = "";// 临时存储station_id的
		String jg = "";// 存储结果
		for (i = 0; i < size; i++) {// stationList循环
			dataMap = (Map) stationList.get(i);
			station_id = (String) dataMap.get("station_id");

			tsize = xchcList.size();
			for (j = 0; j < tsize; j++) {
				tMap = (Map) xchcList.get(j);
				t_id = (String) tMap.get("qyid");
				if (station_id.equals(t_id)) {
					dataMap.put("sb_sbyzl", tMap.get("sb_sbyzl"));
					dataMap.put("sb_sjcsl", tMap.get("sb_sjcsl"));
					break;
				}
			}
			if (j == tsize) {
				dataMap.put("sb_sbyzl", "");
				dataMap.put("sb_sjcsl", "");
			}

			dataList.add(dataMap);

		}
		String area_id = req.getParameter("area_id");
		String area_name = "江西省";

		if (area_id.equals("3601")) {
			area_name = "江西省南昌市";
		} else if (area_id.equals("3602")) {
			area_name = "江西省景德镇市";
		} else if (area_id.equals("3603")) {
			area_name = "江西省萍乡市";
		} else if (area_id.equals("3604")) {
			area_name = "江西省九江市";
		} else if (area_id.equals("3605")) {
			area_name = "江西省新余市";
		} else if (area_id.equals("3606")) {
			area_name = "江西省鹰潭市";
		} else if (area_id.equals("3607")) {
			area_name = "江西省赣州市";
		} else if (area_id.equals("3608")) {
			area_name = "江西省吉安市";
		} else if (area_id.equals("3609")) {
			area_name = "江西省宜春市";
		} else if (area_id.equals("36010")) {
			area_name = "江西省抚州市";
		} else if (area_id.equals("36011")) {
			area_name = "江西省上饶市";
		}

		req.setAttribute("year", year);
		req.setAttribute("area_name", area_name);
		req.setAttribute("jidu", jidu);
		req.setAttribute("list", dataList);

		con.close();

	}

	/*
	 * ! 根据request值返回当前监督员可以监督的站位信息，并把值传到request
	 */
	public static void qsjdkh_data(HttpServletRequest req) throws Exception {
		List stationList;
		List xchcList;
		List bdjcList;
		List khjlList;
		List hgbzList;
		List dataList = new ArrayList();
		Map dataMap = null;
		Map tMap = null;
		Map model = f.model(req);
		String station_type = null;

		station_type = (String) model.get("station_type");
		if (f.empty(station_type)) {
			f.error("请选择监测类型");
		}

		String year = req.getParameter("year");// 年份
		String jidu = req.getParameter("jidu");// 季度

		// 根据上面的年份和季度得到开始时间和结束时间
		SimpleDateFormat fdf = new SimpleDateFormat("yyyy-MM-dd");
		String sds = fdf.format(f.getFirstDayOfQuarter(Integer.valueOf(year),
				Integer.valueOf(jidu)));// 季度的开始时间
		String fds = fdf.format(f.getLastDayOfQuarter(Integer.valueOf(year),
				Integer.valueOf(jidu)));// 季度的结束时间

		// 查询该地区的站位信息
		model.put("cols",
				"station_id,station_desc,station_bz,link_surface,content_flag");
		model.put("order_cols", "area_id,station_desc");
		stationList = f.getStationList(model, req);

		Connection con = f.getConn();
		// 查询出在当前季度范围内的最新的现场核查记录
		String sql = "select id,qyid,hcjl,hcrq from t_xchc where hcrq>='" + sds
				+ "' and hcrq<='" + fds + "' order by hcrq desc";
		dataMap = f.query(con, sql, null, req);
		xchcList = (List) dataMap.get("data");

		// 查询出在当前季度范围内的最新的比对监测记录
		sql = "select id,qyid,bdjg,bdrq from t_bdjc where bdrq>='" + sds
				+ "' and bdrq<='" + fds + "' order by bdrq desc";
		dataMap = f.query(con, sql, null, req);
		bdjcList = (List) dataMap.get("data");

		// 查询出在当前季度范围内的最新的考核结论记录
		sql = "select id,qy_id,jd_jg,jd_rq from t_khjl where jd_rq>='" + sds
				+ "' and jd_rq<='" + fds + "' order by jd_rq desc";
		dataMap = f.query(con, sql, null, req);
		khjlList = (List) dataMap.get("data");

		// 查询出在当前季度范围内的最新的合格标志记录
		sql = "select id,qyid,bzhfrq,bzyxqz from t_hgbz where bzhfrq>='" + sds
				+ "' and bzhfrq<='" + fds + "' order by bzhfrq desc";
		dataMap = f.query(con, sql, null, req);
		hgbzList = (List) dataMap.get("data");

		// req.setAttribute("list",stationList);
		int size = stationList.size();
		int tsize = 0;
		int i = 0;
		int j = 0;
		String station_id = "";
		String t_id = "";// 临时存储station_id的
		String jg = "";// 存储结果
		for (i = 0; i < size; i++) {// stationList循环
			dataMap = (Map) stationList.get(i);
			station_id = (String) dataMap.get("station_id");

			tsize = xchcList.size();
			for (j = 0; j < tsize; j++) {
				tMap = (Map) xchcList.get(j);
				t_id = (String) tMap.get("qyid");
				if (station_id.equals(t_id)) {
					dataMap.put("xchc_id", tMap.get("id"));
					dataMap.put("xchc_url",
							"'xchc_update.jsp','" + tMap.get("id") + "','"
									+ dataMap.get("station_desc") + "','"
									+ dataMap.get("content_flag") + "'");

					jg = (String) tMap.get("hcjl");
					if (!"".equals(jg) && jg.equals("1")) {
						jg = "合格";
					} else {
						jg = "不合格";
					}
					dataMap.put("xchc_jg", jg);
					break;
				}
			}
			if (j == tsize) {
				dataMap.put(
						"xchc_url",
						"'xchc_info.jsp','" + station_id + "','"
								+ dataMap.get("station_desc") + "','"
								+ dataMap.get("content_flag") + "'");
				dataMap.put("xchc_jg", "新增");
			}

			tsize = bdjcList.size();
			for (j = 0; j < tsize; j++) {
				tMap = (Map) bdjcList.get(j);
				t_id = (String) tMap.get("qyid");
				if (station_id.equals(t_id)) {
					dataMap.put("bdjc_id", tMap.get("id"));
					dataMap.put("bdjc_url",
							"'bdjc_update.jsp','" + tMap.get("id") + "','"
									+ dataMap.get("station_desc") + "','"
									+ dataMap.get("content_flag") + "'");
					jg = (String) tMap.get("bdjg");
					if (!"".equals(jg) && jg.equals("1")) {
						jg = "合格";
					} else {
						jg = "不合格";
					}
					dataMap.put("bdjc_jg", jg);
					break;
				}
			}
			if (j == tsize) {
				dataMap.put(
						"bdjc_url",
						"'bdjc_info.jsp','" + station_id + "','"
								+ dataMap.get("station_desc") + "','"
								+ dataMap.get("content_flag") + "'");
				dataMap.put("bdjc_jg", "新增");
			}

			tsize = khjlList.size();
			for (j = 0; j < tsize; j++) {
				tMap = (Map) khjlList.get(j);
				t_id = (String) tMap.get("qy_id");

				if (station_id.equals(t_id)) {
					dataMap.put("khjl_id", tMap.get("id"));
					dataMap.put("khjl_url",
							"'khjl_update.jsp','" + tMap.get("id") + "','"
									+ dataMap.get("station_desc") + "','"
									+ dataMap.get("content_flag") + "'");
					jg = (String) tMap.get("jd_jg");
					if (!"".equals(jg) && jg.equals("1")) {
						jg = "合格";
					} else {
						jg = "不合格";
					}
					dataMap.put("khjl_jg", jg);
					break;
				}
			}
			if (j == tsize) {
				dataMap.put(
						"khjl_url",
						"'khjl_info.jsp','" + station_id + "','"
								+ dataMap.get("station_desc") + "','"
								+ dataMap.get("content_flag") + "'");
				dataMap.put("khjl_jg", "新增");
			}

			tsize = hgbzList.size();
			for (j = 0; j < tsize; j++) {
				tMap = (Map) hgbzList.get(j);
				t_id = (String) tMap.get("qyid");

				if (station_id.equals(t_id)) {
					dataMap.put("hgbz_id", tMap.get("id"));
					dataMap.put("hgbz_url",
							"'hgbz_update.jsp','" + tMap.get("id") + "','"
									+ dataMap.get("station_desc") + "','"
									+ dataMap.get("content_flag") + "'");
					dataMap.put("hgbz_jg", "合格");
					break;
				}
			}
			if (j == tsize) {
				dataMap.put(
						"hgbz_url",
						"'hgbz_info.jsp','" + station_id + "','"
								+ dataMap.get("station_desc") + "','"
								+ dataMap.get("content_flag") + "'");
				dataMap.put("hgbz_jg", "新增");
			}

			dataList.add(dataMap);

		}

		req.setAttribute("list", dataList);

		con.close();

	}

	/*
	 * ! 根据具体的站位ID，查询出它全部的考核信息，包括现场核查，比对监测，考核结论，合格标志等。并把值传到request
	 */
	public static void stationkhdetail_data(HttpServletRequest req)
			throws Exception {

		List xchcList;
		List bdjcList;
		List khjlList;
		List hgbzList;
		List timeList = new ArrayList();
		SortedSet timeSet = new TreeSet();
		List dataList = new ArrayList();
		Map dataMap = null;
		Map tMap = null;

		String station_id = req.getParameter("station_id");// 站位ID

		Connection con = f.getConn();
		// 查询出当前站位所有的现场核查记录
		String sql = "select id,qyid,hcjl,hcrq from t_xchc where qyid='"
				+ station_id + "' order by hcrq asc";
		dataMap = f.query(con, sql, null, req);
		xchcList = (List) dataMap.get("data");

		// 查询出当前站位所有的比对监测记录
		sql = "select id,qyid,bdjg,bdrq from t_bdjc where qyid='" + station_id
				+ "' order by bdrq asc";
		dataMap = f.query(con, sql, null, req);
		bdjcList = (List) dataMap.get("data");

		// 查询出当前站位所有的考核结论记录
		sql = "select id,qy_id,jd_jg,jd_rq from t_khjl where qy_id='"
				+ station_id + "' order by jd_rq asc";
		dataMap = f.query(con, sql, null, req);
		khjlList = (List) dataMap.get("data");

		// 查询出当前站位所有的合格标志记录
		sql = "select id,qyid,bzhfrq,bzyxqz from t_hgbz where qyid='"
				+ station_id + "' order by bzhfrq asc";
		dataMap = f.query(con, sql, null, req);
		hgbzList = (List) dataMap.get("data");

		con.close();

		int size = xchcList.size();
		int tsize = 0;
		int i = 0;
		int j = 0;
		int k = 0;
		String t_rq = "";
		String jg = "";
		int year = 0;
		// 查询出各类考核的所有年份
		for (i = 0; i < size; i++) {
			tMap = (Map) xchcList.get(i);
			t_rq = (String) tMap.get("hcrq");
			year = f.getYear(t_rq);
			if (!timeSet.contains(year))
				timeSet.add(year);
		}// 现场核查
		size = bdjcList.size();
		for (i = 0; i < size; i++) {
			tMap = (Map) bdjcList.get(i);
			t_rq = (String) tMap.get("bdrq");
			year = f.getYear(t_rq);
			if (!timeSet.contains(year))
				timeSet.add(year);
		}// 比对监测
		size = khjlList.size();
		for (i = 0; i < size; i++) {
			tMap = (Map) khjlList.get(i);
			t_rq = (String) tMap.get("jd_rq");
			year = f.getYear(t_rq);
			if (!timeSet.contains(year))
				timeSet.add(year);
		}// 考核结论
		size = hgbzList.size();
		for (i = 0; i < size; i++) {
			tMap = (Map) hgbzList.get(i);
			t_rq = (String) tMap.get("bzhfrq");
			year = f.getYear(t_rq);
			if (!timeSet.contains(year))
				timeSet.add(year);
		}// 合格标志

		// String[] years = (String[])timeSet.size();
		size = timeSet.size();
		Date s_time = null;// 季度开始时间
		Date e_time = null;// 季度结束时间
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Iterator<Integer> it = timeSet.iterator();

		for (i = 0; i < size; i++) {// 循环所有的年份，得到各类考核的各季度的考核数据
			year = it.next();// 得到年份

			// 得到每个季度的数据来
			for (j = 1; j <= 4; j++) {
				s_time = df
						.parse(sdf.format((f.getFirstDayOfQuarter(year, j))));
				e_time = df.parse(sdf.format((f.getLastDayOfQuarter(year, j))));
				Map dataMap_t = new HashMap();
				// 各类考核循环
				tsize = xchcList.size();
				for (k = 0; k < tsize; k++) {
					tMap = (Map) xchcList.get(k);
					t_rq = (String) tMap.get("hcrq");
					if (s_time.getTime() <= df.parse(t_rq).getTime()
							&& df.parse(t_rq).getTime() <= e_time.getTime()) {
						dataMap_t.put("xchc_id", tMap.get("id"));
						jg = (String) tMap.get("hcjl");
						if (!"".equals(jg) && jg.equals("1")) {
							jg = "合格";
						} else {
							jg = "不合格";
						}
						dataMap_t.put("xchc_jg", jg);
						break;
					}
				}
				if (k == tsize) {
					dataMap_t.put("xchc_id", "");
					dataMap_t.put("xchc_jg", "");
				}

				tsize = bdjcList.size();
				for (k = 0; k < tsize; k++) {
					tMap = (Map) bdjcList.get(k);
					t_rq = (String) tMap.get("bdrq");
					if (s_time.getTime() <= df.parse(t_rq).getTime()
							&& df.parse(t_rq).getTime() <= e_time.getTime()) {
						dataMap_t.put("bdjc_id", tMap.get("id"));
						jg = (String) tMap.get("bdjg");
						if (!"".equals(jg) && jg.equals("1")) {
							jg = "合格";
						} else {
							jg = "不合格";
						}
						dataMap_t.put("bdjc_jg", jg);
						break;
					}
				}
				if (k == tsize) {
					dataMap_t.put("bdjc_id", "");
					dataMap_t.put("bdjc_jg", "");
				}

				tsize = khjlList.size();
				for (k = 0; k < tsize; k++) {
					tMap = (Map) khjlList.get(k);
					t_rq = (String) tMap.get("jd_rq");
					if (s_time.getTime() <= df.parse(t_rq).getTime()
							&& df.parse(t_rq).getTime() <= e_time.getTime()) {
						dataMap_t.put("khjl_id", tMap.get("id"));
						jg = (String) tMap.get("jd_jg");
						if (!"".equals(jg) && jg.equals("1")) {
							jg = "合格";
						} else {
							jg = "不合格";
						}
						dataMap_t.put("khjl_jg", jg);
						break;
					}
				}
				if (k == tsize) {
					dataMap_t.put("khjl_id", "");
					dataMap_t.put("khjl_jg", "");
				}

				tsize = hgbzList.size();
				for (k = 0; k < tsize; k++) {
					tMap = (Map) hgbzList.get(k);
					t_rq = (String) tMap.get("bzhfrq");
					if (s_time.getTime() <= df.parse(t_rq).getTime()
							&& df.parse(t_rq).getTime() <= e_time.getTime()) {
						dataMap_t.put("hgbz_id", tMap.get("id"));
						dataMap_t.put("hgbz_jg", "合格");
						break;
					}
				}
				if (k == tsize) {
					dataMap_t.put("hgbz_id", "");
					dataMap_t.put("hgbz_jg", "");
				}
				dataMap_t.put("year", year);
				dataList.add(dataMap_t);
			}
		}

		xchcList = null;
		bdjcList = null;
		khjlList = null;
		hgbzList = null;
		timeList = null;
		timeSet = null;
		dataMap = null;
		tMap = null;

		req.setAttribute("list", dataList);

	}

	/*
	 * ! 查询监督考核中审核合格率
	 */
	public static void jdkh_shhgl(HttpServletRequest req) throws Exception {

		List stationList;
		List khjlList;// 包含合格的与不合格的
		List hg = new ArrayList();// 合格记录
		List nhg = new ArrayList();// 不合格记录
		List noac = new ArrayList();// 没做监督的记录
		String hglv = "";// 合格率
		String wclv = "";// 完成率
		String bhglv = "";// 不合格率
		Map dataMap = null;
		Map model = f.model(req);
		String station_type = null;
		String area_id = "";
		String station_id = "";
		String date1 = "";
		String date2 = "";
		Map m = null;
		Map t_m = null;
		String ids = "";
		String jd_jg = "";
		String station_id_01 = "";
		String station_id_02 = "";

		station_type = (String) model.get("station_type");
		if (f.empty(station_type)) {
			f.error("请选择监测类型");
		}
		area_id = (String) model.get("area_id");
		date1 = (String) model.get("date1");
		date2 = (String) model.get("date2");

		String sql = "";

		if (!"".equals(area_id) && area_id.equals("36")) {
			sql = "select station_id,station_desc,build_flag,station_bz,area_id from T_CFG_STATION_INFO where station_type='"
					+ station_type
					+ "' and show_flag !='1' and content_flag='1'";
		} else {
			sql = "select station_id,station_desc,build_flag,station_bz,area_id from T_CFG_STATION_INFO where station_type='"
					+ station_type
					+ "' and show_flag !='1' and content_flag !='1'  and area_id like '"
					+ area_id + "%'";
		}

		dataMap = f.query(sql, null, req);

		stationList = (List) dataMap.get("data");// 本地市的所有站位信息

		// 得到站位id
		int size = stationList.size();
		if (stationList != null && size > 0) {
			for (int i = 0; i < size; i++) {
				m = (Map) stationList.get(i);
				if (!"".equals(ids)) {
					ids = ids + ",'" + (String) m.get("station_id") + "'";
				} else {
					ids = "'" + (String) m.get("station_id") + "'";
				}
			}

			// 根据时间段查询出date1到date2时间段的考核结论。
			sql = "select * from t_khjl where jd_rq>='" + date1
					+ "' and jd_rq<='" + date2 + "' and qy_id in(" + ids + ")";
			dataMap = f.query(sql, null, req);
			khjlList = (List) dataMap.get("data");

			int j = 0;
			int i = 0;
			int count = 0;
			int size2 = khjlList.size();
			for (i = 0; i < size; i++) {
				t_m = (Map) stationList.get(i);

				if (size2 > 0) {
					for (j = 0; j < size2; j++) {
						m = (Map) khjlList.get(j);
						if (m != null) {
							jd_jg = (String) m.get("jd_jg");
							if (!"".equals(jd_jg) && jd_jg.equals("1")) {
								if (!hg.contains(m))
									hg.add(m);
							} else if (!"".equals(jd_jg) && jd_jg.equals("0")) {
								if (!nhg.contains(m))
									nhg.add(m);
							}
						}
						station_id_01 = (String) m.get("qy_id");
						station_id_02 = (String) t_m.get("station_id");
						if (station_id_02.equals(station_id_01)) {
							count++;
						}
					}
				}

				if (count == 0)
					noac.add(t_m);
				count = 0;

			}

			float tmp_01 = stationList.size();
			if (tmp_01 == 0)
				tmp_01 = 1;
			float tmp_02 = hg.size();
			Format format = new DecimalFormat("0.00");
			hglv = format.format(tmp_02 / tmp_01);
			tmp_02 = khjlList.size();
			wclv = format.format(tmp_02 / tmp_01);
			tmp_02 = nhg.size();
			bhglv = format.format(tmp_02 / tmp_01);

		}

		// req.setAttribute("list",stationList);
		req.setAttribute("hg", hg);
		req.setAttribute("nhg", nhg);
		req.setAttribute("noac", noac);
		req.setAttribute("hglv", hglv);
		req.setAttribute("wclv", wclv);
		req.setAttribute("bhglv", bhglv);

	}

	/*
	 * ! 查询全省的监督考核审核合格率
	 */
	public static void jdkh_qshhgl(HttpServletRequest req) throws Exception {

		List stationList;
		List khjlList;// 包含合格的与不合格的
		List hg = new ArrayList();// 合格记录
		List nhg = new ArrayList();// 不合格记录
		List noac = new ArrayList();// 没做监督的记录
		String hglv = "";// 合格率
		String wclv = "";// 完成率
		String bhglv = "";// 不合格率
		Map dataMap = null;
		Map model = f.model(req);
		String station_type = null;
		String area_id = "";
		String station_id = "";
		String date1 = "";
		String date2 = "";
		Map m = null;
		Map t_m = null;
		String ids = "";
		String jd_jg = "";
		String station_id_01 = "";
		String station_id_02 = "";

		station_type = (String) model.get("station_type");
		if (f.empty(station_type)) {
			f.error("请选择监测类型");
		}
		area_id = (String) model.get("area_id");
		date1 = (String) model.get("date1");
		date2 = (String) model.get("date2");

		String sql = "select station_id,station_desc,build_flag,station_bz,area_id from T_CFG_STATION_INFO where station_type='"
				+ station_type
				+ "' and show_flag !='1' and area_id like '"
				+ area_id + "%'";

		dataMap = f.query(sql, null, req);

		stationList = (List) dataMap.get("data");// 本地市的所有站位信息

		// 得到站位id
		int size = stationList.size();
		if (stationList != null && size > 0) {
			for (int i = 0; i < size; i++) {
				m = (Map) stationList.get(i);
				if (!"".equals(ids)) {
					ids = ids + ",'" + (String) m.get("station_id") + "'";
				} else {
					ids = "'" + (String) m.get("station_id") + "'";
				}
			}

			// 根据时间段查询出date1到date2时间段的考核结论。
			sql = "select * from t_khjl where jd_rq>='" + date1
					+ "' and jd_rq<='" + date2 + "' and qy_id in(" + ids + ")";
			dataMap = f.query(sql, null, req);
			khjlList = (List) dataMap.get("data");

			int j = 0;
			int i = 0;
			int count = 0;
			int size2 = khjlList.size();
			for (i = 0; i < size; i++) {
				t_m = (Map) stationList.get(i);

				if (size2 > 0) {
					for (j = 0; j < size2; j++) {
						m = (Map) khjlList.get(j);
						if (m != null) {
							jd_jg = (String) m.get("jd_jg");
							if (!"".equals(jd_jg) && jd_jg.equals("1")) {
								if (!hg.contains(m))
									hg.add(m);
							} else if (!"".equals(jd_jg) && jd_jg.equals("0")) {
								if (!nhg.contains(m))
									nhg.add(m);
							}
						}
						station_id_01 = (String) m.get("qy_id");
						station_id_02 = (String) t_m.get("station_id");
						if (station_id_02.equals(station_id_01)) {
							count++;
						}
					}
				}

				if (count == 0)
					noac.add(t_m);
				count = 0;

			}

			float tmp_01 = stationList.size();
			if (tmp_01 == 0)
				tmp_01 = 1;
			float tmp_02 = hg.size();
			Format format = new DecimalFormat("0.00");
			hglv = format.format(tmp_02 / tmp_01);
			tmp_02 = khjlList.size();
			wclv = format.format(tmp_02 / tmp_01);
			tmp_02 = nhg.size();
			bhglv = format.format(tmp_02 / tmp_01);

		}

		// req.setAttribute("list",stationList);
		req.setAttribute("hg", hg);
		req.setAttribute("nhg", nhg);
		req.setAttribute("noac", noac);
		req.setAttribute("hglv", hglv);
		req.setAttribute("wclv", wclv);
		req.setAttribute("bhglv", bhglv);

	}

	/*
	 * ! 根据根据站位的id获得现核查历史记录
	 */
	public static void queryXchcHisByID(HttpServletRequest req)
			throws Exception {
		String station_id;

		int i, num = 0;
		String cols = null;
		String sql = null;
		Map m = null;

		station_id = req.getParameter("station_id");
		if (f.empty(station_id)) {
			f.error("请选择站位");
		}

		String date1 = (String) req.getParameter("date1");
		String date2 = (String) req.getParameter("date2");
		String hcjl = req.getParameter("hcjl");
		if ("".equals(hcjl)) {
			sql = "select id,qymc,address,hcdw,hcrq,hcjl,username from t_xchc where hcrq>='"
					+ date1
					+ "' and hcrq<='"
					+ date2
					+ "' and qyid='"
					+ station_id + "' order by hcrq desc ";
		} else {
			sql = "select id,qymc,address,hcdw,hcrq,hcjl,username from t_xchc where hcrq>='"
					+ date1
					+ "' and hcrq<='"
					+ date2
					+ "' and hcjl='"
					+ hcjl
					+ "' and qyid='" + station_id + "' order by hcrq desc ";
		}

		// Object[]p = new Object[]{station_id};
		m = f.query(sql, null, req);

		List datalist = (List) m.get("data");
		// List data = new ArrayList();

		req.setAttribute("station_id", station_id);
		req.setAttribute("date1", date1);
		req.setAttribute("date2", date2);
		req.setAttribute("hcjl", hcjl);
		req.setAttribute("data", datalist);
		req.setAttribute("bar", m.get("bar"));
		req.setAttribute("sql", sql);

	}

	/*
	 * ! 根据根据站位的id获得比对监测历史记录
	 */
	public static void queryBdjcHisByID(HttpServletRequest req)
			throws Exception {
		String station_id;

		int i, num = 0;
		String cols = null;
		String sql = null;
		Map m = null;

		station_id = req.getParameter("station_id");
		if (f.empty(station_id)) {
			f.error("请选择站位");
		}

		String date1 = (String) req.getParameter("date1");
		String date2 = (String) req.getParameter("date2");
		String bdjg = req.getParameter("bdjg");

		if ("".equals(bdjg)) {
			sql = "select id,qymc,zzdw,bdrq,bdjg,username from t_bdjc where bdrq>='"
					+ date1
					+ "' and bdrq<='"
					+ date2
					+ "' and qyid='"
					+ station_id + "' order by bdrq desc ";
		} else {
			sql = "select id,qymc,zzdw,bdrq,bdjg,username from t_bdjc where bdrq>='"
					+ date1
					+ "' and bdrq<='"
					+ date2
					+ "' and bdjg='"
					+ bdjg
					+ "' and qyid='" + station_id + "' order by bdrq desc ";
		}

		// Object[]p = new Object[]{station_id};
		m = f.query(sql, null, req);

		List datalist = (List) m.get("data");
		// List data = new ArrayList();

		req.setAttribute("station_id", station_id);
		req.setAttribute("date1", date1);
		req.setAttribute("date2", date2);
		req.setAttribute("bdjg", bdjg);
		req.setAttribute("data", datalist);
		req.setAttribute("bar", m.get("bar"));
		req.setAttribute("sql", sql);

	}

	/*
	 * ! 根据根据站位的id获得考核结论历史记录
	 */
	public static void queryKhjlHisByID(HttpServletRequest req)
			throws Exception {
		String station_id;

		int i, num = 0;
		String cols = null;
		String sql = null;
		Map m = null;

		station_id = req.getParameter("station_id");
		if (f.empty(station_id)) {
			f.error("请选择站位");
		}

		String date1 = (String) req.getParameter("date1");
		String date2 = (String) req.getParameter("date2");
		String jd_jg = req.getParameter("jd_jg");

		if ("".equals(jd_jg)) {
			sql = "select id,qy_mc,jd_rq,jd_jg,jd_zhi,jd_hao,jd_name from t_khjl where jd_rq>='"
					+ date1
					+ "' and jd_rq<='"
					+ date2
					+ "' and qy_id='"
					+ station_id + "' order by jd_rq desc ";
		} else {
			sql = "select id,qy_mc,jd_rq,jd_jg,jd_zhi,jd_hao,jd_name from t_khjl where jd_rq>='"
					+ date1
					+ "' and jd_rq<='"
					+ date2
					+ "' and jd_jg='"
					+ jd_jg
					+ "' and qy_id='"
					+ station_id
					+ "' order by jd_rq desc ";
		}

		// Object[]p = new Object[]{station_id};
		m = f.query(sql, null, req);

		List datalist = (List) m.get("data");
		// List data = new ArrayList();

		req.setAttribute("station_id", station_id);
		req.setAttribute("date1", date1);
		req.setAttribute("date2", date2);
		req.setAttribute("jd_jg", jd_jg);
		req.setAttribute("data", datalist);
		req.setAttribute("bar", m.get("bar"));
		req.setAttribute("sql", sql);

	}

	/*
	 * ! 根据现场核查信息id，查询现场核查信息详细信息
	 */
	public static void queryXchcInfoByID(HttpServletRequest req)
			throws Exception {
		String id;

		int i, num = 0;
		String cols = null;
		String sql = null;
		Map m = null;

		id = req.getParameter("id");

		sql = "select * from t_xchc where id='" + id + "'";

		// Object[]p = new Object[]{station_id};
		m = f.queryOne(sql, null);

		// List datalist = (List)m.;
		// List data = new ArrayList();

		req.setAttribute("id", id);
		req.setAttribute("data", m);
		// req.setAttribute("bar",m.get("bar"));
		req.setAttribute("sql", sql);

	}

	/*
	 * ! 根据考核结论信息id，查询考核结论详细信息
	 */
	public static void queryKhjlInfoByID(HttpServletRequest req)
			throws Exception {
		String id;

		int i, num = 0;
		String cols = null;
		String sql = null;
		Map m = null;

		id = req.getParameter("id");

		sql = "select * from t_khjl where id='" + id + "'";

		// Object[]p = new Object[]{station_id};
		m = f.queryOne(sql, null);

		// List datalist = (List)m.;
		// List data = new ArrayList();

		req.setAttribute("id", id);
		req.setAttribute("data", m);
		// req.setAttribute("bar",m.get("bar"));
		req.setAttribute("sql", sql);

	}

	/*
	 * ! 根据合格标志信息id，查询合格标志详细信息
	 */
	public static void queryHgbzInfoByID(HttpServletRequest req)
			throws Exception {
		String id;

		int i, num = 0;
		String cols = null;
		String sql = null;
		Map m = null;

		id = req.getParameter("id");

		sql = "select * from t_hgbz where id='" + id + "'";

		// Object[]p = new Object[]{station_id};
		m = f.queryOne(sql, null);

		// List datalist = (List)m.;
		// List data = new ArrayList();

		req.setAttribute("id", id);
		req.setAttribute("data", m);
		// req.setAttribute("bar",m.get("bar"));
		req.setAttribute("sql", sql);

	}

	/*
	 * ! 根据比对监测信息id，查询比对监测详细信息
	 */
	public static void queryBdjcInfoByID(HttpServletRequest req)
			throws Exception {
		String id;

		int i, num = 0;
		String cols = null;
		String sql = null;
		Map m_bdjc = null;
		Map m_jcxm = null;
		Map m_xm = null;

		id = req.getParameter("id");

		sql = "select * from t_bdjc where id='" + id + "'";// 查询比对监测信息中的主表

		// Object[]p = new Object[]{station_id};
		m_bdjc = f.queryOne(sql, null);

		sql = "select * from t_jcxm where bdjc_id='" + id + "'";// 查询监测项目记录信息
		m_jcxm = f.query(sql, null, req);

		sql = "select * from t_xm where bdjc_id='" + id + "'";// 查询监测项目记录信息
		m_xm = f.query(sql, null, req);

		// List datalist = (List)m.;
		// List data = new ArrayList();

		List data_jcxm = (List) m_jcxm.get("data");

		List data_xm = (List) m_xm.get("data");

		req.setAttribute("id", id);
		req.setAttribute("data_bdjc", m_bdjc);
		req.setAttribute("data_jcxm", data_jcxm);
		req.setAttribute("data_xm", data_xm);
		// req.setAttribute("bar",m.get("bar"));
		req.setAttribute("sql", sql);

		m_jcxm = null;
		m_bdjc = null;
		m_xm = null;
		data_jcxm = null;
		data_xm = null;

	}

}