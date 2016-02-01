package com.hoson.app;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hoson.*;



public class AppPagedUtil {

	private static int maxRows = 3000;

	private static int setMaxRowsFlag = 1;
	
	//--------
	public static int getMaxRows(){
		
		return maxRows;
		
	}

	// ----------
	public static String getValueStr(String s) {
		return f.v(s);

	}

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
		String pages = "10,15,20";
		
		pages = App.get("page_size_value","10,15,20");
		if(StringUtil.isempty(pages)){pages="10,15,20";}
		
		String s = "";
		int page_num = getPageNum(page_size, row_num);

		pageOption = JspUtil.getOption(pages, pages, page_size + "");
		// s = "&nbsp;&nbsp;共" + row_num +"条记录," + page_num + "页，每页";
		s = "&nbsp;&nbsp;共" + row_num + "行," + page_num + "页&nbsp;&nbsp;";
		 s = s + "<select name=page_size onchange=form1.submit()>" +
		 pageOption+"</select>条记录 ";
		s = s + getPageUrl(page, page_num);
		s = s + " 转到<input type=text name=page style='width:36px' value="
				+ page + ">页 ";
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
		String s1 = "<a href=javascript:f_page_goFirst()>第一页</a> <a href=javascript:f_page_goPre()>上一页</a>";
		String s2 = "<a href=javascript:f_page_goNext()>下一页</a> <a href=javascript:f_page_goLast()>最后页</a>";

		// String s1 = "<a
		// href=javascript:f_page_goFirst()>||&lt;&nbsp;&nbsp;</a> <a
		// href=javascript:f_page_goPre()>&lt;&nbsp;&nbsp;</a>";
		// String s2 = "<a href=javascript:f_page_goNext()>&gt;&nbsp;&nbsp;</a>
		// <a href=javascript:f_page_goLast()>&gt||</a>";

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
			throw e;
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
			throw e;
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

			if (setMaxRowsFlag > 0) {
				if (count > maxRows) {
					count = maxRows;
				}
			}
            /*
			try {
				//page_size = Integer.parseInt(req.getParameter("page_size"));
				
			} catch (Exception e) {
				page_size = 10;
			}
			*/
			page_size = StringUtil.getInt(req.getParameter("page_size"),App.getDefaultPageSize());
			
			
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

			if (setMaxRowsFlag > 0) {
				stmt.setMaxRows(maxRows);
			}

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
					s2 = getValueStr(s2);
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
			throw e;
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
		}
	}

	// --------------------------
	
	public static String[] queryWithMinMax(Connection cn, String sql,
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

			if (setMaxRowsFlag > 0) {
				if (count > maxRows) {
					count = maxRows;
				}
			}

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

			if (setMaxRowsFlag > 0) {
				stmt.setMaxRows(maxRows);
			}

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
					//s2 = getValueStr(s2);
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
			throw e;
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
			if (setMaxRowsFlag > 0) {
				if (count > maxRows) {
					count = maxRows;
				}
			}

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

			if (setMaxRowsFlag > 0) {
				stmt.setMaxRows(maxRows);
			}

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
			throw e;
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
			cn = DBUtil.getConn();
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
			
			if (setMaxRowsFlag > 0) {
				if (count > maxRows) {
					count = maxRows;
				}
			}
			/*
			try {
				page_size = Integer.parseInt();
			} catch (Exception e) {
				page_size = 10;
			}
			*/
			page_size = StringUtil.getInt(req.getParameter("page_size"),App.getDefaultPageSize());
			
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
			if (setMaxRowsFlag > 0) {
				stmt.setMaxRows(maxRows);
			}

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

					s2 = getValueStr(s2);

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
			throw e;
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
		}
	}

	// --------------------------
	public static String[] query(String sql, int pkNum,
			String colSep, javax.servlet.http.HttpServletRequest req,
			int check_box_flag) throws Exception {
		Connection cn = null;
		String[]arr = null;
		try{
		cn = DBUtil.getConn(req);
		arr = query(cn,sql,pkNum,colSep,req,check_box_flag);
		return arr;
		}catch(Exception e){throw e;}finally{DBUtil.close(cn);}
		
	}
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

					s2 = getValueStr(s2);

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
			throw e;
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
			throw e;
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
			throw e;
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
			
			if (setMaxRowsFlag > 0) {
				if (count > maxRows) {
					count = maxRows;
				}
			}
			
			
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
			

			if (setMaxRowsFlag > 0) {
				stmt.setMaxRows(maxRows);
			}
			
			
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
			throw e;
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

					s2 = getValueStr(s2);

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
			throw e;
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
			if (setMaxRowsFlag > 0) {
				stmt.setMaxRows(maxRows);
			}
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
			throw e;
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
	public static List queryListNoPaging(Connection cn, String sql)
	throws Exception {
List list = new ArrayList();
Map map = null;
Statement stmt = null;
ResultSet rs = null;

ResultSetMetaData rsmd = null;
int i = 0;
int num = 0;
String v = null;

String[]arrColName = null;
try {
	stmt = cn.createStatement();
	if (setMaxRowsFlag > 0) {
		stmt.setMaxRows(maxRows);
	}
	rs = stmt.executeQuery(sql);
	rsmd = rs.getMetaData();
	num = rsmd.getColumnCount();
    arrColName = new String[num];
	for(i=0;i<num;i++){
		arrColName[i]=rsmd.getColumnName(i+1).toLowerCase();
	}
	while (rs.next()) {
		map = new HashMap();
		for (i = 1; i <= num; i++) {
			v = rs.getString(i);
			if(v==null){v="";}
			map.put(arrColName[i-1],v);
		}
		list.add(map);
	}// end while
	return list;
} catch (Exception e) {
	throw e;
} finally {
	DBUtil.close(rs);
	DBUtil.close(stmt);
}
}

// ------------------------------
public static List queryListNoPaging(String sql,
	javax.servlet.http.HttpServletRequest req) throws Exception {
Connection cn = null;
try {
	cn = DBUtil.getConn(req);
	return queryListNoPaging(cn, sql);
} catch (Exception e) {
	throw e;
} finally {
	DBUtil.close(cn);
}
}
// ------------------------------
//------------------------getString()-----
public static String[] queryUsingGetString(Connection cn, String sql,
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
		if (setMaxRowsFlag > 0) {
			//stmt.setMaxRows(maxRows);
			if(count>maxRows){count=maxRows;}
		}
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
		if (setMaxRowsFlag > 0) {
			stmt.setMaxRows(maxRows);
		}
		rs = stmt.executeQuery(sql);
		ResultSetMetaData rsmd = null;
		rsmd = rs.getMetaData();
		num = rsmd.getColumnCount();
        /*
		for (i = 1; i <= num; i++) {
			title = title + "<td>" + rsmd.getColumnName(i) + "</td>\n";
		}
		title = title.toLowerCase();
		title = "<tr class=title>" + title + "</tr>\n";
        */
		
		
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

				//s2 = getValueStr(s2);

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
		throw e;
	} finally {
		DBUtil.close(rs);
		DBUtil.close(stmt);
	}
}

// --------------------------
public static String[] queryUsingGetString(String sql,
		javax.servlet.http.HttpServletRequest req) throws Exception {
	
	
	Connection cn = null;
	try{
	cn = DBUtil.getConn(req);
	return queryUsingGetString(cn,  sql,req);
	}catch(Exception e){throw e;}finally{DBUtil.close(cn);}
}
//--------------------------	

// ------------------------
public static String[] queryUsingGetString(Connection cn, String sql, int pkNum,
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
		
		if (setMaxRowsFlag > 0) {
			if (count > maxRows) {
				count = maxRows;
			}
		}
		
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
		if (setMaxRowsFlag > 0) {
			stmt.setMaxRows(maxRows);
		}

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

				//s2 = getValueStr(s2);

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
		throw e;
	} finally {
		DBUtil.close(rs);
		DBUtil.close(stmt);
	}
}

// --------------------------
public static String[] queryUsingGetString(String sql, int pkNum,
		String colSep, javax.servlet.http.HttpServletRequest req,
		int check_box_flag) throws Exception {
	Connection cn = null;
	String[]arr = null;
	try{
	cn = DBUtil.getConn(req);
	arr = query(cn,sql,pkNum,colSep,req,check_box_flag);
	return arr;
	}catch(Exception e){throw e;}finally{DBUtil.close(cn);}
	
}
// ------------------------

	
}// end class
