package com.hoson.ww;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.hoson.DBUtil;
import com.hoson.PagedUtil2;
import com.hoson.f;

public class user {

	public static void getUsers(String sql, HttpServletRequest req)
			throws Exception {
		Connection cn = f.getConn();
		Map pageMap = null;
		try {
			pageMap = PagedUtil2.getPagingInfo(cn, sql, req);
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}

		String page_bar = (String) pageMap.get("page_bar");
		List list = f.query(sql, null);
		req.setAttribute("users", list);
		req.setAttribute("page_bar", page_bar);
	}

	public static String getMultipleOption(String sql,String station_ids) throws Exception {
		Connection cn = f.getConn();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String ids  = "";
		String names  = "";
		try {
			stmt = cn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while(rs.next()){
				ids = ids + String.valueOf(rs.getString("station_id")) + ",";
				names = names + rs.getString("station_desc") + ",";
			}
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
		return getOption(ids,names,station_ids);
	}

	public static String getOption(String vs, String ts, String defaultV)
			throws Exception {
		if (vs == null)
			vs = "";
		if (ts == null)
			ts = "";
		vs = vs.trim();
		ts = ts.trim();
		if (vs.length() == 0 || ts.length() == 0)
			return "";
		String s = "";
		if (defaultV == null)
			defaultV = "";
		String strv = null;
		String strt = null;
		int i = 0;
		int num = 0;
		String arrv[] = vs.split(",");
		String arrt[] = ts.split(",");
		String arrdefaultV[] = defaultV.split(",");
		num = arrv.length;
		if (arrt.length != num)
			throw new Exception("值与标题长度不一致");
		String flag = null;
		for (i = 0; i < num; i++) {
			strv = arrv[i];
			strt = arrt[i];
			strv = strv.trim();
			strt = strt.trim();
			for (int n = 0; n < arrdefaultV.length; n++) {
				if (strv.equals(arrdefaultV[n].trim())){
					flag = " selected";
					break;
				}
				else
					flag = "";
			}
			s = s + "<option value=\"" + strv + "\"" + flag + ">" + strt
					+ "</option>\n";
		}

		return s;
	}
}
