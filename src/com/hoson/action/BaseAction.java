package com.hoson.action;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import com.hoson.*;
import java.sql.*;
import java.util.*;

import javax.servlet.http.*;

//public class BaseAction extends AjfAction{
public class BaseAction {
	static String NULL = "/pages/commons/blank.jsp";

	String method = null;

	public Connection conn = null;

	public Map model = null;

	public HttpServletRequest request = null;

	public HttpServletResponse response = null;

	public HttpSession session = null;

	public String run(HttpServletRequest request, HttpServletResponse response,
			String method) throws Exception {
		try {
			this.response = response;
			this.request = request;
			session = request.getSession();
			this.method = method;
			model = JspUtil.getRequestModel(request);
			execute();
			return null;
		} catch (Exception e) {
			// rollback();
			throw e;
		} finally {
			close();
		}
	}

	public String execute() throws Exception {
		if (f.empty(method)) {
			throw new Exception("method is empty");
		}
		Class c = this.getClass();
		Method m = c.getMethod(method, null);
		try {
			return (String) m.invoke(this, null);
		} catch (InvocationTargetException e) {
			//e.printStackTrace();
			throw new Exception(e.getTargetException() + "");
			
		}
	}

	public void getConn() throws Exception {
		if (conn == null) {
			conn = DBUtil.getConn();
		}
	}

	public void close() throws Exception {
		if (conn == null) {
			return;
		}
		DBUtil.close(conn);
		conn = null;
	}

	public void start() throws Exception {
		getConn();
		conn.setAutoCommit(false);

	}

	public void commit() throws Exception {

		if (conn.getAutoCommit()) {
			return;
		}
		conn.commit();
		if (!conn.getAutoCommit()) {
			conn.setAutoCommit(true);
		}
	}

	public void rollback() throws Exception {

		if (conn == null) {
			return;
		}
		if (conn.getAutoCommit()) {
			return;
		}
		conn.rollback();
	}

	public void seta(String name, Object obj) {
		request.setAttribute(name, obj);
	}

	public String p(String name) throws Exception {
		return JspUtil.getParameter(request, name);
	}

	public String p(String name, String def) throws Exception {
		String s = JspUtil.getParameter(request, name);
		if (f.empty(s)) {
			s = def;
		}
		return s;
	}

	public void add(String key, Object value) {
		if (StringUtil.isempty(key)) {
			return;
		}
		if (value == null) {
			return;
		}
		request.setAttribute(key, value);
	}

	public void add(Map map) throws Exception {
		if (map == null) {
			return;
		}
		List list = null;
		int i = 0;
		int num = 0;
		Object key = null;
		list = StringUtil.getMapKey(map);
		num = list.size();
		for (i = 0; i < num; i++) {
			key = list.get(i);
			if (key != null) {
				add(key + "", map.get(key));
			}
		}
	}
}