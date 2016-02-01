package com.hoson.action;

import java.sql.*;
import java.util.*;
import com.hoson.*;
import com.hoson.util.*;

public class RealQueryInputAction extends BaseAction {

	public String view() throws Exception {
		conn = DBUtil.getConn();
		String station_id = null;
		String now = StringUtil.getNowDate() + "";
		int hh = StringUtil.getNowHour();
		int starth = 0;
		int endh = 0;
		String station_type = null;
		String sql = null;
		String infectantOption = null;
		String startHourOption = null;
		String endHourOption = null;
		Map map = null;
		String station_name = null;

		if (hh < 23) {
			endh = hh + 1;
		} else {
			endh = hh;
		}
		starth = hh - 6;
		if (starth < 0) {
			starth = 0;
		}

		station_id = request.getParameter("station_id");
		if (StringUtil.isempty(station_id)) {

			throw new Exception("请选择一个站位");
		}

		sql = "select station_desc,station_type from t_cfg_station_info where station_id='"
				+ station_id + "'";
		// station_type = DBUtil.getString(conn,sql);
		map = DBUtil.queryOne(conn, sql, null);
		station_type = (String) map.get("station_type");
		station_name = (String) map.get("station_desc");
		if (StringUtil.isempty(station_type)) {

			throw new Exception("请选择一个监测类别");
		}

		infectantOption = JspPageUtil.getInfectantOptionByStationId(conn,
				station_id);

		startHourOption = JspUtil.getHourOption(starth);
		endHourOption = JspUtil.getHourOption(endh);
		model.put("infectantOption", infectantOption);
		model.put("startHourOption", startHourOption);
		model.put("endHourOption", endHourOption);
		model.put("now", now);
		model.put("station_name", station_name);

		sql = "select station_bz from t_cfg_station_info where station_id='"
				+ station_id + "'";
		map = DBUtil.queryOne(conn, sql, null);
		String bz = null;
		if (map == null) {
			bz = "";
		}
		bz = (String) map.get("station_bz");
		if (bz == null) {
			bz = "";
		}
		model.put("bz", bz);
		seta("now", now);
		seta("station_bz", bz);
		seta("station_name", station_name);
		seta("station_id", station_id);
		return null;
	}

}