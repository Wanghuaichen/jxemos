package com.hoson.action;

import java.sql.*;
import java.text.DecimalFormat;
import java.text.Format;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

import com.hoson.*;
import com.hoson.util.*;
import com.hoson.app.*;

public class ReportNbAction extends BaseAction {

	String no_data_string = "-";

	String not_config_string = "n";

	String offline_string = "X";

	String online_string = "√";

	void config() throws Exception {
		no_data_string = p("no_data_string", "-");
		not_config_string = p("not_config_string", "n");
		offline_string = p("offline_string", "X");
		online_string = p("online_string", "√");
	}
	
	/*!
	 * 脱机统计报表
	 */
	public String rpt01() throws Exception {
		config();
		String area_id = p("area_id");
		String date1 = p("date1");
		String date2 = p("date2");
		String station_type = p("station_type");
		String station_id = p("station_id");
		String trade_id = p("trade_id");
		String sql = null;
		int i, num = 0;
		Map m = null;
		String id, m_time = null;
		Map data = new HashMap();
		List dataList = new ArrayList();
		List list = null;
		List stationList = null;
		List timeList = getTimeList(date1, date2);
		sql = getSql(station_type, station_id, area_id, date1, date2, request);
		getConn();
		list = f.query(conn, sql, null);
		stationList = getStationList(conn, station_type, station_id, area_id,trade_id,
				request);
		close();
		Timestamp t = null;
		Map stationMap = null;
		Map row = null;

		int j, snum = 0;
		num = list.size();
		for (i = 0; i < num; i++) {
			m = (Map) list.get(i);
			id = (String) m.get("station_id");
			m_time = (String) m.get("m_time");
			m_time = f.sub(m_time, 0, 13);
			data.put(id + "_" + m_time, "1");

		}

		num = timeList.size();
		snum = stationList.size();
		for (i = 0; i < num; i++) {
			t = (Timestamp) timeList.get(i);
			for (j = 0; j < snum; j++) {
				stationMap = (Map) stationList.get(j);
				row = getDataRow01(stationMap, t, data);
				dataList.add(row);
			}
		}
		seta("data", dataList);
		return null;
	}
	
	
	/*!
	 * 月脱机统计报表
	 */
	public String tj_yue() throws Exception {
		config();
		String area_id = p("area_id");
		String year = p("year");
		String month = p("month");
		String station_type = p("station_type");
		String station_id = p("station_id");
		String trade_id = p("trade_id");
		String sql = null;
		int i, num = 0;
		Map m = null;
		String id, m_time = null;
		Map data = new HashMap();
		List dataList = new ArrayList();
		List list = null;
		List stationList = null;
		List timeList = new ArrayList();
		timeList.add(year+"-"+month);
		sql = getSqlOfYueTJ(station_type, station_id, area_id, year, month, request);
		getConn();
		list = f.query(conn, sql, null);
		stationList = getStationList(conn, station_type, station_id, area_id,trade_id,
				request);
		close();
		String t = null;
		Map stationMap = null;
		Map row = null;

		int j, snum = 0;
		num = list.size();
		for (i = 0; i < num; i++) {
			m = (Map) list.get(i);
			id = (String) m.get("station_id");
			m_time = (String) m.get("m_time");
			m_time = f.sub(m_time, 0, 10);
			data.put(id + "_" + m_time, "1");

		}

		num = timeList.size();
		snum = stationList.size();
		for (i = 0; i < num; i++) {
			t = (String) timeList.get(i);
			for (j = 0; j < snum; j++) {
				stationMap = (Map) stationList.get(j);
				row = getDataRowYueTJ(stationMap, t, data,year,month);
				dataList.add(row);
			}
		}
		seta("data", dataList);
		seta("year", year);
		seta("month", month);
		return null;
	}
	
	/*!
	 * 污染源在线监测日报表
	 */
	public String rpt02() throws Exception {
		config();
		String area_id = p("area_id");
		String date1 = p("date1");
		String ph_col = p("ph_col");
		String cod_col = p("cod_col");
		String q_col = p("q_col");
		String station_type = p("station_type");
		String sql = null;
		List list = null;
		Map data = new HashMap();
		List stationList = null;
		int i, num = 0;
		Map m = null;
		String station_id = null;
		List dataList = new ArrayList();
		Map datarow = null;
		Map infectantMap = null;
		String area_name = null;
		String tableName = request.getParameter("tableName");

		sql = "select station_id," + ph_col + "," + cod_col + "," + q_col;
		sql = sql + " from " + tableName + " where m_time>='" + date1 + "' ";
		sql = sql + " and m_time<='" + date1 + " 23:59:59' ";
		sql = sql
				+ DataAclUtil.getStationIdInString(request, station_type,
						"station_id");
		getConn();
		list = f.query(conn, sql, null);
		stationList = JspPageUtil.getStationList(conn, station_type, area_id,
				null, request);
		infectantMap = getInfectantInfoMap(conn, station_type, area_id, ph_col,
				cod_col, q_col);
		sql = "select area_name from t_cfg_area where area_id='" + area_id
				+ "'";
		m = f.queryOne(conn, sql, null);

		close();
		if (m == null) {
			area_name = "";
		} else {
			area_name = (String) m.get("area_name");
		}

		data = f.getListMap(list, "station_id");
		num = stationList.size();
		for (i = 0; i < num; i++) {
			m = (Map) stationList.get(i);
			station_id = (String) m.get("station_id");
			list = (List) data.get(station_id);
			datarow = getDataRow(station_id, list, ph_col, cod_col, q_col,
					infectantMap);
			datarow.put("station_id", station_id);
			datarow.put("station_desc", m.get("station_desc"));
			dataList.add(datarow);
		}

		seta("data", dataList);
		seta("date1", date1);
		seta("area_name", area_name);

		return null;
	}
	/*!
	 * 废水在线监测点完好率统计报表2
	 */
	Map getInfectantInfoMap(Connection cn, String station_type, String area_id,
			String ph_col, String cod_col, String q_col) throws Exception {
		Map m = new HashMap();
		String sql = null;
		List list = null;
		int i, num = 0;

		Map m2, m3 = null;
		String station_id, infectant_column = null;
		double dv = 0;
		String v = null;
		String key = null;
		sql = "select station_id,infectant_column,lolo,hihi from t_cfg_monitor_param ";
		sql = sql + " where station_id in(";
		sql = sql + "select station_id from t_cfg_station_info ";
		sql = sql + " where station_type='" + station_type + "' ";
		sql = sql + " and area_id like '" + area_id + "%' ";
		sql = sql + ") ";
		try {
			list = f.query(cn, sql, null);
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
		num = list.size();
		for (i = 0; i < num; i++) {
			m2 = (Map) list.get(i);
			station_id = (String) m2.get("station_id");
			infectant_column = (String) m2.get("infectant_column");
			if (f.empty(station_id) || f.empty(infectant_column)) {
				continue;
			}
			infectant_column = infectant_column.toLowerCase();
			if (f.eq(infectant_column, ph_col)
					|| f.eq(infectant_column, cod_col)
					|| f.eq(infectant_column, q_col)) {

				m3 = new HashMap();

				v = (String) m2.get("lolo");
				dv = f.getDouble(v, 0);
				if (dv > 0) {
					m3.put("lolo", new Double(dv));
				}

				v = (String) m2.get("hihi");
				dv = f.getDouble(v, 0);
				if (dv > 0) {
					m3.put("hihi", new Double(dv));
				}

				key = station_id + "_" + infectant_column;
				m.put(key, m3);

			}

		}

		return m;
	}
	/*!
	 * 废水在线监测点完好率统计报表2
	 */
	Map getDataRow(String station_id, List list, String ph_col, String cod_col,
			String q_col, Map infectantMap) throws Exception {
		if (list == null) {
			list = new ArrayList();
		}
		Map row = new HashMap();
		String v = null;
		v = getUp(station_id, list, infectantMap, ph_col);
		row.put("ph_up", v);

		v = getUp(station_id, list, infectantMap, cod_col);
		row.put("cod_up", v);

		v = getCodAvg(station_id, list, infectantMap, cod_col);
		row.put("cod_avg", v);

		v = getQSum(station_id, list, infectantMap, q_col);
		row.put("q", v);

		v = getDataGetRate(station_id, list, q_col, infectantMap);
		row.put("r", v);

		v = getDataGetRate(station_id, list, cod_col, infectantMap);
		row.put("r_cod", v);
		makeDataRow(row);
		return row;
	}
	/*!
	 * 废水在线监测点完好率统计报表2
	 */
	void makeDataRow(Map row) {
		String r_cod = (String) row.get("r_cod");
		String r = (String) row.get("r");
		String q = (String) row.get("q");
		String cod_avg = (String) row.get("cod_avg");
		String q2 = null;
		String cod1, cod2 = null;
		Double cod_avg_obj = null;
		Double q_obj = null;
		double dv_r = f.getDouble(r, 0);
		double dv = 0;
		double dv_r_cod = f.getDouble(r_cod, 0);
		cod1 = "";
		cod2 = "";
		q2 = "";

		cod_avg_obj = f.getDoubleObj(cod_avg, null);
		q_obj = f.getDoubleObj(q, null);
		if (cod_avg_obj == null) {
			cod1 = cod_avg;
			cod2 = cod_avg;
		} else {
			if (q_obj != null) {
				dv = cod_avg_obj.doubleValue() * q_obj.doubleValue() / 1000;
				cod1 = dv + "";
				if (dv_r_cod > 0) {
					dv = dv * 100 / dv_r_cod;
					cod2 = dv + "";
				}
			}
		}
		if (q_obj == null) {
			q2 = q;
		} else {
			dv = q_obj.doubleValue();
			if (dv_r_cod > 0) {
				dv = dv * 100 / dv_r_cod;
				q2 = dv + "";
			}
		}
		row.put("cod1", cod1);
		row.put("cod2", cod2);
		row.put("q2", q2);

	}
	/*!
	 * 废水在线监测点完好率统计报表2
	 */
	String getUp(String station_id, List list, Map infectantMap, String col) {
		if (list == null) {
			list = new ArrayList();
		}
		String s = null;
		Map info = null;
		info = (Map) infectantMap.get(station_id + "_" + col);

		if (info == null) {
			return not_config_string;
		}
		Map m = null;
		int i, dnum = 0;
		String v = null;
		double dv = 0;
		Double dvobj = null;
		Double hihi, lolo = null;

		int num = 0;
		int numup = 0;

		dnum = list.size();
		if (dnum < 1) {
			return no_data_string;
		}
		for (i = 0; i < dnum; i++) {
			m = (Map) list.get(i);

			v = (String) m.get(col);

			if (f.empty(v)) {
				continue;
			}
			v = f.v(v);
			dvobj = f.getDoubleObj(v, null);
			if (dvobj == null) {
				continue;
			}
			num++;
			dv = dvobj.doubleValue();

			if (isup(dv, info)) {
				numup++;
			}
		}
		if (num < 1) {
			return no_data_string;
		}
		dv = numup * (100.0) / num;
		s = dv + "";
		return s;
	}

	public static boolean isup(double v, Map info) {
		if (v <= 0) {
			return false;
		}
		boolean b = false;
		Double lolo = null;
		Double hihi = null;

		lolo = (Double) info.get("lolo");
		hihi = (Double) info.get("hihi");

		double dv = 0;
		if (lolo != null) {
			dv = lolo.doubleValue();
			if (dv > 0 && v < dv) {
				return true;
			}
		}
		if (hihi != null) {
			dv = hihi.doubleValue();
			if (dv > 0 && v > dv) {
				return true;
			}
		}
		return b;
	}

	String getDataGetRate(List list) {

		if (list == null) {
			return "0";
		}
		int num = list.size();
		double v = num * 100.0 / 24;
		return v + "";
	}

	String getDataGetRate(String station_id, List list, String col,
			Map infectantMap) {

		Map info = (Map) infectantMap.get(station_id + "_" + col);
		if (info == null) {
			return not_config_string;
		}
		if (list == null) {
			return "0";
		}
		int num = list.size();
		int i = 0;
		Map m = null;
		String v = null;
		double dv = 0;
		int dnum = 0;
		for (i = 0; i < num; i++) {
			m = (Map) list.get(i);
			v = (String) m.get(col);

			if (!f.empty(v)) {
				dnum++;
			}
		}

		dv = dnum * (100.0) / 24;
		return dv + "";
	}
	/*!
	 * 废水在线监测点完好率统计报表2
	 */
	String getCodAvg(String station_id, List list, Map infectantMap,
			String cod_col) {
		if (list == null) {
			list = new ArrayList();
		}
		String s = null;
		Map info = null;
		info = (Map) infectantMap.get(station_id + "_" + cod_col);
		if (info == null) {
			return not_config_string;
		}
		Map m = null;
		int i, dnum = 0;
		String v = null;
		double dv = 0;
		Double dvobj = null;
		Double sumdvobj = null;

		int datanum = 0;
		dnum = list.size();

		if (dnum < 1) {
			return no_data_string;
		}
		for (i = 0; i < dnum; i++) {
			m = (Map) list.get(i);
			v = (String) m.get(cod_col);
			if (f.empty(v)) {
				continue;
			}
			v = f.v(v);

			dvobj = f.getDoubleObj(v, null);
			if (dvobj == null) {
				continue;
			}
			datanum++;
			if (sumdvobj == null) {
				sumdvobj = dvobj;
			} else {
				dv = dvobj.doubleValue();
				dv = dv + sumdvobj.doubleValue();
				sumdvobj = new Double(dv);
			}
		}
		if (sumdvobj == null) {
			return no_data_string;
		}
		dv = sumdvobj.doubleValue() / datanum;
		s = dv + "";
		return s;
	}
	/*!
	 * 废水在线监测点完好率统计报表2
	 */
	String getQSum(String station_id, List list, Map infectantMap, String q_col) {
		if (list == null) {
			list = new ArrayList();
		}
		String s = null;
		Map info = null;
		info = (Map) infectantMap.get(station_id + "_" + q_col);
		if (info == null) {
			return not_config_string;
		}
		Map m = null;
		int i, dnum = 0;
		String v = null;
		double dv = 0;
		Double dvobj = null;
		Double sumdvobj = null;

		int datanum = 0;
		dnum = list.size();
		if (dnum < 1) {
			return no_data_string;
		}
		for (i = 0; i < dnum; i++) {
			m = (Map) list.get(i);
			v = (String) m.get(q_col);
			if (f.empty(v)) {
				continue;
			}
			v = f.v(v);
			dvobj = f.getDoubleObj(v, null);
			if (dvobj == null) {
				continue;
			}
			datanum++;
			if (sumdvobj == null) {
				sumdvobj = dvobj;
			} else {
				dv = dvobj.doubleValue();
				dv = dv + sumdvobj.doubleValue();
			}
		}
		if (sumdvobj == null) {
			return no_data_string;
		}
		s = sumdvobj + "";
		return s;
	}
	/*!
	 * 废水在线监测点完好率统计报表2
	 */
	public String getSql(String station_type, String station_id,
			String area_id, String date1, String date2, HttpServletRequest req)
			throws Exception {
		String sql = null;

		//System.out.println("tableName11====="
				//+ request.getParameter("tableName"));
		String tableName = request.getParameter("tableName");
		if (!f.empty(station_id)) {
			sql = "select station_id,m_time from  " + tableName
					+ " where station_id='" + station_id + "' ";
			sql = sql + " and m_time>='" + date1 + "' and m_time<='" + date2
					+ " 23:59:59'";
			return sql;
		}

		sql = "select station_id,m_time from " + tableName;
		sql = sql + " where m_time>='" + date1 + "' and m_time<='" + date2
				+ " 23:59:59' ";
		sql = sql + " and station_id in(";
		sql = sql + "select station_id from t_cfg_station_info where ";
		sql = sql + " station_type='" + station_type + "' and area_id like '"
				+ area_id + "%'";
		sql = sql + ") ";
		sql = sql
				+ DataAclUtil.getStationIdInString(req, station_type,
						"station_id");
		return sql;
	}
	
	
	/*!
	 * 月在线脱机统计报表
	 */
	public String getSqlOfYueTJ(String station_type, String station_id,
			String area_id, String year, String month, HttpServletRequest req)
			throws Exception {
		String sql = null;

		//System.out.println("tableName11====="
				//+ request.getParameter("tableName"));
		String tableName = request.getParameter("tableName");
		
		if(!"".equals(tableName) && tableName.equals("t_monitor_real_hour")){
			tableName = "t_monitor_real_day";
		}else{
			tableName = "t_monitor_real_day_v";
		}
		String date1 = year+"-"+month+"-01";
		String date2 = f.getLastDayOfMonthString(Integer.valueOf(year), Integer.valueOf(month));
		if (!f.empty(station_id)) {
			sql = "select station_id,m_time from  " + tableName
					+ " where station_id='" + station_id + "' ";
			sql = sql + " and m_time>='" + date1 + "' and m_time<='" + date2+"'";
			return sql;
		}

		sql = "select station_id,m_time from " + tableName;
		sql = sql + " where m_time>='" + date1 + "' and m_time<='" + date2+"'";
		sql = sql + " and station_id in(";
		sql = sql + "select station_id from t_cfg_station_info where ";
		sql = sql + " station_type='" + station_type + "' and area_id like '"
				+ area_id + "%'";
		sql = sql + ") ";
		sql = sql
				+ DataAclUtil.getStationIdInString(req, station_type,
						"station_id");
		return sql;
	}
	
	/*!
	 * 废水在线监测点完好率统计报表2
	 */
	public static List getStationList(Connection cn, String station_type,
			String station_id, String area_id,String trade_id, HttpServletRequest req)
			throws Exception {
		Map m = null;
		String sql = null;
		List list = null;
		sql = "select a.station_id,a.station_desc,b.area_name from t_cfg_station_info a,t_cfg_area b";
		//sql = sql + " where a.area_id=b.area_id ";//黄宝修改
		sql = sql + " where a.area_id=b.area_id and a.show_flag !='1'";
		if (!f.empty(station_id)) {

			sql = sql + " and a.station_id='" + station_id + "'";
			try {
				list = f.query(cn, sql, null);
			} catch (Exception e) {
				throw e;
			} finally {
				DBUtil.close(cn);
			}
			return list;
		}
		sql = sql + " and a.station_id in (";
		sql = sql
				+ "select station_id from t_cfg_station_info where a.show_flag !='1' and station_type='"
				+ station_type + "' ";
		sql = sql + " and area_id like '" + area_id + "%'";
		if(trade_id !=null && !"".equals(trade_id)){
			sql = sql + " and trade_id like '" + trade_id + "%'";
		}
		sql = sql + ") ";
		sql = sql+ DataAclUtil.getStationIdInString(req, station_type,"a.station_id");
		sql = sql + " order by a.area_id,a.station_desc";
		try {
			list = f.query(cn, sql, null);
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
		return list;
	}
	/*!
	 * 废水在线监测点完好率统计报表2
	 */
	static List getTimeList(String date1, String date2) throws Exception {
		List list = new ArrayList();
		Timestamp t1 = f.time(date1);
		Timestamp t2 = f.time(date2);
		Timestamp t = null;

		long ms1, ms2 = 0;
		long ms = 0;

		ms1 = t1.getTime();
		ms2 = t2.getTime();
		if (ms1 > ms2) {
			return list;
		}
		if (ms1 == ms2) {
			list.add(t1);
			return list;
		}
		list.add(t1);
		int i = 1;

		while (true) {
			t = f.dateAdd(t1, "day", i);
			ms = t.getTime();
			if (ms > ms2) {
				break;
			}
			list.add(t);
			i++;

		}
		return list;
	}
	/*!
	 * 废水在线监测点完好率统计报表2
	 */
	Map getDataRow01(Map stationMap, Timestamp t, Map data) {
		Map row = new HashMap();
		String m_time = t + "";
		m_time = f.sub(m_time, 0, 10);
		int i, num = 0;
		Object obj = null;
		String flag = null;
		num = 24;
		String key = null;
		String station_id = (String) stationMap.get("station_id");
		int offnum = 0;
		float onnum = 0;
		for (i = 0; i < num; i++) {
			if (i < 10) {
				key = "0" + i;
			} else {
				key = i + "";
			}
			key = station_id + "_" + m_time + " " + key;
			obj = data.get(key);
			if (obj == null) {
				flag = offline_string;
				offnum++;
			} else {
				flag = online_string;
				onnum ++;
			}
			row.put(i + "", flag);
		}
		row.put("m_time", m_time);
		row.put("station_id", station_id);
		row.put("station_desc", stationMap.get("station_desc"));
		row.put("area_name", stationMap.get("area_name"));
		row.put("off", offnum + "");
		Format   format = new   DecimalFormat("0.00"); 
		row.put("online", format.format((onnum/num)*100));
		return row;
	}
	
	
	/*!
	 * 月在线脱机统计报表
	 */
	Map getDataRowYueTJ(Map stationMap,String t, Map data,String year ,String month) {
		Map row = new HashMap();
		String m_time = t + "";

		int i, num = 0;
		Object obj = null;
		String flag = null;
		String[] last_day = f.getLastDayOfMonthString(Integer.valueOf(year), Integer.valueOf(month)).split("-");
		num = Integer.valueOf(last_day[2]);
		String key = null;
		String station_id = (String) stationMap.get("station_id");
		int offnum = 0;
		float onnum = 0;
		for (i = 1; i <= num; i++) {
			if (i < 10) {
				key = "0" + i;
			} else {
				key = i + "";
			}
			key = station_id + "_" + m_time + "-" + key;
			obj = data.get(key);
			if (obj == null) {
				flag = offline_string;
				offnum++;
			} else {
				flag = online_string;
				onnum++;
			}
			row.put(i + "", flag);
		}
		row.put("m_time", m_time);
		row.put("station_id", station_id);
		row.put("station_desc", stationMap.get("station_desc"));
		row.put("area_name", stationMap.get("area_name"));
		Format   format = new   DecimalFormat("0.00"); 
		row.put("off", offnum + "");
		row.put("online", format.format((onnum/num)*100));
		return row;
	}
	
	
}