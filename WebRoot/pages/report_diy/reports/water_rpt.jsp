<%@page import="com.hoson.StringUtil"%>
<%@page import="com.hoson.app.App"%>
<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
	//Crystal Report Viewer imports.
%>
<%-- webreporting.jar--%>
<%@page import="com.crystaldecisions.report.web.viewer.*"%>
<%-- rascore.jar--%>
<%@page import="com.crystaldecisions.reports.sdk.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>

<body>


	<%@page import="com.hoson.map.CrystalDataSource,com.hoson.PropUtil;"%>
	<%
		String reportName = "reports/water_hz.rpt";

		String trade_id = request.getParameter("trade_id");
		String area_id = request.getParameter("area_id");
		if (area_id == null)
			area_id = App.get("default_area_id");
		String date1 = request.getParameter("date1");
		String date2 = request.getParameter("date2");

		//a1: 省 a2: 市 a3: 县
		String query = "select b.VAL02 as v02, b.VAL04 v04, b.VAL16 v16,b.VAL05 v05, b.VAL17 v17,  ";
		if (area_id == null || area_id.equals("36")) {
			query += "a1.AREA_NAME as p_name, a2.AREA_NAME as name, ";
		} else {
			query += "a2.AREA_NAME as p_name, a3.AREA_NAME as name, ";
		}
		if (trade_id != null && !trade_id.equals("root")) {
			query += "d.trace_name as trade from T_CFG_TRADE d, ";
		} else {
			query += "'全部行业' as trade from ";
		}
		if (area_id == null || area_id.equals("36")) {
			query += "T_CFG_AREA a1, T_CFG_AREA a2, T_CFG_AREA a3, T_MONITOR_REAL_HOUR b, T_CFG_STATION_INFO c where ( (c.AREA_ID=a3.AREA_ID and a3.AREA_PID=a2.AREA_ID and a2.AREA_PID=a1.AREA_ID and a1.AREA_ID like '36%') or (c.AREA_ID=a3.AREA_ID and a3.AREA_PID=a2.AREA_ID and a2.AREA_ID like '36%') or (c.AREA_ID=a3.AREA_ID and a3.AREA_ID like '36%') ) ";
		} else {
			query += "T_CFG_AREA a2, T_CFG_AREA a3, T_MONITOR_REAL_HOUR b, T_CFG_STATION_INFO c where ( (c.AREA_ID=a3.AREA_ID and a3.AREA_PID=a2.AREA_ID and a2.AREA_ID like '"
					+ area_id
					+ "%') or (c.AREA_ID=a3.AREA_ID and a3.AREA_ID like '"
					+ area_id + "%') ) ";
		}
		query += "and b.STATION_ID=c.STATION_ID and c.station_type='1' and c.show_flag !='1' "
				+ "and b.m_time>='";
		if (date1 != null && !date1.equals("")) {
			query += date1 + " 00:00:00' and b.m_time <='";
		} else {
			//TODO 默认开始时间
			query += StringUtil.getNowDate()
					+ " 00:00:00' and b.m_time <='";
		}
		if (date2 != null && !date2.equals("")) {
			query += date2 + " 23:59:59' ";
		} else {
			//TODO 默认结束时间
			query += StringUtil.getNowDate() + " 23:59:59' ";
		}
		if (trade_id != null && !trade_id.equals("root")) {
			query += "and d.trade_id like '" + trade_id
					+ "%' and c.TRADE_ID like '" + trade_id
					+ "%' order by a2.AREA_ID asc;";
		} else {
			query += "order by a2.AREA_ID asc;";
		}

		//打开报表
		ReportClientDocument reportClientDoc = new ReportClientDocument();
		reportClientDoc.open(reportName, 0);

		//显示水晶报表
		CrystalReportViewer viewer = new CrystalReportViewer();
		viewer.setOwnPage(true);

		viewer.setHasLogo(false);
		//设置组数面板是否显示
		viewer.setToolPanelViewType(CrToolPanelViewTypeEnum.none);
		//设置是否显示参数按钮
		viewer.setHasToggleParameterPanelButton(false);
		//设置是否显示组数按钮
		viewer.setHasToggleGroupTreeButton(false);
		//设置缩放比例
	//	viewer.setZoomFactor(135);
		//Sets whether to enable drill down.
		viewer.setEnableDrillDown(false);
		//Sets whether to display drilldown tabs.
		viewer.setHasDrilldownTabs(false);

		viewer.setPrintMode(CrPrintMode.ACTIVEX);
		viewer.setReportSource(new CrystalDataSource(reportName)
				.getReportSource(query));
		viewer.processHttpRequest(request, response, this
				.getServletConfig().getServletContext(), null);

		//@SuppressWarnings("rawtypes")
		//Enumeration names = request.getParameterNames();
		//while (names.hasMoreElements()) {
		//	String name = (String) names.nextElement();
		//	System.out.println(name + "\t" + request.getParameter(name));
		//}
	%>
</body>
</html>
