package com.hoson.action;

import java.sql.*;
import java.util.*;
import com.hoson.*;
import com.hoson.app.*;
import com.hoson.util.*;

public class CheckAction extends BaseAction {

	public String execute() throws Exception {

		if (StringUtil.equals(method, "u")) {
			return execute_u();
		}
		if (StringUtil.equals(method, "q")) {
			return execute_q();
		}
		return null;
	}

	public String execute_q() throws Exception {

		String sql = null;
		String msg = null;
		String station_id = (String) model.get("station_id");
		Map map = null;
		Object[] arr = null;
		List list = null;
		String bar = null;
		String dbcols = null;
		String cols = null;
		String data = null;
		if (StringUtil.isempty(station_id)) {
			msg = "请选择一个站位";
			throw new Exception(msg);
		}
		conn = DBUtil.getConn();
		sql = CheckUtil.getCheckQuerySql(conn, model);
		cols = (String) model.get("cols");
		dbcols = "m_time," + cols;
		arr = AppPagedUtil.queryList(conn, sql, dbcols, request);

		list = (List) arr[0];
		bar = (String) arr[1];
		data = CheckUtil.getDataTable(list, dbcols);
		model.put("bar", bar);
		model.put("data", data);
		model.put("sql", sql);
		return null;
	}
	public String execute_u() throws Exception {
		return null;
	}
}