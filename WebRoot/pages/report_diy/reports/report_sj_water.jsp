<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>���߼��ͼ�ع���ϵͳ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<script type="text/javascript" src="../../../scripts/calendar.js"></script>
<script type="text/javascript" src="../../../scripts/jquery.js"></script>
<link rel="stylesheet" href="../../../web/index.css" />

<%
	RowSet station;
	try {
		SwjUpdate.report_sj_index(request);
	} catch (Exception e) {
		w.error(e);
		return;
	}
	station = w.rs("stationList");
	String sh_flag = request.getParameter("sh_flag");
	String shOption = SwjUpdate.getShState(sh_flag);

	//TODO Ĭ��ʱ�� �޸ĵĻ�test_Rpt.jsp��SQL���Ҳ���޸�
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
<body id="bd">
	<form name=form1 method=post action='report_sj_water_Rpt.jsp'
		target='rpt'>

		<div class="frame-main-content"
			style="left:0; top:0;position: static;">
			<div class="nt">
				<div class="sub" style="margin-bottom: 10px;">
					<select name=area_id onchange=f_r() class="search">
						<%=w.get("areaOption")%>

					</select> <select name=ctl_type onchange=f_r() class="search">
						<option value=''>�ص�Դ����</option>

						<%=w.get("ctlTypeOption")%>
					</select> <select name=valley_id onchange=f_r() class="search">
						<option value=''>��ѡ������</option>
						<%=w.get("valleyOption")%>
					</select> <select name=trade_id onchange=f_r() class="search">
						<option value=''>��ѡ����ҵ</option>
						<%=w.get("tradeOption")%>
					</select> <select name=station_id onchange="form1.submit();" class="search">
						<option value=''>��ѡ��վλ</option>
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
					��ֵ����: <select name='rpt_data_table' id='rpt_data_table'
						onchange="form1.submit();" class="selectoption">
						<%--<option value='T_MONITOR_REAL_TEN_MINUTE' >ʮ��������</option>--%>
						<option value='t_monitor_real_hour' selected>Сʱ����</option>
						<option value='t_monitor_real_day'>������</option>
						<option value='t_monitor_real_month'>������</option>
					</select>
				</p>
				<p class="tiaojiao-p">
					����״̬: <select name="sh_flag" onchange="form1.submit();"
						class="selectoption">
						<%=shOption%>
					</select>
				</p>
				<p class="tiaojiao-p">
					��: <input type='text' class="c1" name='date1' id='date1'
						value='<%=date1%>' readonly="readonly"
						onclick="new Calendar().show(this);" />
				</p>
				<p class="tiaojiao-p">
					��: <input type='text' class="c1" name='date2' id='date2'
						value='<%=date2%>' readonly="readonly"
						onclick="new Calendar().show(this);" />
				</p>
				<input type="submit" value='�鿴' title="�鿴" class="tiaojianbutton"
					id='btn_view' />
			</div>
		</div>
	</form>
	<div>
		<iframe src='report_sj_water_Rpt.jsp' name="rpt" width=100%
			height="1400" frameborder=0 scrolling="auto"></iframe>
	</div>
</body>
<script type="text/javascript">
	function f_r() {
		form1.action = '';
		form1.target = '';
		var a = document.getElementById("lw");
		a.value = 2;
		form1.submit();
	}

	/* 	$(document).ready(
	 function (){
	 $("option[value='360101']").attr("selected","selected");
	 $("option[value='11FC000000']").attr("selected","selected");
	 $("option[value='1']").attr("selected","selected");
	 }); 
	
	
	 $(document).ready(
	
	 //Ĭ�ϱ�������
	 function (){
	 var  a=$("#lw").val();
	 if(a=="1"){
	 $("select[name='area_id'] option[value='360101']").attr("selected","selected");
	 $("select[name='valley_id'] option[value='11FC000000']").attr("selected","selected");
	 $("select[name='ctl_type'] option[value='1']").attr("selected","selected");
	 $("select[name='station_id'] option[value='3601001900132']").attr("selected","selected");
	 $("select[name='trade_id'] option[value='B']").attr("selected","selected");
	 }
	 });  
	 $(function(){
	 $("#bd").one("load",function(){
	 $("option[value='360101']").attr("selected","selected");
	 $("option[value='11FC000000']").attr("selected","selected");
	 $("option[value='1']").attr("selected","selected");
	 });
	 }); 
	 */
</script>
</html>
