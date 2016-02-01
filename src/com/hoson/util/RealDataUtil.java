package com.hoson.util;

import com.hoson.*;

import java.util.*;
import java.sql.*;

import javax.servlet.http.HttpServletRequest;

public class RealDataUtil {

	/*!
	 *  判断两个日期是否相等
	 */
	public static boolean isTimeEqual(Timestamp t1, Timestamp t2) {
		if (t1 == null && t2 != null) {
			return false;
		}
		if (t1 != null && t2 == null) {
			return false;
		}
		if (t1 == null && t2 == null) {
			return true;
		}
		return t1.equals(t2);
	}

	/*!
	 *  根据数据库连接cn和sql查询实时数据
	 */
	public static List getRealData(Connection cn, String sql) throws Exception {
		List list = new ArrayList();
		Map map = null;
		Timestamp m_time = null;
		Timestamp m_time0 = null;
		String infectant_id = null;
		String station_id = null;
		Double m_value = null;
		String v = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				station_id = rs.getString("station_id");
				infectant_id = rs.getString("infectant_id");
				m_time = rs.getTimestamp("m_time");
				v = rs.getString("m_value");
				if (v == null) {
					m_value = null;
				} else {
					m_value = new Double(StringUtil.getDouble(v, 0));
				}
				if (!isTimeEqual(m_time, m_time0)) {
					map = new HashMap();
					list.add(map);
					map.put("station_id", station_id);
					map.put("m_time", m_time);
					map.put(infectant_id, m_value);
					m_time0 = m_time;
				} else {
					map.put(infectant_id, m_value);
				}
			}
			return list;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs, stmt, null);
		}
	}

	/*!
	 *  根据sql查询实时数据
	 */
	public static List getRealData(String sql) throws Exception {
		Connection cn = null;
		try {
			cn = DBUtil.getConn();
			return getRealData(cn, sql);
		} catch (Exception e) {

			throw e;
		} finally {
			DBUtil.close(cn);
		}
	}

	/*!
	 *  查询数据库获得实时数据，返回map集合
	 */
	public static Map getRealDataListMap() throws Exception {
		Map cacheMap = CacheUtil.getRealDataMap();
		Map dataMap = new HashMap();
		Map tmp, row = null;
		List dataList = null;
		int i, num = 0;
		String station_id, infectant_id, m_value, m_time = null;
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
		}
		return dataMap;
	}

	/*!
	 *  根据实时数据dataList集合获得实时数据的map集合
	 */
	public static Map getRealDataListMap(List dataList) throws Exception {
		Map dataMap = new HashMap();
		Map tmp, row = null;
		int i, num = 0;
		String station_id, infectant_id, m_value, m_time = null;
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
				row.put(infectant_id, m_value);//对应pages/real_data/real.jsp页面中的v = rs.get(id);
			}
		}
		return dataMap;
	}
}