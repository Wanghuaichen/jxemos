package com.hoson;

import java.sql.*;
import java.util.*;

public class DBMetaData {

	// ----------------------

	public static int getRowNum(Connection cn, String t) throws Exception {
		Statement stmt;
		ResultSet rs;
		int num = 0;
		String sql = null;
		stmt = null;
		rs = null;
		String msg = null;

		try {
			stmt = cn.createStatement();
			sql = "select count(*) from " + t;
			rs = stmt.executeQuery(sql);

			try {
				rs.next();
				num = Integer.parseInt(rs.getString(1));
			} catch (Exception e1) {
				num = 0;
			}
			return num;
		} catch (Exception e2) {
			msg = "error in getRowNum(Connection cn, String t) ---"
					+ e2.getMessage();
			throw new Exception(msg);
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
			DBUtil.close(cn);
		}

	}

	// --------------------------------
	public static Map getDBInfo(Connection cn) throws Exception {
		Map map = new HashMap();
		DatabaseMetaData dbmd = null;
		String DatabaseMajorVersion = "";
		String DatabaseMinorVersion = "";
		String DatabaseProductName = "";
		String DatabaseProductVersion = "";
		String DriverMajorVersion = "";
		String DriverMinorVersion = "";
		String DriverName = "";
		String DriverVersion = "";
		String db = "";
		String driver = "";
		try {
			dbmd = cn.getMetaData();
			DatabaseMajorVersion = dbmd.getDatabaseMajorVersion() + "";
			DatabaseMinorVersion = dbmd.getDatabaseMinorVersion() + "";
			DatabaseProductName = dbmd.getDatabaseProductName() + "";
			DatabaseProductVersion = dbmd.getDatabaseProductVersion() + "";
			DriverMajorVersion = dbmd.getDriverMajorVersion() + "";
			DriverMinorVersion = dbmd.getDriverMinorVersion() + "";
			DriverName = dbmd.getDriverName() + "";
			DriverVersion = dbmd.getDriverVersion() + "";
			db = DatabaseMajorVersion + "," + DatabaseMinorVersion + ","
					+ DatabaseProductName + "," + DatabaseProductVersion;
			db = db.toLowerCase();
			driver = DriverMajorVersion + "," + DriverMinorVersion + ","
					+ DriverName + "," + DriverVersion;
			driver = driver.toLowerCase();
		} catch (Exception e) {
		}
		map.put("DatabaseMajorVersion", DatabaseMajorVersion);
		map.put("DatabaseMinorVersion", DatabaseMinorVersion);
		map.put("DatabaseProductName", DatabaseProductName);
		map.put("DatabaseProductVersion", DatabaseProductVersion);
		map.put("DriverMajorVersion", DriverMajorVersion);
		map.put("DriverMinorVersion", DriverMinorVersion);
		map.put("DriverName", DriverName);
		map.put("DriverVersion", DriverVersion);
		map.put("db", db);
		map.put("driver", driver);
		return map;
	}

	// ---------------------------------------
	public static String getCol(Connection cn, String t) throws Exception {
		String s;
		Statement stmt;
		String sql;
		ResultSet rs;
		s = "";
		stmt = null;
		sql = "select * from " + t + " where 1>2";
		rs = null;
		ResultSetMetaData rsmd = null;
		int i = 0;
		int num = 0;
		String msg;
		try {
			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);
			rsmd = rs.getMetaData();
			num = rsmd.getColumnCount();
			for (i = 1; i <= num; i++)
				s = s + rsmd.getColumnName(i) + ",";

			s = s.substring(0, s.length() - 1);
			s = s.toLowerCase();
			return s;
		} catch (Exception e) {
			msg = "error in getCol(Connection cn, String t)---"
					+ e.getMessage();
			throw new Exception(msg);
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
			DBUtil.close(cn);
		}
	}

	// -------------------------
	public static Map getColTypeClassName(Connection cn, String t)
			throws Exception {
		Map map = new HashMap();
		String sql = null;
		Statement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		try{
		int i = 0;
		int num = 0;
		String className = null;
		String colName = null;
		sql = "select * from " + t + " where 1>2";

		stmt = cn.createStatement();
		rs = stmt.executeQuery(sql);
		rsmd = rs.getMetaData();
		num = rsmd.getColumnCount();
		for (i = 1; i <= num; i++) {
			className = rsmd.getColumnClassName(i);
			colName = rsmd.getColumnName(i);
			map.put(colName, className);
		}// end for
			} catch (Exception e) {
				throw new Exception(e);
			} finally {
				DBUtil.close(rs);
				DBUtil.close(stmt);
				DBUtil.close(cn);
			}
		return map;
	}

	// ----------------
	public static int[] getColTypeFlag(Connection cn, String t, String cols)
			throws Exception {
		int[] arr = null;
		int i = 0;
		int num = 0;
		String sql = null;
		Statement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String colClassName = null;

		String[] arrCol = cols.split(",");
		num = arrCol.length;

		arr = new int[num];

		for (i = 0; i < num; i++) {
			arr[i] = 0;
		}

		sql = "select " + cols + " from " + t + " where 1>2";

		stmt = cn.createStatement();
		rs = stmt.executeQuery(sql);
		rsmd = rs.getMetaData();

		for (i = 0; i < num; i++) {
			colClassName = rsmd.getColumnClassName(i + 1);
			if (colClassName.equals("java.sql.Date")
					|| colClassName.equals("java.sql.Time")
					|| colClassName.equals("java.sql.Timestamp")
					|| colClassName.equals("java.util.Date")) {
				arr[i] = 1;
			}
		}

		return arr;
	}

	// --------------------------
	// --------------2006-08-24

	// -----------------
	public static String getTableColInfoAsHtmlTable(Connection cn, String table)
			throws Exception {
		String s = "";
		String cols = null;
		String titles = null;
		Map map = null;
		List list = null;
		int i = 0;
		int num = 0;

		int colNum = 0;
		int j = 0;

		String key = null;
		String val = null;

		String[] arrCol = null;
		String[] arrTitle = null;

		cols = "catalog_name,schema_name,table_name,column_name,column_type,column_type_name,column_class_name,column_display_size,precision,scale,is_auto_increment,is_nullable";

		cols = "column_name,column_type,column_type_name,column_class_name,column_display_size,precision,scale,is_auto_increment,is_nullable";

		titles = cols + "";

		arrCol = cols.split(",");
		arrTitle = titles.split(",");

		num = arrCol.length;
		if (arrTitle.length != num) {
			throw new Exception("字段与标题数目不匹配");
		}

		list = getTableColInfo(cn, table);

		colNum = list.size();

		for (i = 0; i < colNum; i++) {

			map = (Map) list.get(i);

			s = s + "<tr class=tr" + i % 2 + ">\n";
			s = s + "<td>" + (i + 1) + "</td>\n";

			for (j = 0; j < num; j++) {
				key = arrCol[j];
				val = (String) map.get(key);
				if (val == null) {
					val = "";
				}

				s = s + "<td>" + val + "</td>\n";
			}// end for j

			s = s + "</tr>";

		}// end for i

		String ts = "";

		ts = ts + "<tr class=title>\n<td>NO.</td>\n";

		for (i = 0; i < num; i++) {
			ts = ts + "<td>" + arrTitle[i] + "</td\n>";
		}
		ts = ts + "</tr>\n";

		s = ts + s;

		return s;
	}

	// ----------------

	public static String getTableColInfoAsHtmlTable(String table)
			throws Exception {
		Connection cn = null;
		try {
			cn = DBUtil.getConn();
			return getTableColInfoAsHtmlTable(cn, table);
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
	}

	// -----------------

	public static List getTableColInfo(Connection cn, String table)
			throws Exception {
		List list = new ArrayList();
		Map map = null;
		int i = 0;
		int num = 0;
		String sql = null;
		Statement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;

		sql = "select * from " + table + " where 1>2";

		try {

			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);
			rsmd = rs.getMetaData();
			num = rsmd.getColumnCount();

			for (i = 1; i <= num; i++) {
				map = new HashMap();

				map.put("catalog_name", rsmd.getCatalogName(i));
				map.put("schema_name", rsmd.getSchemaName(i));
				map.put("table_name", rsmd.getTableName(i));
				map.put("column_class_name", rsmd.getColumnClassName(i));
				map.put("column_display_size", rsmd.getColumnDisplaySize(i)
						+ "");
				map.put("column_label", rsmd.getColumnLabel(i));
				map.put("column_name", rsmd.getColumnName(i));
				map.put("column_type", rsmd.getColumnType(i) + "");
				map.put("column_type_name", rsmd.getColumnTypeName(i));

				map.put("precision", rsmd.getPrecision(i) + "");
				map.put("scale", rsmd.getScale(i) + "");
				map.put("is_auto_increment", rsmd.isAutoIncrement(i) + "");
				map.put("is_nullable", rsmd.isNullable(i) + "");

				list.add(map);

			}

			return list;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs, stmt);
		}
	}

	// -----------------
	public static List getResultSetColumnInfo(ResultSet rs) throws Exception {
		if (rs == null) {
			throw new Exception("result set is null");
		}
		List list = new ArrayList();
		Map map = null;
		String col_name = null;

		ResultSetMetaData rsmd = null;
		int i, num = 0;

		try {

			rsmd = rs.getMetaData();

			num = rsmd.getColumnCount();

			for (i = 1; i <= num; i++) {

				col_name = rsmd.getColumnName(i);
				col_name = col_name.toLowerCase();

				map = new HashMap();

				map.put("column_name", col_name);
				map.put("column_class_name", rsmd.getColumnClassName(i));

				map.put("precision", rsmd.getPrecision(i) + "");
				map.put("scale", rsmd.getScale(i) + "");

				list.add(map);

			}

			return list;
		} catch (Exception e) {
			throw new Exception("error when getResultSetColumnInfo," + e);

		}
	}

	public static int[] getResultSetColumnTypes(List columnInfoList)
			throws Exception {
		if (columnInfoList == null) {

			throw new Exception("columnInfoList is null");
		}
		int[] types = null;
		int i, num = 0;
		String columnClassName = null;
		Map map = null;

		num = columnInfoList.size();

		types = new int[num];

		for (i = 0; i < num; i++) {
			map = (Map) columnInfoList.get(i);
			columnClassName = (String) map.get("column_class_name");
			types[i] = getColumnType(columnClassName);
		}

		return types;

	}

	// 0 getString,1 getObject,2 getDate,3 getTimestamp
	public static int getColumnType(String colClassName) {
		int type = 0;

		if (colClassName.equals("java.util.Date")) {
			return 3;
		}
		if (colClassName.equals("java.sql.Date")) {
			return 3;
		}
		if (colClassName.equals("java.sql.Timestamp")) {
			return 3;
		}
		if (colClassName.equals("java.sql.Time")) {
			return 3;
		}

		if (colClassName.equals("java.lang.Number")) {
			return 1;
		}
		if (colClassName.equals("java.math.BigDecimal")) {
			return 1;
		}
		if (colClassName.equals("java.math.BigInteger")) {
			return 1;
		}
		if (colClassName.equals("java.lang.Byte")) {
			return 1;
		}
		if (colClassName.equals("java.lang.Double")) {
			return 1;
		}
		if (colClassName.equals("java.lang.Float")) {
			return 1;
		}
		if (colClassName.equals("java.lang.Integer")) {
			return 1;
		}
		if (colClassName.equals("java.lang.Long")) {
			return 1;
		}
		if (colClassName.equals("java.lang.Short")) {
			return 1;
		}

		return type;
	}

}// end class
