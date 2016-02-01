<%@page import="org.apache.derby.tools.sysinfo"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%
	Properties dynaBean = null;
	String tableName = "t_cfg_trade";
	String cols = "trade_id,trace_name";

	String trade_id = null;
	String trace_name = null;
	String trade_desc = null;
	Map map = null;
	String msg = null;
	String sql = null;
	Connection cn = null;

	try {
		cn = DBUtil.getConn();
		dynaBean = JspUtil.getReqProp(request);

		//	trade_id = dynaBean.getProperty("trade_id");
		trade_id = JspUtil.getParameter(request,"trade_id");

		//trace_name = dynaBean.getProperty("trace_name");
		trace_name = JspUtil.getParameter(request,"trace_name");
// 		trade_desc = JspUtil.getParameter(request,"trade_desc");
		//System.out.print(trade_desc);
// 		if (trade_desc == null){
// 			trade_desc = "";}
		if (StringUtil.isempty(trace_name)) {
			msg = "行业名称不能为空";
			JspUtil.go2error(request, response, msg);
			return;

		}
		sql = "select trade_id from t_cfg_trade where trace_name='"
				+ trace_name + "' ";
		sql = sql + "and trade_id<>'" + trade_id + "' ";
		map = DBUtil.queryOne(cn, sql, null);
		if (map != null) {
			msg = "行业名称[" + trace_name + "]已被使用";
			JspUtil.go2error(request, response, msg);
			return;
		}
		
		 dynaBean.setProperty("trade_id", trade_id);
		dynaBean.setProperty("trace_name", trace_name);
// 		dynaBean.setProperty("trade_desc", trade_desc);
		//System.out.print(dynaBean.getProperty("trace_name"));
		DBUtil.updateRow(cn, tableName, cols, dynaBean); 
		JspUtil.forward(request, response, "trade_query.jsp");
	} catch (Exception e) {
		JspUtil.go2error(request, response, e);
		return;
	} finally {
		DBUtil.close(cn);
	}
%>