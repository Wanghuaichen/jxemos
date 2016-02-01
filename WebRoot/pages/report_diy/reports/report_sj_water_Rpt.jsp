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
	<%--
	<%
		@SuppressWarnings("rawtypes")
		Enumeration names = request.getParameterNames();
		while (names.hasMoreElements()) {
			String name = (String) names.nextElement();
			System.out.println(name + "\t" + request.getParameter(name));
		}
	%>
	--%>
	<%
		String reportName = "reports/report_sj_water.rpt";

		String sh_flag = request.getParameter("sh_flag");
		String rpt_data_table = request.getParameter("rpt_data_table");
		String station_id = request.getParameter("station_id");
		//String valley_id = request.getParameter("valley_id");
		//String area_id = request.getParameter("area_id");
		//c.ctl_type �ص�Դ����
		//c.trade_id ��ѡ����ҵ
		String date1 = request.getParameter("date1");
		String date2 = request.getParameter("date2");

		//Ĭ����ʼʱ��
		date1 = (date1 == null ? StringUtil.getNowDate().toString() : date1);
		date2 = (date2 == null ? StringUtil.getNowDate().toString() : date2);
		String query = "select b.AREA_NAME, c.STATION_DESC, d.VALLEY_NAME, a.m_time, a.val02, a.val03, a.val04, a.val05, a.val16, a.val17, '"
				+ date1 + "' as date1, '" + date2 + "' as date2, ";
		if (sh_flag != null && sh_flag.equals("1")) {
			query += "'�������' as sh_flag, ";
		} else {
			//Ĭ������״̬
			query += "'ԭʼ����' as sh_flag, ";
		}
		if (rpt_data_table != null
				&& rpt_data_table.equals("t_monitor_real_month")) {
			if (sh_flag != null && sh_flag.equals("1")) {
				query += "'������' as rpt_data_table from t_monitor_real_month_v a, ";
			} else {
				//Ĭ������״̬
				query += "'������' as rpt_data_table from t_monitor_real_month a, ";
			}
		} else if (rpt_data_table != null
				&& rpt_data_table.equals("t_monitor_real_day")) {
			if (sh_flag != null && sh_flag.equals("1")) {
				query += "'������' as rpt_data_table from t_monitor_real_day_v a, ";
			} else {
				//Ĭ������״̬
				query += "'������' as rpt_data_table from t_monitor_real_day a, ";
			}
		} else {
			//Ĭ�Ͼ�ֵ����
			if (sh_flag != null && sh_flag.equals("1")) {
				query += "'Сʱ����' as rpt_data_table from t_monitor_real_hour_v a, ";
			} else {
				//Ĭ������״̬
				query += "'Сʱ����' as rpt_data_table from t_monitor_real_hour a, ";
			}
		}
		query += "T_CFG_AREA b, T_CFG_STATION_INFO c, T_CFG_VALLEY d where d.VALLEY_ID=c.VALLEY_ID and c.STATION_ID=a.STATION_ID and b.AREA_ID=c.AREA_ID and a.M_TIME >=CONVERT(DATETIME, '"+date1+" 00:00:00', 120) and a.M_TIME <=CONVERT(DATETIME, '"+date2+" 23:59:59', 120) ";
		if (station_id != null && !station_id.equals("")) {
			query += "and a.station_id='" + station_id
					+ "' order by a.m_time asc;";
		} else {
			//Ĭ��վλ
			query += "and a.station_id in(select  ss.station_id from T_CFG_STATION_INFO ss WHERE ss.area_id like '"+App.get("default_area_id")+"%' and ss.station_type='1') order by a.m_time asc;";
		//	query += "and a.station_id='3609011003' order by a.m_time asc;";
		}

		//System.out.println(query);

		//��ʾˮ������
		CrystalReportViewer viewer = new CrystalReportViewer();
		viewer.setOwnPage(true);

		viewer.setHasLogo(false);
		//������������Ƿ���ʾ
		viewer.setToolPanelViewType(CrToolPanelViewTypeEnum.none);
		//�����Ƿ���ʾ������ť
		viewer.setHasToggleParameterPanelButton(false);
		//�����Ƿ���ʾ������ť
		viewer.setHasToggleGroupTreeButton(false);
		//�������ű���
		//viewer.setZoomFactor(135);
		
		
		
		//Sets whether to enable drill down.
		viewer.setEnableDrillDown(false);
		//Sets whether to display drilldown tabs.
		viewer.setHasDrilldownTabs(false);

		viewer.setPrintMode(CrPrintMode.ACTIVEX);
		viewer.setReportSource(new CrystalDataSource(reportName)
				.getReportSource(query));
		viewer.processHttpRequest(request, response, this
				.getServletConfig().getServletContext(), null);
	%>
</body>
</html>
