package com.hoson.action;

import com.hoson.mvc.*;
import com.hoson.*;

import java.util.*;
import java.sql.*;

import javax.servlet.http.HttpServletRequest;

import com.hoson.util.*;
import com.hoson.app.*;
import com.hoson.app.AppPagedUtil;

public class StdReportAction extends BaseAction {

	String msg = "请选择一个站位";

	public String rpt() throws Exception {
		String station_id = p("station_id");
		String station_type = p("station_type");
		String report_type = p("report_type");
		String date1 = p("date1");

		String sql = getSql(request.getParameter("tableName"));
		List list = null;
		Map tjMap = new HashMap();
		String tjcols = null;
		String sql2 = null;
		Map m = null;
		String station_name = null;
		Timestamp time = f.time(date1);

		tjcols = p("gas_cols") + "," + p("water_cols") + ",";
		tjcols = tjcols + p("gas_q_cols") + "," + p("water_q_cols");

		if (f.empty(station_id)) {
			throw new Exception(msg);
		}

		sql2 = "select station_desc,station_type from t_cfg_station_info where station_id='"
				+ station_id + "'";
		m = f.queryOne(sql2, null);
		if (m == null) {
			throw new Exception("站位不存在");
		}

		station_name = (String) m.get("station_desc");

		seta("sql", sql);

		list = f.query(sql, null);
		String cols = getCols(station_type);
		list = decodeList(list, cols);

		ZeroAsNull.make(list, cols);

		StdReportUtil.qs(list);

		StdReportUtil.hztjs(list, tjcols, tjMap);

		list = StdReportUtil.getReportDataList(report_type, list, date1);

		seta("data", list);
		seta("tj", tjMap);
		seta("station_name", station_name);
		seta("station_id", station_id);
		seta("time", time);
		return null;
	}

	List decodeList(List list, String cols) throws Exception {
		List list2 = new ArrayList();
		int i, num = 0;
		Map m = null;
		String[] colarr = cols.split(",");
		String col = null;
		int j, colnum = 0;
		String v = null;
		Double vobj = null;
		colnum = colarr.length;
		Double nulldouble = null;

		num = list.size();

		for (i = 0; i < num; i++) {
			m = (Map) list.get(i);
			for (j = 0; j < colnum; j++) {
				col = colarr[j];
				if (f.empty(col)) {
					continue;
				}
				v = (String) m.get(col);
				if (f.empty(v)) {
					m.put(col, nulldouble);

					continue;
				}
				v = f.v(v);
				vobj = f.getDoubleObj(v, null);
				m.put(col, vobj);

			}
			list2.add(m);

		}

		return list2;

	}

	String getStationTypeOption(String station_type) throws Exception {
		String s = null;
		String vs = "1,2";
		String ts = "污染源废水,污染源烟气";

		s = JspUtil.getOption(vs, ts, station_type);

		return s;

	}

	String getReportTypeOption(String report_type) throws Exception {
		String s = null;
		String vs = "day,month,year";
		String ts = "日报表,月报表,年报表";

		s = JspUtil.getOption(vs, ts, report_type);

		return s;

	}

	public String form() throws Exception {

		String station_type = "2";
		String area_id = null;
		String sql = null;
		String areaOption = null;
		String stationOption = null;

		String stationTypeOption = null;
		String reportTypeOption = null;
		String report_type = null;
		List stationList = null;

		station_type = p("station_type");
		if (f.empty(station_type)) {
			station_type = "1";
		}

		report_type = p("report_type");
		if (f.empty(report_type)) {
			report_type = "day";
		}

		area_id = p("area_id");
		if (f.empty(area_id)) {
			area_id = f.cfg("default_area_id", "3301");
		}

		sql = "select station_id,station_desc from t_cfg_station_info ";
		sql = sql + " where station_type='" + station_type
				+ "' and area_id like '" + area_id + "%'";
		sql = sql + " order by area_id,station_desc";

		getConn();

		stationList = JspPageUtil.getStationList(conn, station_type, area_id,
				null, request);

		// stationOption = f.getOption(conn,sql,null);

		stationOption = f.getOption(stationList, "station_id", "station_desc",
				null);

		areaOption = JspPageUtil.getAreaOption(conn, area_id);

		stationTypeOption = getStationTypeOption(station_type);
		reportTypeOption = getReportTypeOption(report_type);

		seta("stationOption", stationOption);
		seta("areaOption", areaOption);
		seta("stationTypeOption", stationTypeOption);
		seta("reportTypeOption", reportTypeOption);

		return null;
	}

	String getDataTable(String report_type) throws Exception {
		String t = "t_monitor_real_hour";

		if (f.eq(report_type, "month")) {
			t = "t_monitor_real_day";
		}
		if (f.eq(report_type, "year")) {
			t = "t_monitor_real_month";
		}
		return t;
	}

	String getCols(String station_type) throws Exception {
		String cols = null;
		String gas_cols = p("gas_cols");
		String water_cols = p("water_cols");

		cols = water_cols;
		if (f.eq(station_type, "2")) {
			cols = gas_cols;
		}
		return cols;
	}

	String getSql(String tableName) throws Exception {
		String sql = "";

		String report_type = p("report_type");
		String station_type = p("station_type");
		String station_id = p("station_id");
		String date1 = p("date1");

		String cols = null;
		String data_table = null;
		String[] colarr = null;
		int i, num = 0;
		String col = null;
		String f_col = null;
		Map timeMap = StdReportUtil.getStartAndEndTime(date1, report_type);

		cols = getCols(station_type);
		data_table = getDataTable(report_type);
		if (tableName.equals("t_monitor_real_hour_v")) {
			data_table = data_table + "_v";
		}

		colarr = cols.split(",");

		num = colarr.length;

		for (i = 0; i < num; i++) {
			col = colarr[i];
			if (f.empty(col)) {
				continue;
			}
			f_col = p(col);

			if (f.empty(f_col)) {
				continue;
			}

			sql = sql + "," + f_col + " as " + col;

		}
		sql = "select station_id,m_time" + sql + " from " + data_table;

		sql = sql + " where station_id='" + station_id + "' ";
		sql = sql + " and m_time>='" + timeMap.get("start") + "' ";
		sql = sql + " and m_time<'" + timeMap.get("end") + "' ";
		sql = sql + " order by m_time ";
		return sql;
	}
}