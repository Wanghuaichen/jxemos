package com.hoson.action;

import java.sql.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

import com.hoson.*;
import com.hoson.util.*;
import com.hoson.app.*;

public class SiteReportAction extends BaseAction {

	public String rpt() throws Exception {
		String report_type = p("report_type");
		String m_time = p("m_time");
		String station_id = p("station_id");
		String sql = null;
		Map m = null;
		String station_desc, station_type = null;
		Map timeMap = null;
		Map minMap, maxMap, countMap, sumMap, avgMap = null;

		sql = "select station_desc,station_type from t_cfg_station_info where station_id='"
				+ station_id + "'";
		List infectantList = null;
		List data = null;
		String report_type_name = "日";
		if (f.eq(report_type, "0")) {
			report_type_name = "日";
		}
		if (f.eq(report_type, "1")) {
			report_type_name = "周";
		}
		if (f.eq(report_type, "2")) {
			report_type_name = "月";
		}
		getConn();
		m = f.queryOne(conn, sql, null);
		if (m == null) {
			throw new Exception("站位不存在");
		}
		station_desc = (String) m.get("station_desc");
		station_type = (String) m.get("station_type");
		timeMap = SiteReportUtil.getReportTimeInfo(report_type, m_time,
				station_type);
		infectantList = SiteReportUtil.getInfectantList(conn, station_id);

		data = SiteReportUtil.getData(conn, report_type, station_id, timeMap,
				infectantList);

		close();

		minMap = SiteReportUtil.min(data, infectantList);
		maxMap = SiteReportUtil.max(data, infectantList);
		countMap = SiteReportUtil.count(data, infectantList);
		sumMap = SiteReportUtil.sum(data, infectantList);
		avgMap = SiteReportUtil.avg(sumMap, countMap, infectantList);

		seta("station_desc", station_desc);
		seta("start", timeMap.get("start"));
		seta("end", timeMap.get("end"));
		seta("data", data);
		seta("infectant", infectantList);
		seta("report_type", report_type);
		seta("station_id", station_id);
		seta("station_type", station_type);
		seta("report_type_name", report_type_name);
		seta("min", minMap);
		seta("max", maxMap);
		seta("avg", avgMap);
		seta("count", countMap);
		seta("sum", sumMap);
		return null;
	}
}