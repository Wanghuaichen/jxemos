<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
String station_type = request.getParameter("station_type");
if(station_type==null){
station_type = App.getDefStationId(request);
}
String stationTypeOption = App.getStationTypeOption(station_type,request);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>在线检测和监控管理系统</title>
<link rel="stylesheet" href="../../web/index.css"/>
<script type="text/javascript" src="../../scripts/calendar.js"></script>
<script>

 function f_1(){
  form1.action='map.jsp';
  form1.submit();
 }
 
</script>
</head>
<body onload=f_1() style="overflow: hidden;">
<form name=form1 method=post target=q>
	<div class="frame-main-content" style="left:0; top:0;position: static;">
	    <div class="nt">
	    	<p class="tiaojiao-p">
	    	站位类型:
			<select name="station_type" onchange=form1.submit() class="selectoption" >
			<%=stationTypeOption%>
			</select>
	    	</p>
			<input id="buttonSee" type=button value="查看"  title="查看" class="tiaojianbutton"  onclick="f_1();" />
	    </div>    
	</div>
	 
</form><iframe name=q id="q" width=100% style="height:820" frameborder=0></iframe>
<script>

</script>
</body>
</html>
