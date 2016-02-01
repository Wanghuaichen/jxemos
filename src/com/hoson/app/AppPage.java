package com.hoson.app;

import java.sql.*;
import java.util.*;

import com.hoson.*;
import com.hoson.util.*;

import javax.servlet.http.*;

public class AppPage {

	static String value_zero_string = get_zero_string();

	static String value_null_string = App.get("value_null_string", "");

	private AppPage() {
	}
	/*!
	 * 获得配置文件的value_zero_string值
	 */
	static String get_zero_string() {
		String s = App.get("value_zero_string", "");
		try {
			s = StringUtil.iso2gbk(s);
		} catch (Exception e) {
			s = "";
		}
		return s;
	}
	/*!
	 * 获得配置文件的value_zero_string值
	 */
	public static String getValueZeroString(String v) {

		if (StringUtil.isempty(v)) {
			return value_null_string;
		}

		if (StringUtil.getDouble(v, -1) == 0) {
			return value_zero_string;
		}
		return v;
	}
	/*!
	 * 根据站位编号列表和map值返回list
	 */
	public static List getStationIdListHaveData(List idList, Map map) {
		List list = new ArrayList();
		int i, num = 0;
		num = idList.size();
		String id = null;
		String v = null;

		for (i = 0; i < num; i++) {

			id = (String) idList.get(i);
			v = (String) map.get(id);
			if (v != null) {
				list.add(id);
			}
		}
		return list;
	}
	/*!
	 * 根据request值获得列和标题
	 */
	public static String[] get_col_and_title(HttpServletRequest req)
			throws Exception {
		String[] arr = new String[2];
		List colList = new ArrayList();
		List nameList = new ArrayList();
		List unitList = new ArrayList();

		Connection cn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String col = null;
		String name = null;
		String unit = null;

		String sql = null;
		String station_type = req.getParameter("station_type");

		sql = "select infectant_column,infectant_name,infectant_unit from t_cfg_infectant_base ";
		sql = sql + "where station_type='" + station_type + "' and ";
		sql = sql+ "(infectant_type='1' or infectant_type='2') order by infectant_order ";
		try {
			cn = DBUtil.getConn(req);
			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				col = rs.getString(1);
				name = rs.getString(2);
				unit = rs.getString(3);
				if (name == null) {
					name = "";
				}
				if (unit == null) {
					unit = "";
				}
				if (!StringUtil.isempty(col)) {
					colList.add(col);
					nameList.add(name);
					unitList.add(unit);
				}
			}
			String cols = "";
			String title = "";
			int i = 0;
			int num = 0;
			int flag = 0;

			num = colList.size();
			flag = num - 1;
			for (i = 0; i < num; i++) {
				if (i < flag) {
					cols = cols + "a." + colList.get(i) + ",";
				} else {
					cols = cols + "a." + colList.get(i);
				}
				title = title + "<td>" + nameList.get(i) + "<br>"
						+ unitList.get(i) + "</td>\n";
			}
			arr[0] = cols;
			arr[1] = title;
			return arr;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs, stmt, cn);
		}
	}

	public static String get_fx_data_query_sql(String cols,
			HttpServletRequest req) throws Exception {

		String data_type = null;
		String area_id = null;

		String t = null;
		String sql = null;
		String date1 = null;
		String date2 = null;
		String date3 = null;

		String station_name = null;
		String valley_id = null;
		String station_type = null;
		String station_id = req.getParameter("station_id");
		station_name = JspUtil.getParameter(req, "station_name");
		station_type = req.getParameter("station_type");
		data_type = req.getParameter("data_type");
		area_id = req.getParameter("area_id");
		valley_id = req.getParameter("valley_id");
		date1 = req.getParameter("date1");
		date2 = req.getParameter("date2");
		if (StringUtil.isempty(date2)) {
			date3 = null;
		} else {
			date3 = StringUtil.getNextDay(java.sql.Date.valueOf(date2)) + "";
		}
		t = App.getChartTypeTable(data_type);
		sql = "select b.station_desc as station_name,a.m_time,";
		sql = sql + cols;
		sql = sql + " from " + t + " a,";
		sql = sql + "t_cfg_station_info b ";
		sql = sql + " where a.station_id=b.station_id and b.station_type='"
				+ station_type + "'  ";
		sql = sql+ DataAclUtil.getStationIdInString(req, station_type,"a.station_id");
		if (!StringUtil.isempty(station_id)) {
			sql = sql + " and a.station_id='" + station_id + "' ";
		}
		sql = sql + " and m_time>='" + date1 + "' and ";
		if (!StringUtil.isempty(date3)) {
			sql = sql + " m_time<'" + date3 + "' ";
		}
		if (!StringUtil.isempty(station_name)) {
			sql = sql + " and b.station_desc like '%" + station_name + "%' ";
		}
		Connection cn = null;
		try {
			cn = DBUtil.getConn(req);
			if (!StringUtil.isempty(area_id)) {
				sql = sql + " and a.station_id in(";
				sql = sql + "select station_id from t_cfg_station_info where ";
				sql = sql + "area_id like '" + area_id + "%') ";
			}
			if (!StringUtil.isempty(valley_id)) {
				sql = sql + " and a.station_id in(";
				sql = sql + "select station_id from t_cfg_station_info where ";
				sql = sql + "valley_id like '" + valley_id + "%') ";
			}
			sql = sql + " order by a.m_time";
			return sql;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
	}

	// ----------
	public static String get_fx_data_query_sql(List infectantList,
			HttpServletRequest req) throws Exception {

		String data_type = null;
		String area_id = null;

		String t = null;
		String sql = null;
		String date1 = null;
		String date2 = null;
		String date3 = null;

		String station_name = null;
		String valley_id = null;
		String station_type = null;
		String station_id = req.getParameter("station_id");
		int i, num = 0;
		String cols = "";
		String col = null;
		Map m = null;

		num = infectantList.size();
		if (num < 1) {
			throw new Exception("请配置监测指标");
		}

		for (i = 0; i < num; i++) {
			m = (Map) infectantList.get(i);
			col = (String) m.get("infectant_column");
			if (f.empty(col)) {
				continue;
			}
			cols = cols + ",a." + col;

		}
		station_name = JspUtil.getParameter(req, "station_name");
		station_type = req.getParameter("station_type");

		data_type = req.getParameter("data_type");
		area_id = req.getParameter("area_id");
		valley_id = req.getParameter("valley_id");
		date1 = req.getParameter("date1");
		date2 = req.getParameter("date2");

		if (StringUtil.isempty(date2)) {
			date3 = null;
		} else {
			date3 = StringUtil.getNextDay(java.sql.Date.valueOf(date2)) + "";
		}
		//t = App.getChartTypeTable(data_type);//黄宝修改十分钟数据
		t = data_type;
		if (req.getParameter("sh_flag").equals("1")) {
			t = t + "_v";
			cols = cols + ",v_flag";
		}
		sql = "select b.station_desc as station_name,a.station_id,a.m_time";
		sql = sql + cols;
		sql = sql + " from " + t + " a,";
		sql = sql + "t_cfg_station_info b ";
		sql = sql + " where a.station_id=b.station_id and b.station_type='"
				+ station_type + "' and b.show_flag !='1'";//黄宝修改

		sql = sql+ DataAclUtil.getStationIdInString(req, station_type,"a.station_id");
		if (!StringUtil.isempty(station_id)) {

			sql = sql + " and a.station_id='" + station_id + "' ";
		}
		sql = sql + " and m_time>='" + date1 + "' and ";
		if (!StringUtil.isempty(date3)) {
			sql = sql + " m_time<'" + date3 + "' ";
		}
		if (!StringUtil.isempty(station_name)) {
			sql = sql + " and b.station_desc like '%" + station_name + "%' ";
		}
		Connection cn = null;
		try {
			cn = DBUtil.getConn(req);
			if (!StringUtil.isempty(area_id)) {
				sql = sql + " and a.station_id in(";
				sql = sql + "select station_id from t_cfg_station_info where ";
				sql = sql + "area_id like '" + area_id + "%') ";

			}

			if (!StringUtil.isempty(valley_id)) {
				sql = sql + " and a.station_id in(";
				sql = sql + "select station_id from t_cfg_station_info where ";

				sql = sql + "valley_id like '" + valley_id + "%') ";
			}
			sql = sql + " order by a.station_id,a.m_time desc";
			return sql;

		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
	}

	public static String get_check_all_sql(String cols, HttpServletRequest req)
			throws Exception {

		// String data_type = null;
		String area_id = null;

		String t = null;
		String sql = null;
		String date1 = null;
		String date2 = null;
		String date3 = null;
		String station_name = null;
		String valley_id = null;
		List areaIdList = null;
		List valleyIdList = null;
		String areaIds = null;
		String valleyIds = null;
		String station_type = null;
		int check_flag = StringUtil.getInt(req.getParameter("check_flag"), 0);

		station_name = JspUtil.getParameter(req, "station_name");
		station_type = req.getParameter("station_type");

		// data_type = req.getParameter("data_type");
		area_id = req.getParameter("area_id");
		valley_id = req.getParameter("valley_id");
		date1 = req.getParameter("date1");
		date2 = req.getParameter("date2");
		date3 = StringUtil.getNextDay(java.sql.Date.valueOf(date2)) + "";

		// t = App.getChartTypeTable(data_type);
		t = "t_monitor_real_hour";

		sql = "select a.station_id as pk1,a.m_time as pk2,b.station_desc as station_name,a.m_time,";
		// sql=sql+"a.val01,a.val02,a.val03,a.val04,a.val05,a.val06,a.val07,a.val08,a.val09,a.val10
		// ";
		sql = sql + cols;
		sql = sql + " from " + t + " a,";
		sql = sql + "t_cfg_station_info b ";
		sql = sql + " where a.check_flag='" + check_flag
				+ "' and  a.station_id=b.station_id and b.station_type='"
				+ station_type + "' and ";
		sql = sql + "m_time>='" + date1 + "' and ";
		// sql=sql+" m_time<='"+date2+"' ";
		sql = sql + " m_time<'" + date3 + "' ";
		if (!StringUtil.isempty(station_name)) {
			sql = sql + " and b.station_desc like '%" + station_name + "%' ";
		}

		Connection cn = null;
		try {

			cn = DBUtil.getConn(req);

			if (!StringUtil.isempty(area_id)) {
				areaIdList = App.getSiteIdList(cn, area_id);
				areaIds = StringUtil.list2str(areaIdList, "','");
				areaIds = "'" + areaIds + "'";
				sql = sql + " and a.station_id in(";
				sql = sql + "select station_id from t_cfg_station_info where ";
				sql = sql + "area_id in(" + areaIds + ")) ";
			}

			if (!StringUtil.isempty(valley_id)) {
				valleyIdList = App.getValleyIdList(cn, valley_id);
				valleyIds = StringUtil.list2str(valleyIdList, "','");
				valleyIds = "'" + valleyIds + "'";
				sql = sql + " and a.station_id in(";
				sql = sql + "select station_id from t_cfg_station_info where ";
				sql = sql + "valley_id in(" + valleyIds + ")) ";
			}
			// System.out.println(sql);
			return sql;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}

	}

	// ------------

	public static Map getInfectantIdAndTitle(Connection cn, String station_type)
			throws Exception {
		Map map = new HashMap();
		List idList = new ArrayList();
		List titleList = new ArrayList();
		List colList = new ArrayList();
		String sql = null;
		String id = null;
		String name = null;
		String unit = null;
		String title = null;
		Statement stmt = null;
		ResultSet rs = null;
		String column = null;
		int num = 0;

		sql = "select infectant_id,infectant_name,infectant_unit,infectant_column ";
		sql = sql + "from t_cfg_infectant_base ";
		sql = sql + "where ";
		sql = sql + "station_type='" + station_type + "' ";
		sql = sql + "and ( infectant_type='1' ";
		sql = sql + "or infectant_type='2') order by infectant_order";

		try {
			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				id = rs.getString(1);
				name = rs.getString(2);
				unit = rs.getString(3);
				column = rs.getString(4);
				if (StringUtil.isempty(column)) {
					throw new Exception(
							"infectant_column isempty for infectant,infectant_id="
									+ id);
				}
				column = column.toLowerCase();
				if (name == null) {
					name = "";
				}
				if (unit == null) {
					unit = "";
				}
				if (unit == null) {
					unit = "";
				}
				title = name + "<br>" + unit;
				idList.add(id);
				titleList.add(title);
				colList.add(column);
			}

			num = idList.size();
			if (num < 1) {

				throw new Exception("请配置监测指标");
			}

			map.put("id", idList);
			map.put("title", titleList);
			map.put("column", colList);
			// System.out.println(idList.size()+sql);
			return map;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs, stmt, null);
		}
	}

	public static Map getInfectantIdAndTitle(Connection cn, String station_id,
			String flag) throws Exception {
		Map map = new HashMap();
		List idList = new ArrayList();
		List titleList = new ArrayList();
		List colList = new ArrayList();
		String sql = null;
		String id = null;
		String name = null;
		String unit = null;
		String title = null;
		Statement stmt = null;
		ResultSet rs = null;
		String column = null;
		int num = 0;

		sql = "select infectant_id,infectant_name,infectant_unit,infectant_column ";
		sql = sql + "from t_cfg_infectant_base ";
		sql = sql + "where 2>1 ";
		// sql=sql+" and station_type='"+station_type+"' ";
		sql = sql + "and ( infectant_type='1' ";
		sql = sql + "or infectant_type='2') ";

		sql = sql
				+ " and infectant_id in ( select infectant_id from t_cfg_monitor_param where station_id='"
				+ station_id + "') ";

		sql = sql + " order by infectant_order";

		try {
			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				id = rs.getString(1);
				name = rs.getString(2);
				unit = rs.getString(3);
				column = rs.getString(4);
				if (StringUtil.isempty(column)) {
					throw new Exception(
							"infectant_column isempty for infectant,infectant_id="
									+ id);
				}
				column = column.toLowerCase();
				if (name == null) {
					name = "";
				}
				if (unit == null) {
					unit = "";
				}
				if (unit == null) {
					unit = "";
				}
				title = name + "<br>" + unit;
				idList.add(id);
				titleList.add(title);
				colList.add(column);
			}

			num = idList.size();
			if (num < 1) {

				throw new Exception("请配置监测指标");
			}

			map.put("id", idList);
			map.put("title", titleList);
			map.put("column", colList);
			// System.out.println(idList.size()+sql);
			return map;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs, stmt, null);
		}
	}

	public static String getRealData(HttpServletRequest req) throws Exception {
		String s = "";
		Map stationMap = null;
		String sql = null;
		Connection cn = null;
		List stationIdList = null;
		String station_type = null;
		String area_id = null;
		String valley_id = null;
		List stationIdListNoData = new ArrayList();
		List stationIdListHasData = new ArrayList();
		String sqlIn = "";

		int flag = 0;
		int i = 0;
		int j = 0;
		int num = 0;
		int idNum = 0;
		String[] arrCol = null;
		List list = null;
		String col = null;
		Map infectantIdAndTitleMap = null;
		List infectantIdList = null;
		List titleList = null;
		String errMsg = null;
		Map map = null;
		String station_id = null;
		String station_name = null;
		String id = null;
		String infectant_id = null;
		String m_value = null;

		Map valueMap = new HashMap();
		Statement stmt = null;
		ResultSet rs = null;
		String tmpId = null;
		String key = null;
		String nowDate = StringUtil.getNowDate() + "";
		// nowDate="2006-05-05";
		station_type = req.getParameter("station_type");
		valley_id = req.getParameter("valley_id");
		area_id = req.getParameter("area_id");

		// nowDate="2006-06-01";
		try {
			cn = DBUtil.getConn();

			infectantIdAndTitleMap = getInfectantIdAndTitle(cn, station_type);

			infectantIdList = (List) infectantIdAndTitleMap.get("id");
			titleList = (List) infectantIdAndTitleMap.get("title");

			idNum = infectantIdList.size();

			// System.out.println(idNum+"--"+StringUtil.getNowTime());
			if (idNum < 1) {
				errMsg = "监测指标为空，请配置监测指标";
				throw new Exception(errMsg);
			}

			sql = "select station_id,station_desc from t_cfg_station_info";
			stationMap = DBUtil.getMap(cn, sql);
			stationIdList = getStationIdListByAreaAndValleyId(cn, station_type,
					area_id, valley_id, req);
			num = stationIdList.size();
			flag = num - 1;
			if (num < 1) {
				sqlIn = "1>2";
			} else {

				for (i = 0; i < num; i++) {
					id = (String) stationIdList.get(i);
					if (i < flag) {
						sqlIn = sqlIn + "'" + id + "',";
					} else {
						sqlIn = sqlIn + "'" + id + "'";
					}

				}

				sqlIn = "station_id in(" + sqlIn + ")";
			}

			// System.out.println(num+"--"+StringUtil.getNowTime());

			sql = "select  a.station_id,a.infectant_id,a.m_value ";
			sql = sql + "from t_monitor_real_minute a,";
			sql = sql
					+ "(select station_id,infectant_id,max(m_time) as  m_time from t_monitor_real_minute ";
			sql = sql + "where m_time>='" + nowDate + "' ";
			// sql=sql+"and station_id in ("+sqlIn+") ";
			sql = sql + "and " + sqlIn + " ";
			// sql=sql+"select station_id from t_cfg_station_info where
			// station_type='"+station_type+"') ";
			sql = sql + "group by station_id,infectant_id ) d ";
			sql = sql + "where a.station_id = d.station_id  ";
			sql = sql + "and a.m_time>='" + nowDate + "' ";
			sql = sql
					+ "and a.infectant_id = d.infectant_id and a.m_time = d.m_time ";

			sql = sql + "order by a.station_id,a.infectant_id ";

			// System.out.println(sql);
			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);

			int ii = 0;

			while (rs.next()) {
				station_id = rs.getString(1);
				infectant_id = rs.getString(2);
				m_value = rs.getString(3);
				/*
				 * if(!StringUtil.equals(tmpId,station_id)){
				 * stationIdListHasData.add(station_id); tmpId=station_id; }
				 */
				if (StringUtil.isempty(station_id)) {
					continue;
				}
				if (StringUtil.isempty(infectant_id)) {
					continue;
				}
				key = station_id + infectant_id;
				valueMap.put(key, m_value);
				ii++;
			}

			// System.out.println(ii+"--"+StringUtil.getNowTime());

			// num = StationIdListHasData.size();

			for (i = 0; i < num; i++) {
				station_id = (String) stationIdList.get(i);

				station_name = (String) stationMap.get(station_id);
				if (station_name == null) {
					station_name = "";
				}

				s = s + "<tr class=tr" + i % 2 + ">\n";
				s = s + "<td>" + station_name + "</td>";

				for (j = 0; j < idNum; j++) {
					infectant_id = (String) infectantIdList.get(j);
					key = station_id + infectant_id;
					m_value = (String) valueMap.get(key);
					if (m_value == null) {
						m_value = "";
					}
					s = s + "<td>" + m_value + "</td>";
				}
				s = s + "</tr>\n";

			}// end for

			String s2 = "";

			// s2 = s2+"<tr class=title><td>站位名称</td>";
			s2 = "";
			num = titleList.size();

			for (i = 0; i < num; i++) {
				s2 = s2 + "<td>" + titleList.get(i) + "</td>";
			}
			s2 = s2 + "</tr>\n";
			s = s2 + s;

			return s;
		} catch (Exception e) {
			throw e;
		} finally {

			DBUtil.close(rs, stmt, cn);
		}

	}

	// --------------

	public static String getRealData2(HttpServletRequest req) throws Exception {
		String s = "";
		Map stationMap = null;
		String sql = null;
		Connection cn = null;
		List stationIdList = null;
		String station_type = null;
		String area_id = null;
		String valley_id = null;
		List stationIdListNoData = new ArrayList();
		List stationIdListHasData = new ArrayList();
		String sqlIn = "";

		int flag = 0;
		int i = 0;
		int j = 0;
		int num = 0;
		int idNum = 0;
		String[] arrCol = null;
		List list = null;
		String col = null;
		Map infectantIdAndTitleMap = null;
		List infectantIdList = null;
		List titleList = null;
		String errMsg = null;
		Map map = null;
		String station_id = null;
		String station_name = null;
		String id = null;
		String infectant_id = null;
		String m_value = null;
		String m_time = null;
		Map valueMap = new HashMap();
		// Statement stmt = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String key = null;
		String show_all_flag = req.getParameter("show_all_flag");

		Timestamp dateNow = StringUtil.getNowTime();

		dateNow = new Timestamp(StringUtil.dateAdd(dateNow, Calendar.HOUR, -1).getTime());

		String dataTr = "";
		String timeTr = "";
		String js = null;
		String real_view = null;

		station_type = req.getParameter("station_type");
		valley_id = req.getParameter("valley_id");
		area_id = req.getParameter("area_id");

		try {
			cn = DBUtil.getConn();

			infectantIdAndTitleMap = getInfectantIdAndTitle(cn, station_type);

			infectantIdList = (List) infectantIdAndTitleMap.get("id");
			titleList = (List) infectantIdAndTitleMap.get("title");

			idNum = infectantIdList.size();

			if (idNum < 1) {
				errMsg = "监测指标为空，请配置监测指标";
				throw new Exception(errMsg);
			}
			sql = "select station_id,station_desc from t_cfg_station_info";
			stationMap = DBUtil.getMap(cn, sql);
			stationIdList = getStationIdListByAreaAndValleyId(cn, station_type,
					area_id, valley_id, req);
			num = stationIdList.size();
			flag = num - 1;
			if (num < 1) {
				sqlIn = "1>2";
			} else {
				for (i = 0; i < num; i++) {
					id = (String) stationIdList.get(i);
					if (i < flag) {
						sqlIn = sqlIn + "'" + id + "',";
					} else {
						sqlIn = sqlIn + "'" + id + "'";
					}

				}
				sqlIn = "station_id in(" + sqlIn + ")";
			}

			Map stationIdMap = new HashMap();

			num = stationIdList.size();
			for (i = 0; i < num; i++) {
				stationIdMap.put((String) stationIdList.get(i), "1");
			}

			sql = "select  station_id,infectant_id,m_value,m_time from v_view_real ";
			sql = sql + "where (station_id,infectant_id,m_time) in ";
			sql = sql
					+ "(select station_id,infectant_id,max(m_time) as  m_time from v_view_real ";
			sql = sql + "group by station_id,infectant_id)";

			stmt = cn.prepareStatement(sql);
			rs = stmt.executeQuery();

			int ii = 0;

			Map stationIdMapHasData = new HashMap();

			while (rs.next()) {
				station_id = rs.getString(1);
				infectant_id = rs.getString(2);
				m_value = rs.getString(3);
				m_time = rs.getString(4);
				if (StringUtil.isempty(station_id)) {
					continue;
				}
				if (StringUtil.isempty(infectant_id)) {
					continue;
				}
				key = station_id + infectant_id;
				valueMap.put(key, m_value + ";" + m_time);
				if (stationIdMap.get(station_id) != null) {
					stationIdMapHasData.put(station_id, "0");
				}
				ii++;
			}

			String[] arrtmp = null;
			String timeAndValue = null;

			stationIdListHasData = StringUtil.getMapKey(stationIdMapHasData);

			if (!StringUtil.equals(show_all_flag, "1")) {
				stationIdList = stationIdListHasData;

			}
			num = stationIdList.size();
			for (i = 0; i < num; i++) {
				station_id = (String) stationIdList.get(i);
				station_name = (String) stationMap.get(station_id);
				if (station_name == null) {
					station_name = "";
				}

				dataTr = "";
				timeTr = "";
				ii = 0;
				for (j = 0; j < idNum; j++) {
					infectant_id = (String) infectantIdList.get(j);
					key = station_id + infectant_id;
					timeAndValue = (String) valueMap.get(key);
					if (timeAndValue == null) {

						m_time = "";
						m_value = "";
					} else {

						arrtmp = timeAndValue.split(";");
						m_value = arrtmp[0];
						m_time = arrtmp[1];
						m_time = getRealTime(m_time);
						ii++;
					}

					dataTr = dataTr + "<td>" + m_value + "</td>\n";
					timeTr = timeTr + "<td>" + m_time + "</td>";
				}
				js = "f_real_view('" + station_id + "')";

				real_view = "<font color=blue style='cursor:hand' onclick=\""
						+ js + "\">查看</font>";
				if (ii < 1) {
					real_view = "";
				}
				dataTr = "<tr class=tr0><td>" + station_name + "</td><td></td>"
						+ dataTr + "<td>" + real_view + "</td></tr>";
				timeTr = "<tr class=tr1><td></td><td>采样时间</td>" + timeTr
						+ "<td>" + "</td></tr>";

				s = s + dataTr + timeTr;
			}

			String s2 = "";

			s2 = "";
			num = titleList.size();

			for (i = 0; i < num; i++) {
				s2 = s2 + "<td>" + titleList.get(i) + "</td>";
			}
			s2 = s2 + "<td style=\"width:30px\"></td></tr>\n";
			s = s2 + s;

			return s;
		} catch (Exception e) {
			throw e;
		} finally {

			DBUtil.close(rs, stmt, cn);
		}

	}

	// --------------

	public static String getRealDataNew(HttpServletRequest req)
			throws Exception {
		String s = "";
		Map stationMap = null;
		Map tmp = null;
		List dataList = null;
		String sql = null;
		Connection cn = null;
		List stationIdList = null;
		String station_type = null;
		String area_id = null;
		String valley_id = null;
		List stationIdListNoData = new ArrayList();
		List stationIdListHasData = new ArrayList();
		String sqlIn = "";
		List currentPageStationIdList = new ArrayList();
		Map infectantInfoMap;
		String show_view_btn = req.getParameter("show_view_btn");

		int flag = 0;
		int i = 0;
		int j = 0;
		int num = 0;
		int idNum = 0;
		String[] arrCol = null;
		List list = null;
		String col = null;
		Map infectantIdAndTitleMap = null;
		List infectantIdList = null;
		List titleList = null;
		String errMsg = null;
		Map map = null;
		String station_id = null;
		String station_name = null;
		String id = null;
		String infectant_id = null;
		String m_value = null;
		String m_time = null;
		Map valueMap = new HashMap();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String tmpId = null;
		String key = null;
		String nowDate = StringUtil.getNowDate() + "";
		String show_all_flag = req.getParameter("show_all_flag");

		String css = "";
		String mm_time = null;
		int ii = 0;
		Map mmm = null;

		int alert_time = JspUtil.getInt(req, "alert_time", 5);

		java.util.Date ddddd = StringUtil.dateAdd(StringUtil.getNowTime(),"minute", -alert_time);
		String alert_time_string = new Timestamp(ddddd.getTime()) + "";
		String m_time_string = null;
		String alert_css = "";
		Map surfaceMap = null;
		String surface = null;
		String bz = null;
		Map bzMap = null;

		Timestamp dateNow = StringUtil.getNowTime();

		dateNow = new Timestamp(StringUtil.dateAdd(dateNow, Calendar.HOUR, -1).getTime());
		String dataTr = "";
		String js = null;
		String real_view = null;
		station_type = req.getParameter("station_type");
		valley_id = req.getParameter("valley_id");
		area_id = req.getParameter("area_id");

		try {
			cn = DBUtil.getConn();

			infectantIdAndTitleMap = getInfectantIdAndTitle(cn, station_type);

			infectantIdList = (List) infectantIdAndTitleMap.get("id");
			titleList = (List) infectantIdAndTitleMap.get("title");

			idNum = infectantIdList.size();

			if (idNum < 1) {
				errMsg = "监测指标为空，请配置监测指标";
				throw new Exception(errMsg);
			}
			sql = "select station_id,station_desc from t_cfg_station_info order by station_desc";
			stationMap = DBUtil.getMap(cn, sql);

			sql = "select station_id,link_surface from t_cfg_station_info";
			surfaceMap = DBUtil.getMap(cn, sql);

			sql = "select station_id,station_bz from t_cfg_station_info";
			bzMap = DBUtil.getMap(cn, sql);
			stationIdList = getStationIdListByAreaAndValleyId(cn, station_type,
					area_id, valley_id, req);
			num = stationIdList.size();
			flag = num - 1;
			if (num < 1) {
				sqlIn = "1>2";
			} else {
				for (i = 0; i < num; i++) {
					id = (String) stationIdList.get(i);
					if (i < flag) {
						sqlIn = sqlIn + "'" + id + "',";
					} else {
						sqlIn = sqlIn + "'" + id + "'";
					}
				}
				sqlIn = "station_id in(" + sqlIn + ")";
			}
			Map stationIdMap = new HashMap();
			num = stationIdList.size();
			for (i = 0; i < num; i++) {
				stationIdMap.put((String) stationIdList.get(i), "1");

			}
			Map stationIdMapHasData = new HashMap();
			Map cacheMap = CacheUtil.getRealDataMap();

			dataList = (List) cacheMap.get("data");
			Map rowNumMap = CacheUtil.getDataReportMap();
			rowNumMap = (Map) rowNumMap.get("minute");
			String rowNum = null;
			num = dataList.size();
			for (i = 0; i < num; i++) {
				tmp = (Map) dataList.get(i);

				station_id = (String) tmp.get("station_id");
				infectant_id = (String) tmp.get("infectant_id");
				m_value = (String) tmp.get("m_value");
				m_time = (String) tmp.get("m_time");

				if (StringUtil.isempty(station_id)) {
					continue;
				}
				if (StringUtil.isempty(infectant_id)) {
					continue;
				}
				key = station_id + infectant_id;
				valueMap.put(key, m_value + ";" + m_time);
				if (stationIdMap.get(station_id) != null) {
					stationIdMapHasData.put(station_id, "0");
				}

			}
			String[] arrtmp = null;
			String timeAndValue = null;

			stationIdListHasData = getStationIdListHaveData(stationIdList,
					stationIdMapHasData);
			if (!StringUtil.equals(show_all_flag, "1")) {
				stationIdList = stationIdListHasData;
			}
			num = stationIdList.size();

			int page = JspUtil.getInt(req, "page", 1);
			int page_size = JspUtil.getInt(req, "page_size", 10);

			if (page < 1) {
				page = 1;
			}
			if (page_size < 5) {
				page_size = 5;
			}

			int page_num = 0;

			int m = 0;

			m = num % page_size;
			if (m == 0) {
				page_num = num / page_size;

			} else {
				page_num = ((num - m) / page_size) + 1;
			}
			int skip = (page - 1) * page_size;
			int irow = 0;

			int station_num = 0;
			int seq = 0;
			station_num = num;

			// ------------------
			skip = 0;
			for (i = skip; i < num; i++) {
				// seq=seq+1;
				/*
				 * irow=irow+1;
				 * 
				 * if(irow>page_size){ break; }
				 */

				station_id = (String) stationIdList.get(i);

				currentPageStationIdList.add(station_id);

			}

			infectantInfoMap = getInfectantInfoMap(cn, currentPageStationIdList);
			// System.out.println(currentPageStationIdList.size());
			// System.out.println(infectantInfoMap);
			// System.out.println(infectantInfoMap +"\n\n\n///////\n");
			irow = 0;

			// paging in client
			skip = 0;
			page_size = 1000;
			//

			for (i = skip; i < num; i++) {
				seq = seq + 1;
				irow = irow + 1;

				if (irow > page_size) {
					break;
				}

				station_id = (String) stationIdList.get(i);
				// station_id = (String)stationIdListHasData.get(i);
				station_name = (String) stationMap.get(station_id);
				surface = (String) surfaceMap.get(station_id);
				bz = (String) bzMap.get(station_id);
				if (surface == null) {
					surface = "";
				}
				if (bz == null) {
					bz = "";
				}
				if (station_name == null) {
					station_name = "";
				}
				// rowNum = (String)rowNumMap.get(station_id);
				mmm = (Map) rowNumMap.get(station_id);
				// System.out.println(rowNumMap);
				rowNum = null;
				if (mmm != null) {
					rowNum = (String) mmm.get("row_num");
				}
				if (rowNum == null) {
					rowNum = "0";
				}
				// s = s+"<tr class=tr"+i%2+">\n";
				// s=s+"<td>"+station_name+"</td>";

				dataTr = "";
				ii = 0;
				mm_time = "";

				for (j = 0; j < idNum; j++) {
					infectant_id = (String) infectantIdList.get(j);
					key = station_id + infectant_id;
					// m_value=(String)valueMap.get(key);
					timeAndValue = (String) valueMap.get(key);
					// if(m_value==null){m_value="";}
					if (timeAndValue == null) {

						m_time = "";
						m_value = "";
					} else {

						arrtmp = timeAndValue.split(";");
						m_value = arrtmp[0];

						m_value = StringUtil.format(m_value, "0.#####");

						m_time = arrtmp[1];
						m_time_string = m_time;
						m_time = getRealTime(m_time);

						if (!StringUtil.isempty(m_time)
								&& StringUtil.isempty(mm_time)) {
							mm_time = m_time;
						}

						ii++;
					}

					m_value = getValueZeroString(m_value);

					css = getCss(station_id, infectant_id, m_value,
							infectantInfoMap);
					// s=s+"<td>"+m_value+"</td>";
					if (StringUtil.isempty(css)) {
						dataTr = dataTr + "<td>" + m_value + "</td>\n";
					} else {
						dataTr = dataTr + "<td class=" + css + ">" + m_value
								+ "</td>\n";

					}
					// timeTr=timeTr+"<td>"+m_time+"</td>";
				}
				// s=s+"</tr>\n";
				js = "f_real_view('" + station_id + "')";
				// System.out.println(mm_time);
				real_view = "<font color=blue style='cursor:hand' onclick=\""
						+ js + "\">查看</font>";

				if (!StringUtil.equals(show_view_btn, "1")) {
					if (ii < 1) {
						real_view = "";
					}
				}

				// System.out.println(alert_time_string+","+m_time_string+","+alert_time_string.compareTo(m_time_string));

				if (StringUtil.isempty(m_time_string)) {

					alert_css = " no_data";
				} else {
					if (alert_time_string.compareTo(m_time_string) < 0) {
						alert_css = "";
					} else {
						alert_css = " no_data";
					}

				}
				// System.out.println(station_name+","+m_time_string+","+alert_css+","+rowNum);
				if (StringUtil.isempty(mm_time)) {
					alert_css = " no_data";
				}

				// dataTr = "<tr class=tr0><td>"+seq+"</td><td
				// class='left"+alert_css+"'
				// >"+station_name+"</td><td>"+rowNum+"</td><td>"+mm_time+"</td>"+dataTr+"<td>"+real_view+"</td></tr>";
				// no row num

				if (StringUtil.equals(station_type, "5")) {

					surface = "<td>" + surface + "</td>";
				} else {

					surface = "";
				}

				dataTr = "<tr class=tr0><td>" + seq + "</td><td class='left"
						+ alert_css + "' >" + station_name + "</td>" + surface
						+ "<td>" + mm_time + "</td>" + dataTr + "<td>" + bz
						+ "</td><td>" + real_view + "</td></tr>";

				s = s + dataTr;

			}
			if(2>1){return s;}

			String s2 = "";

			s2 = "";
			num = titleList.size();

			for (i = 0; i < num; i++) {
				s2 = s2
						+ "<td class=title_sort style='text-align:center' onclick=f_sort("
						+ i + ")>" + titleList.get(i) + "</td>";

			}
			s2 = s2 + "<td>备注</td><td style=\"width:30px\"></td></tr>\n";
			s = s2 + s;

			return s;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs, stmt, cn);
		}

	}

	// --------------
	public static String getRealDataNew_jx(HttpServletRequest req)
			throws Exception {
		String s = "";
		Map stationMap = null;
		Map tmp = null;
		List dataList = null;
		String sql = null;
		Connection cn = null;
		List stationIdList = null;
		String station_type = null;
		String area_id = null;
		String valley_id = null;
		List stationIdListHasData = new ArrayList();
		String sqlIn = "";
		List currentPageStationIdList = new ArrayList();
		Map infectantInfoMap;
		String show_view_btn = req.getParameter("show_view_btn");

		int flag = 0;
		int i = 0;
		int j = 0;
		int num = 0;
		int idNum = 0;
		Map infectantIdAndTitleMap = null;
		List infectantIdList = null;
		List titleList = null;
		String errMsg = null;
		String station_id = null;
		String station_name = null;
		String id = null;
		String infectant_id = null;
		String m_value = null;
		String m_time = null;
		Map valueMap = new HashMap();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String key = null;
		String show_all_flag = req.getParameter("show_all_flag");
		show_all_flag = "1";
		String css = "";
		String mm_time = null;
		int ii = 0;
		Map mmm = null;
		Map bzMap = null;
		String bz = null;

		int alert_time = JspUtil.getInt(req, "alert_time", 5);

		java.util.Date ddddd = StringUtil.dateAdd(StringUtil.getNowTime(),
				"minute", -alert_time);

		String alert_time_string = new Timestamp(ddddd.getTime()) + "";
		String m_time_string = null;
		String alert_css = "";

		Timestamp dateNow = StringUtil.getNowTime();

		dateNow = new Timestamp(StringUtil.dateAdd(dateNow, Calendar.HOUR, -1)
				.getTime());

		String dataTr = "";
		String timeTr = "";
		String js = null;
		String real_view = null;

		station_type = req.getParameter("station_type");
		valley_id = req.getParameter("valley_id");
		area_id = req.getParameter("area_id");

		try {
			cn = DBUtil.getConn();

			infectantIdAndTitleMap = getInfectantIdAndTitle(cn, station_type);

			infectantIdList = (List) infectantIdAndTitleMap.get("id");
			titleList = (List) infectantIdAndTitleMap.get("title");

			idNum = infectantIdList.size();

			if (idNum < 1) {
				errMsg = "监测指标为空，请配置监测指标";
				throw new Exception(errMsg);
			}

			sql = "select station_id,station_desc from t_cfg_station_info order by station_desc";
			stationMap = DBUtil.getMap(cn, sql);

			sql = "select station_id,station_bz from t_cfg_station_info";
			bzMap = DBUtil.getMap(cn, sql);

			stationIdList = getStationIdListByAreaAndValleyId(cn, station_type,
					area_id, valley_id, req);
			num = stationIdList.size();
			flag = num - 1;
			if (num < 1) {
				sqlIn = "1>2";
			} else {

				for (i = 0; i < num; i++) {
					id = (String) stationIdList.get(i);
					if (i < flag) {
						sqlIn = sqlIn + "'" + id + "',";
					} else {
						sqlIn = sqlIn + "'" + id + "'";
					}

				}

				sqlIn = "station_id in(" + sqlIn + ")";
			}

			Map stationIdMap = new HashMap();

			num = stationIdList.size();
			for (i = 0; i < num; i++) {
				stationIdMap.put((String) stationIdList.get(i), "1");

			}
			Map stationIdMapHasData = new HashMap();
			Map cacheMap = CacheUtil.getRealDataMap();
			// dataList = (List)cache.get(55,null);

			dataList = (List) cacheMap.get("data");
			Map rowNumMap = CacheUtil.getDataReportMap();
			rowNumMap = (Map) rowNumMap.get("minute");
			// System.out.println( rowNumMap);
			// System.out.println(1);
			// System.out.println(rowNumMap);

			String rowNum = null;

			num = dataList.size();

			for (i = 0; i < num; i++) {
				tmp = (Map) dataList.get(i);

				station_id = (String) tmp.get("station_id");
				infectant_id = (String) tmp.get("infectant_id");
				m_value = (String) tmp.get("m_value");
				m_time = (String) tmp.get("m_time");

				if (StringUtil.isempty(station_id)) {
					continue;
				}
				if (StringUtil.isempty(infectant_id)) {
					continue;
				}
				key = station_id + infectant_id;
				valueMap.put(key, m_value + ";" + m_time);
				if (stationIdMap.get(station_id) != null) {
					stationIdMapHasData.put(station_id, "0");
				}

			}

			String[] arrtmp = null;
			String timeAndValue = null;

			stationIdListHasData = getStationIdListHaveData(stationIdList,
					stationIdMapHasData);

			if (!StringUtil.equals(show_all_flag, "1")) {
				stationIdList = stationIdListHasData;

			}
			num = stationIdList.size();

			int page = JspUtil.getInt(req, "page", 1);
			int page_size = JspUtil.getInt(req, "page_size", 10);

			if (page < 1) {
				page = 1;
			}
			if (page_size < 5) {
				page_size = 5;
			}

			int page_num = 0;

			int m = 0;

			m = num % page_size;
			if (m == 0) {
				page_num = num / page_size;

			} else {
				page_num = ((num - m) / page_size) + 1;
			}
			int skip = (page - 1) * page_size;
			int irow = 0;

			int station_num = 0;
			int seq = 0;
			station_num = num;

			skip = 0;
			for (i = skip; i < num; i++) {
				station_id = (String) stationIdList.get(i);
				currentPageStationIdList.add(station_id);
			}

			infectantInfoMap = getInfectantInfoMap(cn, currentPageStationIdList);
			irow = 0;

			skip = 0;
			page_size = 1000;

			for (i = skip; i < num; i++) {
				seq = seq + 1;
				irow = irow + 1;

				if (irow > page_size) {
					break;
				}

				station_id = (String) stationIdList.get(i);
				station_name = (String) stationMap.get(station_id);
				if (station_name == null) {
					station_name = "";
				}
				bz = (String) bzMap.get(station_id);
				if (bz == null) {
					bz = "";
				}
				mmm = (Map) rowNumMap.get(station_id);
				rowNum = null;
				if (mmm != null) {
					rowNum = (String) mmm.get("row_num");
				}
				if (rowNum == null) {
					rowNum = "0";
				}

				dataTr = "";
				timeTr = "";
				ii = 0;
				mm_time = "";

				for (j = 0; j < idNum; j++) {
					infectant_id = (String) infectantIdList.get(j);
					key = station_id + infectant_id;
					timeAndValue = (String) valueMap.get(key);

					if (timeAndValue == null) {

						m_time = "";
						m_value = "";
					} else {

						arrtmp = timeAndValue.split(";");
						m_value = arrtmp[0];
						m_value = StringUtil.format(m_value, "0.#####");

						m_time = arrtmp[1];
						m_time_string = m_time;

						if (!StringUtil.isempty(m_time)
								&& StringUtil.isempty(mm_time)) {
							mm_time = m_time;
						}

						ii++;
					}

					m_value = getValueZeroString(m_value);

					css = getCss(station_id, infectant_id, m_value,
							infectantInfoMap);
					if (StringUtil.isempty(css)) {
						dataTr = dataTr + "<td>" + m_value + "</td>\n";
					} else {
						dataTr = dataTr + "<td class=" + css + ">" + m_value
								+ "</td>\n";

					}
				}
				js = "f_real_view('" + station_id + "')";
				real_view = "<font color=blue style='cursor:hand' onclick=\""
						+ js + "\">查看</font>";

				if (!StringUtil.equals(show_view_btn, "1")) {
					if (ii < 1) {
						real_view = "";
					}
				}

				if (StringUtil.isempty(m_time_string)) {

					alert_css = " no_data";
				} else {
					if (alert_time_string.compareTo(m_time_string) < 0) {
						alert_css = "";
					} else {
						alert_css = " no_data";
					}

				}
				if (StringUtil.isempty(mm_time)) {
					alert_css = " no_data";
				}

				dataTr = "<tr class=tr0><td>" + seq + "</td><td class='left"
						+ alert_css + "' >" + station_name + "</td><td>"
						+ rowNum + "</td><td>" + mm_time + "</td>" + dataTr
						+ "<td class=bz>" + bz + "</td>" + "<td>" + real_view
						+ "</td></tr>";
				s = s + dataTr;
			}

			String s2 = "";

			s2 = "";
			num = titleList.size();

			for (i = 0; i < num; i++) {
				s2 = s2
						+ "<td class=title_sort style='text-align:center' onclick=f_sort("
						+ i + ")>" + titleList.get(i) + "</td>";

			}
			s2 = s2 + "<td>备注</td><td style=\"width:30px\"></td></tr>\n";
			s = s2 + s;

			return s;
		} catch (Exception e) {
			throw e;
		} finally {

			DBUtil.close(rs, stmt, cn);
		}

	}

	// --------------

	public static String getRealDataWithUrl(HttpServletRequest req)
			throws Exception {
		String s = "";
		Map stationMap = null;
		String sql = null;
		Connection cn = null;
		List stationIdList = null;
		String station_type = null;
		String area_id = null;
		String valley_id = null;
		String sqlIn = "";

		int flag = 0;
		int i = 0;
		int j = 0;
		int num = 0;
		int idNum = 0;
		Map infectantIdAndTitleMap = null;
		List infectantIdList = null;
		List titleList = null;
		String errMsg = null;
		String station_id = null;
		String station_name = null;
		String id = null;
		String infectant_id = null;
		String m_value = null;
		String m_time = null;
		Map valueMap = new HashMap();
		Statement stmt = null;
		ResultSet rs = null;
		String key = null;
		String nowDate = StringUtil.getNowDate() + "";

		String dataTr = "";
		String timeTr = "";
		String js = null;
		String real_view = null;

		String url = null;

		station_type = req.getParameter("station_type");
		valley_id = req.getParameter("valley_id");
		area_id = req.getParameter("area_id");

		try {
			cn = DBUtil.getConn();

			infectantIdAndTitleMap = getInfectantIdAndTitle(cn, station_type);

			infectantIdList = (List) infectantIdAndTitleMap.get("id");
			titleList = (List) infectantIdAndTitleMap.get("title");

			idNum = infectantIdList.size();

			if (idNum < 1) {
				errMsg = "监测指标为空，请配置监测指标";
				throw new Exception(errMsg);
			}

			sql = "select station_id,station_desc from t_cfg_station_info";
			stationMap = DBUtil.getMap(cn, sql);
			stationIdList = getStationIdListByAreaAndValleyId(cn, station_type,
					area_id, valley_id, req);
			num = stationIdList.size();
			flag = num - 1;
			if (num < 1) {
				sqlIn = "1>2";
			} else {

				for (i = 0; i < num; i++) {
					id = (String) stationIdList.get(i);
					if (i < flag) {
						sqlIn = sqlIn + "'" + id + "',";
					} else {
						sqlIn = sqlIn + "'" + id + "'";
					}

				}

				sqlIn = "station_id in(" + sqlIn + ")";
			}

			sql = "select  a.station_id,a.infectant_id,a.m_value,a.m_time ";
			sql = sql + "from t_monitor_real_minute a,";
			sql = sql
					+ "(select station_id,infectant_id,max(m_time) as  m_time from t_monitor_real_minute ";
			sql = sql + "where m_time>='" + nowDate + "' ";
			sql = sql + "and " + sqlIn + " ";
			sql = sql + "group by station_id,infectant_id ) d ";
			sql = sql + "where a.station_id = d.station_id  ";
			sql = sql + "and a.m_time>='" + nowDate + "' ";
			sql = sql
					+ "and a.infectant_id = d.infectant_id and a.m_time = d.m_time ";

			sql = sql + "order by a.station_id,a.infectant_id ";

			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);

			int ii = 0;

			while (rs.next()) {
				station_id = rs.getString(1);
				infectant_id = rs.getString(2);
				m_value = rs.getString(3);
				m_time = rs.getString(4);
				if (StringUtil.isempty(station_id)) {
					continue;
				}
				if (StringUtil.isempty(infectant_id)) {
					continue;
				}
				key = station_id + infectant_id;
				valueMap.put(key, m_value + ";" + m_time);
				ii++;
			}

			String[] arrtmp = null;
			String timeAndValue = null;

			for (i = 0; i < num; i++) {
				station_id = (String) stationIdList.get(i);

				station_name = (String) stationMap.get(station_id);
				if (station_name == null) {
					station_name = "";
				}

				dataTr = "";
				timeTr = "";
				ii = 0;
				for (j = 0; j < idNum; j++) {
					infectant_id = (String) infectantIdList.get(j);
					key = station_id + infectant_id;
					timeAndValue = (String) valueMap.get(key);
					if (timeAndValue == null) {
						m_time = "";
						m_value = "";
					} else {

						arrtmp = timeAndValue.split(";");
						m_value = arrtmp[0];
						m_time = arrtmp[1];
						m_time = getRealTime(m_time);
						ii++;
					}

					dataTr = dataTr + "<td>" + m_value + "</td>\n";
					timeTr = timeTr + "<td>" + m_time + "</td>";
				}
				js = "f_real_view('" + station_id + "')";

				real_view = "<font color=blue style='cursor:hand' onclick=\""
						+ js + "\">查看</font>";
				if (ii < 1) {
					real_view = "";
				}

				url = "<a href=\"../../site/zw_home.jsp?station_id="
						+ station_id + "\" target=middle>" + station_name
						+ "</a>";


				dataTr = "<tr class=tr0><td>" + url + "</td><td></td>" + dataTr
						+ "<td>" + real_view + "</td></tr>";

				timeTr = "<tr class=tr1><td></td><td>采样时间</td>" + timeTr
						+ "<td>" + "</td></tr>";

				s = s + dataTr + timeTr;
			}
			if(2>1){return s;}

			String s2 = "";

			s2 = "";
			num = titleList.size();

			for (i = 0; i < num; i++) {
				s2 = s2 + "<td>" + titleList.get(i) + "</td>";
			}
			s2 = s2 + "<td style=\"width:30px\"></td></tr>\n";
			s = s2 + s;

			return s;
		} catch (Exception e) {
			throw e;
		} finally {

			DBUtil.close(rs, stmt, cn);
		}

	}

	// --------------

	public static List getStationIdListByAreaAndValleyId(Connection cn,
			String station_type,
			// String date1,String date2,
			String area_id, String valley_id, HttpServletRequest req)
			throws Exception {
		List list = new ArrayList();
		String sql = null;
		Statement stmt = null;
		ResultSet rs = null;

		sql = "select ";
		sql = sql + " station_id ";

		sql = sql + "from ";
		sql = sql + "t_cfg_station_info ";
		sql = sql + "where station_type='" + station_type + "' ";

		sql = sql
				+ DataAclUtil.getStationIdInString(req, station_type,
						"station_id");

		if (!StringUtil.isempty(area_id)) {
			sql = sql + "and area_id like '" + area_id + "%' ";
		}
		if (!StringUtil.isempty(valley_id)) {
			sql = sql + "and valley_id like '" + valley_id + "%' ";
		}
		sql = sql + " order by area_id,station_desc ";
		// System.out.println(sql);
		try {
			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				list.add(rs.getString(1));
			}

			return list;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs, stmt, null);
		}
	}

	public static List getStationIdListByAreaAndValleyId_order_by_no(
			Connection cn, String station_type,
			// String date1,String date2,
			String area_id, String valley_id, HttpServletRequest req)
			throws Exception {
		List list = new ArrayList();
		String sql = null;
		Statement stmt = null;
		ResultSet rs = null;

		sql = "select ";
		sql = sql + " station_id ";

		sql = sql + "from ";
		sql = sql + "t_cfg_station_info ";
		sql = sql + "where station_type='" + station_type + "' ";

		sql = sql
				+ DataAclUtil.getStationIdInString(req, station_type,
						"station_id");

		if (!StringUtil.isempty(area_id)) {
			sql = sql + "and area_id like '" + area_id + "%' ";
		}
		if (!StringUtil.isempty(valley_id)) {
			sql = sql + "and valley_id like '" + valley_id + "%' ";
		}
		sql = sql + " order by station_no,area_id,station_desc ";
		// System.out.println(sql);
		try {
			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				list.add(rs.getString(1));
			}

			return list;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs, stmt, null);
		}
	}

	// ------------------------
	public static String getRealTime(String s) throws Exception {

		if (s == null) {
			return "";
		}

		// if(2>1){return s;}

		int ipos = 0;
		ipos = s.indexOf(" ");
		if (ipos >= 0) {
			s = s.substring(ipos);
		}
		ipos = s.indexOf(".");
		if (ipos >= 0) {
			s = s.substring(0, ipos);
		}
		return s;

	}

	public static Map getInfectantInfoMap(Connection cn, List list)
			throws Exception {

		Map map = new HashMap();
		int i = 0;
		int num = 0;
		String sql = "";
		String instr = "";
		String id = null;
		List list2 = null;
		Map m = null;
		String key = null;

		if (list == null) {
			return map;
		}
		num = list.size();
		if (num < 1) {
			return map;
		}

		sql = "select station_id,infectant_id,lo,hi from "
				+ " t_cfg_monitor_param where station_id in ";

		for (i = 0; i < num; i++) {

			if (i > 0) {

				instr = instr + ",'" + list.get(i) + "'";
			} else {

				instr = instr + "'" + list.get(i) + "'";
			}

		}

		sql = sql + "(" + instr + ")";

		list2 = DBUtil.query(cn, sql, null);
		num = list2.size();
		for (i = 0; i < num; i++) {
			m = (Map) list2.get(i);
			key = m.get("station_id") + "_" + m.get("infectant_id") + "_lo";
			map.put(key, m.get("lo"));

			key = m.get("station_id") + "_" + m.get("infectant_id") + "_hi";
			map.put(key, m.get("hi"));

		}

		return map;

	}

	// 20071123
	public static Map getInfectantInfoMap(Connection cn, String station_type,
			String area_id) throws Exception {

		Map map = new HashMap();
		int i = 0;
		int num = 0;
		String sql = "";
		String instr = "";
		String id = null;
		List list2 = null;
		Map m = null;
		String key = null;

		sql = "select station_id,infectant_id,lo,hi from "
				+ " t_cfg_monitor_param where station_id in ( select station_id ";
		sql = sql + " from t_cfg_station_info where station_type='"
				+ station_type + "' ";
		if (!StringUtil.isempty(area_id)) {

			sql = sql + " and area_id like '" + area_id + "%' ";
		}
		sql = sql + ")";

		list2 = DBUtil.query(cn, sql, null);
		num = list2.size();
		for (i = 0; i < num; i++) {
			m = (Map) list2.get(i);
			key = m.get("station_id") + "_" + m.get("infectant_id") + "_lo";
			map.put(key, m.get("lo"));

			key = m.get("station_id") + "_" + m.get("infectant_id") + "_hi";
			map.put(key, m.get("hi"));

		}

		return map;

	}

	public static String getCss(String station_id, String infectant_id,
			String m_value, Map map) {
		String v = null;
		String lo;
		String hi;
		String key;
		double d_v = 0;
		double d_lo;
		double d_hi;

		if (StringUtil.isempty(m_value)) {
			return "";
		}
		d_v = StringUtil.getDouble(m_value, 0);

		key = station_id + "_" + infectant_id + "_lo";
		lo = (String) map.get(key);
		key = station_id + "_" + infectant_id + "_hi";
		hi = (String) map.get(key);

		d_lo = StringUtil.getDouble(lo, 0);
		d_hi = StringUtil.getDouble(hi, 0);

		if (d_v > d_hi && d_hi > 0) {
			return "alert";
		}
		if (d_v < d_lo && d_lo > 0 && d_v > 0) {
			return "alert";
		}

		return "";

	}

	// ---------
	public static String getRealDataTable(String station_id, String infectant_id)
			throws Exception {
		String sql = null;
		int max_row = 300;
		Statement stmt = null;
		ResultSet rs = null;
		Connection cn = null;
		StringBuffer sb = new StringBuffer();
		String v = null;

		sql = NewChart.getRealSql(station_id, infectant_id);
		sql = sql + " desc";

		try {
			cn = DBUtil.getConn();
			stmt = cn.createStatement();
			stmt.setMaxRows(max_row);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				v = rs.getString(1);
				if (v == null) {
					v = "";
				}

				if (v.endsWith(".0")) {
					v = v.substring(0, v.length() - 2);
				}
				/*
				 * if(StringUtil.getDouble(v,-1)==0){ v = "<=MR"; }
				 */

				sb.append("<tr>\n<td>").append(v);

				v = rs.getString(2);
				if (v == null) {
					v = "";
				}
				// if(v.startsWith(".")){v="0"+v;}
				v = f.rv(v);
				v = StringUtil.format(v, "0.######");

				v = getValueZeroString(v);
				sb.append("</td>\n<td>").append(v);
				sb.append("</td>\n</tr>\n");

			}
		} catch (Exception e) {
			throw e;
		} finally {

			DBUtil.close(rs, stmt, cn);
		}

		return sb.toString();

		// return null;
	}

	public static String getRealDataByDay(HttpServletRequest req)
			throws Exception {
		String s = null;
		String station_id = (String) req.getParameter("station_id");
		String m_time = (String) req.getParameter("m_time");

		String sql = null;
		Map map = null;
		Map m = null;
		List list = null;
		List dataList = new ArrayList();
		Map timeMap = new HashMap();
		int i, j, num = 0;
		Connection cn = null;

		String infectant_id = null;
		String m_time0 = null;
		String station_type = null;
		StringBuffer sb = new StringBuffer();
		String m_value = null;

		sql = "select m_time,infectant_id,m_value from t_monitor_real_minute where station_id='"
				+ station_id
				+ "' and m_time>='"
				+ m_time
				+ "' and m_time<'"
				+ m_time + " 23:59:59' order by m_time desc";
		// System.out.println(sql);
		try {
			cn = DBUtil.getConn();
			list = DBUtil.query(cn, sql);

			num = list.size();

			for (i = 0; i < num; i++) {

				map = (Map) list.get(i);
				m_time = (String) map.get("m_time");
				infectant_id = (String) map.get("infectant_id");

				if (!StringUtil.equals(m_time, m_time0)) {
					m_time0 = m_time;
					m = new HashMap();
					dataList.add(m);
					m.put("m_time", m_time);
					m.put(infectant_id, map.get("m_value"));
				} else {
					m.put(infectant_id, map.get("m_value"));
				}

				// System.out.println(m);

			}
			sql = "select station_type from t_cfg_station_info where station_id='"
					+ station_id + "' ";
			map = DBUtil.queryOne(cn, sql, null);
			if (map == null) {
				// throw new Exception("station_type不能为空");
				throw new Exception("记录不存在 station_id=" + station_id);
			}
			station_type = (String) map.get("station_type");

			map = getInfectantIdAndTitle(cn, station_type);

			List idList = (List) map.get("id");
			List titleList = (List) map.get("title");

			int idNum = 0;
			idNum = idList.size();
			// System.out.println(idNum);
			num = dataList.size();
			for (i = 0; i < num; i++) {
				map = (Map) dataList.get(i);
				sb.append("<tr>\n");

				sb.append("<td>").append(i + 1).append("</td>");
				m_time = (String) map.get("m_time");
				m_time = getRealTime(m_time);

				sb.append("<td>").append(m_time).append("</td>\n");

				for (j = 0; j < idNum; j++) {
					infectant_id = (String) idList.get(j);
					m_value = (String) map.get(infectant_id);
					/*
					 * if(StringUtil.isempty(m_value)){ sb.append("<td></td>\n");
					 * }else{ if(m_value.startsWith(".")){m_value="0"+m_value;}
					 * sb.append("<td>").append(m_value).append("</td>\n"); }
					 */
					if (StringUtil.isempty(m_value)) {
						m_value = "";
					}
					if (m_value.startsWith(".")) {
						m_value = "0" + m_value;
					}
					sb.append("<td>").append(m_value).append("</td>\n");

				}
				sb.append("</tr>\n");
			}
			s = sb + "";
			String s2 = "";
			for (i = 0; i < idNum; i++) {
				s2 = s2 + "<td class=center>" + titleList.get(i) + "</td>\n";

			}
			s = s2 + "</tr>\n" + s;

			return s;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}

	}

	public static String getRealDataNew_zxy(HttpServletRequest req)
			throws Exception {
		String s = "";
		Map stationMap = null;
		Map stationSPMap = null;
		Map tmp = null;
		List dataList = null;
		String sql = null;
		Connection cn = null;
		List stationIdList = null;
		String station_type = null;
		String area_id = null;
		String valley_id = null;
		List stationIdListNoData = new ArrayList();
		List stationIdListHasData = new ArrayList();
		String sqlIn = "";
		List currentPageStationIdList = new ArrayList();
		Map infectantInfoMap;
		String show_view_btn = req.getParameter("show_view_btn");

		int flag = 0;
		int i = 0;
		int j = 0;
		int num = 0;
		int idNum = 0;
		String[] arrCol = null;
		List list = null;
		String col = null;
		Map infectantIdAndTitleMap = null;
		List infectantIdList = null;
		List titleList = null;
		String errMsg = null;
		Map map = null;
		String station_id = null;
		String station_name = null;
		String id = null;
		String infectant_id = null;
		String m_value = null;
		String m_time = null;
		Map valueMap = new HashMap();
		// Statement stmt = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String tmpId = null;
		String key = null;
		String nowDate = StringUtil.getNowDate() + "";
		String show_all_flag = req.getParameter("show_all_flag");
		// System.out.println(show_all_flag);
		// show_all_flag = "1";
		String css = "";
		String mm_time = null;
		int ii = 0;
		Map mmm = null;

		// System.out.println(JspUtil.getRequestModel(req));

		int alert_time = JspUtil.getInt(req, "alert_time", 5);

		java.util.Date ddddd = StringUtil.dateAdd(StringUtil.getNowTime(),
				"minute", -alert_time);

		String alert_time_string = new Timestamp(ddddd.getTime()) + "";
		String m_time_string = null;
		String alert_css = "";

		Timestamp dateNow = StringUtil.getNowTime();

		dateNow = new Timestamp(StringUtil.dateAdd(dateNow, Calendar.HOUR, -1)
				.getTime());

		String dataTr = "";
		String js = null;
		String real_view = null;

		// nowDate="2006-05-05";
		station_type = req.getParameter("station_type");
		valley_id = req.getParameter("valley_id");
		area_id = req.getParameter("area_id");
		String strFDID = "";

		// nowDate="2006-06-01";
		try {
			cn = DBUtil.getConn();

			infectantIdAndTitleMap = getInfectantIdAndTitle(cn, station_type);

			infectantIdList = (List) infectantIdAndTitleMap.get("id");
			titleList = (List) infectantIdAndTitleMap.get("title");

			idNum = infectantIdList.size();

			// System.out.println(idNum+"--"+StringUtil.getNowTime());
			if (idNum < 1) {
				errMsg = "监测指标为空，请配置监测指标";
				throw new Exception(errMsg);
			}

			sql = "select station_id,station_desc "
					+ " from t_cfg_station_info  order by station_desc";
			String strSqlSP = "select a.station_id as station_id,b.sb_id as sp_id "
					+ " from t_cfg_station_info a left join  t_sp_sb_station b "
					+ " on a.station_id = b.station_id order by a.station_desc";
			stationMap = DBUtil.getMap(cn, sql);
			stationSPMap = DBUtil.getMap(cn, strSqlSP);
			stationIdList = getStationIdListByAreaAndValleyId(cn, station_type,
					area_id, valley_id, req);
			num = stationIdList.size();
			flag = num - 1;
			if (num < 1) {
				sqlIn = "1>2";
			} else {

				for (i = 0; i < num; i++) {
					id = (String) stationIdList.get(i);
					if (i < flag) {
						sqlIn = sqlIn + "'" + id + "',";
					} else {
						sqlIn = sqlIn + "'" + id + "'";
					}

				}

				sqlIn = "station_id in(" + sqlIn + ")";
			}

			Map stationIdMap = new HashMap();

			num = stationIdList.size();
			for (i = 0; i < num; i++) {
				stationIdMap.put((String) stationIdList.get(i), "1");

			}
			Map stationIdMapHasData = new HashMap();

			// using cache
			// Cache cache = new RealDataCache();
			// Map cacheMap = (Map)cache.get(55,null);
			Map cacheMap = CacheUtil.getRealDataMap();
			// dataList = (List)cache.get(55,null);

			dataList = (List) cacheMap.get("data");
			Map rowNumMap = CacheUtil.getDataReportMap();
			rowNumMap = (Map) rowNumMap.get("minute");
			// System.out.println( rowNumMap);
			// System.out.println(1);
			// System.out.println(rowNumMap);

			String rowNum = null;

			num = dataList.size();

			for (i = 0; i < num; i++) {
				tmp = (Map) dataList.get(i);

				station_id = (String) tmp.get("station_id");

				infectant_id = (String) tmp.get("infectant_id");
				m_value = (String) tmp.get("m_value");
				m_time = (String) tmp.get("m_time");

				if (StringUtil.isempty(station_id)) {
					continue;
				}
				if (StringUtil.isempty(infectant_id)) {
					continue;
				}
				key = station_id + infectant_id;
				valueMap.put(key, m_value + ";" + m_time);
				if (stationIdMap.get(station_id) != null) {
					stationIdMapHasData.put(station_id, "0");
				}

			}

			// end using cache

			// System.out.println(ii+"--"+StringUtil.getNowTime());

			// num = StationIdListHasData.size();

			String[] arrtmp = null;
			String timeAndValue = null;

			stationIdListHasData = StringUtil.getMapKey(stationIdMapHasData);

			// System.out.println(2222);
			// System.out.println(num);

			if (!StringUtil.equals(show_all_flag, "1")) {
				stationIdList = stationIdListHasData;
				// System.out.println("has data");

			}
			// System.out.println(StringUtil.getNowTime()+",show_all_flag="+show_all_flag);
			num = stationIdList.size();
			// System.out.println(num);

			// --------------paging

			int page = JspUtil.getInt(req, "page", 1);
			int page_size = JspUtil.getInt(req, "page_size", 10);

			if (page < 1) {
				page = 1;
			}
			if (page_size < 5) {
				page_size = 5;
			}

			int page_num = 0;

			int m = 0;

			m = num % page_size;
			if (m == 0) {
				page_num = num / page_size;

			} else {
				page_num = ((num - m) / page_size) + 1;
			}
			int skip = (page - 1) * page_size;
			int irow = 0;

			int station_num = 0;
			int seq = 0;
			station_num = num;

			// ------------------
			skip = 0;
			for (i = skip; i < num; i++) {
				// seq=seq+1;
				/*
				 * irow=irow+1;
				 * 
				 * if(irow>page_size){ break; }
				 */

				station_id = (String) stationIdList.get(i);

				currentPageStationIdList.add(station_id);

			}

			infectantInfoMap = getInfectantInfoMap(cn, currentPageStationIdList);
			// System.out.println(currentPageStationIdList.size());
			// System.out.println(infectantInfoMap);
			// System.out.println(infectantInfoMap +"\n\n\n///////\n");
			irow = 0;

			// paging in client
			skip = 0;
			page_size = 1000;
			//

			for (i = skip; i < num; i++) {
				seq = seq + 1;
				irow = irow + 1;

				if (irow > page_size) {
					break;
				}

				station_id = (String) stationIdList.get(i);
				// station_id = (String)stationIdListHasData.get(i);
				station_name = (String) stationMap.get(station_id);
				strFDID = (String) stationSPMap.get(station_id);

				if (station_name == null) {
					station_name = "";
				}
				// rowNum = (String)rowNumMap.get(station_id);
				mmm = (Map) rowNumMap.get(station_id);
				// System.out.println(rowNumMap);
				rowNum = null;
				if (mmm != null) {
					rowNum = (String) mmm.get("row_num");
				}
				if (rowNum == null) {
					rowNum = "0";
				}
				// s = s+"<tr class=tr"+i%2+">\n";
				// s=s+"<td>"+station_name+"</td>";

				dataTr = "";
				ii = 0;
				mm_time = "";

				for (j = 0; j < idNum; j++) {
					infectant_id = (String) infectantIdList.get(j);
					key = station_id + infectant_id;
					// m_value=(String)valueMap.get(key);
					timeAndValue = (String) valueMap.get(key);
					// if(m_value==null){m_value="";}
					if (timeAndValue == null) {

						m_time = "";
						m_value = "";
					} else {

						arrtmp = timeAndValue.split(";");
						m_value = arrtmp[0];
						if (m_value.startsWith(".")) {
							m_value = "0" + m_value;
						}

						m_time = arrtmp[1];
						m_time_string = m_time;
						m_time = getRealTime(m_time);

						if (!StringUtil.isempty(m_time)
								&& StringUtil.isempty(mm_time)) {
							mm_time = m_time;
						}

						ii++;
					}

					css = getCss(station_id, infectant_id, m_value,
							infectantInfoMap);
					// s=s+"<td>"+m_value+"</td>";
					if (StringUtil.isempty(css)) {
						dataTr = dataTr + "<td>" + m_value + "</td>\n";
					} else {
						dataTr = dataTr + "<td class=" + css + ">" + m_value
								+ "</td>\n";

					}
					// timeTr=timeTr+"<td>"+m_time+"</td>";
				}
				// s=s+"</tr>\n";
				js = "f_real_view('" + station_id + "')";
				// System.out.println(mm_time);
				real_view = "<font color=blue style='cursor:hand' onclick=\""
						+ js + "\">查看</font>";

				if (!StringUtil.equals(show_view_btn, "1")) {
					if (ii < 1) {
						real_view = "";
					}
				}

				// System.out.println(alert_time_string+","+m_time_string+","+alert_time_string.compareTo(m_time_string));

				if (StringUtil.isempty(m_time_string)) {

					alert_css = " no_data";
				} else {
					if (alert_time_string.compareTo(m_time_string) < 0) {
						alert_css = "";
					} else {
						alert_css = " no_data";
					}

				}
				// System.out.println(station_name+","+m_time_string+","+alert_css+","+rowNum);
				if (StringUtil.isempty(mm_time)) {
					alert_css = " no_data";
				}

				/**
				 * modify by:zxyong add url to video
				 */
				if (strFDID.length() > 10) {
					/*
					 * if(strFDID.indexOf(",") != -1) {
					 * 
					 * station_name = "<a style='cursor:hand'
					 * onmouseover='ShowWindow(\""+strFDID+"\",\"ShowVideo.jsp?station_id="+station_id+"\",\"608\",\"408\",this);'>" +
					 * station_name +"</a>"; } else {
					 */
					station_name = "<a style='cursor:hand' onclick='openWindow(\"ShowVideo.jsp?FDID="
							+ strFDID
							+ "&station_id="
							+ station_id
							+ "\",\"608\",\"408\");'>" + station_name + "</a>";
					// }
				}
				/** ********************** */

				dataTr = "<tr class=tr0><td>" + seq + "</td><td class='left"
						+ alert_css + "' >" + station_name + "</td><td>"
						+ rowNum + "</td><td>" + mm_time + "</td>" + dataTr
						+ "<td>" + real_view + "</td></tr>";
				// timeTr = "<tr
				// class=tr1><td></td><td>采样时间</td>"+timeTr+"<td>"+"</td></tr>";

				// s = s +dataTr+timeTr;
				s = s + dataTr;

			}// end for

			// if(2>1){return s;}

			String s2 = "";

			// s2 = s2+"<tr class=title><td>站位名称</td>";
			s2 = "";
			num = titleList.size();

			for (i = 0; i < num; i++) {
				s2 = s2
						+ "<td class=title_sort style='text-align:center' onclick=f_sort("
						+ i + ")>" + titleList.get(i) + "</td>";

			}
			s2 = s2 + "<td style=\"width:30px\"></td></tr>\n";
			s = s2 + s;

			// req.setAttribute("bar",RealData.getPageBar(station_num,req));
			// req.setAttribute("bar",RealData.getPageBar2(station_num,req));
			return s;
		} catch (Exception e) {
			throw e;
		} finally {

			DBUtil.close(rs, stmt, cn);
		}

	}

	public static void getRealData_20070628(HttpServletRequest req)
			throws Exception {
		Map cacheMap = CacheUtil.getRealDataMap();
		List dataList = null;
		List list = null;
		String sql = null;
		Map dataMap = new HashMap();
		Map tmp, row = null;
		int i, num = 0;
		String station_id, infectant_id, m_value, m_time = null;
		Connection cn = null;
		String station_type, area_id, valley_id = null;
		List stationIdList = null;
		Map infectantIdAndTitleMap = null;
		Map infectantInfoMap = null;

		List infectantIdList = null;
		List titleList = null;
		String[] infectantIdArray = null;
		Map stationMap = null;
		int show_all = JspUtil.getInt(req, "show_all_flag", 0);

		station_type = req.getParameter("station_type");
		area_id = req.getParameter("area_id");
		valley_id = req.getParameter("valley_id");

		dataList = (List) cacheMap.get("data");

		num = dataList.size();

		for (i = 0; i < num; i++) {
			tmp = (Map) dataList.get(i);

			station_id = (String) tmp.get("station_id");

			infectant_id = (String) tmp.get("infectant_id");
			m_value = (String) tmp.get("m_value");
			m_time = (String) tmp.get("m_time");

			if (StringUtil.isempty(station_id)) {
				continue;
			}
			if (StringUtil.isempty(infectant_id)) {
				continue;
			}
			if (StringUtil.isempty(m_time)) {
				continue;
			}
			if (StringUtil.isempty(m_value)) {
				continue;
			}
			row = (Map) dataMap.get(station_id);
			if (row == null) {
				row = new HashMap();
				dataMap.put(station_id, row);
			}
			if (row.get("m_time") == null) {
				row.put("m_time", m_time);
			}
			if (row.get(infectant_id) == null) {
				row.put(infectant_id, m_value);
			}

		}// end for i for dataList
		try {
			cn = DBUtil.getConn();

			sql = "select station_id,station_desc,station_bz,link_surface from t_cfg_station_info where station_type='"
					+ station_type + "'";
			list = DBUtil.query(cn, sql, null);
			stationMap = getMap(list, "station_id");

			stationIdList = getStationIdListByAreaAndValleyId(cn, station_type,
					area_id, valley_id, req);

			infectantIdAndTitleMap = getInfectantIdAndTitle(cn, station_type);

			infectantIdList = (List) infectantIdAndTitleMap.get("id");
			titleList = (List) infectantIdAndTitleMap.get("title");
			num = infectantIdList.size();
			infectantIdArray = new String[num];
			for (i = 0; i < num; i++) {

				infectantIdArray[i] = (String) infectantIdList.get(i);
			}

			list = new ArrayList();
			num = stationIdList.size();
			for (i = 0; i < num; i++) {
				station_id = (String) stationIdList.get(i);
				row = (Map) dataMap.get(station_id);
				if (show_all < 1 && row == null) {
					continue;
				}
				if (row == null) {
					row = new HashMap();
				}
				tmp = (Map) stationMap.get(station_id);
				if (tmp == null) {
					tmp = new HashMap();
				}
				row.put("station_name", tmp.get("station_desc"));
				row.put("bz", tmp.get("station_bz"));
				row.put("surface", tmp.get("link_surface"));
				list.add(row);
			}
			infectantInfoMap = getInfectantInfoMap(cn, stationIdList);

		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}

		req.setAttribute("id", infectantIdArray);
		req.setAttribute("title", titleList);
		req.setAttribute("data", list);
		req.setAttribute("info", infectantInfoMap);

	}

	public static Map getMap(List list, String key) {
		Map m = new HashMap();
		if (list == null) {
			return m;
		}
		int i, num = 0;
		Map row = null;
		Object kv = null;
		num = list.size();
		for (i = 0; i < num; i++) {
			row = (Map) list.get(i);
			kv = row.get(key);
			if (kv == null) {
				continue;
			}
			m.put(kv, row);
		}
		return m;
	}

}// end class

