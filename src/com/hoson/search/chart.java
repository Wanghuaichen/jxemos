package com.hoson.search;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import ChartDirector.AreaLayer;
import ChartDirector.BarLayer;
import ChartDirector.Chart;
import ChartDirector.LineLayer;
import ChartDirector.XYChart;

import com.hoson.DBUtil;
import com.hoson.StringUtil;
import com.hoson.f;
import com.hoson.app.NewChart;

public class chart {

	private static int TITLE_FONT_COLOR = 0xff0000;

	private static int LINE_COLOR = 0x00ff00;

	private static int VALUE_SHAPE_SIZE = 5;

	private static int LINE_WIDTH = 2;

	private static int max_num_show_shape = 300;

	private static int FONT_SIZE = 12;

	/*!
	 *  根据request,站位编号station_id,查询sql,标题titleName,日期格式获得图表信息
	 */
	public String getChart(HttpServletRequest request, String station_id,
			String sql, String titleName, String formatDate) throws Exception {

		int left = 35;
		int right = 20;
		int top = 58;
		int bottom = 45;
		String ws, hs;
		ws = request.getParameter("w");
		hs = request.getParameter("h");

		int w = f.getInt(ws, 750);
		int h = f.getInt(hs, 300);

		Map map = this.getChartValue(station_id, request, sql, formatDate);
		Map infectantMap = this.getInfectant(station_id, request);
		String[] labels = (String[]) map.get("time");

		// 设置图表的高和宽h*w，背景色为白色
		XYChart c = new XYChart(w + 20, h, 0xffffff, 0x000000, 1);
		c.setRoundedFrame();

		// 设置绘图领域为(left,top) 大小为(w - left - right)*(h - top - bottom) 背景色为白色
		// 横坐标和纵坐标的网格线颜色
		c.setPlotArea(left, top, w - left - right, h - top - bottom, 0xffffff,
				-1, -1, 0xcccccc, 0xcccccc);

		// 设置网格上边和标题下边的区域大小为(50, 30)，字横向排列，字体为宋体，大小为9
		c.addLegend(left, 25, false, "宋体", 9).setBackground(Chart.Transparent);

		// 设置标题的内容，字体，颜色
		c.addTitle(titleName, "宋体", 15).setBackground(0xffffff, 0x000000,
				Chart.glassEffect());

		// 设置y轴的标题,字体，大小，颜色
		c.yAxis().setTitle("数据", "宋体", 9, 0x000000);

		// 设置x轴的标签
		c.xAxis().setLabels(labels);

		// 设置x轴显示数据的跨度
		c.xAxis().setLabelStep(1);

		// 设置x轴标题,字体，大小，颜色
		c.xAxis().setTitle("日期", "宋体", 9, 0x000000);

		LineLayer layer = c.addLineLayer2();

		// 设置线的宽度
		layer.setLineWidth(2);

		Iterator it = map.entrySet().iterator();
		int i = 0x900000;
		while (it.hasNext()) {
			Map.Entry m = (Map.Entry) it.next();

			if (!m.getKey().toString().equals("time")) {
				// 填写数据
				layer.addDataSet((double[]) m.getValue(), i, infectantMap.get(
						m.getKey()).toString());
			}
			i = i + 100000;
		}

		// 输出图表
		String chart1URL = c.makeSession(request, "chart1");
		return chart1URL;
	}
	public String getChart(String sql, int w, int h, int top,
			int bottom, int left, int right, String title,String dateFormat,HttpServletRequest req)
			throws Exception {
		Map map = NewChart.getXYValue(sql, req);
		String ws,hs;
		ws = req.getParameter("w");
		hs = req.getParameter("h");
		
		w = f.getInt(ws,700)-30;
		h = f.getInt(hs,300)-20;
		return this.get3DBarChartWithLimit(map, w, h, top, bottom, left, right, dateFormat,title, req,"chart1");
	}
	public String get3DBarChartWithLimit(Map map, int w, int h, int top,
			int bottom, int left, int right, String dateFormat,String title,
			 HttpServletRequest req,String chartName) throws Exception {
		double[] arry = null;
		java.util.Date[] arrx = null;
		arry = (double[]) map.get("y");
		arrx = (java.util.Date[]) map.get("x");
		XYChart c = new XYChart(w, h);

//		 Set the plotarea at (45, 30) and of size 200 x 200 pixels
		c.setPlotArea(left, top, w - left - right, h - top - bottom);

//		 Add a title to the chart
		c.addTitle(title, "宋体", FONT_SIZE, TITLE_FONT_COLOR);

//		 Add a title to the y axis
//		c.yAxis().setTitle("MBytes");

//		 Add a title to the x axis
//		c.xAxis().setTitle("Work Week 25");

//		 Add a bar chart layer with green (0x00ff00) bars using the given data
		c.addBarLayer(arry, 0x00ff00).set3D();

//		 Set the labels on the x axis.
		
		c.xAxis().setLabels(arrx);
		int m = arrx.length*100/w;
		c.xAxis().setLabelStep(m);
		c.xAxis().setLabelFormat("{value|" + dateFormat + "}");
//		 output the chart
		String chart1URL = c.makeSession(req, chartName);
		return chart1URL;
		
	}
	/*!
	 *  根据request和站位编号station_id获得相对应的因子
	 */
	public Map getInfectant(String station_id, HttpServletRequest request)
			throws Exception {
		Connection cn = null;
		PreparedStatement stm = null;
		ResultSet rs = null;
		Map map = new HashMap();
		try {
			cn = DBUtil.getConn(request);
			String sql = "select m.infectant_column,i.INFECTANT_NAME from t_cfg_monitor_param m,T_CFG_INFECTANT_BASE i  "
					+ "where m.INFECTANT_ID=i.INFECTANT_ID and station_id=? order by m.infectant_column";
			stm = cn.prepareStatement(sql);
			stm.setString(1, station_id);
			rs = stm.executeQuery();
			while (rs.next()) {
				List list = new ArrayList();
				list.add(rs.getString(2));
				map.put(rs.getString(1), list);
			}
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs, stm, cn);
		}
		return map;
	}

	/*!
	 *  根据站位编号：station_id,request,sql,日期个数formatDate获得图表显示的值map
	 */
	public Map getChartValue(String station_id, HttpServletRequest request,
			String sql, String formatDate) throws Exception {
		Connection cn = null;
		PreparedStatement stm = null;
		ResultSet rs = null;
		Map map = new HashMap();
		java.sql.Timestamp ts = null;
		DateFormat format = new SimpleDateFormat(formatDate);
		try {
			cn = DBUtil.getConn(request);
			Map infectantMap = this.getInfectant(station_id, request);
			// 查询
			stm = cn.prepareStatement(sql);
			// stm.setDate(1, format.parse(date1));
			// stm.setDate(2, format.parse(date2));
			rs = stm.executeQuery();
			List timeList = new ArrayList();
			List tempList = null;
			while (rs.next()) {
				ts = rs.getTimestamp(1);
				int num = 2;
				Iterator it2 = infectantMap.entrySet().iterator();
				while (it2.hasNext()) {
					Map.Entry m = (Map.Entry) it2.next();
					tempList = (List) m.getValue();
					tempList.add(f.v(rs.getString(num++)));
					infectantMap.put(m.getKey().toString(), tempList);
				}
				if (ts != null) {
					timeList.add(ts);
				}
			}
			int num = timeList.size();
			String[] arrTime = new String[num];

			for (int n = 0; n < num; n++) {
				arrTime[n] = format.format(timeList.get(n));
			}
			Iterator it1 = infectantMap.entrySet().iterator();
			while (it1.hasNext()) {
				double[] arrValue = new double[num];
				Map.Entry m = (Map.Entry) it1.next();
				tempList = (List) m.getValue();
				for (int n = 0; n < num; n++) {
					arrValue[n] = StringUtil.getDouble(
							tempList.get(n + 1) + "", 0);
				}
				map.put(m.getKey().toString(), arrValue);
			}
			map.put("time", arrTime);
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs, stm, cn);
		}
		return map;
	}

	/*!
	 * 根据站位编号：station_id,request,sql,日期个数formatDate获得图表显示的值map
	 */
	public Map getChartValues(String station_id, HttpServletRequest request,
			String sql, String formatDate) throws Exception {
		Connection cn = null;
		PreparedStatement stm = null;
		ResultSet rs = null;
		Map map = new HashMap();
		java.sql.Timestamp ts = null;
		try {
			cn = DBUtil.getConn(request);
			Map infectantMap = this.getInfectant(station_id, request);
			// 查询
			stm = cn.prepareStatement(sql);
			rs = stm.executeQuery();
			List timeList = new ArrayList();
			List tempList = null;
			while (rs.next()) {
				ts = rs.getTimestamp(1);
				int num = 2;
				Iterator it2 = infectantMap.entrySet().iterator();
				while (it2.hasNext()) {
					Map.Entry m = (Map.Entry) it2.next();
					tempList = (List) m.getValue();
					tempList.add(f.v(rs.getString(num++)));
					infectantMap.put(m.getKey().toString(), tempList);
				}
				if (ts != null) {
					timeList.add(ts);
				}
			}
			int num = timeList.size();
			java.util.Date[] arrx = new java.util.Date[num];

			for (int n = 0; n < num; n++) {
				arrx[n] = (java.util.Date) timeList.get(n);
			}
			Iterator it1 = infectantMap.entrySet().iterator();
			while (it1.hasNext()) {
				double[] arrValue = new double[num];
				Map.Entry m = (Map.Entry) it1.next();
				tempList = (List) m.getValue();
				for (int n = 0; n < num; n++) {
					arrValue[n] = StringUtil.getDouble(
							tempList.get(n + 1) + "", 0);
				}
				Map tempMap = new HashMap();
				tempMap.put("y", arrValue);
				tempMap.put("time", arrx);
				map.put(m.getKey().toString(), tempMap);
			}

		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs, stm, cn);
		}
		return map;
	}

	/*!
	 *  根据站位编号：station_id,request,sql,图表标题title,日期个数formatDate获得图表显示的值list
	 */
	public List getChartImg(String sql, String dateFormat, String title,
			HttpServletRequest req, String station_id) throws Exception {
		int w = 750;
		int h = 320;
		int left = 50;
		int right = 20;
		int top = 20;
		int bottom = 20;
		String ws, hs;
		ws = req.getParameter("w");
		hs = req.getParameter("h");

		w = f.getInt(ws, 750);
		h = f.getInt(hs, 300);

		w = w - 30;
		h = h - 30;

		Map map = this.getChartValues(station_id, req, sql, dateFormat);

		Map arrMap = this.getLimitValue(station_id, req);

		List list1 = new ArrayList();

		String value = "";
		Iterator it = map.entrySet().iterator();
		double[] arrDoubleVal = new double[2];
		int num = 1;
		while (it.hasNext()) {
			Map.Entry m = (Map.Entry) it.next();
			Map map1 = (Map) m.getValue();
			value = this.getChartWithLimit(map1, w, h, top, bottom, left,
					right, dateFormat, "("
							+ title
							+ ")"
							+ this.getChartTitle(req, station_id, m.getKey()
									.toString()), (double[]) arrMap.get(m
							.getKey()), req, "chart" + num);
			list1.add(value);
			num++;
		}
		return list1;
	}

	/*!
	 *  根据图表值集合map,宽w,高h,顶部高度top,底部高度bottom,左边距left,右边距right,日期格式dateFormat,
	 * 标题title,报警值arrLimitVal,图表名字chartName获得图表信息
	 */
	public String getChartWithLimit(Map map, int w, int h, int top, int bottom,
			int left, int right, String dateFormat, String title,
			double[] arrLimitVal, HttpServletRequest req, String chartName)
			throws Exception {

		String bar = req.getParameter("bar");
		String flag_3d = req.getParameter("flag_3d");
		double[] arry = null;
		java.util.Date[] arrx = null;
		int i, num = 0;
		java.util.Date d = null;
		java.util.Date[] dateArr = NewChart.getStartEndDate(req);

		double hi = arrLimitVal[0];
		double hihi = arrLimitVal[1];

		double[] ay = (double[]) map.get("y");
		arry = new double[ay.length + 1];
		for (int x = 0; x < ay.length; x++) {
			arry[x] = ay[x];
		}
		arry[ay.length] = 0d;
		arrx = (java.util.Date[]) map.get("time");

		String date_axis_fix_flag = null;

		date_axis_fix_flag = req.getParameter("date_axis_fix_flag");

		XYChart c = new XYChart(w, h);

		c.setPlotArea(left, top, w - left - right, h - top - bottom);

		title = f.getChartTitle(title);
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

			if (hihi > 0) {
				c.addInterLineLayer(null, c.yAxis().addMark(hihi, 0xff0000,
						hihi + "").getLine(), -1);

			}
			if (hi > 0) {
				c.addInterLineLayer(null, c.yAxis().addMark(hi, 0xff0000,
						hi + "").getLine(), -1);
			}
			return c.makeSession(req, chartName);

		}

		LineLayer lineLayer = c.addLineLayer();
		if (StringUtil.equals(flag_3d, "1")) {
			lineLayer.set3D();
		}
		int x_num = arrx.length;
		if (x_num < max_num_show_shape) {
			lineLayer.addDataSet(arry, LINE_COLOR, "").setDataSymbol(
					Chart.SquareSymbol, VALUE_SHAPE_SIZE);
		} else {

			lineLayer.addDataSet(arry, LINE_COLOR, "");
		}
		lineLayer.setLineWidth(LINE_WIDTH);

		lineLayer.setXData(arrx);

		c.xAxis().setLabelFormat("{value|" + dateFormat + "}");

		if (StringUtil.equals(date_axis_fix_flag, "1")) {
			c.xAxis().setDateScale(dateArr[0], dateArr[1]);
		}

		AreaLayer a1 = null;
		AreaLayer a2 = null;

		if (hihi > 0) {
			a2 = c.addAreaLayer(arry, c.yZoneColor(hihi, -1, 0xff0000));
			a2.setXData(arrx);
			c.addInterLineLayer(lineLayer.getLine(0), c.yAxis().addMark(hihi,
					0xff0000, hihi + "").getLine(), -1);
		}

		if (hi > 0) {
			a1 = c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xffff00));
			a1.setXData(arrx);
			// 预警线 20070926
			c.addInterLineLayer(lineLayer.getLine(0), c.yAxis().addMark(hi,
					0xffff00, hi + "").getLine(), -1);
		}

		String chart1URL = c.makeSession(req, chartName);
		return chart1URL;

	}

	/*!
	 *  根据站位编号：station_id,request获得站位的报警信息map
	 */
	public Map getLimitValue(String station_id, HttpServletRequest req)
			throws Exception {

		String sql = "select hi,hihi,i.infectant_column from t_cfg_monitor_param m,t_cfg_infectant_base i where m.infectant_id=i.infectant_id "
				+ "and station_id=?";
		Map map = new HashMap();

		Connection cn = null;
		PreparedStatement stm = null;
		ResultSet rs = null;
		try {
			cn = DBUtil.getConn(req);
			// 查询
			stm = cn.prepareStatement(sql);
			stm.setString(1, station_id);
			rs = stm.executeQuery();
			while (rs.next()) {
				double[] arr = new double[2];
				arr[0] = StringUtil.getDouble(rs.getString("hi") + "", 0);
				arr[1] = StringUtil.getDouble(rs.getString("hihi") + "", 0);
				map.put(rs.getString("infectant_column"), arr);
			}
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs, stm, cn);
		}

		return map;
	}

	/*!
	 *  根据站位编号：station_id,因子列infectant_column获得图表的标题
	 */
	public String getChartTitle(HttpServletRequest req, String station_id,
			String infectant_column) throws Exception {
		String s = "";
		String sql = null;
		Map map = null;
		Connection cn = DBUtil.getConn(req);
		sql = "select i.infectant_id,i.infectant_name,i.english_name,i.infectant_unit from t_cfg_infectant_base i,t_cfg_monitor_param m "
				+ "where i.infectant_id=m.infectant_id and i.infectant_column='"
				+ infectant_column + "' and m.station_id='" + station_id + "'";
		try {
			map = DBUtil.queryOne(cn, sql, null);
			s = map.get("infectant_name") + "(";
			s = s + map.get("english_name") + ") ";
			s = s + map.get("infectant_unit");
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
		return s;
	}
}
