<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%
	Connection cn = null;
	String stationTypeOption, areaOption = null;
	String top_area_id = App.get("area_id", "33");
	String sql = null;

	try {

		cn = DBUtil.getConn();

		stationTypeOption = JspPageUtil.getStationTypeOption(cn, null);

		areaOption = JspPageUtil.getAreaOption(cn, null);

	} catch (Exception e) {
		JspUtil.go2error(request, response, e);
		return;
	} finally {
		DBUtil.close(cn);
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<link rel="stylesheet" href="../../../web/index.css" />
<style type="text/css">
.tj1 {
	height: 30px;
	line-height: 30px;
	font-weight: bold;
	margin-left: 80px;
}
</style>

</head>
<body>
	<form name="form1" action="insert.jsp" method="post">
		<input type="hidden" name="show_flag" value="0">
		<div class="frame-main-content" style="left:0; top:0;">
			<div class="fankui">
				<ul>
					<li><b>站位编号</b> <span><input type=text
							name="station_id"> <%=App.require()%></span>
					</li>
					<li><b>站位名称</b> <span><input type=text
							name="station_desc"> <%=App.require()%></span>
					</li>
					<li><b>监测类别</b> <span><select name="station_type"><%=stationTypeOption%></select></span>
					</li>
					<li><b>地区</b> <span><select name="area_id"><%=areaOption%></select></span>
					</li>
					<li><b><input type="submit" value="保 存"
							class="tiaojianbutton tj1" /> </b>&nbsp;&nbsp;&nbsp;&nbsp;<input
						type="button" value="返回" class="tiaojianbutton tj1" onclick="history.back()" />
					</li>
				</ul>
			</div>
		</div>
	</form>
</body>
</html>
