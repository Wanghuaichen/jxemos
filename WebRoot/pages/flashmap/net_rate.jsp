<%@ taglib prefix="any" uri="http://www.anychart.com"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>实时的联网率</title>
</head>
<body>
	<any:chart width="66%" height="88%"
		xmlFile="./net_rate_data.jsp?state=zc&area_id=36&infectant_id=B01&data_flag=real&station_type=1" />
</body>
</html>
