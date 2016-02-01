package com.hoson;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.*;

public class JdbcUtil {

	public static int updateRow(Connection cn, String t, String cols,
			int pkNum, Properties prop) throws Exception {
		if (prop == null) {
			return 0;
		}
		String[] arrCol = cols.split(",");
		int i = 0;
		int num = arrCol.length;
		// String pk = arrCol[0];
		String sql = "";
		String s = "";
		String whereStr = "";
		int flag = 0;
		int num2 = 0;
		int maxIndex = num - 1;
		String v = null;
		String colName = null;
		for (i = 0; i < pkNum; i++) {
			colName = arrCol[i];
			v = prop.getProperty(colName);
			if (StringUtil.isempty(v)) {
				throw new Exception("pk col [" + colName + "] is empty");
			}
		}
		for (i = pkNum; i < num; i++) {
			s = s + arrCol[i] + "=?,";
		}
		s = s.substring(0, s.length() - 1);

		flag = pkNum - 1;
		for (i = 0; i < pkNum; i++) {
			if (i < flag) {
				whereStr = whereStr + arrCol[i] + "=?" + " and ";
			} else {
				whereStr = whereStr + arrCol[i] + "=?";
			}
		}
		sql = "update " + t + " set " + s + " where " + whereStr;
		PreparedStatement ps = null;
		flag = num - pkNum;
		try {
			ps = cn.prepareStatement(sql);
			for (i = 1; i <= num; i++) {
				if (i <= flag) {
					v = prop.getProperty(arrCol[i + pkNum - 1]);
				} else {
					v = prop.getProperty(arrCol[i + pkNum - num - 1]);
				}
				if (StringUtil.isempty(v)) {
					v = null;
				}
				ps.setString(i, v);
			}
			return ps.executeUpdate();
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(ps);
			DBUtil.close(cn);
		}
	}

	public static int updateRow(Connection cn, String t, String cols,
			int pkNum, Map map) throws Exception {
		if (map == null) {
			return 0;
		}
		Properties prop = null;
		prop = DBUtil.map2prop(map);
		return updateRow(cn, t, cols, pkNum, prop);
	}

}