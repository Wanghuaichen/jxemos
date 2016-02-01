package com.hoson;

import java.util.*;

import javax.servlet.http.*;

public class JspWrapperNew {

	HttpServletRequest req = null;
	HttpServletResponse res = null;

	public void set(HttpServletRequest req, HttpServletResponse res) {
		this.req = req;
		this.res = res;

	}

	public Object getObject(String name) {
		return req.getAttribute(name);

	}

	public String get(String name) {
		/*
		 * try{ return JspUtil.get(req,name,0,""); }catch(Exception e){return
		 * "";}
		 */
		Object obj = req.getAttribute(name);
		if (obj == null) {
			return "";
		}
		return obj + "";
	}

	// ------------------method

	public void go2error(Object msg) throws Exception {

		JspUtil.go2error(req, res, msg);
	}

	public void error(Object msg) throws Exception {

		JspUtil.go2error(req, res, msg);
	}

	public void rd(String url) throws Exception {

		JspUtil.rd(req, res, url);
	}

	public void fd(String url) throws Exception {

		JspUtil.fd(req, res, url);
	}

	public Map getModel() throws Exception {

		return JspUtil.getRequestModel(req);
	}

	public Map model() throws Exception {

		return JspUtil.getRequestModel(req);
	}

	public String ctx() {
		return JspUtil.getCtx(req);
	}

	public String path() {
		return JspUtil.getAppPath(req);
	}

	public String url() {
		return JspUtil.getUrl(req);
	}

	public String url(String url) {
		return JspUtil.getUrl(req, url);
	}

	public String p(String name) throws Exception {

		return JspUtil.getParameter(req, name);
	}

	public String p(String name, String defv) throws Exception {
		String s = JspUtil.getParameter(req, name);
		if (StringUtil.isempty(s)) {
			s = defv;
		}
		return s;
	}

	public Object a(String name) {

		return req.getAttribute(name);
	}

	public void a(String name, Object obj) {

		req.setAttribute(name, obj);
	}

	public RowSet rs(String name) {

		List list = null;
		list = (List) a(name);
		return new RowSet(list);
	}

	public XBean b(String name) {

		Map m = null;
		m = (Map) a(name);
		return new XBean(m);
	}

	// 20090219
	public void input(Object msg, String input) throws Exception {

		// JspUtil.go2error(req,res,msg);
		f.go2input(req, res, input, msg);

	}

	public String msg() throws Exception {
		String msg = f.getInputErrorMsg(req);
		if (f.empty(msg)) {
			return "";
		}
		msg = msg.replaceAll("java.lang.Exception:", " ");
		msg = msg.replaceAll("java.lang.IllegalArgumentException", "输入参数格式不正确");
		msg = msg.replaceAll("java.sql.SQLException:", "");
		return msg;
	}

	public void add(String key, Object value) {
		f.add(req, key, value);
	}

	public void add(Map map) throws Exception {
		f.add(req, map);
	}

}
