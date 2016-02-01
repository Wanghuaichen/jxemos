<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.OutputStreamWriter"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%
	String station_ids = null;

	int idNum = 0;
	String[] arr = null;
	String siteTable = null;
	String sqlInStr = null;
	String sql = null;
	String msg = null;
	String type = "";

	arr = App.getStationIdArr(request);

	//out.println(StringUtil.arr2str(arr,","));

	if (arr == null) {
		//out.println("请选择要比较的站位，至少1个");
		msg = "请选择要比较的站位，至少1个";
		JspUtil.go2error(request, response, msg);
		return;
	}
	idNum = arr.length;
	if (idNum < 1) {
		//out.println("请选择站位，至少1个");
		JspUtil.go2error(request, response, msg);
		return;
	}
	if (idNum > 10) {
		//out.println("比较的站位不能超过10个");
		msg = "比较的站位不能超过10个";
		JspUtil.go2error(request, response, msg);
		return;
	}

	String infectant_id = null;
	infectant_id = request.getParameter("infectant_id");
	if (StringUtil.isempty(infectant_id)) {
		//out.println("请选择一个指标");
		msg = "请选择一个指标";
		JspUtil.go2error(request, response, msg);
		return;
	}
	type = request.getParameter("chart_type");
	if (StringUtil.isempty(type)) {
		type = "t_monitor_real_day";
	}
	String table = "";
	//黄宝添加
	//table = App.getChartTypeTable(type);
	table = type;
	if (request.getParameter("sh_flag").equals("1")) {
		table = table + "_v";
	}
	//结束

	//String table = App.getChartTypeTable(type);
	Properties prop = JspUtil.getReqProp(request);
	List sqlList = null;
	prop.setProperty("table", table);
	Connection cn = null;
	String img = null;
	int chartw = 800;
	int h = 360;
	String col = null;
	Map map = null;
	int[] dd = {0, 10};//用来截取日期显示横坐标长度
	try {

		chartw = JspUtil.getInt(request, "w", 760);
		h = JspUtil.getInt(request, "h", 400);
		//f.sop(w+","+h);
		chartw = chartw - 30;
		h = h - 30;
		//f.sop(w+"----"+h);

		cn = DBUtil.getConn(request);
		sqlInStr = StringUtil.arr2str(arr, "','");
		sql = "select station_id,station_desc from t_cfg_station_info where station_id in("
				+ "'" + sqlInStr + "')";
		map = App.getKeyValueMap(cn, sql);
		sqlList = App.getCompareSqlList(cn, arr, infectant_id, map,
				prop);
		//img = NewChart.getChart(sqlList,800,420,20,20,50,50,request);
		String chartTitle = NewChart.getChartTitle(infectant_id,
				request);
		if (type.endsWith("hour")){
			dd = new int[]{5, 16};}
		if (type.endsWith("minute")||type.endsWith("MINUTE"))
			dd = new int[]{5, 16};

		/* if (StringUtil.equals(type, "month")) {
			
		} */
		chartTitle = f.getChartTitle(chartTitle);
		/* img = NewChart.getChart(sqlList, chartw, h, 20, 20, 50, 50,
				chartTitle, df, request); */
		String xmlString = "<?xml version='1.0' encoding='UTF-8'?>";
		xmlString += "";
		xmlString += "<anychart><settings><animation enabled='True' /></settings><charts><chart plot_type='CategorizedVertical'>"
				+ "<chart_settings><title><text>"
				+ chartTitle
				+ "</text><background enabled='false' /></title><chart_background enabled='false'/> "
				+ "<axes><y_axis><title> <text>数值"
				+ "</text></title></y_axis> <x_axis tickmarks_placement='Center'><labels />"
				+ "<title> <text>时间</text></title></x_axis></axes></chart_settings><data_plot_settings default_series_type='Line'>"
				+ "<line_series><tooltip_settings enabled='true'><format>"
				+ "{%SeriesName} \n "
				+ "日期:{%Name} \n"
				+ "大小: {%YValue}{numDecimals:0}"

				+ "</format></tooltip_settings> </line_series></data_plot_settings><data>";
		int num = sqlList.size();
		Map sqlMap = null;
		String sql1 = "";
		String sqlName = "";
		double[] arry = null;
		Date[] arrx = null;
		for (int i = 0; i < num; i++) {
			sqlMap = (Map) sqlList.get(i);
			sql1 = (String) sqlMap.get("sql");
			sqlName = (String) sqlMap.get("name");
			map = NewChart.getXYValue(sql1, request);
			double[] ay = (double[]) map.get("y");
			arry = new double[ay.length + 1];
			for (int x = 0; x < ay.length; x++) {
				arry[x] = ay[x];
			}
			arry[ay.length] = 0d;
			arrx = (Date[]) map.get("x");
			xmlString += "<series name='" + sqlName + "'>";
			for (int j = 0; j < arrx.length; j++) {
				xmlString += "<point name='"
						+ arrx[j].toString().substring(dd[0], dd[1])
						+ "' y='" + arry[j] + "' />";
			}
			xmlString += "</series>";
		}

		xmlString += "</data></chart></charts></anychart>";

		
		
		String fileName = request.getSession().getServletContext()
					.getRealPath("")
					+ "/pages/compare/fx.xml";
			File file = new File(fileName);
			BufferedWriter output = new BufferedWriter(new OutputStreamWriter(
					new FileOutputStream(file), "UTF-8"));
			output.write(xmlString);
			output.flush();
			output.close();
	} catch (Exception e) {
		//out.println(e);
		e.printStackTrace();
		JspUtil.go2error(request, response, e);
		return;
	} finally {
		DBUtil.close(cn);
	}
%>



<!--<style>
body{background-color:#ffffff;}
</style>-->
<html>
<head>
<link rel="StyleSheet"
	href="/<%=JspUtil.getContextName(request)%>/styles/css.css"
	type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" language="javascript"
	src="../flashmap/js/AnyChart.js">
	
</script>
</head>
<body>
	<div style="text-align:center">
		<script type="text/javascript" language="javascript">
			//         
			var chart = new AnyChart('../flashmap/swf/AnyChart.swf');
			chart.width = 1085;
			chart.height = 420;
			chart.setXMLFile('./fx.xml');
			chart.write();
			//
		</script>
	</div>
</body>
</html>


