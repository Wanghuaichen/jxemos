<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%
	String station_type, area_id, station_name, sql = null;
	Connection cn = null;
	String stationTypeOption, areaOption = null;

	try {

		station_type = JspUtil.getParameter(request, "p_station_type",
		"1");
		area_id = JspUtil.getParameter(request, "p_area_id",
		f.cfg("default_area_id", "3301"));
		//area_id = JspUtil.getParameter(request,"p_area_id",f.cfg("area_id","3301"));
		//station_name = JspUtil.getParameter(request, "p_station_name",
		//		"");
	station_name=request.getParameter("p_station_name");
	if(station_name == null )
		station_name="";
		if (f.empty(station_type)) {
	station_type = "1";
		}

		cn = DBUtil.getConn();

		stationTypeOption = JspPageUtil.getStationTypeOption(cn,
		station_type);
		areaOption = JspPageUtil.getAreaOption(cn, "");

	} catch (Exception e) {
		w.error(e);
		return;
	} finally {
		f.close(cn);
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<link rel="stylesheet" href="../../../web/index.css" />
<style>
td {
	text-align: left;
}
* {
font-size: 12px;
}
</style>

</head>

<body onload="f_q()">

	<form name=form1 action=q.jsp target='station_q' method=post>
		<input type=hidden name=station_id>
		<table border=0 cellspacing=0 style='width:100%;height:100%;'>
			<tr>
				<td style='height:20px'>
					<div style="margin: 10px 10px 10px 10px;">
						<select name=p_station_type onchange=form1.submit()>
							<option value="">
								全部类型
								<%=stationTypeOption%>
						</select> 地区: <select name=p_area_id onchange=form1.submit()>
							<option value="36">
								全部地区
								<%=areaOption%>
						</select> 站位名称: <input type=text name=p_station_name
							value="<%=station_name%>"> <input type=button
							value='查找站位' onclick="f_q()" class=tiaojianbutton> <input
							type=button value='添加站位' onclick="f_input()" class=tiaojianbutton>
						<input type=button value='站位序号' onclick="f_no()"
							class=tiaojianbutton>
					</div>
				</td>
			</tr>
			<tr>
				<td style='height:100%'><iframe name="station_q" width=100%
						height=100% frameborder=0></iframe>
				</td>
			</tr>
		</table>
	</form>
	<script>
		function f_view(id) {
			form1.station_id.value = id;
			form1.action = 'view.jsp';
			form1.submit();
		}

		function f_q() {
			form1.action = 'q.jsp';
			form1.submit();
		}
		function f_no() {
			form1.action = 'no.jsp';
			form1.submit();
		}

		function f_input() {
			form1.action = 'input.jsp';
			form1.submit();
		}
	</script>
</body>
</html>
