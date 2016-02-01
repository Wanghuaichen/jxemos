package com.hoson.app;

import java.sql.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.*;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import ChartDirector.AreaLayer;
import ChartDirector.Chart;
import ChartDirector.LineLayer;
import ChartDirector.BarLayer;
import ChartDirector.XYChart;

import com.hoson.DBUtil;
import com.hoson.StringUtil;
import com.hoson.f;


public class NewChartCheck {

	private static int TITLE_FONT_SIZE = 8;
	private static int TITLE_BG_COLOR = 0x0;
	private static int TITLE_FONT_COLOR = 0xff0000;
	//private static int LINE_COLOR = 0xFF9900;
	private static int LINE_COLOR = 0x00ff00;
	
	
	private static int MAXROWS = 3000;

	private static int SET_MAXROWS_FLAG = 1;
	private static int VALUE_SHAPE_SIZE = 5;

	private static int LINE_WIDTH=2;
	
	
	private static int max_num_show_shape = 300;
	
	private static String FONT = "";
	private static int FONT_SIZE = 12;
	private static int legend_font_size = 10;
	
	private NewChartCheck() {
	}

	// ------------------
	
	public static String getRealSql(String station_id,
			String infectant_id){
		
       // String start = getRealChartStartTime();
		String sql = null;
		
		
		
		/*
		sql = "select m_time,m_value from t_monitor_real_minute ";
		//sql = sql + "where m_time>='"+nowDate+"' order by m_time desc";
		sql = sql+"where station_id='"+station_id+"' and ";
		sql = sql + "infectant_id='"+infectant_id+"' ";
		sql = sql+" and m_time>='"+start+"' ";
		*/
		
		sql = "select m_time,m_value from v_view_real "
			+ " where station_id='"+station_id+"' "
			+" and infectant_id='"+infectant_id+"'"
			+" order by m_time";
		
		
		
		
		return sql;
		
	}

	// --------------
	
	public static String getRealChartStartTime(){
		String s = null;
		java.util.Date dateNow = new java.util.Date();
        Calendar cal = Calendar.getInstance();
          cal.setTime(dateNow);  
          cal.add(Calendar.HOUR,-2);
          Timestamp ts = new Timestamp(cal.getTime().getTime());
          s = StringUtil.getDateTime(ts);

		
		return s;
		
	}
	// ----------
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

	// ----------
	public static String getValueStr(String s) {
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

	// ----------------

	// ----------------

	public static Map getXYValue(String sql, HttpServletRequest req)
			throws Exception {
		return getXYValue(MAXROWS,sql, req);
	}

	// -----------------------
	// ----------------

	public static Map getXYValue(int maxRow,String sql, HttpServletRequest req)
			throws Exception {
		Map map = new HashMap();
		List xList = new ArrayList();
		List yList = new ArrayList();
		int i, num = 0;
		List list = null;
		Map m = null;

		String v = null;
		Timestamp ts = null;

		String strx, stry = null;
		Double dv = null;
		//System.out.println(f.time()+",check,"+sql);

		try {

			if (maxRow > MAXROWS) {
				maxRow = MAXROWS;
			}
			// System.out.println(sql);
			// System.out.println(params[0]+","+params[1]);
			list = f.query(sql, null, maxRow);
			//num = list.size();
			//System.out.println("before check,"+num+","+sql);
			
			sql=sql.toLowerCase();
			if(sql.indexOf("_minute")>=0){
				list = f.dataCheck(list);
				
			}else{
				list = f.avgDataCheck(list);
			}
			
			
			
			num = list.size();
			
			//System.out.println("getxyvalue,"+num+","+sql);
			
			
			for (i = 0; i < num; i++) {

				m = (Map) list.get(i);
				strx = (String) m.get("m_time");
				stry = (String) m.get("m_value");
				ts = StringUtil.getTimestamp(strx, null);
				//System.out.print(stry);
				stry = f.v(stry);
			    //System.out.println(stry);
				//System.out.print("   ,"+stry);
				
				dv = getDouble(stry, null);
				
				//System.out.println("   ,"+dv);
				
				if (ts != null && dv != null) {

					xList.add(ts);
					yList.add(dv);
				}
			}// end while

			num = xList.size();
			// System.out.println(num+"---"+irow+"------"+StringUtil.getNowTime());
			double[] arry = new double[num];
			java.util.Date[] arrx = new java.util.Date[num];

			for (i = 0; i < num; i++) {
				dv = (Double) yList.get(i);
				arry[i] = dv.doubleValue();
				arrx[i] = (java.util.Date) xList.get(i);
			}

			map.put("x", arrx);
			map.put("y", arry);
			return map;
		} catch (Exception e) {
			throw e;
		} 
	}

	// -----------------------	
	public static Double getDouble(String s,Double def){
		double v = 0;
		try{
		v = Double.parseDouble(s);
		return new Double(v);
		}catch(Exception e){
			return def;
		}
		
	}
	//-------
	public static String getChart(String sql, int w, int h, int top,
			int bottom, int left, int right, HttpServletRequest req)
			throws Exception {

		Map map = null;
		double[] arry = null;
		java.util.Date[] arrx = null;
		map = getXYValue(sql, req);

		arry = (double[]) map.get("y");
		arrx = (java.util.Date[]) map.get("x");

		XYChart c = new XYChart(w, h);

		c.setPlotArea(left, top, w - left - right, h - top - bottom);

		LineLayer lineLayer = c.addLineLayer();

		lineLayer.addDataSet(arry, -1, "").setDataSymbol(Chart.SquareSymbol, VALUE_SHAPE_SIZE);

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

	// -------------
	// -----------
	public static String getChart(String sql, int w, int h, int top,
			int bottom, int left, int right, String dateFormat,
			HttpServletRequest req) throws Exception {

		Map map = null;
		double[] arry = null;
		java.util.Date[] arrx = null;
		map = getXYValue(sql, req);

		arry = (double[]) map.get("y");
		arrx = (java.util.Date[]) map.get("x");

		XYChart c = new XYChart(w, h);

		c.setPlotArea(left, top, w - left - right, h - top - bottom);

		LineLayer lineLayer = c.addLineLayer();

		//lineLayer.addDataSet(arry, -1, "").setDataSymbol(Chart.SquareSymbol, 7);
		lineLayer.addDataSet(arry, -1, "").setDataSymbol(Chart.SquareSymbol, VALUE_SHAPE_SIZE);
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

	// -------------
	// -----------
	public static String getChart(String sql, int w, int h, int top,
			int bottom, int left, int right, String dateFormat,int color,
			HttpServletRequest req) throws Exception {

		Map map = null;
		double[] arry = null;
		java.util.Date[] arrx = null;
		map = getXYValue(sql, req);

		arry = (double[]) map.get("y");
		arrx = (java.util.Date[]) map.get("x");

		XYChart c = new XYChart(w, h);

		c.setPlotArea(left, top, w - left - right, h - top - bottom);

		LineLayer lineLayer = c.addLineLayer();

		//lineLayer.addDataSet(arry, color, "").setDataSymbol(Chart.SquareSymbol, 7);
		lineLayer.addDataSet(arry, color, "").setDataSymbol(Chart.SquareSymbol, VALUE_SHAPE_SIZE);
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

	// -------------
	
	
	public static String getChart(int maxRows,String sql, int w, int h, int top,
			int bottom, int left, int right, String dateFormat,
			HttpServletRequest req) throws Exception {

		Map map = null;
		double[] arry = null;
		java.util.Date[] arrx = null;
		//map = getXYValue(sql, req);
		map = getXYValue(maxRows,sql, req);
		arry = (double[]) map.get("y");
		arrx = (java.util.Date[]) map.get("x");

		XYChart c = new XYChart(w, h);

		c.setPlotArea(left, top, w - left - right, h - top - bottom);

		LineLayer lineLayer = c.addLineLayer();

		lineLayer.addDataSet(arry, -1, "").setDataSymbol(Chart.SquareSymbol, VALUE_SHAPE_SIZE);

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

	// -------------
	

	public static String getChart(int maxRows,String sql, int w, int h, int top,
			int bottom, int left, int right, String dateFormat,int color,
			HttpServletRequest req) throws Exception {

		Map map = null;
		double[] arry = null;
		java.util.Date[] arrx = null;
		//map = getXYValue(sql, req);
		map = getXYValue(maxRows,sql, req);
		arry = (double[]) map.get("y");
		arrx = (java.util.Date[]) map.get("x");

		XYChart c = new XYChart(w, h);

		c.setPlotArea(left, top, w - left - right, h - top - bottom);

		LineLayer lineLayer = c.addLineLayer();

		lineLayer.addDataSet(arry, color, "").setDataSymbol(Chart.SquareSymbol, VALUE_SHAPE_SIZE);

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

	// -------------
	
	
	
//------------------------------
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
		
		
		c.addLegend(70,1, false, "", 8).setBackground(Chart.Transparent);

		LineLayer lineLayer = null;

		num = sqlList.size();

		for (i = 0; i < num; i++) {
			sqlMap = (Map) sqlList.get(i);
			sql = (String) sqlMap.get("sql");
			sqlName = (String) sqlMap.get("name");

			map = getXYValue(sql, req);
			arry = (double[]) map.get("y");
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

	// ------------------
	// ------------
	public static String getRealChart(int num, int w, int h, int top,
			int bottom, int left, int right, HttpServletRequest req)
			throws Exception {
		//String sql = App.getRealChartSql(num, req);
		String url = null;
		String station_id = req.getParameter("station_id");
		String infectant_id = req.getParameter("infectant_id");
		String nowDate = StringUtil.getNowDate()+"";
		
		String sql = "select m_time,m_value from t_monitor_real_minute ";
		//sql = sql + "where m_time>='"+nowDate+"' order by m_time desc";
		sql = sql+"where station_id='"+station_id+"' and ";
		sql = sql + "infectant_id='"+infectant_id+"' ";
		//sql = sql+" and m_time>='"+nowDate+"' ";
		sql = sql +"order by m_time desc";
		//System.out.println(sql);
		//url = getChart(num,sql, w, h, top, bottom, left, right,"yy-mm-dd hh:nn",req);
		url = getChartWithLimit(num,sql, w, h, top, bottom, left, right,"yy-mm-dd-hh-nn",req);
		
		return url;
	}

	// ---------------------
	public static String getChartWithLimit(String sql, int w, int h, int top,
			int bottom, int left, int right, double[] arrLimitVal,
			HttpServletRequest req) throws Exception {

		Map map = null;
		double[] arry = null;
		java.util.Date[] arrx = null;
		map = getXYValue(sql, req);

		double hi = arrLimitVal[0];
		double hihi = arrLimitVal[0];

		arry = (double[]) map.get("y");
		arrx = (java.util.Date[]) map.get("x");

		XYChart c = new XYChart(w, h);

		c.setPlotArea(left, top, w - left - right, h - top - bottom);

		LineLayer lineLayer = c.addLineLayer();

		//lineLayer.addDataSet(arry, -1, "").setDataSymbol(Chart.SquareSymbol, 7);
		lineLayer.addDataSet(arry, 0x00ff00, "").setDataSymbol(Chart.SquareSymbol, VALUE_SHAPE_SIZE);
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

	// ------------
	public static String getChartWithLimit(String sql, int w, int h, int top,
			int bottom, int left, int right, String dateFormat,
			double[] arrLimitVal, HttpServletRequest req) throws Exception {

		Map map = null;
		double[] arry = null;
		java.util.Date[] arrx = null;
		map = getXYValue(sql, req);

		double hi = arrLimitVal[0];
		double hihi = arrLimitVal[1];

		arry = (double[]) map.get("y");
		arrx = (java.util.Date[]) map.get("x");

		XYChart c = new XYChart(w, h);

		c.setPlotArea(left, top, w - left - right, h - top - bottom);

		LineLayer lineLayer = c.addLineLayer();

		//lineLayer.addDataSet(arry, -1, "").setDataSymbol(Chart.SquareSymbol, 7);
		lineLayer.addDataSet(arry, 0x00ff00, "").setDataSymbol(Chart.SquareSymbol, VALUE_SHAPE_SIZE);
		
		
		lineLayer.setLineWidth(1);

		lineLayer.setXData(arrx);

		c.xAxis().setLabelFormat("{value|" + dateFormat + "}");

		AreaLayer a1 = null;
		AreaLayer a2 = null;

		if (hihi > 0) {
			a2 = c.addAreaLayer(arry, c.yZoneColor(hihi, -1, 0xff0000));
			a2.setXData(arrx);
			//c.addAreaLayer(arry, c.yZoneColor(hihi, -1, 0xffff00));
		}
		
		if (hi > 0) {
			//a1 = c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xff0000));
			a1 = c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xffff00));
			a1.setXData(arrx);
			//c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xff0000));
		}
		//c.yAxis().setLinearScale();
		
		

		String chart1URL = c.makeSession(req, "chart1");
		return chart1URL;

	}

	// ------------
	
//	 ------------
	public static String getChartWithLimit(int maxRows,String sql, int w, int h, int top,
			int bottom, int left, int right, String dateFormat,
			//double[] arrLimitVal, 
			HttpServletRequest req) throws Exception {

		Map map = null;
		double[] arry = null;
		java.util.Date[] arrx = null;
		map = getXYValue( maxRows,sql, req);

		String station_id = req.getParameter("station_id");
		String infectant_id = req.getParameter("infectant_id");
		
		double[] arrLimitVal = getLimitValue(station_id,infectant_id,req);
			
			
		double hi = arrLimitVal[0];
		double hihi = arrLimitVal[1];

		arry = (double[]) map.get("y");
		arrx = (java.util.Date[]) map.get("x");

		XYChart c = new XYChart(w, h);

		c.setPlotArea(left, top, w - left - right, h - top - bottom);

		LineLayer lineLayer = c.addLineLayer();

		//lineLayer.addDataSet(arry, -1, "").setDataSymbol(Chart.SquareSymbol, 7);
		lineLayer.addDataSet(arry, 0x00ff00, "").setDataSymbol(Chart.SquareSymbol, VALUE_SHAPE_SIZE);
		lineLayer.setLineWidth(1);

		lineLayer.setXData(arrx);

		c.xAxis().setLabelFormat("{value|" + dateFormat + "}");

		AreaLayer a1 = null;
		AreaLayer a2 = null;

		if (hihi > 0) {
			a2 = c.addAreaLayer(arry, c.yZoneColor(hihi, -1, 0xff0000));
			a2.setXData(arrx);
			//c.addAreaLayer(arry, c.yZoneColor(hihi, -1, 0xffff00));
		}
		
		if (hi > 0) {
			//a1 = c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xff0000));
			a1 = c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xffff00));
			a1.setXData(arrx);
			//c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xff0000));
		}
		

		String chart1URL = c.makeSession(req, "chart1");
		return chart1URL;

	}

	// ------------
	
	
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
	// --------------
	//---------------
	//--------------060608------with title--
	//--------------------
	public static String getChartTitle(Connection cn,String infectant_id)
	throws Exception{
		String s = "";
		String sql = null;
		Map map = null;
		
		sql = "select infectant_id,infectant_name,english_name,infectant_unit ";
		sql=sql+"from t_cfg_infectant_base ";
		sql=sql+"where infectant_id='"+infectant_id+"'";
		
		map=DBUtil.queryOne(cn,sql,null);
		s=map.get("infectant_name")+"(";
		s=s+map.get("english_name")+") ";
		s=s+map.get("infectant_unit");
		
		return s;	
	}
	//----------------------------
	public static String getChartTitle(String infectant_id, HttpServletRequest req)
	throws Exception{
		Connection cn = null;
		try{
		cn = DBUtil.getConn(req);
		return getChartTitle(cn,infectant_id);
		}catch(Exception e){throw e;}finally{DBUtil.close(cn);}
	}
	//----------------------------
	//----------
	
	//set yaxis line scale 2007-04-11
	public static String getChartWithLimit(String sql, int w, int h, int top,
			int bottom, int left, int right, String dateFormat,String title,
			double[] arrLimitVal, HttpServletRequest req) throws Exception {

		
		//System.out.println( title);
		String bar = req.getParameter("bar");
		String flag_3d = req.getParameter("flag_3d");
		Map map = null;
		double[] arry = null;
		java.util.Date[] arrx = null;
		map = getXYValue(sql, req);
		int i,num=0;
		java.util.Date d = null;
		java.util.Date[]dateArr = getStartEndDate(req);

		double hi = arrLimitVal[0];
		double hihi = arrLimitVal[1];

		arry = (double[]) map.get("y");
		arrx = (java.util.Date[]) map.get("x");

		String date_axis_fix_flag = null;
		
		date_axis_fix_flag = req.getParameter("date_axis_fix_flag");
		
		//System.out.println(req.getParameter("data_type"));
		XYChart c = new XYChart(w, h);

		//c.set3D();
	
		
		c.setPlotArea(left, top, w - left - right, h - top - bottom);

		//c.addTitle("测试趋势图", "宋体", 13, 0xffffff).setBackground(0x800080, -1, 1);
		//c.addTitle(title, "宋体", 13, 0xffffff).setBackground(0x800080, -1, 1);
		//c.addTitle(title, "宋体", 13, 0xffffff);
		//c.addTitle(title, "宋体", 8, 0xffffff).setBackground(0x000000, -1, 1);
		c.addTitle(title, "宋体", FONT_SIZE, TITLE_FONT_COLOR);
		
		
//System.out.println(bar);
		
		if(StringUtil.equals(bar,"1")){
			BarLayer barLayer = null;
			barLayer = c.addBarLayer(arry);
			if(StringUtil.equals(flag_3d,"1")){
				
				barLayer.set3D();
			
			}
			barLayer.setXData(arrx);
			
			if(StringUtil.equals(date_axis_fix_flag,"1")){
			c.xAxis().setDateScale(dateArr[0],dateArr[1]);
			}
			
			c.xAxis().setLabelFormat("{value|" + dateFormat + "}");
			
			//c.addInterLineLayer(null,c.yAxis().addMark(hihi, 0xff0000,hihi+"").getLine(),-1);
			if (hihi > 0) {
				c.addInterLineLayer(null,c.yAxis().addMark(hihi, 0xff0000,hihi+"").getLine(),-1);
				
			}
			if(hi>0){
				c.addInterLineLayer(null,c.yAxis().addMark(hi, 0xff0000,hi+"").getLine(),-1);
			}
			return c.makeSession(req, "chart1");
			
			
		}
		
		LineLayer lineLayer = c.addLineLayer();
		if(StringUtil.equals(flag_3d,"1")){
		lineLayer.set3D();
		}
		//LineLayer lineLayer = c.addLineLayer().set3D();
		
		//lineLayer.addDataSet(arry, -1, "").setDataSymbol(Chart.SquareSymbol, 7);
		
		
		
		
		
		
		
		//lineLayer.addDataSet(arry, 0x00ff00, "").setDataSymbol(Chart.SquareSymbol, VALUE_SHAPE_SIZE);
		//lineLayer.addDataSet(arry, 0x00ff00, "");
		int x_num = arrx.length;
		if(x_num<max_num_show_shape){
			lineLayer.addDataSet(arry, LINE_COLOR, "").setDataSymbol(Chart.SquareSymbol, VALUE_SHAPE_SIZE);
		}else{
			
			lineLayer.addDataSet(arry, LINE_COLOR, "");
		}
		
		
		//lineLayer.set3D();
		lineLayer.setLineWidth(LINE_WIDTH);

		lineLayer.setXData(arrx);

		c.xAxis().setLabelFormat("{value|" + dateFormat + "}");

		
		
		
		
		
		
		if(StringUtil.equals(date_axis_fix_flag,"1")){
		c.xAxis().setDateScale(dateArr[0],dateArr[1]);
		}
		
		
		
		
		
		//System.out.println(date_axis_fix_flag);
		
		AreaLayer a1 = null;
		AreaLayer a2 = null;

		if (hihi > 0) {
		
			a2 = c.addAreaLayer(arry, c.yZoneColor(hihi, -1, 0xff0000));
			a2.setXData(arrx);
			
			//c.addAreaLayer(arry, c.yZoneColor(hihi, -1, 0xffff00));
			
			
			//报警线 20070926
			c.addInterLineLayer(lineLayer.getLine(0),c.yAxis().addMark(hihi, 0xff0000,hihi+"").getLine(),-1);
		
		}
		
		if (hi > 0) {
			//a1 = c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xff0000));
			
			a1 = c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xffff00));
			a1.setXData(arrx);
		
			//c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xff0000));
		
	
			//预警线  20070926
		c.addInterLineLayer(lineLayer.getLine(0),c.yAxis().addMark(hi, 0xff0000,hi+"").getLine(),-1);
		
		//System.out.println(hi);
		
		}
		
		//c.yAxis().setLinearScale(lolo,hihi);
		
        
		//System.out.println(hi+","+hihi+","+StringUtil.getNowTime());
		
		
		String chart1URL = c.makeSession(req, "chart1");
		return chart1URL;

	}

	
	
	// ------------
//	 ------------
	public static String getChartWithLimit(int maxRows,String sql, int w, int h, int top,
			int bottom, int left, int right, String dateFormat,String title,
			//double[] arrLimitVal, 
			HttpServletRequest req) throws Exception {

		Map map = null;
		double[] arry = null;
		java.util.Date[] arrx = null;
		map = getXYValue( maxRows,sql, req);

		String station_id = req.getParameter("station_id");
		String infectant_id = req.getParameter("infectant_id");
		
		double[] arrLimitVal = getLimitValue(station_id,infectant_id,req);
			
			
		double hi = arrLimitVal[0];
		double hihi = arrLimitVal[1];

		arry = (double[]) map.get("y");
		arrx = (java.util.Date[]) map.get("x");

		XYChart c = new XYChart(w, h);

		c.setPlotArea(left, top, w - left - right, h - top - bottom);
		c.addTitle(title, "宋体", FONT_SIZE, TITLE_FONT_COLOR);
		LineLayer lineLayer = c.addLineLayer();

		//lineLayer.addDataSet(arry, -1, "").setDataSymbol(Chart.SquareSymbol, 7);
		lineLayer.addDataSet(arry, 0x00ff00, "").setDataSymbol(Chart.SquareSymbol, VALUE_SHAPE_SIZE);
		lineLayer.setLineWidth(1);

		lineLayer.setXData(arrx);

		c.xAxis().setLabelFormat("{value|" + dateFormat + "}");

		AreaLayer a1 = null;
		AreaLayer a2 = null;

		if (hihi > 0) {
			a2 = c.addAreaLayer(arry, c.yZoneColor(hihi, -1, 0xff0000));
			a2.setXData(arrx);
			//c.addAreaLayer(arry, c.yZoneColor(hihi, -1, 0xffff00));
		}
		
		if (hi > 0) {
			//a1 = c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xff0000));
			a1 = c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xffff00));
			a1.setXData(arrx);
			//c.addAreaLayer(arry, c.yZoneColor(hi, -1, 0xff0000));
		}
		

		String chart1URL = c.makeSession(req, "chart1");
		return chart1URL;

	}

	// ------------
//	------------------------------
	public static String getChart(List sqlList, int w, int h, int top,
			int bottom, int left, int right, String title,HttpServletRequest req)
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
		c.addTitle(title, "宋体", FONT_SIZE, TITLE_FONT_COLOR);
		
		c.addLegend(70,20, false, "", legend_font_size).setBackground(Chart.Transparent);
        
		LineLayer lineLayer = null;

		num = sqlList.size();

		for (i = 0; i < num; i++) {
			sqlMap = (Map) sqlList.get(i);
			sql = (String) sqlMap.get("sql");
			sqlName = (String) sqlMap.get("name");

			map = getXYValue(sql, req);
			arry = (double[]) map.get("y");
			arrx = (java.util.Date[]) map.get("x");

			lineLayer = c.addLineLayer();

			lineLayer.addDataSet(arry, -1, sqlName).setDataSymbol(
					Chart.SquareSymbol, VALUE_SHAPE_SIZE);

			lineLayer.setLineWidth(LINE_WIDTH);

			lineLayer.setXData(arrx);
		}// end for

		c.xAxis().setLabelFormat("{value|yy-mm-dd}");

		
		java.util.Date[]dateArr = getStartEndDate(req);
		
		String date_axis_fix_flag = null;
		
		date_axis_fix_flag = req.getParameter("date_axis_fix_flag");
		
		
		//c.xAxis().setDateScale(dateArr[0],dateArr[1]);

		
		
		if(StringUtil.equals(date_axis_fix_flag,"1")){
		c.xAxis().setDateScale(dateArr[0],dateArr[1]);
		}
		
		
		
		
		String chart1URL = c.makeSession(req, "chart1");
		return chart1URL;

	}

	// ------------------
	
	public static String getChart(List sqlList, int w, int h, int top,
			int bottom, int left, int right, String title,String dateFormat,HttpServletRequest req)
			throws Exception {
		
		System.out.println(" get chart"+f.time());

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
		
		c.addLegend(70,20, false, "", legend_font_size).setBackground(Chart.Transparent);
        
		LineLayer lineLayer = null;

		num = sqlList.size();

		for (i = 0; i < num; i++) {
			sqlMap = (Map) sqlList.get(i);
			sql = (String) sqlMap.get("sql");
			sqlName = (String) sqlMap.get("name");
			
			System.out.println(sqlName+",sql="+sql);

			map = getXYValue(sql, req);
			
			System.out.println(map);
			
			arry = (double[]) map.get("y");
			arrx = (java.util.Date[]) map.get("x");

			lineLayer = c.addLineLayer();

			lineLayer.addDataSet(arry, -1, sqlName).setDataSymbol(
					Chart.SquareSymbol, VALUE_SHAPE_SIZE);

			lineLayer.setLineWidth(LINE_WIDTH);

			lineLayer.setXData(arrx);
		}// end for

		c.xAxis().setLabelFormat("{value|"+dateFormat+"}");

		
		java.util.Date[]dateArr = getStartEndDate(req);
		
		String date_axis_fix_flag = null;
		
		date_axis_fix_flag = req.getParameter("date_axis_fix_flag");
		
		
		//c.xAxis().setDateScale(dateArr[0],dateArr[1]);

		
		
		if(StringUtil.equals(date_axis_fix_flag,"1")){
		c.xAxis().setDateScale(dateArr[0],dateArr[1]);
		}
		
		
		
		
		String chart1URL = c.makeSession(req, "chart1");
		return chart1URL;

	}

	
	
	
	
	//use
	public static String getChart(String sql, String dateFormat,String title,
			double[] arrLimitVal, HttpServletRequest req) throws Exception {
		int w = 750;
		int h = 320;
		int left = 50;
		int right = 20;
		int top = 20;
		int bottom = 20;
		//System.out.println(title);
		
		return getChartWithLimit(sql, w, h, top, bottom, left, right,
				dateFormat, title,arrLimitVal, req);

	}
	// --------------
//	 ------------
	public static String getRealChart(int num, int w, int h, int top,
			int bottom, int left, int right,String title, HttpServletRequest req)
			throws Exception {
		//String sql = App.getRealChartSql(num, req);
		String url = null;
		String station_id = req.getParameter("station_id");
		String infectant_id = req.getParameter("infectant_id");
		//String nowDate = StringUtil.getNowDate()+"";
		String fmt = "hh:nn";
		String sql = null;
		
		//nowDate = nowDate+" "+StringUtil.getNowHour()+":0:0";
		
		//nowDate = getRealChartStartTime();
		
		
		/*
		
		String sql = "select m_time,m_value from t_monitor_real_minute ";
		//sql = sql + "where m_time>='"+nowDate+"' order by m_time desc";
		sql = sql+"where station_id='"+station_id+"' and ";
		sql = sql + "infectant_id='"+infectant_id+"' ";
		sql = sql+" and m_time>='"+nowDate+"' ";
		
		
		sql = sql +"order by m_time desc";
		*/
		
		sql = getRealSql(station_id,infectant_id);
		//System.out.println(sql);
		//url = getChart(num,sql, w, h, top, bottom, left, right,"yy-mm-dd hh:nn",req);
		//url = getChartWithLimit(num,sql, w, h, top, bottom, left, right,"yy-mm-dd-hh-nn",title,req);
		url = getChartWithLimit(num,sql, w, h, top, bottom, left, right,fmt,title,req);
		//String format = "yy-mm-dd-hh-nn";

		//double[] arrDoubleVal = NewChart.getLimitValue(station_id,infectant_id,req);
        
		
		//url = NewChart.getChart(sql,format,title,arrDoubleVal,req);
		
		return url;
	}

	// ---------------------
	public static java.util.Date[] getStartEndDate(HttpServletRequest req)
	throws Exception{
		java.util.Date[]arr=new java.util.Date[2];
		
		Timestamp ts1 = null;
		Timestamp ts2 = null;
		String sts1 = null;
		String sts2 = null;
		
		String date1 = null;
		String date2 = null;
		String hour1 = null;
		String hour2 = null;
		try{
		date1 = req.getParameter("date1");
		date2 = req.getParameter("date2");
		hour1 = req.getParameter("hour1");
		hour2 = req.getParameter("hour2");
		
		if(StringUtil.isempty(hour1)){
			sts1=date1+"";
		}else{
			sts1=date1+" "+hour1+":"+"0:0.0";
			
		}
		
		if(StringUtil.isempty(hour2)){
			sts2=date2+"";
		}else{
			sts2=date2+" "+hour2+":"+"0:0.0";
			
		}
		
		ts1 = StringUtil.getTimestamp(sts1);
		ts2 = StringUtil.getTimestamp(sts2);
		arr[0]=ts1;
		arr[1]=ts2;
		return arr;
		
		}catch(Exception e){
			String msg = null;
			msg = "时间格式不对,"+e;
			throw new Exception(msg);
		}
		
	}
	

}// end class

