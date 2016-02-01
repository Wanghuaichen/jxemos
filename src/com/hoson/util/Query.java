package com.hoson.util;

import java.sql.*;
import java.util.*;
import com.hoson.*;
import com.hoson.app.*;
import javax.servlet.http.HttpServletRequest;

//paged query and query 

public class Query {

	static String db_query_max_rows_key = "db_query_max_rows";

	static String page_size_option_values_key = "page_size_option_values";

	static String page_size_key = "page_size";

	static String page_size_option_values = getPageSizeOptionValues();

	static int default_page_size = getPageSize();

	/*!
	 *  ���ҳ��ҳ��
	 */
	static int getPageSize() {
		String s = App.get(page_size_key, "10");
		return StringUtil.getInt(s, 10);
	}

	/*!
	 *  ���ҳ���������
	 */
	static int getQueryMaxRows(HttpServletRequest req) {

		int max_rows = 0;
		String v = null;
		v = req.getParameter(db_query_max_rows_key);
		max_rows = StringUtil.getInt(v, 0);
		if (max_rows > 0) {
			return max_rows;
		}

		v = App.get(db_query_max_rows_key, "");

		max_rows = StringUtil.getInt(v, 0);
		if (max_rows > 0) {
			return max_rows;
		}

		if (max_rows < 1) {
			max_rows = 2000;
		}

		return max_rows;
	}

	/*!
	 *  ���ҳ����ʾ�е������б�
	 */
	static String getPageSizeOptionValues() {

		return App.get(page_size_option_values_key, "10,15,20,30");
	}

	/*!
	 *  ����sql������params������������ؼ�����б�
	 */
	public static List checkQuery(Connection cn, String sql, Object[] params,
			int max_rows) throws Exception {
		List list = null;
		int num1, num2 = 0;
		list = f.query(cn, sql, params, max_rows);
		num1 = list.size();
		list = f.hourDataCheck(list);
		num2 = list.size();
		return list;
	}

	/*!
	 *  ����sql������params��������������б�
	 */
	public static List query(Connection cn, String sql, Object[] params,
			int max_rows) throws Exception {
		if (cn == null) {
			throw new Exception("connection is null");
		}
		List list = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ps = cn.prepareStatement(sql);
			if (max_rows > 0) {
				ps.setMaxRows(max_rows);
			}
			DBUtil.setParam(ps, params);

			rs = ps.executeQuery();

			list = rs2list(rs);

			return list;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs, ps, null);
		}
	}

	/*!
	 *  ���ݲ�ѯ���rs�����б�
	 */
	public static List rs2list(ResultSet rs) throws Exception {
		List list = new ArrayList();
		if (rs == null) {
			return list;
		}
		String[] arr = null;
		Map map = null;
		arr = DBUtil.getColName(rs);
		int i = 0;
		int num = 0;
		String v = null;

		num = arr.length;
		while (rs.next()) {
			map = new HashMap();
			for (i = 1; i <= num; i++) {
				v = rs.getString(i);

				map.put(arr[i - 1], v);
			}
			list.add(map);
		}
		return list;
	}

	/*!
	 *  ����sql������params��request��ѯ���ݿ⣬����map����
	 */
	public static Map query(Connection cn, String sql, Object[] params,
			HttpServletRequest req) throws Exception {
		List list = null;
		Map map = new HashMap();
		List list2 = new ArrayList();

		int max_rows = getQueryMaxRows(req);

		int page_size = JspUtil.getInt(req, "page_size", getPageSize());
		int page = JspUtil.getInt(req, "page", 1);
		int row_num = 0;
		int i, page_num, start, end = 0;
		String bar = null;

		if (page_size < 1) {
			page_size = 10;
		}
		if (page < 1) {
			page = 1;
		}

		list = query(cn, sql, params, max_rows);
		row_num = list.size();
		page_num = getPageNum(page_size, row_num);

		if (page > page_num) {
			page = page_num;
		}

		if (page < 1) {
			page = 1;
		}

		start = (page - 1) * page_size;
		end = start + page_size;
		if (end > row_num) {
			end = row_num;
		}
		for (i = start; i < end; i++) {
			list2.add(list.get(i));
		}
		bar = getPageBar(page, page_size, row_num, page_size_option_values);
		map.put("data", list2);
		map.put("bar", bar);
		return map;
	}

	/*!
	 *  ����sql������params��request��ѯ���ݿ⣬���ؼ����map����
	 */
	public static Map checkQuery(Connection cn, String sql, Object[] params,
			HttpServletRequest req) throws Exception {
		List list = null;
		Map map = new HashMap();
		List list2 = new ArrayList();

		int max_rows = getQueryMaxRows(req);

		int page_size = JspUtil.getInt(req, "page_size", getPageSize());
		int page = JspUtil.getInt(req, "page", 1);
		int row_num = 0;
		int i, page_num, start, end = 0;
		String bar = null;

		if (page_size < 1) {
			page_size = 10;
		}
		if (page < 1) {
			page = 1;
		}

		list = checkQuery(cn, sql, params, max_rows);
		row_num = list.size();
		//System.out.println("row_num=" + row_num);
		page_num = getPageNum(page_size, row_num);

		if (page > page_num) {
			page = page_num;
		}

		if (page < 1) {
			page = 1;
		}

		start = (page - 1) * page_size;
		end = start + page_size;
		if (end > row_num) {
			end = row_num;
		}
		for (i = start; i < end; i++) {
			list2.add(list.get(i));
		}
		bar = getPageBar(page, page_size, row_num, page_size_option_values);

		map.put("data", list2);
		map.put("bar", bar);
		return map;
	}

	/*!
	 *  ���������б���ҳ��page_size_option_values����ҳ��page_size��������б�ֵ
	 */
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

	/*!
	 *  ���������б���ҳ��page_size_option_values����ҳ��page_size������row_num��������б�ֵ
	 */
	public static String getPageBar(int page, int page_size, int row_num,
			String page_size_option_values) throws Exception {
		String pageOption = "";

		String s = "";
		int page_num = getPageNum(page_size, row_num);

		pageOption = get_page_size_option(page_size_option_values, page_size);

		s = "&nbsp;&nbsp;��" + row_num + "��," + page_num + "ҳ&nbsp;&nbsp;";
		s = s + "\n<select name=page_size onchange=form1.submit()>\n"
				+ pageOption + "</select>����¼\n";
		s = s + getPageUrl(page, page_num);
		s = s + " \nת��<input type=text name=page style='width:36px' value="
				+ page + ">ҳ \n";
		s = s
				+ "<input type=button value='go' onclick='form1.submit()' class='btn'>";
		return s;
	}

	/*!
	 *  ������ҳ��page_size������row_num�����㵱ǰҳ����
	 */
	public static int getPageNum(int page_size, int row_num) {
		int page_num = 0;
		if (row_num % page_size == 0) {
			page_num = row_num / page_size;
		} else {
			page_num = row_num / page_size + 1;
		}
		return page_num;
	}

	/*!
	 *  ������ҳ��page����ҳ��page_num�����ҳ��url
	 */
	public static String getPageUrl(int page, int page_num) throws Exception {
		String s = "";
		int pre = page - 1;
		int next = page + 1;

		String s1 = "<a href=javascript:f_go_page(1)>��һҳ</a> \n<a href=javascript:f_go_page("
				+ pre + ")>��һҳ</a>\n";
		String s2 = "<a href=javascript:f_go_page(" + next
				+ ")>��һҳ</a> \n<a href=javascript:f_go_page(" + page_num
				+ ")>���ҳ</a>\n";

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
}
