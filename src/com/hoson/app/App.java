package com.hoson.app;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.hoson.*;

import java.util.regex.*;
import java.text.*;
import java.net.*;
import com.hoson.util.JspPageUtil;


public class App {
	
	
	public static int getDefaultPageSize(){
		return 15;
	}

	public static Map chartTypeMap = null;

	public static String sysType = null;

	private static Map sysTypeSqlMap = null;

	private static String sysTypeSql = null;

	private static String sqlInStr = null;

	private static Map dataTableMap = null;

	private static Map topImgMap = null;

	private static Map defStationIdMap = null;

	private static Map sysTitleMap = null;

	/*!
	 * 获得地区编号
	 */
	public static String getAreaId(){
		return get("default_area_id","3301");
	}
	/*!
	 * 获得默认的站位类型
	 */
	public static String getDefaultStationType(){
		return get("default_station_type","5"); 
	}
	/*!
	 * 根据key获得配置文件值
	 */
	public static String get(String key)throws Exception{
		return Config.get_sys_prop().getProperty(key);
	}
	/*!
	 * 根据key获得配置文件值,没有则返回默认值defaultValue
	 */
    public static String get(String key,String defaultValue){
		String v = null;
		try{
		v = get(key);
		if(StringUtil.isempty(v)){
			v=defaultValue;
		}
		return v;
		}catch(Exception e){
			return defaultValue;
		}
	}
    /*!
	 * 返回红色html标签
	 */
    public static String require(){
		String s = "(<font color=red>*</font>)";
		return s;
	}
    /*!
	 * 获得返回的html标签
	 */
	public static String getBackButton(){
		String s = "<input type=button onclick='history.back()' class=btn value='返回'>";
		return s;
	}
	/*!
	 * 获得字符串s的解密后数据，如果有","，则返回第一个逗号前的数据
	 */
	public static String getValueStr(String s) {
		if (f.empty(s)) {
			return "";
		}
		s = f.dd_avg_data(s);
		if(f.empty(s)){return "";}
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

	/*!
	 * 获得字符串s的解密后数据，如果有","，则返回第一个逗号前的数据
	 */
	public static String getRealValueStr(String s) {
		if (f.empty(s)) {
			return "";
		}
		s = f.dd_real_data(s);
		if(f.empty(s)){return "";}
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
	/*!
	 * 获得request里的key信息
	 */
	public static String get(HttpServletRequest req, String key) {
		String v = null;
		v = (String) req.getAttribute(key);
		if (v == null) {
			v = "";
		}
		return v;
	}
	/*!
	 * 根据num值选择格式化d数据
	 */
	public static String round(double d, int num) {
		if (num < 0) {
			num = 0;
		}
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMaximumFractionDigits(num);
		return nf.format(d);
	}

	/*!
	 * 根据request获得站位类型下拉列表，station_type为默认选中值
	 */
	public static String getStationTypeOption(String station_type,
			HttpServletRequest req) throws Exception {
		if(2>1){
			return JspPageUtil.getStationTypeOption(station_type);
		}
		String s = null;
		String sql = null;
		try {
			sql = getTreeSql(req);
			s = JspUtil.getOption(sql, station_type, req);
			return s;
		} catch (Exception e) {
			throw e;
		}
	}
	/*!
	 * 根据站位编号station_id,因子编号infectant_id获得因子的值
	 */
	public static Map getInfectantLimitValue(Connection cn, String station_id,
			String infectant_id) throws Exception {
		String sql = "select standard_value,hi,hihi from t_cfg_monitor_param ";
		sql = sql + " where station_id='" + station_id + "' and infectant_id='"
				+ infectant_id + "'";
		Map map = null;
		try{
			map= DBUtil.queryOne(cn, sql, null);
		}catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
		return map;
	}
	/*!
	 * 根据站位编号station_id,因子编号infectant_id获得因子的值
	 */
	public static String getTreeSql(HttpServletRequest req) throws Exception {

		String type = getSysType(req);
		String msg = checkSysType(req);
		if (!StringUtil.isempty(msg)) {
			throw new Exception(msg);
		}
		return (String) sysTypeSqlMap.get(type);
	}
	/*!
	 * 从配置文件中获得系统类型sys_type的值
	 */
	public static String checkSysType(HttpServletRequest req) throws Exception {
		String type = null;
		String msg = null;
		msg = "请在" + Config.get_config_file() + "中配置sys_type参数\n";
		msg = msg + "污染源wry,环境质量hjzl,常规监测cgjc";
		type = getSysType(req);
		if (StringUtil.isempty(type)) {
			return msg;
		}
		String[] arrType = { "wry", "hjzl", "cgjc", "all" };
		if (StringUtil.containsValue(arrType, type) < 1) {
			return msg;
		}
		return "";
	}
	/*!
	 * 从配置文件中获得系统类型sys_type的值
	 */
	public static String getSysType(HttpServletRequest req) throws Exception {
		if (!StringUtil.isempty(sysType)) {
			return sysType;
		}
		Properties prop = null;
		// prop = PropUtil.getProp(req, "db.txt");
		prop = com.hoson.Config.get_sys_prop();
		String type = null;
		type = prop.getProperty("sys_type");

		String[] arrType = { "wry", "hjzl", "cgjc", "all" };
		if (StringUtil.containsValue(arrType, type) < 1) {
			sysType = "all";
		} else {
			sysType = type;
		}
		return sysType;
	}

	// -----------------------------
	static {
		chartTypeMap = new HashMap();
		chartTypeMap.put("minute", "t_monitor_real_minute");
		chartTypeMap.put("hour", "t_monitor_real_hour");
		chartTypeMap.put("day", "t_monitor_real_day");
		chartTypeMap.put("week", "t_monitor_real_week");
		chartTypeMap.put("month", "t_monitor_real_month");
		chartTypeMap.put("year", "t_monitor_real_year");

		sysTypeSqlMap = new HashMap();
		sysTypeSql = "select parameter_value,parameter_name from t_cfg_parameter ";
		sysTypeSql = sysTypeSql
				+ " where parameter_type_id='monitor_type' and parameter_value in ";

		sqlInStr = "'1','2','3','4'";
		sysTypeSqlMap.put("wry", sysTypeSql + "(" + sqlInStr + ")");

		sqlInStr = "'5','6','7','8'";
		sysTypeSqlMap.put("hjzl", sysTypeSql + "(" + sqlInStr + ")");

		sqlInStr = "'A','B','C','D'";
		sysTypeSqlMap.put("cgjc", sysTypeSql + "(" + sqlInStr + ")");
		String sql0 = "select parameter_value,parameter_name from t_cfg_parameter ";
		sql0 = sql0 + "where parameter_type_id='monitor_type'";
		sysTypeSqlMap.put("all", sql0);

		topImgMap = new HashMap();
		topImgMap.put("wry", "top_wry.gif");
		topImgMap.put("hjzl", "top_hjzl.gif");
		topImgMap.put("cgjc", "top_cgjc.gif");
		topImgMap.put("all", "top_all.gif");

		defStationIdMap = new HashMap();
		defStationIdMap.put("wry", "1");
		defStationIdMap.put("hjzl", "5");
		defStationIdMap.put("cgjc", "A");
		defStationIdMap.put("all", "5");

		sysTitleMap = new HashMap();
		sysTitleMap.put("wry", "污染源在线监测数据管理系统");
		sysTitleMap.put("hjzl", "环境质量在线监测数据管理系统");
		sysTitleMap.put("cgjc", "常规监测在线监测数据管理系统");
		sysTitleMap.put("all", "环境质量在线监测数据管理系统");

		dataTableMap = new HashMap();

		dataTableMap.put("minute", "t_monitor_real_minute");
		dataTableMap.put("hour", "t_monitor_real_hour");
		dataTableMap.put("day", "t_monitor_real_day");
		dataTableMap.put("week", "t_monitor_real_week");
		dataTableMap.put("month", "t_monitor_real_month");

		dataTableMap.put("year", "t_monitor_real_year");

	}

	/*!
	 * 获得sysTitleMap里边的sys_type值
	 */
	public static String getSysTitle(HttpServletRequest req) throws Exception {
		String type = getSysType(req);
		return (String) sysTitleMap.get(type);
	}
	/*!
	 * 获得默认的站位类型
	 */
	public static String getDefStationId(HttpServletRequest req)
			throws Exception {
		return getDefaultStationType();
	}
	/*!
	 * 获得数据集合
	 */
	public static Map getDataTableMap() {
		return dataTableMap;
	}
	/*!
	 * 根据sql查询数据库，把结果放入map里，第一列和第二列分别作为map的key和value
	 */
	public static Map getKeyValueMap(Connection cn, String sql)
			throws Exception {
		Statement stmt = null;
		ResultSet rs = null;
		Map map = new HashMap();
		String skey = null;
		String svalue = null;
		try {
			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				skey = rs.getString(1);
				svalue = rs.getString(2);
				if (skey == null) {
					skey = "";
				}
				if (svalue == null) {
					svalue = "";
				}
				map.put(skey, svalue);
			}
			return map;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
			DBUtil.close(cn);
		}
	}
	/*!
	 * 根据sql查询数据库，把结果放入map里，第一列和第二列分别作为map的key和value
	 */
	public static Map getKeyValueMap(String sql, HttpServletRequest req)
			throws Exception {
		Connection cn = null;
		try {
			cn = DBUtil.getConn(req);
			return getKeyValueMap(cn, sql);
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
	}
	/*!
	 * 获得图表类型
	 */
	public static Map getChartTypeMap() {
		return chartTypeMap;
	}
	/*!
	 * 获得图表类型，为空则返回t_monitor_real_day
	 */
	public static String getChartTypeTable(String type) {
		String t = null;
		t = (String) chartTypeMap.get(type);
		if (StringUtil.isempty(t)) {
			t = "t_monitor_real_day";
		}
		return t;
	}
	/*!
	 * 更新表t的数据状态
	 */
	public static void dataCheck(Connection cn, String t, HttpServletRequest req) {
		int check_flag = 0;
		check_flag = JspUtil.getInt(req, "check_action_flag", 0);
		if (check_flag < 1 || check_flag > 3) {
			return;
		}
		String sql = null;
		String[] arr = null;
		String[] valueArr = null;
		String ss = null;
		arr = req.getParameterValues("objectid");
		if (arr == null) {
			return;
		}
		if (check_flag == 1) {
			sql = "update " + t
					+ " set check_flag='0' where station_id=? and m_time=?";
		}
		if (check_flag == 2) {
			sql = "update " + t
					+ " set check_flag='1' where station_id=? and m_time=?";
		}
		if (check_flag == 3) {
			sql = "update " + t
					+ " set check_flag='2' where station_id=? and m_time=?";
		}
		PreparedStatement ps = null;
		try {
			ps = cn.prepareStatement(sql);
			int i = 0;
			int num = arr.length;
			String station_id = null;
			java.sql.Timestamp ts = null;
			for (i = 0; i < num; i++) {
				ss = arr[i];
				valueArr = ss.split(";");
				station_id = valueArr[0];
				ts = StringUtil.getTimestamp(valueArr[1]);
				ps.setString(1, station_id);
				ps.setObject(2, ts);
				ps.executeUpdate();
			}
		} catch (Exception e) {
		} finally {
			DBUtil.close(ps);
			DBUtil.close(cn);
		}
	}
	/*!
	 * 获得request中data_type的值
	 */
	public static void dataCheck(Connection cn, HttpServletRequest req) {
		String t = null;
		String type = null;

		type = req.getParameter("data_type");
		if (StringUtil.isempty(type)) {
			return;
		}
		t = (String) (getDataTableMap().get(type));
		if (StringUtil.isempty(t)) {
			return;
		}
		dataCheck(cn, t, req);
	}
	/*!
	 * 根据站位编号station_id和因子编号infectant_id查询数据库获得因子名称
	 */
	public static String getInfectantCol(Connection cn, String station_id,
			String infectant_id) throws Exception {
		if (StringUtil.isempty(station_id) || StringUtil.isempty(infectant_id)) {
			return null;
		}
		String sql = null;
		Map map = null;
		String col = null;
		sql = "select infectant_column from t_cfg_monitor_param  where station_id='"
				+ station_id + "' and infectant_id='" + infectant_id + "'";
		try{
			map = DBUtil.queryOne(cn, sql, null);
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
		if (map == null) {
			return "";
		}
		col = (String) map.get("infectant_column");
		return col;
	}
	/*!
	 * 获得站位的因子信息，返回radio的html标签
	 */
	public static String getSiteInfectantRadioBox(HttpServletRequest req) {
		String s = null;
		String sql = null;
		HttpSession session = req.getSession();
		String station_id = null;
		station_id = (String) session.getAttribute("station_id");
		if (StringUtil.isempty(station_id)) {
			return "";
		}
		Connection cn = null;
		sql = "SELECT a.infectant_id,b.infectant_name ";
		sql = sql + "FROM t_cfg_monitor_param a ,t_cfg_infectant_base b ";
		sql = sql + "where  a.station_id = '" + station_id
				+ "' and a.infectant_id = b.infectant_id ";
		try {
			cn = DBUtil.getConn(req);
			s = JspUtil.getRadioBoxHtml(cn, sql, "infectant_id", 1, " ", req);
			return s;
		} catch (Exception e) {
			s = "";
			return s;
		} finally {
			DBUtil.close(cn);
		}
	}
	/*!
	 * 获得站位的因子信息，返回radio的html标签
	 */
	public static String getSiteInfectantRadioBoxWithClickEvent(
			HttpServletRequest req) {
		String s = null;
		String sql = null;
		HttpSession session = req.getSession();
		String station_id = null;
		station_id = (String) session.getAttribute("station_id");
		if (StringUtil.isempty(station_id)) {
			return "";
		}
		Connection cn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String strv = null;
		String strt = null;
		s = "";
		int i = 0;
		sql = "SELECT a.infectant_id,b.infectant_name ";
		sql = sql + "FROM t_cfg_monitor_param a ,t_cfg_infectant_base b ";
		sql = sql+ "where  a.station_id = '"
				+ station_id+ "' and a.infectant_id = b.infectant_id order by a.show_order asc";
		try {
			cn = DBUtil.getConn(req);
			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				strv = rs.getString(1);
				strt = rs.getString(2);
				if (i < 1) {
					s = s + "<input type=radio name=infectant_id value=\""
							+ strv + "\" checked onclick=form1.submit()>"
							+"<span onclick=f_check_submit_infectant('"+strv+"')>"
							+ strt + "</span>\n";
				} else {
					s = s + "<input type=radio name=infectant_id value=\""
							+ strv + "\"  onclick=form1.submit()>" 
							+"<span onclick=f_check_submit_infectant('"+strv+"')>"
							+ strt
							+ "</span>\n";
				}

				
				i++;
			}// end while
			return s;
		} catch (Exception e) {
			s = "";
			return s;
		} finally {
			DBUtil.close(cn);
		}
	}
	/*!
	 * 获得站位的因子信息，返回有点击事件的radio的html标签
	 */
	public static String getSiteInfectantRadioBoxWithClickEvent(
			HttpServletRequest req, String v) {
		String s = null;
		String sql = null;
		HttpSession session = req.getSession();
		String station_id = null;
		station_id = (String) session.getAttribute("station_id");
		if (StringUtil.isempty(station_id)) {
			return "";
		}
		Connection cn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String strv = null;
		String strt = null;
		s = "";
		int i = 0;
		sql = "SELECT a.infectant_id,b.infectant_name ";
		sql = sql + "FROM t_cfg_monitor_param a ,t_cfg_infectant_base b ";
		sql = sql
				+ "where  a.station_id = '"
				+ station_id
				+ "' and a.infectant_id = b.infectant_id  order by a.show_order asc";
		try {
			cn = DBUtil.getConn(req);
			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				strv = rs.getString(1);
				strt = rs.getString(2);

				if (i < 1 || StringUtil.equals(v, strv)) {
					s = s + "<input type=radio name=infectant_id value=\""
							+ strv + "\" checked onclick=form1.submit()>"
							+"<span onclick=f_check_submit_infectant('"+strv+"')>"
							
							+ strt + "</span>\n";
				} else {
					s = s + "<input type=radio name=infectant_id value=\""
							+ strv + "\"  onclick=form1.submit()>" 
							+"<span onclick=f_check_submit_infectant('"+strv+"')>"
							+ strt
							+ "</span>\n";
				}

				i++;
			}
			return s;
		} catch (Exception e) {
			s = "";
			return s;
		} finally {
			DBUtil.close(cn);
		}
	}
	/*!
	 * 获得图表的radio列表
	 */
	public static String getChartTypeRadioBox(HttpServletRequest req) {
		String vs = "minute,hour,day,week,month";
		String ts = "分均值线图,时均值线图,日均值线图,周均值线图,月均值线图";
		String s = null;
		try {
			s = JspUtil.getRadioBoxHtml(vs, ts, "chart_type", "day", " ", req);
		} catch (Exception e) {
			s = "";
		}
		return s;
	}
	/*!
	 * 获得图表的下拉列表
	 */
	public static String getChartTypeOption() {
		String vs = "minute,hour,day,week,month";
		String ts = "分均值线图,时均值线图,日均值线图,周均值线图,月均值线图";
		String v = "day";
		String s = null;
		try {
			s = JspUtil.getOption(vs, ts, v);
		} catch (Exception e) {
			s = "";
		}
		return s;
	}
	/*!
	 * 根据站位编号获得因子map集合
	 */
	public static Map getInfectantMap(Connection cn, String station_id)
			throws Exception {
		Map map = new HashMap();

		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		String col = null;
		List idList = new ArrayList();
		List colList = new ArrayList();
		List nameList = new ArrayList();
		List unitList = new ArrayList();
		List standardList = new ArrayList();
		List hiList = new ArrayList();
		List hihiList = new ArrayList();
		sql = "SELECT a.infectant_id, a.infectant_column, b.infectant_name, b.infectant_unit,a.standard_value,a.hi,a.hihi ";
		sql = sql + "FROM t_cfg_monitor_param a ,t_cfg_infectant_base b ";
		sql = sql + "where  a.station_id = '" + station_id
				+ "' and a.infectant_id = b.infectant_id ";
		try {
			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				col = rs.getString(2);
				if (!StringUtil.isempty(col)) {
					idList.add(rs.getString(1));
					colList.add(col);
					nameList.add(rs.getString(3));
					unitList.add(rs.getString(4));
					standardList.add(rs.getString(5));
					hiList.add(rs.getString(6));
					hihiList.add(rs.getString(7));
				}
			}
			map.put("id", idList);
			map.put("name", nameList);
			map.put("col", colList);
			map.put("unit", unitList);
			map.put("standard", standardList);
			map.put("hi", hiList);
			map.put("hihi", hihiList);
			return map;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
			DBUtil.close(cn);
		}
	}
	/*!
	 * 获得因子列的html标签形式
	 */
	public static String getRealDataTable(HttpServletRequest req)
			throws Exception {
		String sql = null;
		String s = "";
		String station_id = null;
		Connection cn = null;
		Statement stmt = null;
		ResultSet rs = null;
		Map map = null;
		String infectant_id = null;
		try {
			HttpSession session = req.getSession();
			station_id = (String) session.getAttribute("station_id");
			sql = "select a.infectant_id as infectant_id,a.m_time as m_time,a.m_value as m_value ";
			sql = sql + "from t_monitor_real_minute a,";
			sql = sql+ "(select infectant_id,max(m_time) as m_time from t_monitor_real_minute ";
			sql = sql+ "where station_id='${station_id}' group by infectant_id) b ";
			sql = sql+ "where a.station_id='${station_id}' and a.infectant_id=b.infectant_id and a.m_time=b.m_time ";
			sql = StringUtil.setParam(sql, "station_id", station_id);
			cn = DBUtil.getConn(req);
			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);
			int irow = 0;
			int flag = 0;

			sql = "select a.infectant_id,b.infectant_name from t_cfg_monitor_param a,t_cfg_infectant_base b ";
			sql = sql+ " where a.infectant_id=b.infectant_id and a.station_id='"+ station_id + "'";
			map = DBUtil.getMap(cn, sql);
			while (rs.next()) {
				flag = irow % 2;
				infectant_id = rs.getString(1);
				s = s + "<tr class=tr" + flag + ">";
				s = s + "<td>" + infectant_id + "</td>";
				s = s + "<td>" + map.get(infectant_id) + "</td>";
				s = s + "<td>" + rs.getString(2) + "</td>";
				s = s + "<td>" + rs.getString(3) + "</td>";
				s = s + "</tr>";
				irow++;
			}
			return s;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs, stmt, cn);
		}
	}
	/*!
	 * 获得查询实时数据的sql
	 */
	public static String getRealChartSql(int num, HttpServletRequest req)
			throws Exception {
		String sql = "";
		String station_id = null;
		String infectant_id = null;
		String dbtype = null;
		int flag = 0;
		HttpSession session = req.getSession();
		infectant_id = JspUtil.getParameter(req, "infectant_id");
		if (infectant_id == null) {
			infectant_id = "0";
		}
		station_id = (String) session.getAttribute("station_id");

		dbtype = DBUtil.getDBType(req);
		if (StringUtil.equals(dbtype, "sqlserver")) {
			sql = "select top " + num
					+ " m_time,m_value from t_monitor_real_minute ";
			sql = sql + "where station_id='" + station_id + "' ";
			sql = sql + "and infectant_id='" + infectant_id + "' ";
			sql = sql + "order by m_time desc";
			flag = 1;
		}
		if (StringUtil.equals(dbtype, "oracle")) {
			sql = "select * from (";
			sql = sql + "select  m_time,m_value from t_monitor_real_minute ";
			sql = sql + "where station_id='" + station_id + "' ";
			sql = sql + "and infectant_id='" + infectant_id + "' ";
			sql = sql + "order by m_time desc";
			sql = sql + ") where rownum<" + num;
			flag = 1;
		}
		if (flag < 1) {
			throw new Exception("未知的数据库类型，请检查配置,unknow db type,please check config");
		}
		return sql;
	}
	/*!
	 * 查询数据库获得站位因子的下拉列表值
	 */
	public static String getInfectantOption(Connection cn,
			HttpServletRequest req) throws Exception {
		String sql = null;
		String station_id = null;
		String infectant_id = null;
		String option = null;
		HttpSession session = req.getSession();
		infectant_id = JspUtil.getParameter(req, "infectant_id");
		if (infectant_id == null) {
			infectant_id = "0";
		}
		station_id = (String) session.getAttribute("station_id");
		sql = "select a.infectant_id,a.infectant_name from t_cfg_infectant_base a,t_cfg_monitor_param b where ";
		sql = sql + "b.station_id='" + station_id + "' ";
		sql = sql + " and a.infectant_id=b.infectant_id";
		option = JspUtil.getOption(cn, sql, infectant_id);
		return option;
	}
	/*!
	 * 获得检测因子的下拉列表
	 */
	public static String getInfectantOption(HttpServletRequest req)
			throws Exception {
		String option = null;
		Connection cn = null;
		try {
			cn = DBUtil.getConn(req);
			option = getInfectantOption(cn, req);
			return option;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
	}
	/*!
	 * 根据站位编号station_id,因子编号infectant_id和配置文件值prop获得查询实时数据的sql
	 */
	public static String getCompareSql(Connection cn, String station_id,
			String infectant_id, Properties prop) throws Exception {
		String col = null;
		String sql1 = "select m_time,val01 from t_monitor_real_year where 1>2";
		String sql2 = "select m_time,${col} as m_value from ${table} ";
		sql2 = sql2+ "where station_id='${station_id}' and m_time>='${date1} ${hour1}:0:0' and ";
		sql2 = sql2 + "m_time<='${date2} ${hour2}:59:59' order by m_time asc";
		col = App.getInfectantCol(cn, station_id, infectant_id);
		if (StringUtil.isempty(col)) {
			return sql1;
		}
		prop.setProperty("col", col);
		prop.setProperty("station_id", station_id);
		sql2 = StringUtil.setParam(sql2, prop);
		return sql2;
	}
	/*!
	 * 根据站位arr_ids,因子编号infectant_id和配置文件值prop获得查询实时数据,返回list集合
	 */
	public static List getCompareSqlList(Connection cn, String[] arr_ids,
			String infectant_id, Properties prop) throws Exception {
		List list = new ArrayList();
		if (arr_ids == null) {
			return list;
		}
		String station_id = null;
		String sql = null;
		Map map = null;
		int i = 0;
		int num = 0;
		num = arr_ids.length;
		for (i = 0; i < num; i++) {
			station_id = arr_ids[i];
			sql = getCompareSql(cn, station_id, infectant_id, prop);
			map = new HashMap();
			map.put("name", station_id);
			map.put("sql", sql);
			list.add(map);
		}
		return list;
	}
	/*!
	 * 根据站位编号station_id,因子编号infectant_id，站位编号名称集合keyValueMap和配置文件值prop获得查询实时数据的sql
	 */
	public static List getCompareSqlList(Connection cn, String[] arr_ids,
			String infectant_id, Map keyValueMap, Properties prop)
			throws Exception {
		List list = new ArrayList();
		if (arr_ids == null) {
			return list;
		}
		String station_id = null;
		String sql = null;
		Map map = null;
		int i = 0;
		int num = 0;
		num = arr_ids.length;
		String sname = null;
		for (i = 0; i < num; i++) {
			station_id = arr_ids[i];
			sql = getCompareSql(cn, station_id, infectant_id, prop);
			map = new HashMap();
			sname = (String) keyValueMap.get(station_id);
			if (sname == null) {
				sname = "";
			}
			map.put("name", sname);
			map.put("sql", sql);
			list.add(map);
		}
		return list;
	}
	/*!
	 * 根据站位类型station_type,名称name,默认值default2和req查询数据库获得该站位类型的检测因子列表
	 */
	public static String getInfectantOption(String station_type, String name,
			String default2, HttpServletRequest req) throws Exception {
		Connection cn = null;
		try {
			cn = DBUtil.getConn(req);
			String sql = "select infectant_id,infectant_name from t_cfg_infectant_base where station_type ='"
				+ station_type + "'";
			return JspUtil.getOption(cn, sql, name, default2, req);
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
	}
	/*!
	 * 根据list获得html的td列表
	 */
	public static String getStandardValueTd(List list) {
		if (list == null) {
			return "";
		}
		int i = 0;
		int num = 0;
		num = list.size();
		String s = "";
		for (i = 0; i < num; i++) {
			s = s + "<td>";
			s = s + StringUtil.getDouble(list.get(i) + "", 0);
			s = s + "</td>\n";
		}
		return s;
	}
	/*!
	 * 根据request值更新session里的值
	 */
	public static void updateSessionValue(HttpServletRequest req) {
		HttpSession s = req.getSession();
		s.setAttribute("chart_type", req.getParameter("chart_type"));
		s.setAttribute("data_type", req.getParameter("data_type"));
		s.setAttribute("date1", JspUtil.getDate(req, "date1", null) + "");
		s.setAttribute("date2", JspUtil.getDate(req, "date2", null) + "");
		s.setAttribute("hour1", JspUtil.getHour(req, "hour1", 0) + "");
		s.setAttribute("hour2", JspUtil.getHour(req, "hour2", 23) + "");
		s.setAttribute("infectant_id", req.getParameter("infectant_id"));
		s.setAttribute("date_axis_fix_flag", req.getParameter("date_axis_fix_flag"));
		s.setAttribute("bar", req.getParameter("bar"));
		s.setAttribute("flag_3d", req.getParameter("flag_3d"));
	}
	/*!
	 * 根据radio的value值vs，text值ts，名称name,是否选中v，onclick事件js,排序boxSep获得radio的html
	 */
	public static String getRadioBox(String vs, String ts, String name,
			String v, String js, String boxSep) throws Exception {
		String s = "";
		if (StringUtil.isempty(vs)) {
			throw new Exception("值不能为空");
		}
		if (StringUtil.isempty(ts)) {
			throw new Exception("标题不能为空");
		}
		int i = 0;
		int num = 0;
		String strv = null;
		String strt = null;
		String checkedFlag = null;
		String[] arrv = vs.split(",");
		String[] arrt = ts.split(",");
		num = arrv.length;
		if (arrt.length != num) {
			throw new Exception("值与标题数目不匹配");
		}
		for (i = 0; i < num; i++) {
			strv = arrv[i];
			strt = arrt[i];
			if (StringUtil.equals(strv, v)) {
				checkedFlag = " checked ";
			} else {
				checkedFlag = " ";
			}
			s = s + "<input type=\"radio\" name=\"" + name + "\" value=\""
					+ strv + "\" ";
			s = s + "onclick=\"" + js + "\" " + checkedFlag + ">";
			s = s + strt + boxSep + " \n";
		}
		return s;
	}
	/*!
	 * 根据session，名称name和默认日期，获得日期，出现异常返回默认日期值
	 */
	public static Date getDate(HttpSession s, String name, Date defaultDate) {
		Date d = null;
		if (defaultDate == null) {
			try {
				defaultDate = StringUtil.getNowDate();
			} catch (Exception e) {
			}
		}
		String v = null;
		v = (String) s.getAttribute(name);
		if (v == null) {
			return defaultDate;
		}
		java.sql.Timestamp ts = null;
		try {
			ts = StringUtil.getTimestamp(v);
		} catch (Exception e) {
			return defaultDate;
		}
		d = StringUtil.getSqlDate(ts);
		return d;
	}
	/*!
	 * 根据session，名称name和默认小时值，获得小时，出现异常返回默认小时值
	 */
	public static int getHour(HttpSession s, String name, int defVal) {
		int hh = 0;
		int nowHour = StringUtil.getNowHour();

		String v = (String) s.getAttribute(name);
		if (v == null) {
			hh = defVal;
		} else {
			hh = StringUtil.getInt(v, nowHour);
		}
		if (hh < 0 || hh > 23) {
			hh = nowHour;
		}
		return hh;
	}
	/*!
	 * 对s进行小时的范式匹配验证
	 */
	public static String trimHour(String s) {
		if (StringUtil.isempty(s)) {
			return "";
		}
		Pattern p = Pattern
				.compile("([0-9]{4}\\-[0-9]{1,2}\\-[0-9]{1,2}) [0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}\\.[0-9]{1,9}");
		Matcher m = p.matcher(s);
		StringBuffer sb = new StringBuffer();
		String v = null;
		while (m.find()) {
			v = m.group(1);
			m.appendReplacement(sb, v);
		}
		return sb.toString();
	}
	/*!
	 * 对s进行豪秒的范式匹配验证
	 */
	public static String trimMilliSecond(String s) {
		if (StringUtil.isempty(s)) {
			return "";
		}
		Pattern p = Pattern
				.compile("([0-9]{4}\\-[0-9]{1,2}\\-[0-9]{1,2} [0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2})\\.[0-9]{1,9}");
		Matcher m = p.matcher(s);
		StringBuffer sb = new StringBuffer();
		String v = null;
		while (m.find()) {
			v = m.group(1);
			m.appendReplacement(sb, v);
		}
		return sb.toString();

	}
	/*!
	 * 对s进行秒的范式匹配验证
	 */
	public static String trimSecond(String s) {
		if (StringUtil.isempty(s)) {
			return "";
		}
		Pattern p = Pattern
				.compile("([0-9]{4}\\-[0-9]{1,2}\\-[0-9]{1,2} [0-9]{1,2}:[0-9]{1,2}):[0-9]{1,2}\\.[0-9]{1,9}");
		Matcher m = p.matcher(s);
		StringBuffer sb = new StringBuffer();
		String v = null;
		while (m.find()) {
			v = m.group(1);
			m.appendReplacement(sb, v);
		}
		return sb.toString();

	}
	/*!
	 * 对s进行分钟的范式匹配验证
	 */
	public static String trimMinute(String s) {

		if (StringUtil.isempty(s)) {
			return "";
		}
		Pattern p = Pattern
				.compile("([0-9]{4}\\-[0-9]{1,2}\\-[0-9]{1,2} [0-9]{1,2}):[0-9]{1,2}:[0-9]{1,2}\\.[0-9]{1,9}");
		Matcher m = p.matcher(s);
		StringBuffer sb = new StringBuffer();
		String v = null;
		while (m.find()) {
			v = m.group(1);
			m.appendReplacement(sb, v);
		}
		return sb.toString();

	}
	/*!
	 * 对s进行天的范式匹配验证
	 */
	public static String trimDay(String s) {

		if (StringUtil.isempty(s)) {
			return "";
		}
		Pattern p = Pattern
				.compile("([0-9]{4}\\-[0-9]{1,2})\\-[0-9]{1,2} [0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}\\.[0-9]{1,9}");
		Matcher m = p.matcher(s);
		StringBuffer sb = new StringBuffer();
		String v = null;
		while (m.find()) {
			v = m.group(1);
			m.appendReplacement(sb, v);
		}
		return sb.toString();

	}
	/*!
	 * 查询数据库获得因子列表
	 */
	public static Map getInfectantColMap(Connection cn) throws Exception {
		Map map = new HashMap();
		String key = null;
		String val = null;
		String sql = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			sql = "select station_id,infectant_id,infectant_column from t_cfg_monitor_param";
			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				key = rs.getString(1) + rs.getString(2);
				val = rs.getString(3);
				if (val != null) {
					val = val.toLowerCase();
					map.put(key, val);
				}
			}
			return map;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
		}
	}
	/*!
	 * 根据request值查询数据库获得因子列表
	 */
	public static Map getInfectantColMap(HttpServletRequest req)
			throws Exception {
		Connection cn = null;
		try {
			cn = DBUtil.getConn(req);
			return getInfectantColMap(cn);
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
	}
	/*!
	 * 根据父编号获得子编号的list集合
	 */
	public static List getChildIdList(String pid, String[][] arr) {
		List list = new ArrayList();
		int rowNum = 0;
		rowNum = arr.length;
		String sid = null;
		String spid = null;
		int i = 0;
		for (i = 0; i < rowNum; i++) {
			sid = arr[i][0];
			spid = arr[i][1];
			if (StringUtil.equals(pid, spid)) {
				list.add(sid);
			}
		}
		return list;
	}
	/*!
	 * 根据父列表pidList获得子编号的list集合
	 */
	public static List getChildIdList(List pidList, String[][] arr) {
		List list = new ArrayList();
		int rowNum = 0;
		String pid = null;
		rowNum = arr.length;
		String sid = null;
		String spid = null;
		int i = 0;
		int pidNum = 0;
		pidNum = pidList.size();
		int j = 0;
		for (j = 0; j < pidNum; j++) {
			pid = (String) pidList.get(j);
			for (i = 0; i < rowNum; i++) {
				sid = arr[i][0];
				spid = arr[i][1];
				if (StringUtil.equals(pid, spid)) {
					list.add(sid);
				}
			}
		}
		return list;
	}
	/*!
	 * 根据父编号pid，二维数组arr和级别level获得子编号的list集合
	 */
	public static List getChildIdList(String pid, String[][] arr, int level) {
		if (level < 1 || level > 8) {
			level = 8;
		}
		List list = new ArrayList();
		List tmp = null;
		Object[] arrList = new Object[level];
		int i = 0;
		for (i = 0; i < level; i++) {
			arrList[i] = new ArrayList();
		}
		for (i = 0; i < level; i++) {
			if (i < 1) {
				arrList[i] = getChildIdList(pid, arr);
			} else {
				arrList[i] = getChildIdList((List) arrList[i - 1], arr);
			}
		}
		int num = 0;
		int j = 0;
		for (i = 0; i < level; i++) {
			tmp = (List) arrList[i];
			num = tmp.size();
			for (j = 0; j < num; j++) {
				list.add((String) tmp.get(j));
			}
		}
		return list;
	}
	/*!
	 * 根据父编号pid查询数据库获得子编号的list集合
	 */
	public static List getSiteIdList(Connection cn, String pid)
			throws Exception {
		List list = null;
		String sql = "select area_id,area_pid from t_cfg_area";
		String[][] arr = DBUtil.queryAsArray(cn, sql);
		list = getChildIdList(pid, arr, 5);
		list.add(pid);
		return list;
	}
	/*!
	 * 根据流域的父编号pid获得子流域的list集合
	 */
	public static List getValleyIdList(Connection cn, String pid)
			throws Exception {
		List list = null;
		String sql = "select valley_id,parent_id from t_cfg_valley";
		String[][] arr = DBUtil.queryAsArray(cn, sql);
		list = getChildIdList(pid, arr, 5);
		list.add(pid);
		return list;
	}
	/*!
	 * 根据sql查询数据库获得总记录数
	 */
	public static int getCountNum(Connection cn, String sql) throws Exception {
		int num = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			num = rs.getInt(1);
			return num;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
		}
	}
	/*!
	 * 根据list和使用标记user_sep_flag获得sql
	 */
	public static String getSqlInStr(List list, int use_sep_flag) {
		if (list == null) {
			return "";
		}
		int num = 0;
		num = list.size();
		if (num < 1) {
			return "";
		}
		String s = "";
		if (use_sep_flag > 0) {
			s = StringUtil.list2str(list, "','");
			s = "'" + s + "'";
		} else {
			s = StringUtil.list2str(list, ",");
		}
		return s;
	}
	/*!
	 * 根据request中的check_flag值获得按钮的html
	 */
	public static String getCheckButton(HttpServletRequest req) {
		int check_flag = JspUtil.getInt(req, "check_flag", 0);
		if (check_flag < 0 || check_flag > 2) {
			check_flag = 0;
		}
		String s = "";
		String passBtn = "<input type=button value=\"通过\" onclick=\"f_pass()\" class=btn>";
		String noPassBtn = "<input type=button value=\"不通过\" onclick=\"f_no_pass()\" class=btn>";
		String checkUndoBtn = "<input type=button value=\"撤消审核\" onclick=\"f_check_undo()\" class=btn>";
		if (check_flag == 0) {
			s = passBtn + " " + noPassBtn;
		}
		if (check_flag == 1) {
			s = checkUndoBtn;
		}
		if (check_flag == 2) {
			s = checkUndoBtn;
		}
		return s;
	}
	/*!
	 * 根据request的值获得站位编号的数组
	 */
	public static String[] getStationIdArr(HttpServletRequest req)
			throws Exception {

		String station_ids = req.getParameter("station_ids");
		if (StringUtil.isempty(station_ids)) {
			return null;
		}
		String[] arr = null;
		if(station_ids.indexOf(",")>=0){
		 arr = station_ids.split(",");
		}else{
			arr = station_ids.split(";");
			
		}
		if (arr == null) {
			return null;
		}
		int i = 0;
		int num = 0;
		num = arr.length;
		String v = null;
        List list = new ArrayList();
		for (i = 0; i < num; i++) {
			v = arr[i];
			if (v == null) {
				v = "";
			}
			if (v.indexOf("site") >= 0) {
				v = v.substring(4);
				list.add(v);
			}else{
			
			if (v.indexOf("site") < 0&&v.indexOf("node")<0) {
				list.add(v);
			}
			}
		}
		num = list.size();
		String[]arr2=new String[num];
		for(i=0;i<num;i++){
			
			arr2[i]=(String)list.get(i);
		}
		return arr2;
	}
	/*!
	 * 根据类的名字获得类的路径
	 */
	public static String getClassJar(Class c) throws Exception {
		String s = null;
		s = c.getName();
		s = s.replaceAll(".", "/");
		s = "/" + s;
		s = App.class.getResource(s) + "";
		return s;
	}
	/*!
	 *  获得页面的头部信息
	 */
	public static String getPageTopInfo(
			HttpServletRequest req){
		String s = "";
		HttpSession session = null;
		java.util.Date dateNow = StringUtil.getNowDate();
		int yy = 0;
		int mm = 0;
		int dd = 0;
		String user_name = null;
		yy = dateNow.getYear()+1900;
		mm = dateNow.getMonth()+1;
		dd = dateNow.getDate();
		session=req.getSession();
		s = s+"今天是 "+yy+"年"+mm+"月"+dd+"日<br>";
		user_name = (String)session.getAttribute("user_name");
		if(!StringUtil.isempty(user_name)){
			s = s+"当前用户 <b>"+user_name+"</b>";
		}
		return s;
	}
}