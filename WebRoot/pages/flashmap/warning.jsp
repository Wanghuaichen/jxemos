<%@page import="com.hoson.map.WarningAnyChart"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	WarningAnyChart warn = new WarningAnyChart();
	warn.saveAsXml(request);
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" language="javascript"
	src="./js/AnyChart.js">
	
</script>
</head>
<body>
	<div style="text-align:center">
		<script type="text/javascript" language="javascript">
			//         
			var chart = new AnyChart('./swf/AnyChart.swf');
			chart.width = '800';//chart.width = '100%';
			chart.height = '673';
			chart.setXMLFile('./warning.xml');
			chart.write();
			//
		</script>
	</div>
</body>
</html>
