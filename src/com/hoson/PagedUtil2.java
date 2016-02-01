package com.hoson;

import java.util.*;
import java.sql.*;
import java.io.*;

/**
 * 分页查询工具类
 * 
 * 
 * 
 */

public class PagedUtil2 {

	// --------------20060906 page bar
	
	private static int PAGE_SIZE = 15;

	public static Map getPagingInfo(Connection cn, String sql,
			javax.servlet.http.HttpServletRequest req) throws Exception {
		Map map = new HashMap();
		int[] arr = new int[6];

		int page = 0;
		int page_size = 0;
		int page_num = 0;
		int row_num = 0;
		String sql2 = null;
		int max_rows = 0;
		String page_bar = null;
		String page_size_option_values = null;

		sql2 = get_count_sql(sql);
		row_num = get_rs_size(cn, sql2);
		max_rows = get_db_query_max_rows(req);
		if (max_rows > 0 && row_num > max_rows) {
			row_num = max_rows;
		}

		page_size = StringUtil.getInt(req.getParameter("page_size"), PAGE_SIZE);
		page = StringUtil.getInt(req.getParameter("page"), 1);

		page_num = getPageNum(page_size, row_num);
		if (page > page_num) {
			page = page_num;
		}
		if (page == 0) {
			page = 1;
		}

		page_size_option_values = get_page_size_option_values(req);

		arr[0] = page;
		arr[1] = page_size;
		arr[2] = max_rows;

		page_bar = "\n"
				+ getPageBar(page, page_size, row_num, page_size_option_values);

		page_bar = page_bar + "\n"
				+ "<input type=hidden name='db_query_max_rows' value='"
				+ max_rows + "'>\n";
		if (!StringUtil.isempty(page_size_option_values)) {
			page_bar = page_bar
					+ "\n"
					+ "<input type=hidden name='page_size_option_values' value='"
					+ page_size_option_values + "'>\n";
		}

		map.put("page_bar", page_bar);
		map.put("page_info", arr);

		return map;

	}

	public static String get_page_size_option_values(
			javax.servlet.http.HttpServletRequest req) {

		String s = null;
		s = req.getParameter("page_size_option_values");
		if (!StringUtil.isempty(s)) {
			return s;
		}

		// return Config.get_page_size_option_values();
		return "10,15,20";

	}

	public static int get_db_query_max_rows(
			javax.servlet.http.HttpServletRequest req) {

		String s = null;
		int max_rows = 0;
		s = req.getParameter("db_query_max_rows");

		max_rows = StringUtil.getInt(s, 0);
		if (max_rows > 0) {
			return max_rows;
		}

		// return Config.get_db_query_max_rows();
		return 10000;

	}

	public static String get_page_size_option(String page_size_option_values,
			int page_size) {
		String s = null;
		String pages = "10,15,20";
		try {
			if (!StringUtil.isempty(page_size_option_values)) {
				s = JspUtil.getOption(page_size_option_values,
						page_size_option_values, page_size + "");
				return s;
			} else {
				return JspUtil.getOption(pages, pages, page_size + "");
			}
		} catch (Exception e) {
			return "<option>10</option>";
		}

	}

	// -------------20060906 page bar end

	// -----------
	public static int getPageNum(int page_size, int row_num) {
		int page_num = 0;
		if (row_num % page_size == 0) {
			page_num = row_num / page_size;
		} else {
			page_num = row_num / page_size + 1;
		}
		return page_num;
	}

	// ----------------
	public static String getPageBar(int page, int page_size, int row_num)
			throws Exception {
		String pageOption = "";
		String pages = "10,20,30,40,50";
		String s = "";
		int page_num = getPageNum(page_size, row_num);

		pageOption = JspUtil.getOption(pages, pages, page_size + "");
		// s = "&nbsp;&nbsp;共" + row_num +"条记录," + page_num + "页，每页";
		s = "&nbsp;&nbsp;共" + row_num + "行," + page_num + "页&nbsp;&nbsp;";
		// s = s + "\n<select name=page_size onchange=form1.submit()>\n" +
		// pageOption+"</select>条记录 ";
		s = s + getPageUrl(page, page_num);
		s = s + "\n转到<input type=text name=page style='width:36px' value="
				+ page + ">页 \n";
		s = s
				+ "<input type=button value='go' onclick='form1.submit()' class=btn>";
		return s;
	}

	// ----------------------

	// ----------------
	public static String getPageBar(int page, int page_size, int row_num,
			String page_size_option_values) throws Exception {
		String pageOption = "";

		String s = "";
		int page_num = getPageNum(page_size, row_num);

		pageOption = get_page_size_option(page_size_option_values, page_size);

		// s = "&nbsp;&nbsp;共" + row_num +"条记录," + page_num + "页，每页";
		s = "&nbsp;&nbsp;共" + row_num + "行," + page_num + "页&nbsp;&nbsp;";
		s = s + "\n<select name=page_size onchange=form1.submit()>\n"
				+ pageOption + "</select>条记录\n";
		s = s + getPageUrl(page, page_num);
		s = s + " \n转到<input type=text name=page style='width:36px' value="
				+ page + ">页 \n";
		s = s
				+ "<input type=button value='go' onclick='form1.submit()' class=btn>";
		return s;
	}

	// ----------------------

	public static String getPageBar(Connection cn, int page, int page_size,
			String sql) throws Exception {
		String s = null;
		int row_num = 0;
		String sql2 = null;
		sql2 = get_count_sql(sql);
		row_num = get_rs_size(cn, sql2);
		s = getPageBar(page, page_size, row_num);
		return s;
	}

	// ----------------------
	public static String getPageUrl(int page, int page_num) throws Exception {
		String s = "";
		String s1 = "<a href=javascript:f_page_goFirst()>第一页</a> \n<a href=javascript:f_page_goPre()>上一页</a>\n";
		String s2 = "<a href=javascript:f_page_goNext()>下一页</a> \n<a href=javascript:f_page_goLast()>最后页</a>\n";

		// String s1 = "<a
		// href=javascript:f_page_goFirst()>||&lt;&nbsp;&nbsp;</a> <a
		// href=javascript:f_page_goPre()>&lt;&nbsp;&nbsp;</a>\n";
		// String s2 = "<a href=javascript:f_page_goNext()>&gt;&nbsp;&nbsp;</a>
		// <a href=javascript:f_page_goLast()>&gt||</a>\n";

		if (page == 1 && page < page_num) {
			s = s2;
		}
		if (page == 1 && page == page_num) {
			s = "";
		}
		if (page > 1 && page == page_num) {
			s = s1;
		}
		if (page > 1 && page < page_num) {
			s = s1 + " " + s2;
		}
		return s;
	}

	// ------------------

	public static int get_rs_size(Connection cn, String sql) throws Exception {

		int i = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			i = rs.getInt(1);
			return i;
		} catch (Exception e) {
			throw new Exception(e + "," + sql);
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
		}

	}

	// ------------------
	public static int get_rs_size(Connection cn, String sql, Object[] params)
			throws Exception {

		int i = 0;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = cn.prepareStatement(sql);
			DBUtil.setParam(ps, params);
			rs = ps.executeQuery();
			rs.next();
			i = rs.getInt(1);
			return i;
		} catch (Exception e) {

			throw new Exception(e + "," + sql);

		} finally {
			DBUtil.close(rs);
			DBUtil.close(ps);
		}

	}

	// ------------------

	public static String get_count_sql(String sql) throws Exception {
		String sql2 = null;
		sql = sql.replaceAll("\t", " ");
		sql = sql.replaceAll("\r", " ");
		sql = sql.replaceAll("\n", " ");

		sql2 = sql.toLowerCase();

		if (sql2.indexOf(" group ") >= 0) {
			throw new Exception("分页SQL语句中不能包含 group by 子句 ");
		}
		int ipos = 0;
		ipos = sql2.indexOf(" order ");
		if (ipos >= 0) {
			sql = sql.substring(0, ipos);
		}

		sql2 = sql.toLowerCase();
		ipos = sql2.indexOf(" from ");
		if (ipos >= 0) {
			sql = sql.substring(ipos);
			sql = "select count(*) " + sql;
		}
		return sql;
	}

	// ------------------------
	public static String[] query(String sql,
			javax.servlet.http.HttpServletRequest req, int check_box_flag)
			throws Exception {
		Connection cn = null;
		String[] arr = null;
		try {
			cn = DBUtil.getConn(req);
			arr = query(cn, sql, req, check_box_flag);
			return arr;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
	}

	// ------------------------
	public static String[] query(Connection cn, String sql,
			javax.servlet.http.HttpServletRequest req, int check_box_flag)
			throws Exception {

		// Connection cn = null;
		Statement stmt = null;
		ResultSet rs = null;
		StringBuffer s = new StringBuffer();

		int page = 0;
		int page_size = 0;
		int page_num = 0;
		int num = 0;

		int count = 0;
		// cn = DBUtil.getConn(req);

		try {
			String sql2 = get_count_sql(sql);
			count = get_rs_size(cn, sql2);
			try {
				page_size = Integer.parseInt(req.getParameter("page_size"));
			} catch (Exception e) {
				page_size = 10;
			}
			try {
				page = Integer.parseInt(req.getParameter("page"));
			} catch (Exception e) {
				page = 1;
			}

			page_num = getPageNum(page_size, count);
			if (page > page_num) {
				page = page_num;
			}
			if (page == 0) {
				page = 1;
			}

			String s2 = null;
			String style = null;
			String objectid = null;
			int pos = (page - 1) * page_size;

			// num = f.length;
			int i = 0;
			int j = 0;
			int iskip = 0;
			int startIndex = 0;

			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);
			ResultSetMetaData rsmd = null;
			rsmd = rs.getMetaData();
			num = rsmd.getColumnCount();

			while ((rs.next()) && (j < page_size)) {

				if (iskip < pos) {
					iskip++;
					continue;
				}

				style = "tr" + j % 2;
				s.append("<tr ").append(" class=").append(style).append(">\n");

				if (check_box_flag > 0) {
					objectid = rs.getString(1);
					if (objectid == null) {
						objectid = "";
					}
					s.append("<td align=center>").append(
							"<input type=checkbox name=objectid value='")
							.append(objectid).append("'></td>\n");
				}

				if (check_box_flag > 0) {
					startIndex = 1;
				} else {
					startIndex = 0;
				}

				for (i = startIndex; i < num; i++) {
					s.append("<td>");
					s2 = rs.getString(i + 1);
					if (s2 != null) {
						s.append(s2);
					}
					s.append("</td>\n");
				}
				s.append("</tr>\n");
				j++;
			}// end while

			// -------------- page toolbar ----------------
			String[] arr = new String[2];
			String pageBar = getPageBar(page, page_size, count);
			arr[0] = s.toString();
			arr[1] = pageBar;
			return arr;
		} catch (Exception e) {

			throw new Exception(e + "," + sql);

		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
		}
	}

	// --------------------------
	public static String[] query(Connection cn, String sql, int page_size,
			javax.servlet.http.HttpServletRequest req, int check_box_flag)
			throws Exception {

		// Connection cn = null;
		Statement stmt = null;
		ResultSet rs = null;
		StringBuffer s = new StringBuffer();
		if (page_size < 5) {
			page_size = 5;
		}

		int page = 0;
		// int page_size = 0;
		int page_num = 0;
		int num = 0;

		int count = 0;
		// cn = DBUtil.getConn(req);

		try {
			String sql2 = get_count_sql(sql);
			count = get_rs_size(cn, sql2);
			// try{page_size =
			// Integer.parseInt(req.getParameter("page_size"));}catch(Exception
			// e){page_size = 10;}
			// try{page =
			// Integer.parseInt(req.getParameter("page"));}catch(Exception
			// e){page = 1;}

			page = JspUtil.getInt(req, "page", 1);

			page_num = getPageNum(page_size, count);
			if (page > page_num) {
				page = page_num;
			}
			if (page == 0) {
				page = 1;
			}

			String s2 = null;
			String style = null;
			String objectid = null;
			int pos = (page - 1) * page_size;

			// num = f.length;
			int i = 0;
			int j = 0;
			int iskip = 0;
			int startIndex = 0;

			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);
			ResultSetMetaData rsmd = null;
			rsmd = rs.getMetaData();
			num = rsmd.getColumnCount();

			while ((rs.next()) && (j < page_size)) {

				if (iskip < pos) {
					iskip++;
					continue;
				}

				style = "tr" + j % 2;
				s.append("<tr ").append(" class=").append(style).append(">\n");

				if (check_box_flag > 0) {
					objectid = rs.getString(1);
					if (objectid == null) {
						objectid = "";
					}
					s.append("<td align=center>").append(
							"<input type=checkbox name=objectid value='")
							.append(objectid).append("'></td>\n");
				}

				if (check_box_flag > 0) {
					startIndex = 1;
				} else {
					startIndex = 0;
				}

				for (i = startIndex; i < num; i++) {
					s.append("<td>");
					s2 = rs.getString(i + 1);
					if (s2 != null) {
						s.append(s2);
					}
					s.append("</td>\n");
				}
				s.append("</tr>\n");
				j++;
			}// end while

			// -------------- page toolbar ----------------
			String[] arr = new String[2];
			String pageBar = getPageBar(page, page_size, count);
			arr[0] = s.toString();
			arr[1] = pageBar;
			return arr;
		} catch (Exception e) {

			throw new Exception(e + "," + sql);

		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
		}
	}

	// --------------------------
	public static String[] query(String sql, int page_size,
			javax.servlet.http.HttpServletRequest req, int check_box_flag)
			throws Exception {
		Connection cn = null;
		try {
			return query(cn, sql, page_size, req, check_box_flag);
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
	}

	// ------------------------
	public static String[] query(Connection cn, String sql, int pkNum,
			String colSep, javax.servlet.http.HttpServletRequest req,
			int check_box_flag) throws Exception {

		// Connection cn = null;
		Statement stmt = null;
		ResultSet rs = null;
		StringBuffer s = new StringBuffer();

		int page = 0;
		int page_size = 0;
		int page_num = 0;
		int num = 0;

		int count = 0;
		// cn = DBUtil.getConn(req);

		try {
			String sql2 = get_count_sql(sql);
			count = get_rs_size(cn, sql2);
			try {
				page_size = Integer.parseInt(req.getParameter("page_size"));
			} catch (Exception e) {
				page_size = 10;
			}
			try {
				page = Integer.parseInt(req.getParameter("page"));
			} catch (Exception e) {
				page = 1;
			}

			page_num = getPageNum(page_size, count);
			if (page > page_num) {
				page = page_num;
			}
			if (page == 0) {
				page = 1;
			}

			String s2 = null;
			String style = null;
			String objectid = null;
			int pos = (page - 1) * page_size;

			// num = f.length;
			int i = 0;
			int j = 0;
			int iskip = 0;
			int startIndex = 0;
			int ipk = 0;

			String pkv = null;

			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);
			ResultSetMetaData rsmd = null;
			rsmd = rs.getMetaData();
			num = rsmd.getColumnCount();

			while ((rs.next()) && (j < page_size)) {

				if (iskip < pos) {
					iskip++;
					continue;
				}

				style = "tr" + j % 2;
				s.append("<tr ").append(" class=").append(style).append(">\n");

				// objectid = rs.getString(1);
				objectid = "";
				for (ipk = 1; ipk <= pkNum; ipk++) {
					pkv = rs.getString(ipk);
					if (pkv == null) {
						pkv = " ";
					}
					if (ipk < pkNum) {
						objectid = objectid + pkv + colSep;
					} else {
						objectid = objectid + pkv;
					}
				}

				// if(objectid==null){objectid="";}
				s.append("<td align=center>").append(
						"<input type=checkbox name=objectid value='").append(
						objectid).append("'></td>\n");

				// if(check_box_flag>0){startIndex=1+pkNum;}else{startIndex=pkNum;}

				for (i = pkNum; i < num; i++) {
					s.append("<td>");
					s2 = rs.getString(i + 1);
					if (s2 != null) {
						s.append(s2);
					}
					s.append("</td>\n");
				}
				s.append("</tr>\n");
				j++;
			}// end while

			// -------------- page toolbar ----------------
			String[] arr = new String[2];
			String pageBar = getPageBar(page, page_size, count);
			arr[0] = s.toString();
			arr[1] = pageBar;
			return arr;
		} catch (Exception e) {

			throw new Exception(e + "," + sql);

		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
		}
	}

	// --------------------------

	// ------------------------
	public static String[] query(String sql, Object[] params,
			javax.servlet.http.HttpServletRequest req, int check_box_flag)
			throws Exception {
		Connection cn = null;
		String[] arr = null;
		try {
			cn = DBUtil.getConn(req);
			arr = query(cn, sql, params, req, check_box_flag);
			return arr;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
	}

	// ------------------------
	public static String[] query(Connection cn, String sql, Object[] params,
			javax.servlet.http.HttpServletRequest req, int check_box_flag)
			throws Exception {

		// Connection cn = null;
		// Statement stmt = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		StringBuffer s = new StringBuffer();

		int page = 0;
		int page_size = 0;
		int page_num = 0;
		int num = 0;

		int count = 0;
		// cn = DBUtil.getConn(req);
		try {
			String sql2 = get_count_sql(sql);
			count = get_rs_size(cn, sql2, params);
			try {
				page_size = Integer.parseInt(req.getParameter("page_size"));
			} catch (Exception e) {
				page_size = 10;
			}
			try {
				page = Integer.parseInt(req.getParameter("page"));
			} catch (Exception e) {
				page = 1;
			}

			page_num = getPageNum(page_size, count);
			if (page > page_num) {
				page = page_num;
			}
			if (page == 0) {
				page = 1;
			}

			String s2 = null;
			String style = null;
			String objectid = null;
			int pos = (page - 1) * page_size;

			// num = f.length;
			int i = 0;
			int j = 0;
			int iskip = 0;
			int startIndex = 0;

			ps = cn.prepareStatement(sql);
			DBUtil.setParam(ps, params);
			rs = ps.executeQuery();
			ResultSetMetaData rsmd = null;
			rsmd = rs.getMetaData();
			num = rsmd.getColumnCount();

			while ((rs.next()) && (j < page_size)) {

				if (iskip < pos) {
					iskip++;
					continue;
				}

				style = "tr" + j % 2;
				s.append("<tr ").append(" class=").append(style).append(">\n");

				if (check_box_flag > 0) {
					objectid = rs.getString(1);
					if (objectid == null) {
						objectid = "";
					}
					s.append("<td align=center>").append(
							"<input type=checkbox name=objectid value='")
							.append(objectid).append("'></td>\n");
				}

				if (check_box_flag > 0) {
					startIndex = 1;
				} else {
					startIndex = 0;
				}

				for (i = startIndex; i < num; i++) {
					s.append("<td>");
					s2 = rs.getString(i + 1);
					if (s2 != null) {
						s.append(s2);
					}
					s.append("</td>\n");
				}
				s.append("</tr>\n");
				j++;
			}// end while

			// -------------- page toolbar ----------------
			String[] arr = new String[2];
			String pageBar = getPageBar(page, page_size, count);
			arr[0] = s.toString();
			arr[1] = pageBar;
			return arr;
		} catch (Exception e) {
			throw new Exception(e + "," + sql);
		} finally {
			DBUtil.close(rs);
			DBUtil.close(ps);
		}
	}

	// ------------------------
	public static String[] queryAsObject(Connection cn, String sql,
			javax.servlet.http.HttpServletRequest req, int check_box_flag)
			throws Exception {

		// Connection cn = null;
		Statement stmt = null;
		ResultSet rs = null;
		StringBuffer s = new StringBuffer();

		int page = 0;
		int page_size = 0;
		int page_num = 0;
		int num = 0;

		int count = 0;
		// cn = DBUtil.getConn(req);
		try {
			String sql2 = get_count_sql(sql);
			count = get_rs_size(cn, sql2);
			try {
				page_size = Integer.parseInt(req.getParameter("page_size"));
			} catch (Exception e) {
				page_size = 10;
			}
			try {
				page = Integer.parseInt(req.getParameter("page"));
			} catch (Exception e) {
				page = 1;
			}

			page_num = getPageNum(page_size, count);
			if (page > page_num) {
				page = page_num;
			}
			if (page == 0) {
				page = 1;
			}

			String s2 = null;
			String style = null;
			String objectid = null;
			int pos = (page - 1) * page_size;
			int i = 0;
			int j = 0;
			int iskip = 0;
			int startIndex = 0;
			Object obj_v = null;

			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);
			ResultSetMetaData rsmd = null;
			rsmd = rs.getMetaData();
			num = rsmd.getColumnCount();

			while ((rs.next()) && (j < page_size)) {

				if (iskip < pos) {
					iskip++;
					continue;
				}

				style = "tr" + j % 2;
				s.append("<tr ").append(" class=").append(style).append(">\n");

				if (check_box_flag > 0) {
					objectid = rs.getString(1);
					if (objectid == null) {
						objectid = "";
					}
					s.append("<td align=center>").append(
							"<input type=checkbox name=objectid value='")
							.append(objectid).append("'></td>\n");
				}

				if (check_box_flag > 0) {
					startIndex = 1;
				} else {
					startIndex = 0;
				}

				for (i = startIndex; i < num; i++) {
					s.append("<td>");
					obj_v = rs.getObject(i + 1);
					if (obj_v != null) {
						s.append(obj_v + "");
					}
					s.append("</td>\n");
				}
				s.append("</tr>\n");
				j++;
			}// end while

			// -------------- page toolbar ----------------
			String[] arr = new String[2];
			String pageBar = getPageBar(page, page_size, count);
			arr[0] = s.toString();
			arr[1] = pageBar;
			return arr;
		} catch (Exception e) {

			throw new Exception(e + "," + sql);

		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
		}
	}

	// --------------------------
	public static String[] queryAsObject(Connection cn, String sql,
			Object[] params, javax.servlet.http.HttpServletRequest req,
			int check_box_flag) throws Exception {

		// Connection cn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		StringBuffer s = new StringBuffer();

		int page = 0;
		int page_size = 0;
		int page_num = 0;
		int num = 0;

		int count = 0;
		// cn = DBUtil.getConn(req);
		try {
			String sql2 = get_count_sql(sql);
			count = get_rs_size(cn, sql2, params);
			try {
				page_size = Integer.parseInt(req.getParameter("page_size"));
			} catch (Exception e) {
				page_size = 10;
			}
			try {
				page = Integer.parseInt(req.getParameter("page"));
			} catch (Exception e) {
				page = 1;
			}

			page_num = getPageNum(page_size, count);
			if (page > page_num) {
				page = page_num;
			}
			if (page == 0) {
				page = 1;
			}

			String s2 = null;
			String style = null;
			String objectid = null;
			int pos = (page - 1) * page_size;

			int i = 0;
			int j = 0;
			int iskip = 0;
			int startIndex = 0;
			Object obj_v = null;

			ps = cn.prepareStatement(sql);
			DBUtil.setParam(ps, params);
			rs = ps.executeQuery();
			ResultSetMetaData rsmd = null;
			rsmd = rs.getMetaData();
			num = rsmd.getColumnCount();

			while ((rs.next()) && (j < page_size)) {

				if (iskip < pos) {
					iskip++;
					continue;
				}

				style = "tr" + j % 2;
				s.append("<tr ").append(" class=").append(style).append(">\n");

				if (check_box_flag > 0) {
					objectid = rs.getString(1);
					if (objectid == null) {
						objectid = "";
					}
					s.append("<td align=center>").append(
							"<input type=checkbox name=objectid value='")
							.append(objectid).append("'></td>\n");
				}

				if (check_box_flag > 0) {
					startIndex = 1;
				} else {
					startIndex = 0;
				}

				for (i = startIndex; i < num; i++) {
					s.append("<td>");
					obj_v = rs.getObject(i + 1);
					if (obj_v != null) {
						s.append(obj_v + "");
					}
					s.append("</td>\n");
				}
				s.append("</tr>\n");
				j++;
			}// end while

			// -------------- page toolbar ----------------
			String[] arr = new String[2];
			String pageBar = getPageBar(page, page_size, count);
			arr[0] = s.toString();
			arr[1] = pageBar;
			return arr;
		} catch (Exception e) {

			throw new Exception(e + "," + sql);

		} finally {
			DBUtil.close(rs);
			DBUtil.close(ps);
		}
	}

	// --------------------------
	// -------------2006-05-09
	// ------------------------
	public static Object[] queryList(Connection cn, String sql, String fields,
			javax.servlet.http.HttpServletRequest req) throws Exception {

		List list = new ArrayList();
		Map mapRow = null;
		Statement stmt = null;
		ResultSet rs = null;
		StringBuffer s = new StringBuffer();

		int page = 0;
		int page_size = 0;
		int page_num = 0;
		int num = 0;

		int count = 0;
		// cn = DBUtil.getConn(req);

		try {
			String sql2 = get_count_sql(sql);
			count = get_rs_size(cn, sql2);
			try {
				page_size = Integer.parseInt(req.getParameter("page_size"));
			} catch (Exception e) {
				page_size = 10;
			}
			try {
				page = Integer.parseInt(req.getParameter("page"));
			} catch (Exception e) {
				page = 1;
			}

			page_num = getPageNum(page_size, count);
			if (page > page_num) {
				page = page_num;
			}
			if (page == 0) {
				page = 1;
			}

			String s2 = null;
			String style = null;
			String objectid = null;
			int pos = (page - 1) * page_size;
			String[] f = fields.split(",");
			num = f.length;
			int i = 0;
			int j = 0;
			int iskip = 0;
			int startIndex = 0;

			String v = null;

			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);
			while ((rs.next()) && (j < page_size)) {
				if (iskip < pos) {
					iskip++;
					continue;
				}
				mapRow = new HashMap();
				for (i = 0; i < num; i++) {
					v = rs.getString(i + 1);
					if (v == null) {
						v = "";
					}
					mapRow.put(f[i], v);
				}
				list.add(mapRow);
				j++;
			}// end while

			// -------------- page toolbar ----------------
			Object[] arr = new Object[2];
			String pageBar = getPageBar(page, page_size, count);
			arr[0] = list;
			arr[1] = pageBar;
			return arr;
		} catch (Exception e) {

			throw new Exception(e + "," + sql);

		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
		}
	}

	// --------------------------
	public static Object[] queryList(String sql, String fields,
			javax.servlet.http.HttpServletRequest req) throws Exception {
		Connection cn = null;
		Object[] arr = null;
		try {
			cn = DBUtil.getConn(req);
			arr = queryList(cn, sql, fields, req);
			return arr;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}

	}

	// --------------------
	// -----------------------for sql query-------------
	// ------------------------
	public static String[] query(Connection cn, String sql,
			javax.servlet.http.HttpServletRequest req) throws Exception {

		// Connection cn = null;
		Statement stmt = null;
		ResultSet rs = null;
		StringBuffer s = new StringBuffer();
		String title = "";
		String colName = null;
		int check_box_flag = 0;

		int page = 0;
		int page_size = 0;
		int page_num = 0;
		int num = 0;

		int count = 0;
		// cn = DBUtil.getConn(req);

		try {
			String sql2 = get_count_sql(sql);
			count = get_rs_size(cn, sql2);
			try {
				page_size = Integer.parseInt(req.getParameter("page_size"));
			} catch (Exception e) {
				page_size = 10;
			}
			try {
				page = Integer.parseInt(req.getParameter("page"));
			} catch (Exception e) {
				page = 1;
			}

			page_num = getPageNum(page_size, count);
			if (page > page_num) {
				page = page_num;
			}
			if (page == 0) {
				page = 1;
			}

			String s2 = null;
			String style = null;
			String objectid = null;
			int pos = (page - 1) * page_size;

			// num = f.length;
			int i = 0;
			int j = 0;
			int iskip = 0;
			int startIndex = 0;

			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);
			ResultSetMetaData rsmd = null;
			rsmd = rs.getMetaData();
			num = rsmd.getColumnCount();

			for (i = 1; i <= num; i++) {
				title = title + "<td>" + rsmd.getColumnName(i) + "</td>\n";
			}
			title = title.toLowerCase();
			title = "<tr class=title>" + title + "</tr>\n";

			while ((rs.next()) && (j < page_size)) {

				if (iskip < pos) {
					iskip++;
					continue;
				}

				style = "tr" + j % 2;
				s.append("<tr ").append(" class=").append(style).append(">\n");

				if (check_box_flag > 0) {
					objectid = rs.getString(1);
					if (objectid == null) {
						objectid = "";
					}
					s.append("<td align=center>").append(
							"<input type=checkbox name=objectid value='")
							.append(objectid).append("'></td>\n");
				}

				if (check_box_flag > 0) {
					startIndex = 1;
				} else {
					startIndex = 0;
				}

				for (i = startIndex; i < num; i++) {
					s.append("<td>");
					s2 = rs.getString(i + 1);
					if (s2 != null) {
						s.append(s2);
					}
					s.append("</td>\n");
				}
				s.append("</tr>\n");
				j++;
			}// end while

			// -------------- page toolbar ----------------
			String[] arr = new String[2];
			String pageBar = getPageBar(page, page_size, count);
			arr[0] = title + s.toString();
			arr[1] = pageBar;
			return arr;
		} catch (Exception e) {

			throw new Exception(e + "," + sql);

		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
		}
	}

	// --------------------------

	// ------------------no paging----

	public static String queryNoPaging(Connection cn, String sql)
			throws Exception {

		Statement stmt = null;
		ResultSet rs = null;
		StringBuffer s = new StringBuffer();
		ResultSetMetaData rsmd = null;
		int i = 0;
		int num = 0;
		String v = null;
		int irow = 0;
		try {
			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);
			rsmd = rs.getMetaData();
			num = rsmd.getColumnCount();

			while (rs.next()) {
				s.append("<tr ").append(" class=tr").append(irow % 2).append(
						">\n");
				for (i = 1; i <= num; i++) {
					s.append("<td>");
					v = rs.getString(i);
					if (v != null) {
						s.append(v);
					}
					s.append("</td>\n");
				}
				s.append("</tr>\n");
				irow++;
			}// end while
			return s.toString();
		} catch (Exception e) {

			throw new Exception(e + "," + sql);

		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
		}
	}

	// ------------------------------
	public static String queryNoPaging(String sql,
			javax.servlet.http.HttpServletRequest req) throws Exception {
		Connection cn = null;
		try {
			cn = DBUtil.getConn(req);
			return queryNoPaging(cn, sql);
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
	}

	// ------------------------------
	// -------------------------0525-----maxRows----

	// ------------------------

	public static String[] queryWithMaxRows(Connection cn, String sql,
			int maxRows, javax.servlet.http.HttpServletRequest req,
			int check_box_flag) throws Exception {

		// Connection cn = null;
		Statement stmt = null;
		ResultSet rs = null;
		StringBuffer s = new StringBuffer();

		int page = 0;
		int page_size = 0;
		int page_num = 0;
		int num = 0;

		int count = 0;
		// cn = DBUtil.getConn(req);

		try {
			String sql2 = get_count_sql(sql);
			count = get_rs_size(cn, sql2);
			try {
				page_size = Integer.parseInt(req.getParameter("page_size"));
			} catch (Exception e) {
				page_size = 10;
			}
			try {
				page = Integer.parseInt(req.getParameter("page"));
			} catch (Exception e) {
				page = 1;
			}

			page_num = getPageNum(page_size, count);
			if (page > page_num) {
				page = page_num;
			}
			if (page == 0) {
				page = 1;
			}

			String s2 = null;
			String style = null;
			String objectid = null;
			int pos = (page - 1) * page_size;

			// num = f.length;
			int i = 0;
			int j = 0;
			int iskip = 0;
			int startIndex = 0;

			stmt = cn.createStatement();
			stmt.setMaxRows(maxRows);
			rs = stmt.executeQuery(sql);
			ResultSetMetaData rsmd = null;
			rsmd = rs.getMetaData();
			num = rsmd.getColumnCount();

			while ((rs.next()) && (j < page_size)) {

				if (iskip < pos) {
					iskip++;
					continue;
				}

				style = "tr" + j % 2;
				s.append("<tr ").append(" class=").append(style).append(">\n");

				if (check_box_flag > 0) {
					objectid = rs.getString(1);
					if (objectid == null) {
						objectid = "";
					}
					s.append("<td align=center>").append(
							"<input type=checkbox name=objectid value='")
							.append(objectid).append("'></td>\n");
				}

				if (check_box_flag > 0) {
					startIndex = 1;
				} else {
					startIndex = 0;
				}

				for (i = startIndex; i < num; i++) {
					s.append("<td>");
					s2 = rs.getString(i + 1);
					if (s2 != null) {
						s.append(s2);
					}
					s.append("</td>\n");
				}
				s.append("</tr>\n");
				j++;
			}// end while

			// -------------- page toolbar ----------------
			String[] arr = new String[2];
			String pageBar = getPageBar(page, page_size, count);
			arr[0] = s.toString();
			arr[1] = pageBar;
			return arr;
		} catch (Exception e) {

			throw new Exception(e + "," + sql);
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
		}
	}

	// --------------------------
	public static String[] queryWithMaxRows(String sql, int maxRows,
			javax.servlet.http.HttpServletRequest req, int check_box_flag)
			throws Exception {
		Connection cn = null;
		try {
			cn = DBUtil.getConn(req);
			return query(cn, sql, maxRows, req, check_box_flag);
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
	}

	// ---------------------

	// -------------------------------060605---------

	// ------------------------
	public static String[] queryWithCheckBox(Connection cn, String sql,
			int pkNum, String colSep, javax.servlet.http.HttpServletRequest req)
			throws Exception {

		// Connection cn = null;
		Statement stmt = null;
		ResultSet rs = null;
		StringBuffer s = new StringBuffer();

		int page = 0;
		int page_size = 0;
		int page_num = 0;
		int num = 0;

		int count = 0;
		// cn = DBUtil.getConn(req);

		try {
			String sql2 = get_count_sql(sql);
			count = get_rs_size(cn, sql2);
			try {
				page_size = Integer.parseInt(req.getParameter("page_size"));
			} catch (Exception e) {
				page_size = 10;
			}
			try {
				page = Integer.parseInt(req.getParameter("page"));
			} catch (Exception e) {
				page = 1;
			}

			page_num = getPageNum(page_size, count);
			if (page > page_num) {
				page = page_num;
			}
			if (page == 0) {
				page = 1;
			}

			String s2 = null;
			String style = null;
			String objectid = null;
			int pos = (page - 1) * page_size;

			// num = f.length;
			int i = 0;
			int j = 0;
			int iskip = 0;
			int startIndex = 0;
			int ipk = 0;

			String pkv = null;

			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);
			ResultSetMetaData rsmd = null;
			rsmd = rs.getMetaData();
			num = rsmd.getColumnCount();

			while ((rs.next()) && (j < page_size)) {

				if (iskip < pos) {
					iskip++;
					continue;
				}

				style = "tr" + j % 2;
				s.append("<tr ").append(" class=").append(style).append(">\n");

				// objectid = rs.getString(1);
				objectid = "";
				for (ipk = 1; ipk <= pkNum; ipk++) {
					pkv = rs.getString(ipk);
					if (pkv == null) {
						pkv = " ";
					}
					if (ipk < pkNum) {
						objectid = objectid + pkv + colSep;
					} else {
						objectid = objectid + pkv;
					}
				}

				// if(objectid==null){objectid="";}
				s.append("<td align=center>").append(
						"<input type=checkbox name=objectid value='").append(
						objectid).append("'></td>\n");

				// if(check_box_flag>0){startIndex=1+pkNum;}else{startIndex=pkNum;}

				for (i = pkNum; i < num; i++) {
					s.append("<td>");
					s2 = rs.getString(i + 1);

					// s2 = getValueStr(s2);

					if (s2 != null) {
						s.append(s2);
					}
					s.append("</td>\n");
				}
				s.append("</tr>\n");
				j++;
			}// end while

			// -------------- page toolbar ----------------
			String[] arr = new String[2];
			String pageBar = getPageBar(page, page_size, count);
			arr[0] = s.toString();
			arr[1] = pageBar;
			return arr;
		} catch (Exception e) {
			throw new Exception(e + "," + sql);
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
		}
	}

	// --------------------------
	public static String[] queryWithoutCheckBox(Connection cn, String sql,
			int pkNum, String colSep, javax.servlet.http.HttpServletRequest req)
			throws Exception {

		// Connection cn = null;
		Statement stmt = null;
		ResultSet rs = null;
		StringBuffer s = new StringBuffer();

		int page = 0;
		int page_size = 0;
		int page_num = 0;
		int num = 0;

		int count = 0;
		// cn = DBUtil.getConn(req);

		try {
			String sql2 = get_count_sql(sql);
			count = get_rs_size(cn, sql2);
			try {
				page_size = Integer.parseInt(req.getParameter("page_size"));
			} catch (Exception e) {
				page_size = 10;
			}
			try {
				page = Integer.parseInt(req.getParameter("page"));
			} catch (Exception e) {
				page = 1;
			}

			page_num = getPageNum(page_size, count);
			if (page > page_num) {
				page = page_num;
			}
			if (page == 0) {
				page = 1;
			}

			String s2 = null;
			String style = null;
			String objectid = null;
			int pos = (page - 1) * page_size;

			// num = f.length;
			int i = 0;
			int j = 0;
			int iskip = 0;
			int startIndex = 0;
			int ipk = 0;

			String pkv = null;

			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);
			ResultSetMetaData rsmd = null;
			rsmd = rs.getMetaData();
			num = rsmd.getColumnCount();

			while ((rs.next()) && (j < page_size)) {

				if (iskip < pos) {
					iskip++;
					continue;
				}

				style = "tr" + j % 2;
				s.append("<tr ").append(" class=").append(style).append(">\n");

				// objectid = rs.getString(1);
				objectid = "";
				for (ipk = 1; ipk <= pkNum; ipk++) {
					pkv = rs.getString(ipk);
					if (pkv == null) {
						pkv = " ";
					}
					if (ipk < pkNum) {
						objectid = objectid + pkv + colSep;
					} else {
						objectid = objectid + pkv;
					}
				}

				// if(objectid==null){objectid="";}
				s.append("<td>").append(objectid).append("</td>\n");

				// if(check_box_flag>0){startIndex=1+pkNum;}else{startIndex=pkNum;}

				for (i = pkNum; i < num; i++) {
					s.append("<td>");
					s2 = rs.getString(i + 1);

					// s2 = getValueStr(s2);

					if (s2 != null) {
						s.append(s2);
					}
					s.append("</td>\n");
				}
				s.append("</tr>\n");
				j++;
			}// end while

			// -------------- page toolbar ----------------
			String[] arr = new String[2];
			String pageBar = getPageBar(page, page_size, count);
			arr[0] = s.toString();
			arr[1] = pageBar;
			return arr;
		} catch (Exception e) {
			throw new Exception(e + "," + sql);
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
		}
	}

	// --------------------------

	public static String[] query(Connection cn, String sql, int pkNum,
			String colSep, int check_box_flag,
			javax.servlet.http.HttpServletRequest req) throws Exception {

		if (check_box_flag > 0) {
			return queryWithCheckBox(cn, sql, pkNum, colSep, req);
		} else {
			return queryWithoutCheckBox(cn, sql, pkNum, colSep, req);
		}
	}

	// ------------------------
	public static String[] query(String sql, int pkNum, String colSep,
			int check_box_flag, javax.servlet.http.HttpServletRequest req)
			throws Exception {

		Connection cn = null;
		try {
			cn = DBUtil.getConn(req);
			return query(cn, sql, pkNum, colSep, check_box_flag, req);
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
	}

	// ------------------------
	// --------------------return list------------

	public static Object[] query(Connection cn, String sql, int pkNum,
			String colSep, javax.servlet.http.HttpServletRequest req)
			throws Exception {

		Statement stmt = null;
		ResultSet rs = null;

		int page = 0;
		int page_size = 0;
		int page_num = 0;
		int num = 0;

		int count = 0;

		String[] arrColName = null;
		Map map = null;
		List list = new ArrayList();
		String v = null;
		try {
			String sql2 = get_count_sql(sql);
			count = get_rs_size(cn, sql2);
			try {
				page_size = Integer.parseInt(req.getParameter("page_size"));
			} catch (Exception e) {
				page_size = 10;
			}
			try {
				page = Integer.parseInt(req.getParameter("page"));
			} catch (Exception e) {
				page = 1;
			}

			page_num = getPageNum(page_size, count);
			if (page > page_num) {
				page = page_num;
			}
			if (page == 0) {
				page = 1;
			}

			String s2 = null;
			String style = null;
			String objectid = null;
			int pos = (page - 1) * page_size;

			int i = 0;
			int j = 0;
			int iskip = 0;
			int startIndex = 0;
			int ipk = 0;

			String pkv = null;

			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);
			ResultSetMetaData rsmd = null;
			rsmd = rs.getMetaData();
			num = rsmd.getColumnCount();
			arrColName = new String[num];

			for (i = 1; i <= num; i++) {
				arrColName[i - 1] = rsmd.getColumnName(i).toLowerCase();
			}

			while ((rs.next()) && (j < page_size)) {

				if (iskip < pos) {
					iskip++;
					continue;
				}

				objectid = "";
				for (ipk = 1; ipk <= pkNum; ipk++) {
					pkv = rs.getString(ipk);
					if (pkv == null) {
						pkv = " ";
					}
					if (ipk < pkNum) {
						objectid = objectid + pkv + colSep;
					} else {
						objectid = objectid + pkv;
					}
				}

				map = new HashMap();
				map.put("objectid", objectid);

				for (i = pkNum; i < num; i++) {
					v = rs.getString(i + 1);
					if (v == null) {
						v = "";
					}
					map.put(arrColName[i], v);
				}

				j++;
				list.add(map);
			}// end while

			// -------------- page toolbar ----------------
			Object[] arr = new Object[2];
			String pageBar = getPageBar(page, page_size, count);
			arr[0] = list;
			arr[1] = pageBar;
			return arr;
		} catch (Exception e) {
			throw new Exception(e + "," + sql);
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
		}
	}

	// -------------------------------
	public static Object[] query(String sql, int pkNum, String colSep,
			javax.servlet.http.HttpServletRequest req) throws Exception {
		Connection cn = null;
		try {
			cn = DBUtil.getConn(req);
			return query(cn, sql, pkNum, colSep, req);
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
	}

	// ------------------------------
	// -------------20060906------

	/**
	 * 返回分页工具条和数据表格，均为字符串类型<br>
	 * page,page_size及记录集最大行限制db_query_max_rows参数从request中获取<br>
	 * cn 数据库连接<br>
	 * sql 查询语句<br>
	 * pkNum 主键列数<br>
	 * colSep 主键列值分割符<br>
	 * check_box_flag 是否显示checkbox复选框 0 不显示 1显示<br>
	 * String page_bar = (String)map.get("page_bar");<br>
	 * String data = (String)map.get("data");<br>
	 */

	public static Map queryString(Connection cn, String sql, int pkNum,
			String colSep, int check_box_flag,
			javax.servlet.http.HttpServletRequest req) throws Exception {

		Map map = new HashMap();
		Map pageMap = null;
		int[] arr = null;
		int page = 0;
		int page_size = 0;
		int max_rows = 0;
		int skip = 0;

		Statement stmt = null;
		ResultSet rs = null;
		String data = null;
		String page_bar = null;

		try {

			pageMap = getPagingInfo(cn, sql, req);
			arr = (int[]) pageMap.get("page_info");
			page = arr[0];
			page_size = arr[1];
			max_rows = arr[2];
			skip = (page - 1) * page_size;

			stmt = cn.createStatement();
			if (max_rows > 0) {
				stmt.setMaxRows(max_rows);
			}
			rs = stmt.executeQuery(sql);
			data = rs2table(rs, skip, page_size, pkNum, colSep, check_box_flag);
			page_bar = (String) pageMap.get("page_bar");
			map.put("data", data);
			map.put("page_bar", page_bar);

			return map;
		} catch (Exception e) {
			throw new Exception(e + "," + sql);
		} finally {
			DBUtil.close(rs, stmt, null);
		}

	}

	// -------------------------------------
	public static Map queryString(Connection cn, String sql, int pkNum,
			int check_box_flag, javax.servlet.http.HttpServletRequest req)
			throws Exception {

		return queryString(cn, sql, pkNum, ";", check_box_flag, req);

	}

	// -----------------

	public static Map queryStringWithUrl(Connection cn, String sql, int pkNum,
			String colSep, int url_flag, String jsfunc,
			javax.servlet.http.HttpServletRequest req) throws Exception {

		Map map = new HashMap();
		Map pageMap = null;
		int[] arr = null;
		int page = 0;
		int page_size = 0;
		int max_rows = 0;
		int skip = 0;

		Statement stmt = null;
		ResultSet rs = null;
		String data = null;
		String page_bar = null;

		try {

			pageMap = getPagingInfo(cn, sql, req);
			arr = (int[]) pageMap.get("page_info");
			page = arr[0];
			page_size = arr[1];
			max_rows = arr[2];
			skip = (page - 1) * page_size;

			stmt = cn.createStatement();
			if (max_rows > 0) {
				stmt.setMaxRows(max_rows);
			}
			rs = stmt.executeQuery(sql);
			data = rs2table(rs, skip, page_size, pkNum, colSep, url_flag,
					jsfunc);
			page_bar = (String) pageMap.get("page_bar");
			map.put("data", data);
			map.put("page_bar", page_bar);

			return map;
		} catch (Exception e) {
			throw new Exception(e + "," + sql);
		} finally {
			DBUtil.close(rs, stmt, null);
		}

	}

	// -------------------------------------
	public static Map queryStringWithUrl(Connection cn, String sql, int pkNum,
			int url_flag, javax.servlet.http.HttpServletRequest req)
			throws Exception {

		return queryStringWithUrl(cn, sql, pkNum, ";", url_flag,
				"f_view_object", req);

	}

	// -----------------
	// -------------------------------------
	public static Map queryStringWithUrl(Connection cn, String sql, int pkNum,
			int url_flag, String jsfunc,
			javax.servlet.http.HttpServletRequest req) throws Exception {

		return queryStringWithUrl(cn, sql, pkNum, ";", url_flag, jsfunc, req);

	}
	
	public static Map queryStringWithUrl(String sql, int pkNum,
			 int url_flag, 
			javax.servlet.http.HttpServletRequest req) throws Exception {
		Connection cn = null;
		try{
		cn = DBUtil.getConn();
		return  queryStringWithUrl(cn,sql, pkNum,
				url_flag,  req);
		}catch(Exception e){throw e;}
		finally{
			
			DBUtil.close(cn);
		}
		
	}

	
	

	/**
	 * 返回分页工具条和数据表格，数据为包含map的list<br>
	 * page,page_size参数从request中获取<br>
	 * cn 数据库连接<br>
	 * sql 查询语句(map中的key为字段名，全部小写)<br>
	 * 
	 * String page_bar = (String)map.get("page_bar");<br>
	 * List data = (List)map.get("data");<br>
	 */

	public static Map queryList(Connection cn, String sql,
			javax.servlet.http.HttpServletRequest req) throws Exception {

		Map map = new HashMap();
		Map pageMap = null;
		int[] arr = null;
		int page = 0;
		int page_size = 0;
		int max_rows = 0;
		int skip = 0;

		Statement stmt = null;
		ResultSet rs = null;
		List data = null;
		String page_bar = null;

		try {

			pageMap = getPagingInfo(cn, sql, req);
			arr = (int[]) pageMap.get("page_info");
			page = arr[0];
			page_size = arr[1];
			max_rows = arr[2];
			skip = (page - 1) * page_size;

			stmt = cn.createStatement();
			if (max_rows > 0) {
				stmt.setMaxRows(max_rows);
			}
			rs = stmt.executeQuery(sql);
			data = rs2list(rs, skip, page_size);
			page_bar = (String) pageMap.get("page_bar");
			map.put("data", data);
			map.put("page_bar", page_bar);

			return map;
		} catch (Exception e) {
			throw new Exception(e + "," + sql);
		} finally {
			DBUtil.close(rs, stmt, null);
		}

	}

	// -------------------------------------
	public static Map queryString(String sql, int pkNum, String colSep,
			int check_box_flag, javax.servlet.http.HttpServletRequest req)
			throws Exception {
		Connection cn = null;
		try {
			cn = DBUtil.getConn();
			return queryString(cn, sql, pkNum, colSep, check_box_flag, req);
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}

	}

	// -----------------------------
	// -------------------------------------
	public static Map queryString(String sql, int pkNum, int check_box_flag,
			javax.servlet.http.HttpServletRequest req) throws Exception {
		Connection cn = null;
		try {
			cn = DBUtil.getConn();
			return queryString(cn, sql, pkNum, ";", check_box_flag, req);
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}

	}

	// -----------------------------
	public static Map queryList(String sql,
			javax.servlet.http.HttpServletRequest req) throws Exception {
		Connection cn = null;
		try {
			cn = DBUtil.getConn();
			return queryList(cn, sql, req);
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}

	}

	public static List rs2list(ResultSet rs) throws Exception {
		List list = new ArrayList();
		if (rs == null) {
			return list;
		}
		String[] arr = null;
		Map map = null;
		arr = getColName(rs);
		int i = 0;
		int num = 0;
		String v = null;
		if (arr != null) {
			num = arr.length;
			while (rs.next()) {
				map = new HashMap();
				for (i = 1; i <= num; i++) {
					v = rs.getString(i);
					if (v == null) {
						v = "";
					}
					map.put(arr[i - 1], v);
				}// end for
				list.add(map);
			}// end while
		}// end if
		return list;
	}

	public static String getPkString(ResultSet rs, int pkNum, String pkColSep)
			throws Exception {

		int flag = 0;
		int i = 0;
		String v = null;
		String s = "";
		for (i = 1; i <= pkNum; i++) {
			v = rs.getString(i);
			if (StringUtil.isempty(v)) {
				v = " ";
			}
			if (i < pkNum) {
				s = s + v + pkColSep;
			} else {
				s = s + v;
			}
		}

		return s;
	}

	public static String rs2table(ResultSet rs, int skip, int page_size)
			throws Exception {

		if (rs == null) {
			return "";
		}
		StringBuffer s = new StringBuffer();
		String s2 = null;
		String style = null;
		ResultSetMetaData rsmd = null;
		rsmd = rs.getMetaData();
		int num = rsmd.getColumnCount();

		int start = 0;
		int i = 0;
		int j = 0;
		int pos = 0;

		while ((rs.next()) && (j < page_size)) {

			if (pos < skip) {
				pos++;
				continue;
			}

			style = "tr" + j % 2;
			s.append("<tr ").append(" class=").append(style).append(">\n");

			for (i = 0; i < num; i++) {
				s.append("<td>");
				s2 = rs.getString(i + 1);

				if (s2 != null) {
					s.append(s2);
				}
				s.append("</td>\n");
			}
			s.append("</tr>\n");
			j++;
		}// end while

		return s.toString();

	}

	public static String rs2table(ResultSet rs, int skip, int page_size,
			int pkNum, String pkColSep) throws Exception {

		if (rs == null) {
			return "";
		}
		StringBuffer s = new StringBuffer();
		String s2 = null;
		String objectid = null;
		String style = null;

		ResultSetMetaData rsmd = null;
		rsmd = rs.getMetaData();
		int num = rsmd.getColumnCount();
		if (pkNum >= num) {
			throw new Exception("主键列数应该小于字段总列数");
		}

		int start = 0;
		int i = 0;
		int j = 0;
		int pos = 0;
		while ((rs.next()) && (j < page_size)) {

			if (pos < skip) {
				pos++;
				continue;
			}

			style = "tr" + j % 2;
			s.append("<tr ").append(" class=").append(style).append(">\n");

			objectid = getPkString(rs, pkNum, pkColSep);

			s.append("<td style='text-align:center'>").append(
					"<input type=checkbox name=objectid value='").append(
					objectid).append("'></td>\n");

			for (i = pkNum; i < num; i++) {
				s.append("<td>");
				s2 = rs.getString(i + 1);

				if (s2 != null) {
					s.append(s2);
				}
				s.append("</td>\n");
			}
			s.append("</tr>\n");
			j++;
		}// end while

		return s.toString();

	}

	public static String rs2table(ResultSet rs, int skip, int page_size,
			int pkNum, String pkColSep, int check_box_flag) throws Exception {
		if (check_box_flag > 0) {
			return rs2table(rs, skip, page_size, pkNum, pkColSep);
		}
		return rs2table(rs, skip, page_size);
	}

	// ------------rs2table using url

	public static String rs2table(ResultSet rs, int skip, int page_size,
			int pkNum, String pkColSep, String jsfunc) throws Exception {

		if (rs == null) {
			return "";
		}
		StringBuffer s = new StringBuffer();
		String s2 = null;
		String objectid = null;
		String style = null;

		ResultSetMetaData rsmd = null;
		rsmd = rs.getMetaData();
		int num = rsmd.getColumnCount();
		if (pkNum >= num) {
			throw new Exception("主键列数应该小于字段总列数");
		}

		int start = 0;
		int i = 0;
		int j = 0;
		int pos = 0;
		while ((rs.next()) && (j < page_size)) {

			if (pos < skip) {
				pos++;
				continue;
			}

			style = "tr" + j % 2;
			s.append("<tr ").append(" class=").append(style).append(">\n");

			objectid = getPkString(rs, pkNum, pkColSep);
			/*
			 * 
			 * s.append("<td style='text-align:center'>").append( "<input
			 * type=checkbox name=objectid value='").append(
			 * objectid).append("'></td>\n");
			 */

			for (i = pkNum; i < num; i++) {
				s.append("<td>");
				
				//t_liang注释 Begin
				/*
				if (i == pkNum) {

					s.append("<a href=\"javascript:" + jsfunc + "('" + objectid
							+ "')\">");
					s.append(rs.getString(i + 1));
					s.append("</a>");

				} else {

					s2 = rs.getString(i + 1);

					if (s2 != null) {
						s.append(s2);
					}

				}
				*/
				//t_liang注释 End
				
				//t_liang新增 Begin
				s2 = rs.getString(i + 1);
				if (s2 != null) {
					s.append(s2);
				}
				//t_liang新增 End

				s.append("</td>\n");
			}
			
			//t_liang新增 Begin
			s.append("<td>");
			s.append("<a href=\"javascript:" + jsfunc + "('" + objectid
					+ "')\">");
			s.append("编辑");
			s.append("</a>");
			s.append("</td>\n");
			//t_liang新增 End
			
			s.append("</tr>\n");
			j++;
		}// end while

		return s.toString();

	}

	public static String rs2table(ResultSet rs, int skip, int page_size,
			int pkNum, String pkColSep, int url_flag, String jsfunc)
			throws Exception {
		if (url_flag > 0) {
			return rs2table(rs, skip, page_size, pkNum, pkColSep, jsfunc);
		}
		return rs2table(rs, skip, page_size);
	}

	// --------

	public static List rs2list(ResultSet rs, int skip, int page_size)
			throws Exception {
		List list = new ArrayList();

		if (rs == null) {
			return list;
		}
		String[] arrColName = null;
		String colName = null;
		int colNum = 0;
		int pos = 0;
		int i = 0;
		int j = 0;
		Map map = null;
		String v = null;

		ResultSetMetaData rsmd = null;
		rsmd = rs.getMetaData();
		colNum = rsmd.getColumnCount();
		arrColName = new String[colNum];

		for (i = 1; i <= colNum; i++) {
			arrColName[i - 1] = rsmd.getColumnName(i).toLowerCase();
		}

		if (page_size == 0) {
			page_size = 10000000;
		}

		while ((rs.next()) && (j < page_size)) {

			if (pos < skip) {
				pos++;
				continue;
			}

			map = new HashMap();

			for (i = 0; i < colNum; i++) {
				v = rs.getString(i + 1);
				if (v == null) {
					v = "";
				}
				map.put(arrColName[i], v);
			}

			j++;
			list.add(map);
		}// end while

		return list;

	}

	public static String[] getColName(ResultSet rs) throws Exception {

		if (rs == null) {
			return null;
		}
		int num = 0;
		int i = 0;
		String colName = null;
		String[] arr = null;
		ResultSetMetaData rsmd = null;
		rsmd = rs.getMetaData();
		num = rsmd.getColumnCount();
		arr = new String[num];
		for (i = 1; i <= num; i++) {
			colName = rsmd.getColumnName(i);
			colName = colName.toLowerCase();
			arr[i - 1] = colName;
		}
		return arr;
	}

}// end class
