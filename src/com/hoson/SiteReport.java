package com.hoson;

import com.hoson.util.JdbcUtil;
import java.sql.*;
import java.util.*;
import com.hoson.app.*;
import javax.servlet.http.*;

public class SiteReport {

	public static String getTitle(List list) throws Exception {
		if (list == null) {
			return "";
		}
		String cols = "";
		String col = null;
		Map map = null;

		int i = 0;
		int num = 0;
		num = list.size();

		for (i = 0; i < num; i++) {
			map = (Map) list.get(i);
			col = (String) map.get("infectant_name");
			cols = cols + "<td>" + col + "</td>\n";
		}
		return cols;
	}

	public static String getCols(List list) throws Exception {
		if (list == null) {
			return "";
		}
		String cols = "";
		String col = null;
		Map map = null;

		int i = 0;
		int num = 0;
		num = list.size();
		for (i = 0; i < num; i++) {
			map = (Map) list.get(i);
			col = (String) map.get("infectant_column");
			cols = cols + "," + col;
		}
		return cols;
	}

	public static List getStationMonitorParamList(Connection cn,
			String station_id) throws Exception {
		List list = null;
		String sql = null;
		int num = 0;
		sql = "select * from view_monitor_param  where infectant_type='1' and station_id=? order by infectant_order";

		list = DBUtil.query(cn, sql, new Object[] { station_id });
		num = list.size();
		if (num < 1) {
			throw new Exception("请配置报表指标列");
		}
		return list;
	}

	public static String getDayReportData(Connection cn, String station_id,
			String m_time, HttpServletRequest request) throws Exception {
		double[][] data = null;
		String station_name = null;
		String sql = null;
		List list = null;
		List monitorParamList = null;
		int i, j = 0;
		int num, colNum = 0;
		Object[] params = null;
		String v = null;
		Timestamp ts = null;
		Object[] arr = null;
		int hh = 0;
		double dd = 0;
		StringBuffer sb = new StringBuffer();
		Map map = null;
		String title = null;

		monitorParamList = getStationMonitorParamList(cn, station_id);

		map = (Map) monitorParamList.get(0);
		station_name = (String) map.get("station_name");

		title = getTitle(monitorParamList);

		sql = "select m_time" + getCols(monitorParamList)
				+ " from t_monitor_real_hour ";
		sql = sql
				+ " where station_id=? and m_time>=? and m_time<? order by m_time";

		params = new Object[3];
		params[0] = station_id;
		params[1] = m_time;
		params[2] = m_time + " 23:59:59";
		int[] types = JdbcUtil.getJdbcType();
		types[0] = 3;
		list = JdbcUtil.query(cn, sql, params, types);

		num = list.size();

		colNum = monitorParamList.size();
		data = new double[29][colNum];

		for (i = 0; i < num; i++) {
			arr = (Object[]) list.get(i);

			ts = (Timestamp) arr[0];
			hh = ts.getHours();
			for (j = 0; j < colNum; j++) {
				v = (String) arr[j + 1];
				v = App.getValueStr(v);
				data[hh][j] = StringUtil.getDouble(v, 0);
			}
		}
		for (i = 0; i < colNum; i++) {
			data[24][i] = data[0][i];
			data[25][i] = data[0][i];
			for (j = 0; j < 24; j++) {
				if (data[24][i] > data[j][i]) {
					data[24][i] = data[j][i];
				}
				if (data[25][i] < data[j][i]) {
					data[25][i] = data[j][i];
				}
				if (data[j][i] > 0) {
					data[26][i] = data[26][i] + data[j][i];
					data[27][i]++;
				}
			}
		}
		for (i = 0; i < colNum; i++) {
			if (data[27][i] > 0) {
				data[28][i] = data[26][i] / data[27][i];
			}
		}
		for (i = 0; i < 24; i++) {
			sb.append("<tr>\n");
			sb.append("<td>").append(i).append("</td>\n");
			for (j = 0; j < colNum; j++) {
				dd = data[i][j];
				sb.append("<td>");
				sb.append(StringUtil.format(dd + "", "#.##"));
				sb.append("</td>");
			}
			sb.append("</tr>\n");
		}
		sb.append("<tr>\n");
		sb.append("<td>最小值</td>\n");
		for (i = 0; i < colNum; i++) {
			dd = data[24][i];
			sb.append("<td>");
			sb.append(StringUtil.format(dd + "", "#.##"));
			sb.append("</td>\n");
		}
		sb.append("</tr>\n");
		sb.append("<tr>\n");
		sb.append("<td>最大值</td>\n");
		for (i = 0; i < colNum; i++) {
			dd = data[25][i];
			sb.append("<td>");
			sb.append(StringUtil.format(dd + "", "#.##"));
			sb.append("</td>\n");
		}
		sb.append("</tr>\n");

		sb.append("<tr>\n");
		sb.append("<td>平均值</td>\n");
		for (i = 0; i < colNum; i++) {
			dd = data[28][i];
			sb.append("<td>");
			/*
			 * if(dd==0){ sb.append("0"); }else{
			 * 
			 * sb.append(StringUtil.format(dd+"","#.##")); }
			 */
			sb.append(StringUtil.format(dd + "", "#.##"));
			sb.append("</td>\n");
		}
		sb.append("</tr>\n");

		request.setAttribute("station_id", station_id);
		request.setAttribute("station_name", station_name);
		request.setAttribute("title", title);
		request.setAttribute("m_time", m_time);
		return sb.toString();
	}

	public static Map getMonthReportTimeInfo(String m_time) throws Exception {
		Map map = new HashMap();

		Timestamp ts = null;
		int yy = 0;
		int mm = 0;
		java.sql.Date start = null;
		java.sql.Date end = null;
		java.sql.Date next = null;
		java.util.Date tmp = null;

		ts = StringUtil.getTimestamp(m_time);
		yy = ts.getYear();
		mm = ts.getMonth();
		start = new java.sql.Date(yy, mm, 1);
		tmp = StringUtil.dateAdd(start, "month", 1);

		next = new java.sql.Date(tmp.getTime());
		tmp = StringUtil.dateAdd(tmp, "day", -1);
		end = new java.sql.Date(tmp.getTime());

		map.put("start", start);
		map.put("end", end);
		map.put("next", next);
		return map;
	}

	public static Map getYealReportTimeInfo(String m_time) throws Exception {
		Map map = new HashMap();

		Timestamp ts = null;
		int yy = 0;
		int mm = 0;
		java.sql.Date start = null;
		java.sql.Date end = null;
		java.sql.Date next = null;
		java.util.Date tmp = null;

		ts = StringUtil.getTimestamp(m_time);
		yy = ts.getYear();

		start = new java.sql.Date(yy, 0, 1);
		tmp = StringUtil.dateAdd(start, "month", 1);

		next = new java.sql.Date(tmp.getTime());

		tmp = StringUtil.dateAdd(tmp, "day", -1);

		end = new java.sql.Date(tmp.getTime());

		map.put("start", start);
		map.put("end", end);
		map.put("next", next);
		return map;
	}

	public static String getMonthReportData(Connection cn, String station_id,
			String m_time, HttpServletRequest request) throws Exception {

		double[][] data = null;
		String station_name = null;
		String sql = null;
		List list = null;
		List monitorParamList = null;
		int i, j = 0;
		int num, colNum = 0;
		Object[] params = null;
		String v = null;
		Timestamp ts = null;
		Object[] arr = null;
		int date = 0;
		double dd = 0;
		StringBuffer sb = new StringBuffer();
		java.sql.Date start = null;
		java.sql.Date end = null;
		java.sql.Date next = null;
		Map map = null;
		int dayNum = 0;
		String title = null;

		map = getMonthReportTimeInfo(m_time);
		start = (java.sql.Date) map.get("start");
		end = (java.sql.Date) map.get("end");
		next = (java.sql.Date) map.get("next");
		dayNum = end.getDate();

		monitorParamList = getStationMonitorParamList(cn, station_id);

		map = (Map) monitorParamList.get(0);
		station_name = (String) map.get("station_name");

		title = getTitle(monitorParamList);

		sql = "select m_time" + getCols(monitorParamList)
				+ " from t_monitor_real_day ";
		sql = sql
				+ " where station_id=? and m_time>=? and m_time<? order by m_time";

		params = new Object[3];
		params[0] = station_id;
		params[1] = start;
		params[2] = next;
		int[] types = JdbcUtil.getJdbcType();
		types[0] = 3;
		list = JdbcUtil.query(cn, sql, params, types);

		num = list.size();

		colNum = monitorParamList.size();
		data = new double[39][colNum];

		for (i = 0; i < num; i++) {
			arr = (Object[]) list.get(i);

			ts = (Timestamp) arr[0];
			date = ts.getDate();
			for (j = 0; j < colNum; j++) {
				v = (String) arr[j + 1];
				v = App.getValueStr(v);
				data[date - 1][j] = StringUtil.getDouble(v, 0);
			}
		}
		for (i = 0; i < colNum; i++) {
			data[32][i] = data[0][i];
			data[33][i] = data[0][i];
			for (j = 0; j < dayNum; j++) {
				if (data[32][i] > data[j][i]) {
					data[32][i] = data[j][i];
				}
				if (data[33][i] < data[j][i]) {
					data[33][i] = data[j][i];
				}
				if (data[j][i] > 0) {
					data[34][i] = data[34][i] + data[j][i];
					data[35][i]++;
				}
			}
		}
		for (i = 0; i < colNum; i++) {
			if (data[35][i] > 0) {
				data[36][i] = data[34][i] / data[35][i];
			}
		}
		for (i = 0; i < dayNum; i++) {

			sb.append("<tr>\n");
			sb.append("<td>").append(i + 1).append("</td>\n");

			for (j = 0; j < colNum; j++) {
				dd = data[i][j];

				sb.append("<td>");
				/*
				 * if(dd==0){ sb.append("0"); }else{ sb.append(dd); }
				 */
				sb.append(StringUtil.format(dd + "", "#.##"));
				sb.append("</td>");

			}
			sb.append("</tr>\n");
		}

		sb.append("<tr>\n");
		sb.append("<td>最小值</td>\n");
		for (i = 0; i < colNum; i++) {

			dd = data[32][i];
			sb.append("<td>");
			/*
			 * if(dd==0){ sb.append("0"); }else{
			 * 
			 * sb.append(dd); }
			 */
			sb.append(StringUtil.format(dd + "", "#.##"));
			sb.append("</td>\n");
		}
		sb.append("</tr>\n");

		sb.append("<tr>\n");
		sb.append("<td>最大值</td>\n");
		for (i = 0; i < colNum; i++) {

			dd = data[33][i];
			sb.append("<td>");
			/*
			 * if(dd==0){ sb.append("0"); }else{
			 * 
			 * sb.append(dd); }
			 */
			sb.append(StringUtil.format(dd + "", "#.##"));
			sb.append("</td>\n");
		}
		sb.append("</tr>\n");

		sb.append("<tr>\n");
		sb.append("<td>平均值</td>\n");
		for (i = 0; i < colNum; i++) {

			dd = data[36][i];
			sb.append("<td>");
			/*
			 * if(dd==0){ sb.append("0"); }else{
			 * 
			 * sb.append(StringUtil.format(dd+"","#.##")); }
			 */
			sb.append(StringUtil.format(dd + "", "#.##"));
			sb.append("</td>\n");
		}
		sb.append("</tr>\n");

		request.setAttribute("station_id", station_id);
		request.setAttribute("station_name", station_name);
		request.setAttribute("title", title);
		request.setAttribute("m_time", m_time);
		return sb.toString();
	}

	public static String getYearReportData(Connection cn, String station_id,
			String m_time, HttpServletRequest request) throws Exception {
		double[][] data = null;
		String station_name = null;
		String sql = null;
		List list = null;
		List monitorParamList = null;
		int i, j = 0;
		int num, colNum = 0;
		Object[] params = null;
		String v = null;
		Timestamp ts = null;
		Object[] arr = null;
		int hh = 0;
		int date = 0;
		double dd = 0;
		StringBuffer sb = new StringBuffer();
		java.sql.Date start = null;
		java.sql.Date end = null;
		java.sql.Date next = null;
		Map map = null;
		int dayNum = 0;
		String title = null;
		int yy = StringUtil.getTimestamp(m_time).getYear() + 1900;
		int mm = 0;

		monitorParamList = getStationMonitorParamList(cn, station_id);

		map = (Map) monitorParamList.get(0);
		station_name = (String) map.get("station_name");

		title = getTitle(monitorParamList);

		sql = "select m_time" + getCols(monitorParamList)
				+ " from t_monitor_real_month ";
		sql = sql
				+ " where station_id=? and m_time>=? and m_time<? order by m_time";

		params = new Object[3];
		params[0] = station_id;
		params[1] = yy + "-1-1";
		params[2] = yy + "-12-31 23:59:59";
		int[] types = JdbcUtil.getJdbcType();
		types[0] = 3;
		list = JdbcUtil.query(cn, sql, params, types);

		num = list.size();

		colNum = monitorParamList.size();
		data = new double[39][colNum];

		for (i = 0; i < num; i++) {
			arr = (Object[]) list.get(i);

			ts = (Timestamp) arr[0];
			mm = ts.getMonth();

			for (j = 0; j < colNum; j++) {
				v = (String) arr[j + 1];
				v = App.getValueStr(v);
				data[mm][j] = StringUtil.getDouble(v, 0);
			}

		}

		for (i = 0; i < colNum; i++) {

			data[32][i] = data[0][i];
			data[33][i] = data[0][i];

			for (j = 0; j < 12; j++) {

				if (data[32][i] > data[j][i]) {
					data[32][i] = data[j][i];
				}

				if (data[33][i] < data[j][i]) {
					data[33][i] = data[j][i];
				}

				if (data[j][i] > 0) {
					data[34][i] = data[34][i] + data[j][i];
					data[35][i]++;
				}

			}
		}
		for (i = 0; i < colNum; i++) {
			if (data[35][i] > 0) {
				data[36][i] = data[34][i] / data[35][i];
			}
		}

		for (i = 0; i < 12; i++) {
			sb.append("<tr>\n");
			sb.append("<td>").append(i + 1).append("</td>\n");

			for (j = 0; j < colNum; j++) {
				dd = data[i][j];
				sb.append("<td>");
				/*
				 * if(dd==0){ sb.append("0"); }else{ sb.append(dd); }
				 */
				sb.append(StringUtil.format(dd + "", "#.##"));
				sb.append("</td>");
			}
			sb.append("</tr>\n");
		}

		sb.append("<tr>\n");
		sb.append("<td>最小值</td>\n");
		for (i = 0; i < colNum; i++) {
			dd = data[32][i];
			sb.append("<td>");
			/*
			 * if(dd==0){ sb.append("0"); }else{
			 * 
			 * sb.append(dd); }
			 */
			sb.append(StringUtil.format(dd + "", "#.##"));
			sb.append("</td>\n");
		}
		sb.append("</tr>\n");

		sb.append("<tr>\n");
		sb.append("<td>最大值</td>\n");
		for (i = 0; i < colNum; i++) {

			dd = data[33][i];
			sb.append("<td>");
			/*
			 * if(dd==0){ sb.append("0"); }else{
			 * 
			 * sb.append(dd); }
			 */
			sb.append(StringUtil.format(dd + "", "#.##"));
			sb.append("</td>\n");
		}
		sb.append("</tr>\n");

		sb.append("<tr>\n");
		sb.append("<td>平均值</td>\n");
		for (i = 0; i < colNum; i++) {

			dd = data[36][i];
			sb.append("<td>");
			/*
			 * if(dd==0){ sb.append("0"); }else{
			 * 
			 * sb.append(StringUtil.format(dd+"","#.##")); }
			 */
			sb.append(StringUtil.format(dd + "", "#.##"));
			sb.append("</td>\n");
		}
		sb.append("</tr>\n");

		request.setAttribute("station_id", station_id);
		request.setAttribute("station_name", station_name);
		request.setAttribute("title", title);
		request.setAttribute("m_time", m_time);

		return sb.toString();

	}

	public static Timestamp add(Timestamp t, String type, int offset)
			throws Exception {

		Timestamp ts = null;
		java.util.Date d = null;
		d = StringUtil.dateAdd(t, type, offset);
		ts = new Timestamp(d.getTime());
		return ts;
	}

	public static Map getDayReportTimeInfo(String m_time, String station_type)
			throws Exception {
		Map m = new HashMap();
		Timestamp start, end = null;
		List list = new ArrayList();
		Timestamp tmp = null;

		int i, num = 0;
		num = 24;
		start = f.time(m_time);
		end = f.time(m_time + " 23:59:59");

		for (i = 0; i < num; i++) {
			tmp = add(start, "hour", i);
			list.add(tmp);
		}
		m.put("start", start);
		m.put("end", end);
		m.put("list", list);
		return m;
	}

	public static Map getWeekReportTimeInfo(String m_time, String station_type)
			throws Exception {
		Map m = new HashMap();
		Timestamp start, end = null;
		List list = new ArrayList();
		Timestamp tmp = null;

		int i, num = 0;
		num = 24;
		start = f.time(m_time);
		end = f.time(m_time + " 23:59:59");

		for (i = 0; i < num; i++) {
			tmp = add(start, "hour", i);
			list.add(tmp);
		}

		m.put("start", start);
		m.put("end", end);
		m.put("list", list);
		return m;
	}

	public static Map getMonthReportTimeInfo(String m_time, String station_type)
			throws Exception {
		Map m = new HashMap();
		Timestamp start, end = null;
		List list = new ArrayList();
		Timestamp tmp = null;
		int i, num = 0;
		num = 24;
		start = f.time(m_time);
		end = f.time(m_time + " 23:59:59");
		for (i = 0; i < num; i++) {
			tmp = add(start, "hour", i);
			list.add(tmp);
		}
		m.put("start", start);
		m.put("end", end);
		m.put("list", list);
		return m;
	}
}