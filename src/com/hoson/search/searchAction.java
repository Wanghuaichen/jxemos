package com.hoson.search;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.hoson.DBUtil;
import com.hoson.XBean;
import com.hoson.f;
import com.hoson.util.WarnUtil;
import com.hoson.zdxupdate.zdxUpdate;

public class searchAction {
	/*!
	 *  根据request值返回报警数据，并传到request中
	 */
	public static void getCbbj(HttpServletRequest req) throws Exception {
		String station_id;
		Connection cn = f.getConn();
		station_id = req.getParameter("station_id");
		String beginDate = req.getParameter("date1");
		String endDate = req.getParameter("date2");
		if (f.empty(station_id)) {
			f.error("请选择站位");
		}
		WarnUtil warn = new WarnUtil();
		Map map = warn.getWarnNumDataRow(station_id, getDataMap(cn, beginDate,
				endDate, station_id), getInfectantList(cn, station_id));
		map.put("ycbj", "2");
		map.put("zlss", "2");
		map.put("scy", "2");
		map.put("jcyq", "1");
		map.put("yczs", "1");
		map.put("wczs", "1");

		req.setAttribute("cbbjData", map);
	}

	/*!
	 * 根据request值返回超标报警数据，并传到request中
	 */
	public static void getBjxx(HttpServletRequest req) throws Exception {
		Connection cn = f.getConn();
		String station_id = req.getParameter("station_id");
		String beginDate = req.getParameter("date1");
		String endDate = req.getParameter("date2");
		String infectant_id = req.getParameter("infectant_id");
		if (f.empty(station_id)) {
			f.error("请选择站位");
		}
		if (f.empty(infectant_id)) {
			f.error("请选择污染物");
		}
		WarnUtil warn = new WarnUtil();
		Map map = warn.getWarnNumDataRow(station_id, getDataMap(cn, beginDate,
				endDate, station_id), getInfectantList(cn, station_id));
		map.put("ycbj", "2");
		map.put("zlss", "2");
		map.put("scy", "2");
		map.put("jcyq", "1");
		map.put("yczs", "1");
		map.put("wczs", "1");

		req.setAttribute("cbbjData", map);
	}

	/*!
	 * 根据开始时间，结束时间，站位编号，查询时均值数据
	 */
	public static List getDataMap(Connection cn, String beginDate,
			String endDate, String station_id) throws Exception {
		List list = null;
		WarnUtil warn = new WarnUtil();
		String sql = "select " + warn.getCols(cn)
				+ " from t_monitor_real_hour ";
		sql = sql + " where m_time>=to_date('" + beginDate + "','yyyy-mm-dd') ";
		sql = sql + " and m_time<=to_date('" + endDate
				+ " 23:59:59','yyyy-mm-dd hh24:mi:ss') and station_id="
				+ station_id;
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
	 * 根据站位编号查询因子列表
	 */
	public static List getInfectantList(Connection cn, String station_id)
			throws Exception {
		List list = null;
		String sql = "select a.infectant_id,a.infectant_name,a.infectant_unit,a.infectant_column,";
		sql = sql + "b.station_id,b.lolo,b.hihi ";
		sql = sql + " from t_cfg_infectant_base a,t_cfg_monitor_param b ";
		sql = sql + " where a.infectant_id=b.infectant_id and b.station_id="
				+ station_id;
		Map m = null;
		int i, num = 0;
		String s = null;
		double dv = 0;
		Double dvobj = null;
		List list2 = new ArrayList();
		try {
			list = f.query(cn, sql, null);
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
		num = list.size();
		for (i = 0; i < num; i++) {
			m = (Map) list.get(i);
			s = (String) m.get("lolo");
			dvobj = f.getDoubleObj(s, null);
			if (dvobj != null) {
				dv = dvobj.doubleValue();
				if (dv == 0) {
					dvobj = null;
				}
			}
			m.put("lolo", dvobj);
			s = (String) m.get("hihi");
			dvobj = f.getDoubleObj(s, null);
			if (dvobj != null) {
				dv = dvobj.doubleValue();
				if (dv == 0) {
					dvobj = null;
				}
			}
			m.put("hihi", dvobj);
			s = (String) m.get("infectant_column");
			if (f.empty(s)) {
				continue;
			}
			s = s.toLowerCase();
			m.put("col", s);
			list2.add(m);
		}
		return list2;
	}

	/*!
	 *  根据request值和站位编号查询备注信息
	 */
	public static void getComments(Connection cn, String station_id,
			HttpServletRequest req) throws Exception {
		List list = null;
		String sql = "select * from t_cfg_station_comment where station_id='"
				+ station_id + "' order by insert_time desc";
		try {
			list = f.query(cn, sql, null);
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
		req.setAttribute("data", list);
	}
	public static String shqx(HttpSession session) throws Exception{
		 String user_name = (String)session.getAttribute("user_name");
		 String session_id = (String)session.getAttribute("session_id");
	  	Map map = zdxUpdate.getRight(user_name,session_id);
	  	XBean b = new XBean(map);
	  	if(b.get("10150").equals("none")){
	  		return "false";
	  	}
		return "true";
	}
}
