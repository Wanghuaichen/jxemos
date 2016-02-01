package com.hoson.app;

import java.sql.*;

import java.util.*;
import com.hoson.f;
import javax.servlet.http.HttpServletRequest;

import ChartDirector.AreaLayer;
import ChartDirector.Chart;
import ChartDirector.LineLayer;
import ChartDirector.BarLayer;
import ChartDirector.XYChart;

import com.hoson.DBUtil;
import com.hoson.StringUtil;
import com.hoson.search.chart;

public class NewChart {

	private static int TITLE_FONT_SIZE = 8;
	private static int TITLE_BG_COLOR = 0x0;
	private static int TITLE_FONT_COLOR = 0xff0000;
	// private static int LINE_COLOR = 0xFF9900;
	private static int LINE_COLOR = 0x00ff00;

	private static int MAXROWS = 3000;

	private static int SET_MAXROWS_FLAG = 1;
	private static int VALUE_SHAPE_SIZE = 5;

	private static int LINE_WIDTH = 2;

	private static int max_num_show_shape = 300;

	private static String FONT = "";
	private static int FONT_SIZE = 12;
	private static int legend_font_size = 10;

	private NewChart() {
	}

	/*
	 * ! 根据站位编号station_id和因子编号infectant_id获得查询实时数据的sql
	 */
	public static String getRealSql(String station_id, String infectant_id) {

		String sql = null;

		sql = "select m_time,m_value from v_view_real " + " where station_id='"
				+ station_id + "' " + " and infectant_id='" + infectant_id
				+ "'" + " order by m_time";
		return sql;
	}

	/*
	 * ! 根据站位编号station_id,因子编号infectant_id和request获得查询实时数据的sql
	 */
	public static String getRealSql(String station_id, String infectant_id,
			HttpServletRequest req) throws Exception {

		String sql = null;
		String date3, hour3;
		int h = 0;

		date3 = req.getParameter("date3");
		hour3 = req.getParameter("hour3");

		if (f.empty(date3)) {
			date3 = f.today();
		}
		h = f.getInt(hour3, 0);
		if (h > 23) {
			h = 23;
		}

		sql = "select  m_time,m_value from t_monitor_real_minute where station_id='{0}' ";
		sql = sql + " and infectant_id='{1}'";
		sql = sql + " and m_time>='{2}'";
		sql = sql + " and m_time<='{3} {4}:59:59' order by m_time";

		Object[] p = new Object[] { station_id, infectant_id, date3, date3,
				hour3 };
		sql = f.str(sql, p);
		req.setAttribute("sql", sql);

		return sql;
	}

	/*
	 * ! 获得查询实时数据的开始时间
	 */
	public static String getRealChartStartTime() {
		String s = null;
		java.util.Date dateNow = new java.util.Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(dateNow);
		cal.add(Calendar.HOUR, -2);
		Timestamp ts = new Timestamp(cal.getTime().getTime());
		s = StringUtil.getDateTime(ts);
		return s;
	}

	/*
	 * ! 根据站位编号station_id,因子编号infectant_id和request获得预警值和报警值的数组
	 */
	public static double[] getLimitValue(String station_id,
			String infectant_id, HttpServletRequest req) throws Exception {
		double[] arr = new double[2];
		arr[0] = 0;
		arr[1] = 0;
		String sql = "select hi,hihi from t_cfg_monitor_param ";
		sql = sql + "where station_id='" + station_id + "' and infectant_id='"
				+ infectant_id + "'";
		Map map = null;

		map = DBUtil.queryOne(sql, null, req);
		if (map == null) {
			return arr;
		}
		arr[0] = StringUtil.getDouble(map.get("hi") + "", 0);
		arr[1] = StringUtil.getDouble(map.get("hihi") + "", 0);

		return arr;
	}

	/*
	 * ! 获得给定字符串的有效值
	 */
	public static String getValueStr(String s) {
		if (2 > 1) {
			return f.v(s);
		}

		if (s == null) {
			return "";
		}
		if (s.indexOf(",") >= 0) {
			try {
				String[] arr = s.split(",");
				return arr[0];
			} catch (Exception e) {
				return "";
			}
		} else {
			return s;
		}
	}

	/*
	 * ! 根据查询sql和request查询数据库，把结果存储到map集合里
	 */
	public static Map getXYValue(String sql, HttpServletRequest req)
			throws Exception {
		Map map = new HashMap();
		List xList = new ArrayList();
		List yList = new ArrayList();

		Connection cn = null;
		Statement stmt = null;
		ResultSet rs = null;

		String infectant_id = req.getParameter("infectant_id").toString();
		Map lcmap = getLch(infectant_id, req);

		String stry = null;
		double dblVal = 0;
		int irow = 0;
		java.sql.Timestamp ts = null;
		try {
			cn = DBUtil.getConn(req);
			stmt = cn.createStatement();
			if (SET_MAXROWS_FLAG > 0) {
				stmt.setMaxRows(MAXROWS);
			}

			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				irow++;
				ts = rs.getTimestamp(1);
				stry = rs.getString(2);
				stry = f.v(stry);
				dblVal = StringUtil.getDouble(stry, 0);
				if (ts != null) {

					xList.add(ts);
					yList.add(stry);
				}
			}
			int i = 0;
			int num = xList.size();
			double[] arry = new double[num];
			java.util.Date[] arrx = new java.util.Date[num];

			for (i = 0; i < num; i++) {
				double yValue = StringUtil.getDouble(yList.get(i) + "", 0);
				if (lcmap.get("max") != null && lcmap.get("min") == null) {
					if (yValue < StringUtil.getDouble(lcmap.get("max") + "", 0)) {
						arry[i] = yValue;
						arrx[i] = (java.util.Date) xList.get(i);
					}
				} else if (lcmap.get("max") == null && lcmap.get("min") != null) {
					if (yValue > StringUtil.getDouble(lcmap.get("min") + "", 0)) {
						arry[i] = yValue;
						arrx[i] = (java.util.Date) xList.get(i);
					}
				} else if (lcmap.get("max") != null && lcmap.get("min") != null) {
					if (yValue > StringUtil.getDouble(lcmap.get("min") + "", 0)
							&& yValue < StringUtil.getDouble(lcmap.get("max")
									+ "", 0)) {
						arry[i] = yValue;
						arrx[i] = (java.util.Date) xList.get(i);
					}
				} else {
					arry[i] = yValue;
					arrx[i] = (java.util.Date) xList.get(i);
				}
			}

			map.put("x", arrx);
			map.put("y", arry);
			return map;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs, stmt, cn);
		}
	}

	/*
	 * ! 根据最大行数maxRow,查询sql和request查询数据库，把结果存储到map集合里
	 */
	public static Map getXYValue(int maxRow, String sql, HttpServletRequest req)
			throws Exception {
		Map map = new HashMap();
		List xList = new ArrayList();
		List yList = new ArrayList();

		Connection cn = null;
		Statement stmt = null;
		ResultSet rs = null;

		String infectant_id = req.getParameter("infectant_id").toString();
		Map lcmap = getLch(infectant_id, req);
		String stry = null;
		double dblVal = 0;
		int irow = 0;
		java.sql.Timestamp ts = null;
		try {
			cn = DBUtil.getConn(req);
			stmt = cn.createStatement();
			if (maxRow > MAXROWS) {
				maxRow = MAXROWS;
			}
			stmt.setMaxRows(maxRow);
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				irow++;
				ts = rs.getTimestamp(1);
				stry = rs.getString(2);
				stry = f.v(stry);
				dblVal = StringUtil.getDouble(stry, 0);
				if (ts != null) {

					xList.add(ts);
					yList.add(stry);
				}
			}
			int i = 0;
			int num = xList.size();
			double[] arry = new double[num];
			java.util.Date[] arrx = new java.util.Date[num];

			for (i = 0; i < num; i++) {
				double yValue = StringUtil.getDouble(yList.get(i) + "", 0);
				if (lcmap.get("max") != null && lcmap.get("min") == null) {
					if (yValue < StringUtil.getDouble(lcmap.get("max") + "", 0)) {
						arry[i] = yValue;
						arrx[i] = (java.util.Date) xList.get(i);
					}
				} else if (lcmap.get("max") == null && lcmap.get("min") != null) {
					if (yValue > StringUtil.getDouble(lcmap.get("min") + "", 0)) {
						arry[i] = yValue;
						arrx[i] = (java.util.Date) xList.get(i);
					}
				} else if (lcmap.get("max") != null && lcmap.get("min") != null) {
					if (yValue > StringUtil.getDouble(lcmap.get("min") + "", 0)
							&& yValue < StringUtil.getDouble(lcmap.get("max")
									+ "", 0)) {
						arry[i] = yValue;
						arrx[i] = (java.util.Date) xList.get(i);
					}
				} else {
					arry[i] = yValue;
					arrx[i] = (java.util.Date) xList.get(i);
				}
			}

			map.put("x", arrx);
			map.put("y", arry);
			return map;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs, stmt, cn);
		}
	}

	/*
	 * ! 根据因子编号infectant_id和request查询数据库，获得因子的报警上下限
	 */
	public static Map getLch(String infectant_id, HttpServletRequest req)
			throws Exception {
		Connection cn = null;
		Statement stmt = null;
		ResultSet rs = null;
		Map map = new HashMap();
		try {
			cn = DBUtil.getConn(req);
			stmt = cn.createStatement();
			String sql = "select t.lo_min,t.hi_max from t_cfg_infectant_base t where t.infectant_id='"
					+ infectant_id + "'";
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				map.put("min", rs.getString("lo_min"));
				map.put("max", rs.getString("hi_max"));
			}
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs, stmt, cn);
		}
		return map;
	}

	/*
	 * !
	 * 根据sql，图表宽度w，图表高度h，顶部高度top,底部高度bottom,左边距left,右边距right和request值，查询数据库，获得图表信息
	 */
	public static String getChart(String sql, int w, int h, int top,
			int bottom, int left, int right, HttpServletRequest req)
			throws Exception {

		Map map = null;
		double[] arry = null;
		java.util.Date[] arrx = null;
		map = getXYValue(sql, req);

		double[] ay = (double[]) map.get("y");
		arry = new double[ay.length + 1];
		for (int x = 0; x < ay.length; x++) {
			arry[x] = ay[x];
		}
		arry[ay.length] = 0d;
		arrx = (java.util.Date[]) map.get("x");

		XYChart c = new XYChart(w, h);

		c.setPlotArea(left, top, w - left - right, h - top - bottom);

		LineLayer lineLayer = c.addLineLayer();

		lineLayer.addDataSet(arry, -1, "").setDataSymbol(Chart.SquareSymbol,
				VALUE_SHAPE_SIZE);

		lineLayer.setLineWidth(1);

		lineLayer.setXData(arrx);

		c.xAxis().setLabelFormat("{value|yy-mm-dd}");

		/*
		 * AreaLayer a1 = c.addAreaLayer(arry, c.yZoneColor(80, -1, 0xff0000));
		 * AreaLayer a2 = c.addAreaLayer(arry, c.yZoneColor(60, -1, 0xffff00));
		 * 
		 * a1.setXData(arrx); a2.setXData(arrx);
		 */

		String chart1URL = c.makeSession(req, "chart1");
		return chart1URL;
	}

	/*
	 * ! 根据sql，图表宽度w，图表高度h，顶部高度top,底部高度bottom,左边距left,右边距right,
	 * 日期格式dateFormat和request值，查询数据库，获得图表信息
	 */
	public static String getChart(String sql, int w, int h, int top,
			int bottom, int left, int right, String dateFormat,
			HttpServletRequest req) throws Exception {

		Map map = null;
		double[] arry = null;
		java.util.Date[] arrx = null;
		map = getXYValue(sql, req);

		double[] ay = (double[]) map.get("y");
		arry = new double[ay.length + 1];
		for (int x = 0; x < ay.length; x++) {
			arry[x] = ay[x];
		}
		arry[ay.length] = 0d;
		arrx = (java.util.Date[]) map.get("x");

		XYChart c = new XYChart(w, h);

		c.setPlotArea(left, top, w - left - right, h - top - bottom);

		LineLayer lineLayer = c.addLineLayer();

		// lineLayer.addDataSet(arry, -1, "").setDataSymbol(Chart.SquareSymbol,
		// 7);
		lineLayer.addDataSet(arry, -1, "").setDataSymbol(Chart.SquareSymbol,
				VALUE_SHAPE_SIZE);
		lineLayer.setLineWidth(1);

		lineLayer.setXData(arrx);

		c.xAxis().setLabelFormat("{value|" + dateFormat + "}");

		/*
		 * AreaLayer a1 = c.addAreaLayer(arry, c.yZoneColor(80, -1, 0xff0000));
		 * AreaLayer a2 = c.addAreaLayer(arry, c.yZoneColor(60, -1, 0xffff00));
		 * 
		 * a1.setXData(arrx); a2.setXData(arrx);
		 */

		String chart1URL = c.makeSession(req, "chart1");
		return chart1URL;
	}

	/*
	 * ! 根据sql，图表宽度w，图表高度h，顶部高度top,底部高度bottom,左边距left,
	 * 右边距right,日期格式dateFormat，颜色color和request值，查询数据库，获得图表信息
	 */
	public static String getChart(String sql, int w, int h, int top,
			int bottom, int left, int right, String dateFormat, int color,
			HttpServletRequest req) throws Exception {

		Map map = null;
		double[] arry = null;
		java.util.Date[] arrx = null;
		map = getXYValue(sql, req);

		double[] ay = (double[]) map.get("y");
		arry = new double[ay.length + 1];
		for (int x = 0; x < ay.length; x++) {
			arry[x] = ay[x];
		}
		arry[ay.length] = 0d;
		arrx = (java.util.Date[]) map.get("x");

		XYChart c = new XYChart(w, h);

		c.setPlotArea(left, top, w - left - right, h - top - bottom);

		LineLayer lineLayer = c.addLineLayer();

		// lineLayer.addDataSet(arry, color,
		// "").setDataSymbol(Chart.SquareSymbol, 7);
		lineLayer.addDataSet(arry, color, "").setDataSymbol(Chart.SquareSymbol,
				VALUE_SHAPE_SIZE);
		lineLayer.setLineWidth(1);

		lineLayer.setXData(arrx);

		c.xAxis().setLabelFormat("{value|" + dateFormat + "}");

		/*
		 * AreaLayer a1 = c.addAreaLayer(arry, c.yZoneColor(80, -1, 0xff0000));
		 * AreaLayer a2 = c.addAreaLayer(arry, c.yZoneColor(60, -1, 0xffff00));
		 * 
		 * a1.setXData(arrx); a2.setXData(arrx);
		 */

		String chart1URL = c.makeSession(req, "chart1");
		return chart1URL;
	}

	/*
	 * ! 根据最大行数maxRows,sql，图表宽度w，图表高度h，顶部高度top,底部高度bottom,左边距left,右边距right，
	 * 日期格式dateFormat和request值，查询数据库，获得图表信息
	 */
	public static String getChart(int maxRows, String sql, int w, int h,
			int top, int bottom, int left, int right, String dateFormat,
			HttpServletRequest req) throws Exception {

		Map map = null;
		double[] arry = null;
		java.util.Date[] arrx = null;
		// map = getXYValue(sql, req);
		map = getXYValue(maxRows, sql, req);
		double[] ay = (double[]) map.get("y");
		arry = new double[ay.length + 1];
		for (int x = 0; x < ay.length; x++) {
			arry[x] = ay[x];
		}
		arry[ay.length] = 0d;
		arrx = (java.util.Date[]) map.get("x");

		XYChart c = new XYChart(w, h);

		c.setPlotArea(left, top, w - left - right, h - top - bottom);

		LineLayer lineLayer = c.addLineLayer();

		lineLayer.addDataSet(arry, -1, "").setDataSymbol(Chart.SquareSymbol,
				VALUE_SHAPE_SIZE);

		lineLayer.setLineWidth(1);

		lineLayer.setXData(arrx);

		c.xAxis().setLabelFormat("{value|" + dateFormat + "}");

		/*
		 * AreaLayer a1 = c.addAreaLayer(arry, c.yZoneColor(80, -1, 0xff0000));
		 * AreaLayer a2 = c.addAreaLayer(arry, c.yZoneColor(60, -1, 0xffff00));
		 * 
		 * a1.setXData(arrx); a2.setXData(arrx);
		 */

		String chart1URL = c.makeSession(req, "chart1");
		return chart1URL;
	}

	/*
	 * ! 根据最大行数maxRows,sql，图表宽度w，图表高度h，顶部高度top,底部高度bottom,左边距left,右边距right，
	 * 日期格式dateFormat,颜色color和request值，查询数据库，获得图表信息
	 */
	public static String getChart(int maxRows, String sql, int w, int h,
			int top, int bottom, int left, int right, String dateFormat,
			int color, HttpServletRequest req) throws Exception {

		Map map = null;
		double[] arry = null;
		java.util.Date[] arrx = null;
		// map = getXYValue(sql, req);
		map = getXYValue(maxRows, sql, req);
		double[] ay = (double[]) map.get("y");
		arry = new double[ay.length + 1];
		for (int x = 0; x < ay.length; x++) {
			arry[x] = ay[x];
		}
		arry[ay.length] = 0d;
		arrx = (java.util.Date[]) map.get("x");

		XYChart c = new XYChart(w, h);

		c.setPlotArea(left, top, w - left - right, h - top - bottom);

		LineLayer lineLayer = c.addLineLayer();

		lineLayer.addDataSet(arry, color, "").setDataSymbol(Chart.SquareSymbol,
				VALUE_SHAPE_SIZE);

		lineLayer.setLineWidth(1);

		lineLayer.setXData(arrx);

		c.xAxis().setLabelFormat("{value|" + dateFormat + "}");

		/*
		 * AreaLayer a1 = c.addAreaLayer(arry, c.yZoneColor(80, -1, 0xff0000));
		 * AreaLayer a2 = c.addAreaLayer(arry, c.yZoneColor(60, -1, 0xffff00));
		 * 
		 * a1.setXData(arrx); a2.setXData(arrx);
		 */

		String chart1URL = c.makeSession(req, "chart1");
		return chart1URL;
	}

	/*
	 * !
	 * 根据数据集合sqlList，图表宽度w，图表高度h，顶部高度top,底部高度bottom,左边距left,右边距right和request值，查询数据库
	 * ，获得图表信息
	 */
	public static String getChart(List sqlList, int w, int h, int top,
			int bottom, int left, int right, HttpServletRequest req)
			throws Exception {

		Map map = null;
		double[] arry = null;
		java.util.Date[] arrx = null;
		// map = getXYValue(sql,req);
		String sql = null;
		String sqlName = null;
		Map sqlMap = null;
		int i = 0;
		int num = 0;

		XYChart c = new XYChart(w, h);

		c.setPlotArea(left, top, w - left - right, h - top - bottom);

		c.setDefaultFonts("宋体");

		c.addLegend(70, 1, false, "", 8).setBackground(Chart.Transparent);

		LineLayer lineLayer = null;

		num = sqlList.size();

		for (i = 0; i < num; i++) {
			sqlMap = (Map) sqlList.get(i);
			sql = (String) sqlMap.get("sql");
			sqlName = (String) sqlMap.get("name");

			map = getXYValue(sql, req);
			double[] ay = (double[]) map.get("y");
			arry = new double[ay.length + 1];
			for (int x = 0; x < ay.length; x++) {
				arry[x] = ay[x];
			}
			arry[ay.length] = 0d;
			arrx = (java.util.Date[]) map.get("x");

			lineLayer = c.addLineLayer();

			lineLayer.addDataSet(arry, -1, sqlName).setDataSymbol(
					Chart.SquareSymbol, VALUE_SHAPE_SIZE);

			lineLayer.setLineWidth(2);

			lineLayer.setXData(arrx);
		}// end for

		c.xAxis().setLabelFormat("{value|yy-mm-dd}");

		String chart1URL = c.makeSession(req, "chart1");
		return chart1URL;

	}

	/*
	 * !
	 * 根据最大行数num，图表宽度w，图表高度h，顶部高度top,底部高度bottom,左边距left,右边距right和request值，查询数据库
	 * ，获得图表信息
	 */
	public static String getRealChart(int num, int w, int h, int top,
			int bottom, int left, int right, HttpServletRequest req)
			throws Exception {
		String url = null;
		String station_id = req.getParameter("station_id");
		String infectant_id = req.getParameter("infectant_id");

		String sql = "select m_time,m_value from t_monitor_real_minute ";
		sql = sql + "where station_id='" + station_id + "' and ";
		sql = sql + "infectant_id='" + infectant_id + "' ";
		sql = sql + "order by m_time desc";
		url = getChartWithLimit(num, sql, w, h, top, bottom, left, right,
				"yy-mm-dd-hh-nn", req);

		return url;
	}

	/*
	 * ! 根据最大行数maxRows,sql，图表宽度w，图表高度h，顶部高度top,底部高度bottom,左边距left,右边距right，
	 * 报警值数组arrLimitVal和request值，查询数据库，获得图表信息
	 */
	public static String getChartWithLimit(String sql, int w, int h, int top,
			int bottom, int left, int right, double[] arrLimitVal,
			HttpServletRequest req) throws Exception {

		Map map = null;
		double[] arry = null;
		java.util.Date[] arrx = null;
		map = getXYValue(sql, req);

		double hi = arrLimitVal[0];
		double hihi = arrLimitVal[0];

		double[] ay = (double[]) map.get("y");
		arry = new double[ay.length + 1];
		for (int x = 0; x < ay.length; x++) {
			arry[x] = ay[x];
		}
		arry[ay.length] = 0d;
		arrx = (java.util.Date[]) map.get("x");

		XYChart c = new XYChart(w, h);

		c.setPlotArea(left, top, w - left - right, h - top - bottom);

		LineLayer lineLayer = c.addLineLayer();

		// lineLayer.addDataSet(arry, -1, "").setDataSymbol(Chart.SquareSymbol,
		// 7);
		lineLayer.addDataSet(arry, 0x00ff00, "").setDataSymbol(
				Chart.SquareSymbol, VALUE_SHAPE_SIZE);
		lineLayer.setLineWidth(1);

		lineLayer.setXData(arrx);

		c.xAxis().setLabelFormat("{value|yy-mm-dd}");

		AreaLayer a1 = null;
		AreaLayer a2 = null;

		if (hi > 0) {
			a1 = c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xff0000));
			a1.setXData(arrx);
		}
		if (hihi > 0) {
			a2 = c.addAreaLayer(arry, c.yZoneColor(hihi, -1, 0xff0000));
			a2.setXData(arrx);
		}

		String chart1URL = c.makeSession(req, "chart1");
		return chart1URL;

	}

	/*
	 * ! 根据sql，图表宽度w，图表高度h，顶部高度top,底部高度bottom,左边距left,右边距right，
	 * 日期格式dateFormat,报警值数组arrLimitVal和request值，查询数据库，获得图表信息
	 */
	public static String getChartWithLimit(String sql, int w, int h, int top,
			int bottom, int left, int right, String dateFormat,
			double[] arrLimitVal, HttpServletRequest req) throws Exception {

		Map map = null;
		double[] arry = null;
		java.util.Date[] arrx = null;
		map = getXYValue(sql, req);

		double hi = arrLimitVal[0];
		double hihi = arrLimitVal[1];

		double[] ay = (double[]) map.get("y");
		arry = new double[ay.length + 1];
		for (int x = 0; x < ay.length; x++) {
			arry[x] = ay[x];
		}
		arry[ay.length] = 0d;
		arrx = (java.util.Date[]) map.get("x");

		XYChart c = new XYChart(w, h);

		c.setPlotArea(left, top, w - left - right, h - top - bottom);

		LineLayer lineLayer = c.addLineLayer();

		// lineLayer.addDataSet(arry, -1, "").setDataSymbol(Chart.SquareSymbol,
		// 7);
		lineLayer.addDataSet(arry, 0x00ff00, "").setDataSymbol(
				Chart.SquareSymbol, VALUE_SHAPE_SIZE);

		lineLayer.setLineWidth(1);

		lineLayer.setXData(arrx);

		c.xAxis().setLabelFormat("{value|" + dateFormat + "}");

		AreaLayer a1 = null;
		AreaLayer a2 = null;

		if (hihi > 0) {
			a2 = c.addAreaLayer(arry, c.yZoneColor(hihi, -1, 0xff0000));
			a2.setXData(arrx);
			// c.addAreaLayer(arry, c.yZoneColor(hihi, -1, 0xffff00));
		}

		if (hi > 0) {
			// a1 = c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xff0000));
			a1 = c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xffff00));
			a1.setXData(arrx);
			// c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xff0000));
		}
		// c.yAxis().setLinearScale();

		String chart1URL = c.makeSession(req, "chart1");
		return chart1URL;

	}

	/*
	 * ! 根据最大行数maxRows,sql，图表宽度w，图表高度h，顶部高度top,底部高度bottom,左边距left,右边距right，
	 * 日期格式dateFormat和request值，查询数据库，获得图表信息
	 */
	public static String getChartWithLimit(int maxRows, String sql, int w,
			int h, int top, int bottom, int left, int right, String dateFormat,
			HttpServletRequest req) throws Exception {

		Map map = null;
		double[] arry = null;
		java.util.Date[] arrx = null;
		map = getXYValue(maxRows, sql, req);

		String station_id = req.getParameter("station_id");
		String infectant_id = req.getParameter("infectant_id");

		double[] arrLimitVal = getLimitValue(station_id, infectant_id, req);

		double hi = arrLimitVal[0];
		double hihi = arrLimitVal[1];

		double[] ay = (double[]) map.get("y");
		arry = new double[ay.length + 1];
		for (int x = 0; x < ay.length; x++) {
			arry[x] = ay[x];
		}
		arry[ay.length] = 0d;
		arrx = (java.util.Date[]) map.get("x");

		XYChart c = new XYChart(w, h);

		c.setPlotArea(left, top, w - left - right, h - top - bottom);

		LineLayer lineLayer = c.addLineLayer();

		// lineLayer.addDataSet(arry, -1, "").setDataSymbol(Chart.SquareSymbol,
		// 7);
		lineLayer.addDataSet(arry, 0x00ff00, "").setDataSymbol(
				Chart.SquareSymbol, VALUE_SHAPE_SIZE);
		lineLayer.setLineWidth(1);

		lineLayer.setXData(arrx);

		c.xAxis().setLabelFormat("{value|" + dateFormat + "}");

		AreaLayer a1 = null;
		AreaLayer a2 = null;

		if (hihi > 0) {
			a2 = c.addAreaLayer(arry, c.yZoneColor(hihi, -1, 0xff0000));
			a2.setXData(arrx);
			// c.addAreaLayer(arry, c.yZoneColor(hihi, -1, 0xffff00));
		}

		if (hi > 0) {
			// a1 = c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xff0000));
			a1 = c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xffff00));
			a1.setXData(arrx);
			// c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xff0000));
		}

		String chart1URL = c.makeSession(req, "chart1");
		return chart1URL;

	}

	/*
	 * ! 根据sql,日期格式dateFormat,报警值数组arrLimitVal和request值，查询数据库，获得图表信息
	 */
	public static String getChart(String sql, String dateFormat,
			double[] arrLimitVal, HttpServletRequest req) throws Exception {
		int w = 750;
		int h = 280;
		int left = 50;
		int right = 20;
		int top = 5;
		int bottom = 20;
		return getChartWithLimit(sql, w, h, top, bottom, left, right,
				dateFormat, arrLimitVal, req);

	}

	/*
	 * ! 根据数据库连接cn和因子编号infectant_id获得图表的标题
	 */
	public static String getChartTitle(Connection cn, String infectant_id)
			throws Exception {
		String s = "";
		String sql = null;
		Map map = null;

		sql = "select infectant_id,infectant_name,english_name,infectant_unit ";
		sql = sql + "from t_cfg_infectant_base ";
		sql = sql + "where infectant_id='" + infectant_id + "'";

		map = DBUtil.queryOne(cn, sql, null);
		s = map.get("infectant_name") + "(";
		s = s + map.get("english_name") + ") ";
		s = s + map.get("infectant_unit");

		return s;
	}

	/*
	 * ! 根据request和因子编号infectant_id获得图表的标题
	 */
	public static String getChartTitle(String infectant_id,
			HttpServletRequest req) throws Exception {
		Connection cn = null;
		try {
			cn = DBUtil.getConn(req);
			return getChartTitle(cn, infectant_id);
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
	}

	public static String getLineAnyChart(String sql, String dateFormat,
			String title, double[] arrLimitVal, HttpServletRequest req,
			String table) throws Exception {
		int w = 750;
		int h = 320;
		int left = 35;
		int right = 10;
		int top = 20;
		int bottom = 20;
		String ws, hs;
		ws = req.getParameter("w");
		hs = req.getParameter("h");

		w = f.getInt(ws, 750);
		h = f.getInt(hs, 300);

		w = w - 30;
		h = h - 30;
		/*System.out.println("table==="+table);
		System.out.println(sql);*/
		return getChartWithLimit(sql, w, h, top, bottom, left, right,
				dateFormat, title, arrLimitVal, req, table);
	}
	
	public static String getBarAnyChart(String sql, String dateFormat,
			String title, double[] arrLimitVal, HttpServletRequest req,
			String table) throws Exception {
		int w = 750;
		int h = 320;
		int left = 35;
		int right = 10;
		int top = 20;
		int bottom = 20;
		String ws, hs;
		ws = req.getParameter("w");
		hs = req.getParameter("h");

		w = f.getInt(ws, 750);
		h = f.getInt(hs, 300);

		w = w - 30;
		h = h - 30;
/*
			System.out.println("table==="+table);
			System.out.println(sql);
			
			*/
		return getBarChart(sql, w, h, top, bottom, left, right,
				dateFormat, title, arrLimitVal, req, table);
	}

	public static String getBarChart(String sql, int w, int h, int top,
			int bottom, int left, int right, String dateFormat, String title,
			double[] arrLimitVal, HttpServletRequest req, String table)
			throws Exception {
		String xmlString = "<?xml version='1.0' encoding='UTF-8'?>";
		 xmlString += "<anychart><settings><animation enabled='True'/></settings>"
				+ "<charts><chart plot_type='CategorizedVertical'>"
				+ "<data_plot_settings default_series_type='Bar' enable_3d_mode='True' z_aspect='2.5'>"
				+ "<bar_series point_padding='0.5' group_padding='1'>"
				+ "<tooltip_settings enabled='true'><format>{%Name}\nValue: {%YValue}</format></tooltip_settings>"
				+ "</bar_series></data_plot_settings><chart_settings><title enabled='true'>"
				+ "<text>" +title+
				"</text></title><axes><y_axis><title><text>数值</text></title></y_axis> <x_axis><labels />"
				+ "<title><text>日期</text></title></x_axis></axes>"
				+ "<chart_background enabled='false'/> </chart_settings> <data><series name='Series 1' palette='Default'>";
			
			
		//System.out.println("哪个表==="+table );
		int[] dd = { 0, 10 };// 截取时间长度的显示起始参数值
		Map map = null;
		double[] arry = null;
		java.util.Date[] arrx = null;
		map = getXYValue(sql, req);
		int i, num = 0;
		java.util.Date d = null;


		double[] ay = (double[]) map.get("y");
		arry = new double[ay.length + 1];
		for (int x = 0; x < ay.length; x++) {
			arry[x] = ay[x];
		}
		arry[ay.length] = 0d;

		arrx = (java.util.Date[]) map.get("x");

		if (table != null){
				if (table.endsWith("hour") || table.endsWith("hour_v")) {
			dd = new int[] { 5, 16 };
			for (int j = arrx.length - 1; j >= 0; j--) {
				xmlString += "<point name='"
						+ arrx[j].toString().substring(dd[0], dd[1]) + "' y='"
						+ arry[j] + "' />";
			}
		} else {
			for (int j2 = 0; j2 < arrx.length; j2++) {
				xmlString += "<point name='"
						+ arrx[j2].toString().substring(dd[0], dd[1]) + "' y='"
						+ arry[j2] + "' />";
			}

		}
		}
		xmlString += "</series>";
		xmlString += "</data></chart></charts></anychart>";
		return xmlString;
		
		
	}

	public static String getChartWithLimit(String sql, int w, int h, int top,
			int bottom, int left, int right, String dateFormat, String title,
			double[] arrLimitVal, HttpServletRequest req, String table)
			throws Exception {
		
		
		
		 String xmlString = "<?xml version='1.0' encoding='UTF-8'?>";
			xmlString += "<anychart><settings><animation enabled='True' /></settings><charts><chart plot_type='CategorizedVertical'>"
					+ "<chart_settings><title><text>"
					+ title
					+ "</text><background enabled='false' /></title><chart_background enabled='false'/> "
					+ "<axes><y_axis><title> <text>数值"
					+ "</text></title></y_axis> <x_axis tickmarks_placement='Center'><labels />"
					+ "<title> <text>时间</text></title></x_axis></axes></chart_settings><data_plot_settings default_series_type='Line'>"
					+ "<line_series><tooltip_settings enabled='true'><format>"
					+ "日期:{%Name} \n"
					+ " 值: {%YValue}{numDecimals:0}"
					+ "</format></tooltip_settings> </line_series></data_plot_settings><data><series>";
		
		
	
		String bar = req.getParameter("bar");
		String flag_3d = req.getParameter("flag_3d");
		int[] dd = { 0, 10 };// 截取时间长度的显示起始参数值
		Map map = null;
		double[] arry = null;
		java.util.Date[] arrx = null;
		map = getXYValue(sql, req);
		int i, num = 0;
		java.util.Date d = null;
		java.util.Date[] dateArr = getStartEndDate(req);

		double hi = arrLimitVal[0];
		double hihi = arrLimitVal[1];

		double[] ay = (double[]) map.get("y");
		arry = new double[ay.length + 1];
		for (int x = 0; x < ay.length; x++) {
			arry[x] = ay[x];
		}
		arry[ay.length] = 0d;

		arrx = (java.util.Date[]) map.get("x");

		if (table != null){
				if (table.endsWith("hour") || table.endsWith("hour_v")||table.endsWith("minute") || table.endsWith("minute_v")) {
			dd = new int[] { 5, 16 };
			for (int j = arrx.length - 1; j >= 0; j--) {
				xmlString += "<point name='"
						+ arrx[j].toString().substring(dd[0], dd[1]) + "' y='"
						+ arry[j] + "' />";
			}
		} else {
			for (int j2 = 0; j2 < arrx.length; j2++) {
				xmlString += "<point name='"
						+ arrx[j2].toString().substring(dd[0], dd[1]) + "' y='"
						+ arry[j2] + "' />";
			}

		}
		}
		xmlString += "</series>";
		xmlString += "</data></chart></charts></anychart>";

		String date_axis_fix_flag = null;

		date_axis_fix_flag = req.getParameter("date_axis_fix_flag");

		// System.out.println(req.getParameter("data_type"));
		XYChart c = new XYChart(w, h);

		// c.set3D();

		c.setPlotArea(left, top, w - left - right, h - top - bottom);

		// c.addTitle("测试趋势图", "宋体", 13, 0xffffff).setBackground(0x800080, -1,
		// 1);
		// c.addTitle(title, "宋体", 13, 0xffffff).setBackground(0x800080, -1, 1);
		// c.addTitle(title, "宋体", 13, 0xffffff);
		// c.addTitle(title, "宋体", 8, 0xffffff).setBackground(0x000000, -1, 1);
		c.addTitle(title, "宋体", FONT_SIZE, TITLE_FONT_COLOR);

		if (StringUtil.equals(bar, "1")) {
			BarLayer barLayer = null;
			barLayer = c.addBarLayer(arry);
			if (StringUtil.equals(flag_3d, "1")) {
				barLayer.set3D();
			}
			barLayer.setXData(arrx);

			if (StringUtil.equals(date_axis_fix_flag, "1")) {
				c.xAxis().setDateScale(dateArr[0], dateArr[1]);
			}

			c.xAxis().setLabelFormat("{value|" + dateFormat + "}");

			// c.addInterLineLayer(null,c.yAxis().addMark(hihi,
			// 0xff0000,hihi+"").getLine(),-1);
			if (hihi > 0) {
				// c.addInterLineLayer(null,c.yAxis().addMark(hihi,
				// 0xff0000,hihi+"").getLine(),-1);//黄宝修改
				c.addInterLineLayer(null,
						c.yAxis().addMark(hihi, 0xff0000, ((int) hihi) + "")
								.getLine(), -1);
			}
			if (hi > 0) {
				// c.addInterLineLayer(null,c.yAxis().addMark(hihi,
				// 0xff0000,hi+"").getLine(),-1);//黄宝修改
				c.addInterLineLayer(null,
						c.yAxis().addMark(hi, 0xff0000, ((int) hi) + "")
								.getLine(), -1);
			}
			return c.makeSession(req, "chart1");
		}

		LineLayer lineLayer = c.addLineLayer();
		if (StringUtil.equals(flag_3d, "1")) {
			lineLayer.set3D();
		}
		// LineLayer lineLayer = c.addLineLayer().set3D();

		// lineLayer.addDataSet(arry, -1, "").setDataSymbol(Chart.SquareSymbol,
		// 7);

		// lineLayer.addDataSet(arry, 0x00ff00,
		// "").setDataSymbol(Chart.SquareSymbol, VALUE_SHAPE_SIZE);
		// lineLayer.addDataSet(arry, 0x00ff00, "");
		int x_num = arrx.length;
		if (x_num < max_num_show_shape) {
			lineLayer.addDataSet(arry, LINE_COLOR, "").setDataSymbol(
					Chart.SquareSymbol, VALUE_SHAPE_SIZE);
		} else {

			lineLayer.addDataSet(arry, LINE_COLOR, "");
		}

		// lineLayer.set3D();
		lineLayer.setLineWidth(LINE_WIDTH);

		lineLayer.setXData(arrx);

		c.xAxis().setLabelFormat("{value|" + dateFormat + "}");

		if (StringUtil.equals(date_axis_fix_flag, "1")) {
			c.xAxis().setDateScale(dateArr[0], dateArr[1]);
		}

		// System.out.println(date_axis_fix_flag);

		AreaLayer a1 = null;
		AreaLayer a2 = null;

		if (hihi > 0) {

			a2 = c.addAreaLayer(arry, c.yZoneColor(hihi, -1, 0xff0000));
			a2.setXData(arrx);
			// c.addAreaLayer(arry, c.yZoneColor(hihi, -1, 0xffff00));
			// 报警线 20070926
			// c.addInterLineLayer(lineLayer.getLine(0),c.yAxis().addMark(hihi,
			// 0xff0000,hihi+"").getLine(),-1);//黄宝修改
			c.addInterLineLayer(lineLayer.getLine(0),
					c.yAxis().addMark(hihi, 0xff0000, ((int) hihi) + "")
							.getLine(), -1);
		}

		if (hi > 0) {
			// a1 = c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xff0000));
			a1 = c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xffff00));
			a1.setXData(arrx);

			// c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xff0000));

			// 预警线 20070926
			// c.addInterLineLayer(lineLayer.getLine(0),c.yAxis().addMark(hi,
			// 0xffff00,hi+"").getLine(),-1);//黄宝修改
			c.addInterLineLayer(lineLayer.getLine(0),
					c.yAxis().addMark(hi, 0xffff00, ((int) hi) + "").getLine(),
					-1);
			// System.out.println(hi);
		}
		// c.yAxis().setLinearScale(lolo,hihi);
		// System.out.println(hi+","+hihi+","+StringUtil.getNowTime());

		String chart1URL = c.makeSession(req, "chart1");
		return xmlString;
	}

	/*
	 * ! 根据最大行数maxRows,sql，图表宽度w，图表高度h，顶部高度top,底部高度bottom,左边距left,右边距right，
	 * 日期格式dateFormat,图表标题title,报警值数组arrlimitVal和request值，查询数据库，获得图表信息
	 */
	public static String getChartWithLimit(String sql, int w, int h, int top,
			int bottom, int left, int right, String dateFormat, String title,
			double[] arrLimitVal, HttpServletRequest req) throws Exception {

		String bar = req.getParameter("bar");
		String flag_3d = req.getParameter("flag_3d");
		Map map = null;
		double[] arry = null;
		java.util.Date[] arrx = null;
		map = getXYValue(sql, req);
		int i, num = 0;
		java.util.Date d = null;
		java.util.Date[] dateArr = getStartEndDate(req);

		double hi = arrLimitVal[0];
		double hihi = arrLimitVal[1];

		double[] ay = (double[]) map.get("y");
		arry = new double[ay.length + 1];
		for (int x = 0; x < ay.length; x++) {
			arry[x] = ay[x];
		}
		arry[ay.length] = 0d;

		arrx = (java.util.Date[]) map.get("x");

		String date_axis_fix_flag = null;

		date_axis_fix_flag = req.getParameter("date_axis_fix_flag");

		// System.out.println(req.getParameter("data_type"));
		XYChart c = new XYChart(w, h);

		// c.set3D();
		c.setPlotArea(left, top, w - left - right, h - top - bottom);

		// c.addTitle("测试趋势图", "宋体", 13, 0xffffff).setBackground(0x800080, -1,
		// 1);
		// c.addTitle(title, "宋体", 13, 0xffffff).setBackground(0x800080, -1, 1);
		// c.addTitle(title, "宋体", 13, 0xffffff);
		// c.addTitle(title, "宋体", 8, 0xffffff).setBackground(0x000000, -1, 1);
		c.addTitle(title, "宋体", FONT_SIZE, TITLE_FONT_COLOR);

		if (StringUtil.equals(bar, "1")) {
			BarLayer barLayer = null;
			barLayer = c.addBarLayer(arry);
			if (StringUtil.equals(flag_3d, "1")) {
				barLayer.set3D();
			}
			barLayer.setXData(arrx);

			if (StringUtil.equals(date_axis_fix_flag, "1")) {
				c.xAxis().setDateScale(dateArr[0], dateArr[1]);
			}

			c.xAxis().setLabelFormat("{value|" + dateFormat + "}");

			// c.addInterLineLayer(null,c.yAxis().addMark(hihi,
			// 0xff0000,hihi+"").getLine(),-1);
			if (hihi > 0) {
				// c.addInterLineLayer(null,c.yAxis().addMark(hihi,
				// 0xff0000,hihi+"").getLine(),-1);//黄宝修改
				c.addInterLineLayer(null,
						c.yAxis().addMark(hihi, 0xff0000, ((int) hihi) + "")
								.getLine(), -1);
			}
			if (hi > 0) {
				// c.addInterLineLayer(null,c.yAxis().addMark(hihi,
				// 0xff0000,hi+"").getLine(),-1);//黄宝修改
				c.addInterLineLayer(null,
						c.yAxis().addMark(hi, 0xff0000, ((int) hi) + "")
								.getLine(), -1);
			}
			return c.makeSession(req, "chart1");
		}

		LineLayer lineLayer = c.addLineLayer();
		if (StringUtil.equals(flag_3d, "1")) {
			lineLayer.set3D();
		}
		// LineLayer lineLayer = c.addLineLayer().set3D();

		// lineLayer.addDataSet(arry, -1, "").setDataSymbol(Chart.SquareSymbol,
		// 7);

		// lineLayer.addDataSet(arry, 0x00ff00,
		// "").setDataSymbol(Chart.SquareSymbol, VALUE_SHAPE_SIZE);
		// lineLayer.addDataSet(arry, 0x00ff00, "");
		int x_num = arrx.length;
		if (x_num < max_num_show_shape) {
			lineLayer.addDataSet(arry, LINE_COLOR, "").setDataSymbol(
					Chart.SquareSymbol, VALUE_SHAPE_SIZE);
		} else {

			lineLayer.addDataSet(arry, LINE_COLOR, "");
		}

		// lineLayer.set3D();
		lineLayer.setLineWidth(LINE_WIDTH);

		lineLayer.setXData(arrx);

		c.xAxis().setLabelFormat("{value|" + dateFormat + "}");

		if (StringUtil.equals(date_axis_fix_flag, "1")) {
			c.xAxis().setDateScale(dateArr[0], dateArr[1]);
		}

		// System.out.println(date_axis_fix_flag);

		AreaLayer a1 = null;
		AreaLayer a2 = null;

		if (hihi > 0) {

			a2 = c.addAreaLayer(arry, c.yZoneColor(hihi, -1, 0xff0000));
			a2.setXData(arrx);
			// c.addAreaLayer(arry, c.yZoneColor(hihi, -1, 0xffff00));
			// 报警线 20070926
			// c.addInterLineLayer(lineLayer.getLine(0),c.yAxis().addMark(hihi,
			// 0xff0000,hihi+"").getLine(),-1);//黄宝修改
			c.addInterLineLayer(lineLayer.getLine(0),
					c.yAxis().addMark(hihi, 0xff0000, ((int) hihi) + "")
							.getLine(), -1);
		}

		if (hi > 0) {
			// a1 = c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xff0000));
			a1 = c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xffff00));
			a1.setXData(arrx);

			// c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xff0000));

			// 预警线 20070926
			// c.addInterLineLayer(lineLayer.getLine(0),c.yAxis().addMark(hi,
			// 0xffff00,hi+"").getLine(),-1);//黄宝修改
			c.addInterLineLayer(lineLayer.getLine(0),
					c.yAxis().addMark(hi, 0xffff00, ((int) hi) + "").getLine(),
					-1);
			// System.out.println(hi);
		}
		// c.yAxis().setLinearScale(lolo,hihi);
		// System.out.println(hi+","+hihi+","+StringUtil.getNowTime());

		String chart1URL = c.makeSession(req, "chart1");
		return chart1URL;
	}

	
	
	//	实时数据xmlString
	public static String getLineChartWithLimit(int maxRows, String sql, int w,
			int h, int top, int bottom, int left, int right, String dateFormat,
			String title, HttpServletRequest req) throws Exception {

		Map map = null;
		double[] arry = null;
		java.util.Date[] arrx = null;
		map = getXYValue(maxRows, sql, req);

		String station_id = req.getParameter("station_id");
		String infectant_id = req.getParameter("infectant_id");
		int[] dd = { 11, 16 };// 截取时间长度的显示起始参数值
		double[] arrLimitVal = getLimitValue(station_id, infectant_id, req);
		
		double hi = arrLimitVal[0];
		double hihi = arrLimitVal[1];

		double[] ay = (double[]) map.get("y");
		arry = new double[ay.length + 1];
		for (int x = 0; x < ay.length; x++) {
			arry[x] = ay[x];
		}
		arry[ay.length] = 0d;
		arrx = (java.util.Date[]) map.get("x");
		
		
		String xmlString = "<?xml version='1.0' encoding='UTF-8'?>";
		xmlString += "<anychart><settings><animation enabled='True' /></settings><charts><chart plot_type='CategorizedVertical'>"
				+ "<chart_settings><title><text>"
				+ title
				+ "</text><background enabled='false' /></title><chart_background enabled='false'/> "
				+ "<axes><y_axis><title> <text>数值"
				+ "</text></title></y_axis> <x_axis tickmarks_placement='Center'><labels />"
				+ "<title> <text>时间</text></title></x_axis></axes></chart_settings><data_plot_settings default_series_type='Line'>"
				+ "<line_series><tooltip_settings enabled='true'><format>"
				+ "日期:{%Name} \n"
				+ " 值: {%YValue}{numDecimals:0}"
				+ "</format></tooltip_settings> </line_series></data_plot_settings><data><series>";
		
		for(int j=0;j<arrx.length;j++) {
			xmlString += "<point name='"
					+ arrx[j].toString().substring(dd[0], dd[1]) + "' y='"
					+ arry[j] + "' />";
		}
		xmlString += "</series>";
		xmlString += "</data></chart></charts></anychart>";

		XYChart c = new XYChart(w, h);

		c.setPlotArea(left, top, w - left - right, h - top - bottom);
		c.addTitle(title, "宋体", FONT_SIZE, TITLE_FONT_COLOR);
		LineLayer lineLayer = c.addLineLayer();

		// lineLayer.addDataSet(arry, -1, "").setDataSymbol(Chart.SquareSymbol,
		// 7);
		lineLayer.addDataSet(arry, 0x00ff00, "").setDataSymbol(
				Chart.SquareSymbol, VALUE_SHAPE_SIZE);
		lineLayer.setLineWidth(1);

		lineLayer.setXData(arrx);

		c.xAxis().setLabelFormat("{value|" + dateFormat + "}");

		AreaLayer a1 = null;
		AreaLayer a2 = null;

		if (hihi > 0) {
			a2 = c.addAreaLayer(arry, c.yZoneColor(hihi, -1, 0xff0000));
			a2.setXData(arrx);
			// c.addAreaLayer(arry, c.yZoneColor(hihi, -1, 0xffff00));
			c.addInterLineLayer(lineLayer.getLine(0),
					c.yAxis().addMark(hihi, 0xff0000, hihi + "").getLine(), -1);
		}

		if (hi > 0) {
			// a1 = c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xff0000));
			a1 = c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xffff00));
			a1.setXData(arrx);
			// c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xff0000));
			c.addInterLineLayer(lineLayer.getLine(0),
					c.yAxis().addMark(hi, 0xffff00, hi + "").getLine(), -1);
		}

		String chart1URL = c.makeSession(req, "chart1");
		return xmlString;

	}
//	实时数据xmlString
	public static String getBarChartWithLimit(int maxRows, String sql, int w,
			int h, int top, int bottom, int left, int right, String dateFormat,
			String title, HttpServletRequest req) throws Exception {

		Map map = null;
		double[] arry = null;
		java.util.Date[] arrx = null;
		map = getXYValue(maxRows, sql, req);

		String station_id = req.getParameter("station_id");
		String infectant_id = req.getParameter("infectant_id");
		int[] dd = { 11, 16 };// 截取时间长度的显示起始参数值
		double[] arrLimitVal = getLimitValue(station_id, infectant_id, req);
		
		double hi = arrLimitVal[0];
		double hihi = arrLimitVal[1];

		double[] ay = (double[]) map.get("y");
		arry = new double[ay.length + 1];
		for (int x = 0; x < ay.length; x++) {
			arry[x] = ay[x];
		}
		arry[ay.length] = 0d;
		arrx = (java.util.Date[]) map.get("x");
		
		
		String xmlString = "<?xml version='1.0' encoding='UTF-8'?>";
		 xmlString += "<anychart><settings><animation enabled='True'/></settings>"
				+ "<charts><chart plot_type='CategorizedVertical'>"
				+ "<data_plot_settings default_series_type='Bar' enable_3d_mode='True' z_aspect='2.5'>"
				+ "<bar_series point_padding='0.5' group_padding='1'>"
				+ "<tooltip_settings enabled='true'><format>{%Name}\nValue: {%YValue}</format></tooltip_settings>"
				+ "</bar_series></data_plot_settings><chart_settings><title enabled='true'>"
				+ "<text>" +title+
				"</text></title><axes><y_axis><title><text>数值</text></title></y_axis> <x_axis><labels />"
				+ "<title><text>日期</text></title></x_axis></axes>"
				+ "<chart_background enabled='false'/> </chart_settings> <data><series name='Series 1' palette='Default'>";
			
		for(int j=0;j<arrx.length;j++) {
			xmlString += "<point name='"
					+ arrx[j].toString().substring(dd[0], dd[1]) + "' y='"
					+ arry[j] + "' />";
		}
		xmlString += "</series>";
		xmlString += "</data></chart></charts></anychart>";

		XYChart c = new XYChart(w, h);

		c.setPlotArea(left, top, w - left - right, h - top - bottom);
		c.addTitle(title, "宋体", FONT_SIZE, TITLE_FONT_COLOR);
		LineLayer lineLayer = c.addLineLayer();

		// lineLayer.addDataSet(arry, -1, "").setDataSymbol(Chart.SquareSymbol,
		// 7);
		lineLayer.addDataSet(arry, 0x00ff00, "").setDataSymbol(
				Chart.SquareSymbol, VALUE_SHAPE_SIZE);
		lineLayer.setLineWidth(1);

		lineLayer.setXData(arrx);

		c.xAxis().setLabelFormat("{value|" + dateFormat + "}");

		AreaLayer a1 = null;
		AreaLayer a2 = null;

		if (hihi > 0) {
			a2 = c.addAreaLayer(arry, c.yZoneColor(hihi, -1, 0xff0000));
			a2.setXData(arrx);
			// c.addAreaLayer(arry, c.yZoneColor(hihi, -1, 0xffff00));
			c.addInterLineLayer(lineLayer.getLine(0),
					c.yAxis().addMark(hihi, 0xff0000, hihi + "").getLine(), -1);
		}

		if (hi > 0) {
			// a1 = c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xff0000));
			a1 = c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xffff00));
			a1.setXData(arrx);
			// c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xff0000));
			c.addInterLineLayer(lineLayer.getLine(0),
					c.yAxis().addMark(hi, 0xffff00, hi + "").getLine(), -1);
		}

		String chart1URL = c.makeSession(req, "chart1");
		return xmlString;

	}
	
	
	
	
	/*
	 * ! 根据最大行数maxRows,sql，图表宽度w，图表高度h，顶部高度top,底部高度bottom,左边距left,右边距right，
	 * 日期格式dateFormat,图表标题title和request值，查询数据库，获得图表信息
	 */
	public static String getChartWithLimit(int maxRows, String sql, int w,
			int h, int top, int bottom, int left, int right, String dateFormat,
			String title, HttpServletRequest req) throws Exception {

		Map map = null;
		double[] arry = null;
		java.util.Date[] arrx = null;
		map = getXYValue(maxRows, sql, req);

		String station_id = req.getParameter("station_id");
		String infectant_id = req.getParameter("infectant_id");

		double[] arrLimitVal = getLimitValue(station_id, infectant_id, req);

		double hi = arrLimitVal[0];
		double hihi = arrLimitVal[1];

		double[] ay = (double[]) map.get("y");
		arry = new double[ay.length + 1];
		for (int x = 0; x < ay.length; x++) {
			arry[x] = ay[x];
		}
		arry[ay.length] = 0d;
		arrx = (java.util.Date[]) map.get("x");

		XYChart c = new XYChart(w, h);

		c.setPlotArea(left, top, w - left - right, h - top - bottom);
		c.addTitle(title, "宋体", FONT_SIZE, TITLE_FONT_COLOR);
		LineLayer lineLayer = c.addLineLayer();

		// lineLayer.addDataSet(arry, -1, "").setDataSymbol(Chart.SquareSymbol,
		// 7);
		lineLayer.addDataSet(arry, 0x00ff00, "").setDataSymbol(
				Chart.SquareSymbol, VALUE_SHAPE_SIZE);
		lineLayer.setLineWidth(1);

		lineLayer.setXData(arrx);

		c.xAxis().setLabelFormat("{value|" + dateFormat + "}");

		AreaLayer a1 = null;
		AreaLayer a2 = null;

		if (hihi > 0) {
			a2 = c.addAreaLayer(arry, c.yZoneColor(hihi, -1, 0xff0000));
			a2.setXData(arrx);
			// c.addAreaLayer(arry, c.yZoneColor(hihi, -1, 0xffff00));
			c.addInterLineLayer(lineLayer.getLine(0),
					c.yAxis().addMark(hihi, 0xff0000, hihi + "").getLine(), -1);
		}

		if (hi > 0) {
			// a1 = c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xff0000));
			a1 = c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xffff00));
			a1.setXData(arrx);
			// c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xff0000));
			c.addInterLineLayer(lineLayer.getLine(0),
					c.yAxis().addMark(hi, 0xffff00, hi + "").getLine(), -1);
		}

		String chart1URL = c.makeSession(req, "chart1");
		return chart1URL;

	}

	/*
	 * ! 根据数据集合sqlList，图表宽度w，图表高度h，顶部高度top,底部高度bottom,左边距left,右边距right，
	 * 图表标题title和request值，查询数据库，获得图表信息
	 */
	public static String getChart(List sqlList, int w, int h, int top,
			int bottom, int left, int right, String title,
			HttpServletRequest req) throws Exception {

		Map map = null;
		double[] arry = null;
		java.util.Date[] arrx = null;
		// map = getXYValue(sql,req);
		String sql = null;
		String sqlName = null;
		Map sqlMap = null;
		int i = 0;
		int num = 0;

		XYChart c = new XYChart(w, h);

		c.setPlotArea(left, top, w - left - right, h - top - bottom);

		c.setDefaultFonts("宋体");
		c.addTitle(title, "宋体", FONT_SIZE, TITLE_FONT_COLOR);

		c.addLegend(70, 20, false, "", legend_font_size).setBackground(
				Chart.Transparent);

		LineLayer lineLayer = null;

		num = sqlList.size();

		for (i = 0; i < num; i++) {
			sqlMap = (Map) sqlList.get(i);
			sql = (String) sqlMap.get("sql");
			sqlName = (String) sqlMap.get("name");

			map = getXYValue(sql, req);
			double[] ay = (double[]) map.get("y");
			arry = new double[ay.length + 1];
			for (int x = 0; x < ay.length; x++) {
				arry[x] = ay[x];
			}
			arry[ay.length] = 0d;
			arrx = (java.util.Date[]) map.get("x");

			lineLayer = c.addLineLayer();

			lineLayer.addDataSet(arry, -1, sqlName).setDataSymbol(
					Chart.SquareSymbol, VALUE_SHAPE_SIZE);

			lineLayer.setLineWidth(LINE_WIDTH);

			lineLayer.setXData(arrx);
		}// end for

		c.xAxis().setLabelFormat("{value|yy-mm-dd}");

		java.util.Date[] dateArr = getStartEndDate(req);

		String date_axis_fix_flag = null;

		date_axis_fix_flag = req.getParameter("date_axis_fix_flag");

		// c.xAxis().setDateScale(dateArr[0],dateArr[1]);

		if (StringUtil.equals(date_axis_fix_flag, "1")) {
			c.xAxis().setDateScale(dateArr[0], dateArr[1]);
		}

		String chart1URL = c.makeSession(req, "chart1");
		return chart1URL;

	}

	/*
	 * ! 根据数据集合sqlList，图表宽度w，图表高度h，顶部高度top,底部高度bottom,左边距left,右边距right，
	 * 日期格式dateFormat和request值，查询数据库，获得图表信息
	 */
	public static String getChart(List sqlList, int w, int h, int top,
			int bottom, int left, int right, String title, String dateFormat,
			HttpServletRequest req) throws Exception {

		Map map = null;
		double[] arry = null;
		java.util.Date[] arrx = null;
		// map = getXYValue(sql,req);
		String sql = null;
		String sqlName = null;
		Map sqlMap = null;
		int i = 0;
		int num = 0;

		XYChart c = new XYChart(w, h);

		c.setPlotArea(left, top, w - left - right, h - top - bottom);

		c.setDefaultFonts("宋体");
		c.addTitle(title, "宋体", FONT_SIZE, TITLE_FONT_COLOR);

		c.addLegend(70, 20, false, "", legend_font_size).setBackground(
				Chart.Transparent);

		LineLayer lineLayer = null;

		num = sqlList.size();

		for (i = 0; i < num; i++) {
			sqlMap = (Map) sqlList.get(i);
			sql = (String) sqlMap.get("sql");
			sqlName = (String) sqlMap.get("name");

			map = getXYValue(sql, req);
			double[] ay = (double[]) map.get("y");
			arry = new double[ay.length + 1];
			for (int x = 0; x < ay.length; x++) {
				arry[x] = ay[x];
			}
			arry[ay.length] = 0d;
			arrx = (java.util.Date[]) map.get("x");

			lineLayer = c.addLineLayer();

			lineLayer.addDataSet(arry, -1, sqlName).setDataSymbol(
					Chart.SquareSymbol, VALUE_SHAPE_SIZE);

			lineLayer.setLineWidth(LINE_WIDTH);

			lineLayer.setXData(arrx);
		}// end for

		c.xAxis().setLabelFormat("{value|" + dateFormat + "}");

		java.util.Date[] dateArr = getStartEndDate(req);

		// String date_axis_fix_flag = null;
		//
		// date_axis_fix_flag = req.getParameter("date_axis_fix_flag");

		c.xAxis().setDateScale(dateArr[0], dateArr[1]);

		// if(StringUtil.equals(date_axis_fix_flag,"1")){
		// c.xAxis().setDateScale(dateArr[0],dateArr[1]);
		// }

		String chart1URL = c.makeSession(req, "chart1");
		return chart1URL;

	}

	/*
	 * ! 根据sql,日期格式dateFormat,图表标题title,报警值数组arrlimitVal和request值，查询数据库，获得图表信息
	 */
	public static String getChart(String sql, String dateFormat, String title,
			double[] arrLimitVal, HttpServletRequest req) throws Exception {
		int w = 750;
		int h = 320;
		int left = 35;
		int right = 10;
		int top = 20;
		int bottom = 20;
		String ws, hs;
		ws = req.getParameter("w");
		hs = req.getParameter("h");

		w = f.getInt(ws, 750);
		h = f.getInt(hs, 300);

		w = w - 30;
		h = h - 30;
/*
		System.out.println(w + "=====" + h);
		System.out.println(sql);*/

		return getChartWithLimit(sql, w, h, top, bottom, left, right,
				dateFormat, title, arrLimitVal, req);
	}

	/*
	 * ! 根据最大行数num，图表宽度w，图表高度h，顶部高度top,底部高度bottom,左边距left,右边距right，
	 * 图表标题title和request值，查询数据库，获得图表信息
	 */
	public static String getRealChart(int num, int w, int h, int top,
			int bottom, int left, int right, String title,
			HttpServletRequest req) throws Exception {
		String url = null;
		String station_id = req.getParameter("station_id");
		String infectant_id = req.getParameter("infectant_id");
		String fmt = "hh:nn";
		String sql = null;

		sql = getRealSql(station_id, infectant_id);

		url = getChartWithLimit(num, sql, w, h, top, bottom, left, right, fmt,
				title, req);

		return url;
	}

	/*
	 * ! 根据最大行数num，图表宽度w，图表高度h，顶部高度top,底部高度bottom,左边距left,右边距right，
	 * 图表标题title和request值，查询数据库，获得图表信息
	 */
	public static String getRealChart_new(int num, int w, int h, int top,
			int bottom, int left, int right, String title,
			HttpServletRequest req, String chart_form) throws Exception {
		String url = null;
		String station_id = req.getParameter("station_id");
		String infectant_id = req.getParameter("infectant_id");
		String fmt = "hh:nn";
		String sql = null;

		sql = getRealSql(station_id, infectant_id, req);
		
		/*System.out.println(sql);
		
		*/
		w = w - 30;
		h = h - 30;
		
		url = getChartWithLimit(num, sql, w, h, top, bottom, left, right, fmt,
				title, req);
		if (chart_form.equals("1")) {
		//	url = getChartWithLimit(num, sql, w, h, top, bottom, left, right,
			url = getLineChartWithLimit(num, sql, w, h, top, bottom, left, right,
					fmt, title, req);
		} else {
			//url = getChartWithLimit(num, sql, w, h, top, bottom, left, right,
			url = getBarChartWithLimit(num, sql, w, h, top, bottom, left, right,
					fmt, title, req);
		}
		return url;
	}

	/*
	 * ! 获得开始和结束时间数组
	 */
	public static java.util.Date[] getStartEndDate(HttpServletRequest req)
			throws Exception {
		java.util.Date[] arr = new java.util.Date[2];

		Timestamp ts1 = null;
		Timestamp ts2 = null;
		String sts1 = null;
		String sts2 = null;

		String date1 = null;
		String date2 = null;
		String hour1 = null;
		String hour2 = null;
		try {
			date1 = req.getParameter("date1");
			date2 = req.getParameter("date2");
			hour1 = req.getParameter("hour1");
			hour2 = req.getParameter("hour2");

			if (StringUtil.isempty(hour1)) {
				sts1 = date1 + "";
			} else {
				sts1 = date1 + " " + hour1 + ":" + "0:0.0";
			}
			if (StringUtil.isempty(hour2)) {
				sts2 = date2 + "";
			} else {
				sts2 = date2 + " " + hour2 + ":" + "0:0.0";
			}
			ts1 = StringUtil.getTimestamp(sts1);
			ts2 = StringUtil.getTimestamp(sts2);
			arr[0] = ts1;
			arr[1] = ts2;
			return arr;
		} catch (Exception e) {
			String msg = null;
			msg = "时间格式不对," + e;
			throw new Exception(msg);
		}
	}
}