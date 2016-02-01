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
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>

<%--
<%@ taglib uri="/crystal-tags-reportviewer.tld" prefix="crviewer"%>
<crviewer:viewer reportSourceType="reportingComponent"
	viewerName="test" reportSourceVar="Customer Profile Report"
	isOwnPage="true">
	<crviewer:report reportName="reports/test.rpt" />
</crviewer:viewer>
--%>

<body>
	<%@page import="com.hoson.map.CrystalDataSource,com.hoson.PropUtil;"%>
	<%
		String reportName = "reports/test.rpt";

		String station_id = request.getParameter("station_id");
		String date1 = request.getParameter("date1");
		String date2 = request.getParameter("date2");

		String query = "select b.STATION_DESC, a.M_TIME, a.VAL04, a.VAL03, a.VAL02, a.VAL05, a.VAL16, a.VAL17 "
				+ "from T_CFG_STATION_INFO b INNER JOIN T_MONITOR_REAL_TEN_MINUTE a on a.STATION_ID=b.STATION_ID "
				+ "where b.STATION_TYPE=1 and b.SHOW_FLAG<>1 and a.M_TIME>=CONVERT(DATETIME, '";
		if (date1 != null && !date1.equals("")) {
			query = query + date1
					+ " 00:00:00', 120) and a.M_TIME<=CONVERT(DATETIME, '";
		} else {
			//TODO 默认开始时间
			query = query
					+ "2011-06-16 00:00:00', 120) and a.M_TIME<=CONVERT(DATETIME, '";
		}
		if (date2 != null && !date2.equals("")) {
			query = query + date2 + " 23:59:59', 120) ";
		} else {
			//TODO 默认结束时间
			query = query + "2011-06-16 23:59:59', 120) ";
		}
		if (station_id != null && !station_id.equals("")) {
			query = query + "and a.station_id='" + station_id
					+ "' order BY b.STATION_ID, a.M_TIME desc;";
		} else {
			query = query + "order BY b.STATION_ID, a.M_TIME desc;";
		}

		//System.out.println(query);

		//显示水晶报表
		CrystalReportViewer viewer = new CrystalReportViewer();
		viewer.setOwnPage(true);

		viewer.setHasLogo(false);
		//设置组数面板是否显示
		viewer.setToolPanelViewType(CrToolPanelViewTypeEnum.none);
		//设置是否显示参数按钮
		viewer.setHasToggleParameterPanelButton(false);
	//设置缩放比例
		viewer.setZoomFactor(135);
		viewer.setPrintMode(CrPrintMode.ACTIVEX);
		viewer.setReportSource(new CrystalDataSource(reportName)
				.getReportSource(query));
		viewer.processHttpRequest(request, response, this
				.getServletConfig().getServletContext(), null);
	%>
</body>
</html>
