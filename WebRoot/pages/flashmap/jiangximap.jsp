<%@ page contentType="text/html;charset=GBK"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title>����ʡ���������Զ������ϵͳ</title>
<script type="text/javascript" src="./js/AnyChart.js"></script>
</head>
<body>
	<div style="text-align:center">
		<script type="text/javascript">
			//         
			var chart = new AnyChart('./swf/AnyChart.swf');
			chart.width = '800';//chart.width = '100%';
			chart.height = '800';
			chart.setXMLFile('./anychart.xml');
			chart.write();
			//
		</script>
	</div>
</body>
</html>
