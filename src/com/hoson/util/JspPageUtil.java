package com.hoson.util;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;

import com.hoson.DBUtil;
import com.hoson.JspUtil;
import com.hoson.StringUtil;
import com.hoson.XBean;
import com.hoson.f;
import com.hoson.app.App;
import com.hoson.app.Cache;
import com.hoson.app.DataReportCache;

public class JspPageUtil {
	static String show_all_area = App.get("show_all_area", "0");

	public static Map getMap(List list, String key_col) {
		Map map = new HashMap();
		if (list == null) {
			return map;
		}
		int i, num = 0;
		num = list.size();
		Map m = null;
		String key = null;

		for (i = 0; i < num; i++) {
			m = (Map) list.get(i);
			key = (String) m.get(key_col);
			if (StringUtil.isempty(key)) {
				continue;
			}
			map.put(key, m);

		}

		return map;
	}

	public static Map getDataReportMap() throws Exception {
		Map map = null;
		Cache cache = new DataReportCache();
		map = (Map) cache.get(50, null);
		return map;

	}

	public static Map getInfectantInfoMap(Connection cn, String station_type)
			throws Exception {
		Map map = new HashMap();
		List list = null;
		Map m = null;
		int i = 0;
		int num = 0;
		String id = null;
		String col = null;
		String unit = null;
		List idList = new ArrayList();
		List colList = new ArrayList();
		String title = "";
		String name = null;

		list = getInfectantInfo(cn, station_type);

		num = list.size();
		if (num < 1) {
			throw new Exception("请配置监测指标");
		}

		for (i = 0; i < num; i++) {
			m = (Map) list.get(i);
			id = (String) m.get("infectant_id");
			if (StringUtil.isempty(id)) {
				throw new Exception("infectant_id can not empty");
			}
			col = (String) m.get("infectant_column");
			if (StringUtil.isempty(col)) {

				throw new Exception("no column for infectant_id " + id);
			}
			col = col.toLowerCase();

			name = (String) m.get("infectant_name");
			unit = (String) m.get("infectant_unit");

			idList.add(id);
			colList.add(col);
			title = title + "<td>" + name + " </td>\n";

		}

		map.put("id", idList);
		map.put("col", colList);
		map.put("title", title);

		return map;
	}

	public static String getTitle() throws Exception {
		String s = null;

		return s;

	}

	public static List getColumnList(List list) throws Exception {

		int i = 0;
		int num = 0;
		String msg = "infectant info list is null";
		String msg2 = "请配置监测指标";

		if (list == null) {
			throw new Exception("infectant info list is null");
		}
		num = list.size();
		if (num < 1) {
			throw new Exception("infectant info list is null");

		}
		List list2 = new ArrayList();
		String col = null;
		Map map = null;
		String id = null;
		for (i = 0; i < num; i++) {
			map = (Map) list.get(i);
			id = (String) map.get("infectant_id");

			col = (String) map.get("infectant_column");
			if (StringUtil.isempty(col)) {
				throw new Exception("no infectant_column for " + id);
			}
			col = col.toLowerCase();
			list2.add(col);

		}
		return list2;
	}

	public static String getHourTodaySql() {

		String sql = null;
		sql = "select a.*,b.row_num from view_hour_today a,"
				+ "(select station_id,count(1) as row_num,max(m_time) as m_time from view_hour_today "

				+ " group by station_id) b where "
				+ "   a.station_id=b.station_id  and a.m_time=b.m_time ";

		return sql;

	}

	public static List getInfectantInfo(Connection cn, String station_type)
			throws Exception {
		List list = null;
		String sql = null;

		sql = "select * from view_infectant_info where  station_type='"
				+ station_type
				+ "' and infectant_type='1' order by infectant_order";
		list = DBUtil.query(cn, sql);

		return list;

	}

	public static String getStationTypeOptionNew(Connection cn, String type)
			throws Exception {
		String sql = null;
		String s = null;
		String sql_in_str = null;
		sql_in_str = getStationTypeSqlInStr();
		sql = "select parameter_value,parameter_name from t_cfg_parameter  where parameter_type_id='monitor_type' ";
		if (!f.empty(sql_in_str)) {
			sql = sql + " and parameter_value in (" + sql_in_str + ")";
		}
		// f.sop(sql);

		s = JspUtil.getOption(cn, sql, type);
		return s;
	}

	public static String getStationTypeSqlInStr() throws Exception {
		String station_types = f.cfg("station_types", "");
		if (f.empty(station_types)) {
			return "";
		}
		String[] arr = station_types.split(",");
		int i, num = 0;
		num = arr.length;
		String s1, s2 = "";
		s1 = "";
		num = num - 1;
		for (i = 0; i <= num; i++) {
			s2 = arr[i];

			s1 = s1 + "'" + s2 + "'";
			if (i < num) {
				s1 = s1 + ",";
			}
		}

		return s1;

	}

	public static String getStationTypeOption(String type) throws Exception {
		Connection cn = null;
		try {
			cn = f.getConn();
			return getStationTypeOption(cn, type);
		} catch (Exception e) {
			throw e;
		} finally {
			f.close(cn);
		}
	}

	public static String getStationTypeOption(Connection cn, String type)
			throws Exception {
		if (2 > 1) {
			return getStationTypeOptionNew(cn, type);
		}
		String sql = null;
		String s = null;
		sql = "select parameter_value,parameter_name from t_cfg_parameter  where parameter_type_id='monitor_type' ";
		s = JspUtil.getOption(cn, sql, type);
		System.out.println("s------------------" + s + "type+++" + type);
		return s;
	}

	public static String getStationTypeOption(Connection cn) throws Exception {
		// String sql = null;
		String s = null;
		String type = null;
		// sql =
		// "select parameter_value,parameter_name from t_cfg_parameter  where parameter_type_id='monitor_type' ";
		type = App.get("default_station_type", "5");
		// s = JspUtil.getOption(cn,sql,type);
		s = getStationTypeOption(cn, type);
		return s;
	}

	public static String getValleyOption(Connection cn) throws Exception {

		String sql = "select valley_id,valley_name from t_cfg_valley ";
		sql = sql
				+ "where valley_level='2' or valley_level='3' order by valley_level";
		String valleyOption = JspUtil.getOption(cn, sql, "");

		return valleyOption;

	}

	public static String getValleyOption(Connection cn, String valley_id)
			throws Exception {

		String sql = "select valley_id,valley_name from t_cfg_valley order by valley_id";
		// sql=sql+"where valley_level='2' or valley_level='3' order by valley_level";
		String valleyOption = getOption(cn, sql, valley_id);

		return valleyOption;

	}

	public static String getOption(Connection cn, String sql, String value)
			throws Exception {
		Statement stmt;
		Exception exception;
		if (value == null)
			value = "";
		value = value.trim();
		stmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer(100);
		String err_msg = null;
		String v = null;
		String label = null;
		err_msg = "****************connection is null in Jsp.get_option()**************";
		if (cn == null)
			throw new Exception(err_msg);
		String s;
		try {
			stmt = cn.createStatement();
			for (rs = stmt.executeQuery(sql); rs.next(); sb.append(">")
					.append(label).append("</option>\n")) {
				v = rs.getString(1);
				label = rs.getString(2);
				if (v == null)
					v = "";
				if (label == null)
					label = "";
				v = v.trim();
				label = label.trim();
				if (v.substring(4, 10).equals("000000")) {
					label = "" + label;
				} else if (v.substring(6, 10).equals("0000")) {
					label = "-" + label;
				} else if (v.substring(8, 10).equals("00")) {
					label = "--" + label;
				} else {
					label = "---" + label;
				}
				sb.append("<option value=\"");
				sb.append(v);
				sb.append("\"");
				if (value.equals(v))
					sb.append(" selected");
			}

			s = sb.toString();
		} catch (Exception e) {
			throw new Exception(e + "," + sql);
		} finally {
			DBUtil.close(rs);
		}
		DBUtil.close(rs);
		DBUtil.close(stmt);
		return s;
	}

	public static String getAreaOption(Connection cn, String area_pid,
			String area_id) throws Exception {
		String sql = null;
		String s = "";
		sql = "select area_id,area_name from t_cfg_area where 2>1 ";
		if (!StringUtil.isempty(area_pid)) {
			// sql = sql+" and area_pid='"+area_pid+"'";
			// sql = sql+" and area_pid like '"+area_pid+"%'";
			if (StringUtil.equals(show_all_area, "1")) {

				sql = sql + " and (area_id='" + area_pid
						+ "' or area_pid like '" + area_pid + "%')";
			} else {

				sql = sql + " and ( area_pid='" + area_pid + "' or area_id='"
						+ area_pid + "')";
			}
		}
		sql = sql + " order by area_id";

//		 System.out.println("jspPageUtil--------------------"+sql);
		s = JspUtil.getOption(cn, sql, area_id);
		// s = "<option value='"+area_pid+"'>全部</option>\n"+s;
		return s;

	}

	public static String getAreaOption(Connection cn, String area_id)
			throws Exception {

		String area_pid = App.get("area_id", "3301");
		return getAreaOption(cn, area_pid, area_id);

	}

	// ----------
	public static String getAreaOptionNoAll(Connection cn, String area_pid,
			String area_id) throws Exception {

		String sql = null;
		String s = "";

		sql = "select area_id,area_name from t_cfg_area where 2>1 ";
		if (!StringUtil.isempty(area_pid)) {
			sql = sql + " and area_pid='" + area_pid + "'";
		}
		// System.out.println(sql);
		s = JspUtil.getOption(cn, sql, area_id);
		// s = "<option value='"+area_pid+"'>全部</option>\n"+s;
		// System.out.println("no all");

		return s;

	}

	public static String getAreaOptionNoAll(Connection cn, String area_id)
			throws Exception {

		String area_pid = App.get("area_id", "3301");

		return getAreaOptionNoAll(cn, area_pid, area_id);

	}

	// ---------

	public static String getAreaOption(String area_id) throws Exception {
		Connection cn = null;

		try {
			cn = DBUtil.getConn();

			return getAreaOption(cn, area_id);
		} catch (Exception e) {

			throw e;
		} finally {
			DBUtil.close(cn);
		}

	}

	public static void checkDate(HttpServletRequest req, String date_name)
			throws Exception {

		String msg = "日期格式不正确";
		String msg2 = "日期不能为空";
		String date = null;

		date = req.getParameter(date_name);

		if (StringUtil.isempty(date)) {
			throw new Exception(msg2);
		}
		try {
			java.sql.Date.valueOf(date);
		} catch (Exception e) {

			throw new Exception(msg);
		}

	}

	public static void checkDate(HttpServletRequest req,
			String start_date_name, String end_date_name) throws Exception {

		String start = null;
		String end = null;
		String msg = "日期格式不正确";
		String msg1 = "起始日期不能为空";
		String msg2 = "结束日期不能为空";

		String msg3 = "起始日期格式不正确";
		String msg4 = "结束日期格式不正确";

		try {
			start = req.getParameter(start_date_name);
			end = req.getParameter(end_date_name);
			/*
			 * if(!StringUtil.isempty(start)){
			 * 
			 * java.sql.Date.valueOf(start); }
			 * 
			 * 
			 * if(!StringUtil.isempty(end)){
			 * 
			 * java.sql.Date.valueOf(end); }
			 */
			if (StringUtil.isempty(start)) {

				throw new Exception(msg1);
			}

			if (StringUtil.isempty(end)) {

				throw new Exception(msg2);
			}

			java.sql.Date.valueOf(start);

			java.sql.Date.valueOf(end);

		} catch (Exception e) {

			throw new Exception(msg);
		}

	}

	public static void checkDate(HttpServletRequest req) throws Exception {

		String start = null;
		String end = null;
		String msg = "日期格式不正确";
		String start_date_name = "date1";
		String end_date_name = "date2";
		checkDate(req, start_date_name, end_date_name);

	}

	public static String getDataLoadDiv(int top) {

		String s = "";
		s = "<div id='data_load_div' class='data_load' style='display:none;top:"
				+ top + "px'>\n";
		s = s + "<center>正在加载数据......</center>\n";
		s = s + "</div>\n";
		return s;
	}

	public static String getDataLoadDiv() {

		return getDataLoadDiv(200);
	}

	public static String getInfectantOption(Connection cn, String station_type)
			throws Exception {

		String s = null;
		String sql = "select infectant_id,infectant_name from t_cfg_infectant_base ";
		sql = sql + "where station_type='" + station_type + "'";
		s = JspUtil.getOption(cn, sql, null);
		return s;

	}

	public static String getInfectantColumnOption(Connection cn,
			String station_type) throws Exception {

		String s = null;
		String sql = "select infectant_column,infectant_name from t_cfg_infectant_base ";
		sql = sql + "where station_type='" + station_type
				+ "' and infectant_type='1' order by infectant_order";
		s = JspUtil.getOption(cn, sql, null);
		return s;

	}

	public static String getInfectantOptionByStationId(Connection cn,
			String station_id) throws Exception {

		String s = null;
		String sql = "select a.infectant_id,b.infectant_name from t_cfg_monitor_param a, ";
		sql = sql + "t_cfg_infectant_base b ";
		sql = sql + "where a.infectant_id=b.infectant_id ";
		sql = sql + "and a.station_id='" + station_id + "'";
		s = JspUtil.getOption(cn, sql, null);
		return s;

	}

	public static String getHourOption(int hh) {
		String s = "";
		int i = 0;
		int num = 23;
		for (i = 0; i < num; i++) {
			if (i == hh) {
				s = s + "<option selected>" + i + "</option>\n";
			} else {
				s = s + "<option>" + i + "</option>\n";
			}

		}
		return s;
	}

	public static String getStationTypeOption(String station_type,
			HttpServletRequest req) throws Exception {

		return App.getStationTypeOption(station_type, req);

	}

	public static String getTopAreaOption(Connection cn, String area_id)
			throws Exception {

		String sql = "select area_id,area_name from t_cfg_area where area_pid='33'";
		return JspUtil.getOption(cn, sql, area_id);
	}

	public static void userStationUpdate(HttpServletRequest req)
			throws Exception {

		String station_ids = "";
		String[] arr = null;
		int i = 0;
		int num = 0;
		Map map = null;
		String sql = null;
		String user_id = null;
		String msg = null;
		String t = "t_sys_user_station";
		String cols = "user_id,station_type,station_ids";
		Connection cn = null;
		String station_type = null;

		Map data = new HashMap();

		station_type = req.getParameter("station_type");

		if (StringUtil.isempty(station_type)) {
			msg = "请选择站位类型";
			throw new Exception(msg);
		}

		user_id = req.getParameter("user_id");
		if (StringUtil.isempty(user_id)) {
			msg = "请选择一个用户";
			throw new Exception(msg);
		}
		arr = req.getParameterValues("station_id");
		try {
			cn = DBUtil.getConn();

			if (arr == null) {
				// return;
				sql = "delete from " + t
						+ " where user_id=? and station_type=?";
				DBUtil.update(cn, sql, new Object[] { user_id, station_type });
				return;
			}
			num = arr.length;
			if (num < 1) {
				// return;
				sql = "delete from " + t
						+ " where user_id=? and station_type=?";
				DBUtil.update(cn, sql, new Object[] { user_id, station_type });
				return;
			}

			for (i = 0; i < num; i++) {

				station_ids = station_ids + arr[i] + ",";
			}

			sql = "select user_id from " + t + " where user_id=" + user_id;
			sql = sql + " and station_type='" + station_type + "'";

			map = DBUtil.queryOne(cn, sql, null);
			data.put("user_id", user_id);
			data.put("station_type", station_type);
			data.put("station_ids", station_ids);
			// System.out.println(data);
			if (map == null) {

				DBUtil.insert(cn, t, cols, 0, data);
			} else {

				DBUtil.updateRow(cn, t, cols, 2, data);

			}

			/*
			 * sql = "delete from "+t+" where user_id=? and station_type=?";
			 * DBUtil.update(cn,sql,new Object[]{user_id,station_type});
			 * if(arr==null){return;} num=arr.length; sql =
			 * "insert into t_sys_user_station(user_id,station_type,station_ids) values(?,?,?)"
			 * ; Object[]pp=new Object[3]; pp[0]=user_id; pp[1]=station_type;
			 * for(i=0;i<num;i++){ pp[2]=arr[i]; DBUtil.update(cn,sql,pp); }
			 */

		} catch (Exception e) {

			throw e;
		} finally {

			DBUtil.close(cn);
		}

	}

	public static String getStationIdsByUserId(Connection cn, String user_id)
			throws Exception {
		String station_ids = null;
		Map map = null;

		String sql = "select station_ids from t_sys_user_station where user_id="
				+ user_id;
		map = DBUtil.queryOne(cn, sql, null);
		if (map == null) {
			station_ids = "";
		} else {

			station_ids = (String) map.get("station_ids");
		}

		return station_ids;

	}

	public static String getStationIds(Connection cn, String user_id,
			String station_type) throws Exception {
		String station_ids = "";
		Map map = null;
		List list = null;
		List idList = new ArrayList();
		String id = null;
		String sql = "select station_ids from t_sys_user_station where user_id="
				+ user_id;

		sql = sql + " and station_type='" + station_type + "'";

		map = DBUtil.queryOne(cn, sql, null);
		if (map == null) {
			station_ids = "";
		} else {

			station_ids = (String) map.get("station_ids");
		}
		/*
		 * list = DBUtil.query(cn,sql,null); int i,num=0; num = list.size();
		 * for(i=0;i<num;i++){ map = (Map)list.get(i);
		 * id=(String)map.get("station_ids");
		 * if(StringUtil.isempty(id)){continue;} idList.add(id); } num =
		 * idList.size(); for(i=0;i<num;i++){ if(i>0){
		 * station_ids=station_ids+","; } station_ids=station_ids+idList.get(i);
		 * }
		 */
		return station_ids;

	}

	public static int check(HttpServletRequest req) throws Exception {
		int flag = 0;
		HttpSession s = req.getSession();
		String user_id = null;
		String station_id = null;
		String station_ids = null;
		String msg = null;
		String station_name = null;
		String ctx = JspUtil.getCtx(req);
		String station_type = null;
		String sql = null;
		Connection cn = null;
		Map map = null;

		station_name = JspUtil.getParameter(req, "station_name");
		// station_type=req.getParameter("station_type");
		user_id = (String) s.getAttribute("user_id");
		if (StringUtil.isempty(user_id)) {
			// return -1;
			msg = "未登录系统或超时 ";
			msg = msg
					+ "<a href='/<%=ctx%>/pages/home/login.jsp' target=new>登录</a>";
			throw new Exception(msg);
		}

		station_id = req.getParameter("station_id");
		if (StringUtil.isempty(station_id)) {

			msg = "请选择一个站位";
			throw new Exception(msg);
		}
		sql = "select station_type from t_cfg_station_info where station_id='"
				+ station_id + "'";

		/*
		 * station_ids = (String)s.getAttribute("station_ids");
		 * if(station_ids==null){ station_ids=""; }
		 */

		try {
			cn = DBUtil.getConn();

			map = DBUtil.queryOne(cn, sql, null);
			if (map == null) {

				station_ids = "";
			} else {
				station_type = (String) map.get("station_type");
				station_ids = getStationIds(cn, user_id, station_type);
			}

			station_ids = "," + station_ids + ",";

			if (station_ids.indexOf(station_id) >= 0) {
				return 1;
			}

		} catch (Exception e) {

			throw e;
		} finally {

			DBUtil.close(cn);
		}

		msg = "你没有站位 [<font color=red>" + station_name + "</font>] 的数据审核权限";
		throw new Exception(msg);

	}

	public static List getStationInfectantList(Connection cn, String station_id)
			throws Exception {

		List list = null;
		String sql = null;

		sql = "select a.infectant_id,b.infectant_name,b.infectant_unit,";
		sql = sql + "a.infectant_column ";
		sql = sql + "from t_cfg_monitor_param a,t_cfg_infectant_base b ";
		sql = sql + " where  a.infectant_id=b.infectant_id ";
		sql = sql + "and a.station_id='" + station_id + "' ";

		list = DBUtil.query(cn, sql, null);

		return list;
	}

	public static String getDataQuerySql(Connection cn,

	Map model) throws Exception {

		String type = null;
		String station_id = null;
		String date1 = null;
		String date2 = null;
		int i = 0;
		int num = 0;
		String sql = null;
		String table = null;
		List list = null;

		String title = "";
		String cols = "";
		Map map = null;

		station_id = (String) model.get("station_id");
		list = getStationInfectantList(cn, station_id);

		num = list.size();

		for (i = 0; i < num; i++) {

			map = (Map) list.get(i);
			if (i > 0) {
				cols = cols + "," + map.get("infectant_column");
			} else {

				cols = cols + map.get("infectant_column");
			}
			title = title + "<td>" + map.get("infectant_name")
					+ map.get("infectant_unit") + "</td>\n";

		}

		model.put("title", title);

		type = (String) model.get("type");

		table = App.getChartTypeTable(type);

		date1 = (String) model.get("date1");
		date2 = (String) model.get("date2");
		date2 = date2 + " 23:59:59";

		sql = "select m_time," + cols + " from " + table + " where ";
		sql = sql + " station_id='" + station_id + "' ";
		sql = sql + " and m_time>='" + date1 + "' ";
		sql = sql + " and m_time<='" + date2 + "' ";

		return sql;
	}

	// get data table

	public static String getDataTable(Connection cn, String sql, Object[] params)
			throws Exception {
		if (cn == null) {
			throw new Exception("connection is null");
		}
		// StringBuffer sb = new StringBuffer();
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ps = cn.prepareStatement(sql);
			DBUtil.setParam(ps, params);
			rs = ps.executeQuery();

			return DBUtil.rs2table(rs, 0, 10000000);
		} catch (Exception e) {

			throw e;
		} finally {

			DBUtil.close(rs, ps, null);
		}

	}

	public static String getDataTable(String sql, Object[] params)
			throws Exception {
		Connection cn = null;
		try {
			cn = DBUtil.getConn();
			return getDataTable(cn, sql, params);
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}

	}

	// ------------
	public static List getStationList(Connection cn, String station_type,
			String area_id, String valley_id, HttpServletRequest req)
			throws Exception {
		List list = null;

		String sql = null;
		sql = "select station_id,station_desc from "
				+ " t_cfg_station_info where station_type='" + station_type
				+ "' "

		;

		sql = sql
				+ DataAclUtil.getStationIdInString(req, station_type,
						"station_id");

		if (!StringUtil.isempty(area_id)) {
			sql = sql + " and area_id like '" + area_id + "%' ";
		}

		if (!StringUtil.isempty(valley_id)) {
			sql = sql + " and valley_id like '" + valley_id + "%' ";
		}
		sql = sql + " order by area_id,station_desc";
		list = DBUtil.query(cn, sql, null);

		return list;

	}

	// -----------------
	public static List getStationList(Connection cn, String station_type,
			String area_id, String valley_id, String station_desc,
			HttpServletRequest req) throws Exception {
		List list = null;

		String sql = null;
		sql = "select station_id,station_desc from "
				+ " t_cfg_station_info where station_type='" + station_type
				+ "' "

		;

		sql = sql
				+ DataAclUtil.getStationIdInString(req, station_type,
						"station_id");

		if (!StringUtil.isempty(area_id)) {
			sql = sql + " and area_id like '" + area_id + "%' ";
		}

		if (!StringUtil.isempty(valley_id)) {
			sql = sql + " and valley_id like '" + valley_id + "%' ";
		}
		if (!StringUtil.isempty(station_desc)) {
			sql = sql + " and station_desc like '%" + station_desc + "%' ";
		}

		sql = sql + " order by area_id,station_desc";
		list = DBUtil.query(cn, sql, null);

		return list;

	}

	public static List getStationList(Connection cn, Map params,
			HttpServletRequest req) throws Exception {
		List list = null;
		String sql = getStationQuerySql(params, req);

		list = DBUtil.query(cn, sql, null);

		return list;

	}

	public static List getStationList2(Connection cn, Map params,
			HttpServletRequest req) throws Exception {
		List list = null;
		String sql = getStationQuerySql2(params, req);

		list = DBUtil.query(cn, sql, null);

		return list;

	}

	public static String getStationQuerySql(Map params, HttpServletRequest req)
			throws Exception {
		List list = null;
		if (params == null) {
			f.error("params is null");
		}

		String sql = null;
		String station_type, area_id, valley_id, station_desc, cols, order_cols, station_ids, build_type = null;
		XBean b = new XBean(params);
		String ctl_type = null;
		String trade_id = null;

		station_type = b.get("station_type");
		area_id = b.get("area_id");
		if (StringUtil.isempty(area_id)) {
			area_id = f.getDefaultAreaId();
		}
		valley_id = b.get("valley_id");
		trade_id = b.get("trade_id");
		station_desc = b.get("station_desc");
		cols = b.get("cols");
		order_cols = b.get("order_cols");
		ctl_type = b.get("ctl_type");
		station_ids = b.get("station_ids");
		build_type = b.get("build_type");
		String sp = null;
		if (b.get("sp") != null) {
			sp = b.get("sp");
		}

		if (f.empty(cols)) {
			f.error("cols is empty");
		}

		// sql = "select "+cols+" from "+
		// "( select s.*,y.comments from t_cfg_station_info s left OUTER JOIN (select t3.* from (select "+
		// "max(t1.write_time) write_time,t1.station_id from t_yw_record t1  where t1.yw_role<4 "+
		// "group by t1.station_id) t2,t_yw_record  t3 where t2.station_id=t3.station_id and t2.write_time=t3.write_time) y "+
		// "on s.station_id=y.station_id) s where 2>1";
		sql = "select " + cols + " from "
				+ "t_cfg_station_info s where 2>1 and show_flag !='1'";// 黄宝修改
		if (!sp.equals("yes")) {
			sql = sql + "and qy_state!='1'";
		}

		if (!StringUtil.isempty(station_type)) {
			sql = sql + " and s.station_type = '" + station_type + "' ";
		}

		if (!StringUtil.isempty(area_id)) {
			sql = sql + " and s.area_id like '" + area_id + "%' ";
		}

		if (!StringUtil.isempty(valley_id)) {
			sql = sql + " and s.valley_id like '" + valley_id + "%' ";
		}

		if (!StringUtil.isempty(trade_id)) {
			sql = sql + " and s.trade_id like '" + trade_id + "%' ";
		}

		if (!StringUtil.isempty(station_desc)) {
			sql = sql + " and s.station_desc like '%" + station_desc + "%' ";
		}

		if (!StringUtil.isempty(build_type)) {
			sql = sql + " and s.build_flag='" + build_type + "' ";
		}

		/*
		 * if(!StringUtil.isempty(ctl_type)){//选择 重点源属性（市控、国控
		 * ）时，查询实时数据不起作用。原因出在这里 if(ctl_type.equals("0")){
		 * sql=sql+" and s.ctl_type ='"+ctl_type+"' "; }else{
		 * sql=sql+" and s.ctl_type >='"+ctl_type+"' "; } }
		 */

		if (!StringUtil.isempty(ctl_type)) {// 选择 重点源属性（市控、国控
											// ）时，查询实时数据不起作用。原因出在这里
			sql = sql + " and s.ctl_type ='" + ctl_type + "' ";

		}

		if (!StringUtil.isempty(station_ids)) {
			sql = sql + " and s.station_id in ("
					+ station_ids.substring(0, station_ids.length() - 1) + ")";
		}

		sql = sql
				+ DataAclUtil.getStationIdInString(req, station_type,
						"station_id");

		// sql = sql+" order by area_id,station_desc";
		if (!StringUtil.isempty(order_cols)) {
			// sql=sql+" and station_desc like '%"+station_desc+"%' ";
			sql = sql + " order by " + order_cols;

		}
		req.setAttribute("sql", sql);

		return sql;

	}

	public static String getStationQuerySql2(Map params, HttpServletRequest req)
			throws Exception {
		List list = null;
		if (params == null) {
			f.error("params is null");
		}

		String sql = null;
		String station_type, area_id, valley_id, station_desc, cols, order_cols, station_ids, build_type = null;
		XBean b = new XBean(params);
		String ctl_type = null;
		String trade_id = null;

		station_type = b.get("station_type");
		area_id = b.get("area_id");
		valley_id = b.get("valley_id");
		trade_id = b.get("trade_id");
		station_desc = b.get("station_desc");
		cols = b.get("cols");
		order_cols = b.get("order_cols");
		ctl_type = b.get("ctl_type");
		station_ids = b.get("station_ids");
		build_type = b.get("build_type");
		String sp = null;
		if (b.get("sp") != null) {
			sp = b.get("sp");
		}

		if (f.empty(cols)) {
			f.error("cols is empty");
		}

		// sql = "select "+cols+" from "+
		// "( select s.*,y.comments from t_cfg_station_info s left OUTER JOIN (select t3.* from (select "+
		// "max(t1.write_time) write_time,t1.station_id from t_yw_record t1  where t1.yw_role<4 "+
		// "group by t1.station_id) t2,t_yw_record  t3 where t2.station_id=t3.station_id and t2.write_time=t3.write_time) y "+
		// "on s.station_id=y.station_id) s where 2>1";
		sql = "select " + cols + " from "
				+ "t_cfg_station_info s where 2>1 and show_flag !='1'";// 黄宝修改
		if (!sp.equals("yes")) {
			sql = sql + "and qy_state!='1'";
		}

		if (!StringUtil.isempty(station_type)) {
			sql = sql + " and s.station_type = '" + station_type + "' ";
		}

		if (!StringUtil.isempty(area_id)) {

			sql = sql + " and s.area_id like '" + area_id + "%'";

		}

		if (!StringUtil.isempty(valley_id)) {
			sql = sql + " and s.valley_id like '" + valley_id + "%' ";
		}

		if (!StringUtil.isempty(trade_id)) {
			sql = sql + " and s.trade_id like '" + trade_id + "%' ";
		}

		if (!StringUtil.isempty(station_desc)) {
			sql = sql + " and s.station_desc like '%" + station_desc + "%' ";
		}

		if (!StringUtil.isempty(build_type)) {
			sql = sql + " and s.build_flag='" + build_type + "' ";
		}

		/*
		 * if(!StringUtil.isempty(ctl_type)){//选择 重点源属性（市控、国控
		 * ）时，查询实时数据不起作用。原因出在这里 if(ctl_type.equals("0")){
		 * sql=sql+" and s.ctl_type ='"+ctl_type+"' "; }else{
		 * sql=sql+" and s.ctl_type >='"+ctl_type+"' "; } }
		 */

		if (!StringUtil.isempty(ctl_type)) {// 选择 重点源属性（市控、国控
											// ）时，查询实时数据不起作用。原因出在这里
			sql = sql + " and s.ctl_type ='" + ctl_type + "' ";

		}

		if (!StringUtil.isempty(station_ids)) {
			sql = sql + " and s.station_id in ("
					+ station_ids.substring(0, station_ids.length() - 1) + ")";
		}

		sql = sql
				+ DataAclUtil.getStationIdInString(req, station_type,
						"station_id");

		// sql = sql+" order by area_id,station_desc";
		if (!StringUtil.isempty(order_cols)) {
			// sql=sql+" and station_desc like '%"+station_desc+"%' ";
			sql = sql + " order by " + order_cols;

		}
		req.setAttribute("sql", sql);

		return sql;

	}

	public static List getStationList(Map params, HttpServletRequest req)
			throws Exception {
		Connection cn = null;
		try {
			cn = f.getConn();
			return getStationList(cn, params, req);
		} catch (Exception e) {
			throw e;
		} finally {
			f.close(cn);
		}

	}

	public static List getStationList2(Map params, HttpServletRequest req)
			throws Exception {
		Connection cn = null;
		try {
			cn = f.getConn();
			return getStationList2(cn, params, req);
		} catch (Exception e) {
			throw e;
		} finally {
			f.close(cn);
		}

	}

	// ------------
	public static List getStationList(Connection cn, HttpServletRequest request)
			throws Exception {

		String station_type, area_id, valley_id;

		station_type = request.getParameter("station_type");
		if (StringUtil.isempty(station_type)) {
			throw new Exception("请选择监测类别");
		}
		area_id = request.getParameter("area_id");
		valley_id = request.getParameter("valley_id");
		return getStationList(cn, station_type, area_id, valley_id, request);

	}

	// -----------------

	public static Map getMinuteDataReportMap(Connection cn) throws Exception {

		Map map = new HashMap();
		String sql = null;
		List list = null;
		int i = 0;
		int num = 0;
		Map m = null;
		Object obj = null;
		String station_id = null;

		// sql =
		// "select distinct station_id,count(1) as row_num,max(m_time) as m_time  from view_minute_today "

		sql = "select distinct station_id,count(1) as row_num,max(m_time) as m_time  from t_monitor_real_minute  ";

		sql = sql + " where m_time>='" + StringUtil.getNowDate() + "' ";
		// + " group by station_id,infectant_id ";
		sql = sql + " group by station_id,infectant_id order by row_num desc";

		// System.out.println(sql);

		list = DBUtil.query(cn, sql);
		num = list.size();
		for (i = 0; i < num; i++) {
			m = (Map) list.get(i);
			station_id = (String) m.get("station_id");

			// map.put(station_id,m);

			obj = map.get(station_id);
			if (obj == null) {
				map.put(station_id, m);
			}
		}

		return map;
	}

	public static Map getHourDataReportMap(Connection cn) throws Exception {
		Map map = new HashMap();
		String sql = null;
		List list = null;
		int i = 0;
		int num = 0;
		Map m = null;
		Object obj = null;
		String station_id = null;

		// sql =
		// " select station_id,count(1) as row_num,max(m_time) as m_time from view_hour_today  "

		sql = " select station_id,count(1) as row_num,max(m_time) as m_time from t_monitor_real_hour ";

		sql = sql + " where m_time>='" + StringUtil.getNowDate() + "' ";
		sql = sql + " group by station_id ";

		// System.out.println(sql);

		list = DBUtil.query(cn, sql);
		num = list.size();
		for (i = 0; i < num; i++) {
			m = (Map) list.get(i);
			station_id = (String) m.get("station_id");

			map.put(station_id, m);

		}

		return map;
	}

	public static Map getTocDayReportData(Connection cn, String m_time,
			String col) throws Exception {
		Map map = new HashMap();
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		Timestamp ts = null;
		String key = null;
		String v = null;
		String station_id = null;

		sql = "select station_id,m_time," + col
				+ " from t_monitor_real_hour where ";
		sql = sql + " m_time>='" + m_time + "' and m_time<'" + m_time
				+ " 23:59:59'";
		try {
			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				station_id = rs.getString(1);
				ts = rs.getTimestamp(2);

				if (ts == null) {
					continue;
				}
				v = rs.getString(3);
				if (StringUtil.isempty(v)) {
					continue;
				}
				v = App.getValueStr(v);

				key = station_id + "_" + ts.getHours();
				map.put(key, v);

			}

			return map;
		} catch (Exception e) {

			throw e;
		} finally {
			DBUtil.close(rs, stmt, null);
		}

	}

	public static String getErrorMsg(String s) {
		String ss = null;
		if (s == null) {
			return null;
		}
		String start_key = "<exception>";
		String end_key = "</exception>";
		int start_pos = 0;
		int end_pos = 0;

		start_pos = s.indexOf(start_key);
		if (start_pos < 0) {
			return null;
		}

		end_pos = s.indexOf(end_key);
		if (end_pos < 0) {
			return null;
		}

		if (end_pos <= start_pos) {
			return null;
		}
		ss = s.substring(start_pos, end_pos);
		ss = StringUtil.encodeHtml(ss);

		return ss;

	}

	public static String getHttpUrl(String url, HttpServletRequest request)
			throws Exception {
		if (StringUtil.isempty(url)) {
			throw new Exception("url is empty");
		}

		String s = null;
		String url2 = null;

		url2 = url.toLowerCase();
		if (url2.startsWith("http://")) {
			return url;
		}
		if (!url.startsWith("/")) {
			throw new Exception("url must start with http:// or /");

		}

		String ctx = JspUtil.getCtx(request);
		String port = request.getServerPort() + "";

		s = "http://127.0.0.1:" + port + "/" + ctx + url;

		return s;

	}

	public static String encodeUrl(String s) throws Exception {
		if (StringUtil.isempty(s)) {
			return "";
		}
		String ss = null;
		ss = URLEncoder.encode(s);

		return ss;
	}

	public static String decodeUrl(String s) throws Exception {
		if (StringUtil.isempty(s)) {
			return "";
		}
		String ss = null;
		ss = URLDecoder.decode(s);

		return ss;
	}

	public static String getHttpGetParamString(Map map) throws Exception {
		if (map == null) {
			return "";
		}
		List list = StringUtil.getMapKey(map);
		String s = "";
		String k = null;
		String v = null;

		int i, num = 0;
		num = list.size();
		for (i = 0; i < num; i++) {
			k = list.get(i) + "";
			if (StringUtil.isempty(k)) {
				continue;
			}
			v = (String) map.get(k);
			v = encodeUrl(v);
			if (i > 0) {
				s = s + "&";
			}
			s = s + k + "=" + v;
		}

		return s;
	}

	// --

	public static Map getRealDataInfoMap() throws Exception {

		Map map = new HashMap();
		String sql = null;
		Map tmp = null;
		Connection cn = null;
		Map m2 = null;

		try {
			cn = DBUtil.getConn();

			sql = "select station_id,count(1) from view_warn_today group by station_id";
			tmp = DBUtil.getMap(cn, sql);
			map.put("warn", tmp);

			sql = "select station_id,count(1) from view_minute_today group by station_id";
			tmp = DBUtil.getMap(cn, sql);
			map.put("minute", tmp);

			sql = "select station_id,count(1) from view_hour_today group by station_id";
			tmp = DBUtil.getMap(cn, sql);
			map.put("hour", tmp);

			m2 = AreaInfo.getAreaInfos(map);

			map.put("all", m2);

			return map;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}

	}

	public static String getRealDataInfo(Map map, List list) throws Exception {
		String s = "";
		int i, num = 0;
		int warnNum, hourNum, minuteNum = 0;
		int warnCount = 0;
		int hourCount = 0;
		int minuteCount = 0;
		int onNum = 0;
		int offNum = 0;

		Map warn, minute, hour = null;
		String id = null;

		warn = (Map) map.get("warn");
		minute = (Map) map.get("minute");
		hour = (Map) map.get("hour");

		num = list.size();

		for (i = 0; i < num; i++) {
			id = (String) list.get(i);
			if (StringUtil.isempty(id)) {
				continue;
			}

			warnNum = StringUtil.getInt(warn.get(id) + "", 0);
			minuteNum = StringUtil.getInt(minute.get(id) + "", 0);
			hourNum = StringUtil.getInt(hour.get(id) + "", 0);

			if (warnNum > 0 || minuteNum > 0 || hourNum > 0) {
				onNum++;
			} else {
				offNum++;
			}
			warnCount = warnCount + warnNum;
			hourCount = hourCount + hourNum;
			minuteCount = minuteCount + minuteNum;
		}

		s = s + "监测点数 " + num + "<br>\n" + "脱机数 " + offNum + "<br>\n" + "联机数 "
				+ onNum + "<br>\n"
				// + "报警记录数 " + warnCount + "<br>\n"
				+ "实时记录数 " + minuteCount + "<br>\n" + "时均值记录数 " + hourCount
				+ "<br>\n";
		return s;

	}

	public static String getSessionIds(HttpServletRequest req) throws Exception {
		Map map = new HashMap();
		String s = "";
		String id = null;
		HttpSession session = req.getSession();

		HttpSessionContext sessionCtx = session.getSessionContext();

		Enumeration e = sessionCtx.getIds();

		while (e.hasMoreElements()) {
			id = e.nextElement() + "";

			s = s + id + ",";
		}

		return s;

		// return map;

	}

	public static String getAreaIdByPid(Connection cn, String pid)
			throws Exception {
		String sql = null;
		Map map = null;
		String area_id = null;

		sql = "select * from t_cfg_area where area_pid=?";

		map = DBUtil.queryOne(cn, sql, new Object[] { pid });
		if (map == null) {
			area_id = null;
		} else {

			area_id = (String) map.get("area_id");
		}
		if (StringUtil.isempty(area_id)) {
			throw new Exception(pid + "没有下级地区");
		}
		return area_id;
	}

	// for jx

	public static String getDefaultStationType() {

		String station_type = "5";

		return station_type;
	}

	public static void dateCheck(HttpServletRequest req) throws Exception {

		String date1 = null;
		String date2 = null;
		String msg = null;

		date1 = req.getParameter("date1");
		date2 = req.getParameter("date2");

		if (StringUtil.isempty(date1)) {

			msg = "开始日期不能为空";
			throw new Exception(msg);
		}

		if (StringUtil.isempty(date2)) {

			msg = "结束日期不能为空";
			throw new Exception(msg);
		}

		java.sql.Date d1 = null;
		java.sql.Date d2 = null;

		try {
			d1 = java.sql.Date.valueOf(date1);
			d2 = java.sql.Date.valueOf(date2);
		} catch (Exception e) {
			msg = "日期格式不正确";
			throw new Exception(msg);
		}

		if (d1.getTime() > d2.getTime()) {

			msg = "开始日期不能大于结束日期";
			throw new Exception(msg);
		}

	}

	// ----------
	public static String getReportUrl(HttpServletRequest req, int index) {

		String pre = "/" + JspUtil.getCtx(req) + "/pages/jx/";
		String s = "";

		String[] urls = new String[] { "toc_form.jsp", "data/form.jsp",
				// "rpt/01_form.jsp",
				"rpt/02_form.jsp" };

		String[] titles = new String[] { "TOC日报表", "完好率统计",
				// "超标率统计",
				"监测点运行日报表" };

		int i = 0;
		int num = urls.length;

		for (i = 0; i < num; i++) {
			if (i != index) {
				s = s + "<a href=" + pre + urls[i] + ">" + titles[i] + "</a>\n";
			} else {

				s = s + "<b>" + titles[i] + "</b>\n";
			}
		}

		return s;

	}

	public static String getHideHtml(HttpServletRequest req) {
		String s = "";

		try {
			Map map = JspUtil.getRequestModel(req);
			List list = StringUtil.getMapKey(map);
			String key = null;
			String v = null;
			int i, num = 0;

			num = list.size();
			for (i = 0; i < num; i++) {

				key = (String) list.get(i);
				v = (String) map.get(key);
				if (v == null) {
					v = "";
				}
				v = StringUtil.encodeHtml(v);
				s = s + "<input type=hidden name=" + key + " value='" + v
						+ "'>\n";
			}

			return s;
		} catch (Exception e) {
			return "";
		}
	}

	// ------2007-05-07
	public static String getStationOption(Connection cn,
			HttpServletRequest request) throws Exception {
		String s = null;
		String sql = null;
		String area_id = request.getParameter("area_id");
		String station_type = request.getParameter("station_type");
		sql = "select station_id,station_desc from t_cfg_station_info where station_type='"
				+ station_type + "' and area_id like '" + area_id + "%' ";
		sql = sql
				+ DataAclUtil.getStationIdInString(request, station_type,
						"station_id");

		s = JspUtil.getOption(cn, sql, null);

		return s;

	}

	public static String getFactorOption(Connection cn,
			HttpServletRequest request) throws Exception {
		String s = "";
		String sql = null;
		List list = null;
		String station_type = request.getParameter("station_type");
		Map map = null;
		String id, name, col = null;
		int i, num = 0;

		if (StringUtil.isempty(station_type)) {
			throw new Exception("station_type不能为空");
		}

		sql = "select infectant_id,infectant_column,infectant_name from t_cfg_infectant_base "
				+ "where station_type='"
				+ station_type
				+ "' "
				+ " and infectant_type='1' " + " order by infectant_order";

		list = DBUtil.query(cn, sql, null);
		num = list.size();
		for (i = 0; i < num; i++) {
			map = (Map) list.get(i);
			id = (String) map.get("infectant_id");
			col = (String) map.get("infectant_column");
			name = (String) map.get("infectant_name");
			if (StringUtil.isempty(id)) {
				continue;
			}
			if (StringUtil.isempty(col)) {
				continue;
			}
			if (StringUtil.isempty(name)) {
				continue;
			}
			s = s + "<option value='" + id + "," + col + "'>" + name
					+ "</option>\n";

		}

		return s;

	}

	public static List getOffline(HttpServletRequest req) throws Exception {
		Map cacheMap = null;
		List dataList = null;
		Map stationIdMapHasData = new HashMap();
		int i, num = 0;
		Map tmp = null;
		String station_id = null;
		Connection cn = null;
		String sql, station_type, area_id, valley_id = null;
		List list = null;
		List list2 = new ArrayList();

		station_type = req.getParameter("station_type");
		area_id = req.getParameter("area_id");
		valley_id = req.getParameter("valley_id");

		cacheMap = CacheUtil.getRealDataMap();
		// dataList = (List)cache.get(55,null);

		dataList = (List) cacheMap.get("data");
		num = dataList.size();

		for (i = 0; i < num; i++) {
			tmp = (Map) dataList.get(i);

			station_id = (String) tmp.get("station_id");

			if (StringUtil.isempty(station_id)) {
				continue;
			}

			stationIdMapHasData.put(station_id, "0");

		}

		sql = "select station_id,station_desc,station_bz from t_cfg_station_info ";
		sql = sql + " where station_type='" + station_type + "' ";
		if (!StringUtil.isempty(area_id)) {

			sql = sql + " and area_id like '" + area_id + "%' ";
		}
		if (!StringUtil.isempty(valley_id)) {

			sql = sql + " and valley_id like '" + valley_id + "%' ";
		}

		sql = sql + " order by area_id,station_desc ";

		try {

			cn = DBUtil.getConn();
			list = DBUtil.query(cn, sql, null);

			num = list.size();

			for (i = 0; i < num; i++) {

				tmp = (Map) list.get(i);
				station_id = (String) tmp.get("station_id");
				if (stationIdMapHasData.get(station_id) == null) {
					list2.add(tmp);
				}
			}

			return list2;

		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}

	}

	public static String getSpTypeOption(Connection cn, String sp_type)
			throws Exception {
		String sql = null;
		sql = "select parameter_value,parameter_name from t_cfg_parameter where parameter_type_id='sp_type'";
		return JspUtil.getOption(cn, sql, sp_type);

	}

	// 20080317
	public static void saveEvent(String station_id, String station_bz)
			throws Exception {
		if (f.empty(station_bz)) {
			return;
		}
		if (f.empty(station_id)) {
			return;
		}
		Connection cn = null;
		String sql = null;
		Object[] p = new Object[3];
		try {
			sql = "insert into t_monitor_event(event_id,station_id,happen_time,remark) values('1',?,?,?)";
			p[0] = station_id;
			p[1] = f.time();
			p[2] = station_bz;
			cn = f.getConn();
			f.update(cn, sql, p);

		} catch (Exception e) {
			throw e;
		} finally {
			f.close(cn);
		}

	}

}// end class