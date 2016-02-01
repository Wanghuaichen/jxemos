<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>在线检测和监控管理系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<script type="text/javascript" src="../../../scripts/calendar.js"></script>
<script type="text/javascript" src="../../../scripts/jquery.js"></script>
<link rel="stylesheet" href="../../../web/index.css" />

<%
	RowSet station;
	try {
		SwjUpdate.report_sj_index2(request);
	} catch (Exception e) {
		w.error(e);
		return;
	}

	station = w.rs("stationList");
	String sh_flag = request.getParameter("sh_flag");
	String shOption = SwjUpdate.getShState(sh_flag);

	String date1 = StringUtil.getNowDate().toString();
	String date2 = StringUtil.getNowDate().toString();
	//String now = StringUtil.getNowDate() + "";
	//date1 = JspUtil.getParameter(request, "date1", now);
	//date2 = JspUtil.getParameter(request, "date2", now);
%>
<style type="text/css">
.sub .search {
	margin-right: 25px;
}
</style>

</head>
<body>
	<form name=form1 method=post action='report_sj_gas_rpt.jsp'
		target='rpt'>
		<div class="frame-main-content"
			style="left:0; top:0;position: static;">
			<div class="nt">
				<div class="sub" style="margin-bottom: 10px;">
					<input type="hidden" value="2" name="station_type"> <select
						name=area_id onchange=f_r() class="search">
						<%=w.get("areaOption")%>
					</select> <select name=ctl_type onchange=f_r() class="search">
						<option value=''>重点源属性</option>
						<%=w.get("ctlTypeOption")%>
					</select> <select name=valley_id onchange=f_r() class="search">
						<option value=''>请选择流域</option>
						<%=w.get("valleyOption")%>
					</select> <select name=trade_id onchange=f_r() class="search">
						<option value=''>请选择行业</option>
						<%=w.get("tradeOption")%>
					</select> <select name=station_id onchange="form1.submit();" class="search">
						<option value=''>请选择站位</option>
						<%
							station.reset();
							//System.out.println(station.size());
							while (station.next()) {
						%>
						<option value='<%=station.get("station_id")%>'><%=station.get("station_desc")%></option>
						<%
							}
						%>
					</select>
				</div>
				<p class="tiaojiao-p">
					均值类型: <select name='rpt_data_table' id='rpt_data_table'
						onchange="form1.submit();" class="selectoption">
						<%--<option value='T_MONITOR_REAL_TEN_MINUTE' >十分钟数据</option>--%>
						<option value='t_monitor_real_hour' selected>小时数据</option>
						<option value='t_monitor_real_day'>日数据</option>
						<option value='t_monitor_real_month'>月数据</option>
					</select>
				</p>
				<p class="tiaojiao-p">
					数据状态: <select name="sh_flag" onchange="form1.submit();"
						class="selectoption">
						<%=shOption%>
					</select>
				</p>
				<p class="tiaojiao-p">
					从: <input type='text' class="c1" name='date1' id='date1'
						value='<%=date1%>' readonly="readonly"
						onclick="new Calendar().show(this);" />
				</p>
				<p class="tiaojiao-p">
					到: <input type='text' class="c1" name='date2' id='date2'
						value='<%=date2%>' readonly="readonly"
						onclick="new Calendar().show(this);" />
				</p>
				<input type="submit" value='查看' title="查看" class="tiaojianbutton"
					id='btn_view' />
			</div>
		</div>
	</form>
	<div>
		<iframe src='report_sj_gas_rpt.jsp' name="rpt" width=100%
			height="1400" frameborder=0 scrolling="auto"></iframe>
	</div>
</body>
<script type="text/javascript">
	function f_r() {
		form1.action = '';
		form1.target = '';
		var a = document.getElementById("fslg");
		a.value = 2;
		form1.submit();

	}
	/* function xx(){
	var a=document.getElementById("fslg");
		a.html("2");
		
	
	} */

	/* 
		$(document).ready(
	function (){
	var  a=$("#fslg").val();
	if(a=="1"){
	$("select[name='area_id'] option[value='361121']").attr("selected","selected");
	$("select[name='valley_id'] option[value='11FK100000']").attr("selected","selected");
	$("select[name='trade_id'] option[value='C']").attr("selected","selected");
	$("select[name='station_id'] option[value='3611012006']").attr("selected","selected");
	$("select[name='ctl_type'] option[value='3']").attr("selected","selected");
	}
	});    */
</script>
</html>
