<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc_empty.jsp"%>
<%
    BaseAction action = null;
			try {
				action = new AreaReportAction();
				action.run(request, response, "form");

			} catch (Exception e) {
				w.error(e);
				return;
			}
%>
<link rel="stylesheet" href="../../../web/index.css" />
<script type="text/javascript" src="../../../scripts/calendar.js"></script>
<body onload=f_rpt() style="overflow: hidden;">

	<form name=form1 method=post action=rpt.jsp>

		<input type=hidden name='tableName'
			value='<%=request.getParameter("tableName")%>'>

		<input type=hidden name=g_so2 value='val01'>
		<input type=hidden name=g_pm value='val02'>
		<input type=hidden name=g_nox value='val03'>
		<input type=hidden name=g_q value='val11'>

		<input type=hidden name=w_cod value='val02'>
		<input type=hidden name=w_ph value='val03'>
		<input type=hidden name=w_q value='val04'>

		<div class="frame-main-content"
			style="left: 0; top: 0; position: static;">
			<div class="nt">
				<p class="tiaojiao-p">
					<select name=station_type onchange=f_rpt() class="selectoption">

						<%=w.get("stationTypeOption")%>
					</select>
				</p>
				<p class="tiaojiao-p">
					<select name=area_id onchange=f_rpt() class="selectoption">
						<%=w.get("areaOption")%>
					</select>
				</p>
				<p class="tiaojiao-p">
					<select name=report_type onchange=f_rpt() class="selectoption">
						<%=w.get("reportTypeOption")%>
					</select>
				</p>
				<p class="tiaojiao-p">
					<input type=text class=c1 name=date1 value='<%=w.get("date1")%>'
						onclick="new Calendar().show(this);">
				</p>
				<input type=button value='²é¿´' onclick=form1.submit()
					class="tiaojianbutton">
			</div>
		</div>
		<iframe name=q frameborder=0 width=100% height=90%></iframe>
	</form>
</body>

<script>
	function r() {
		form1.action = 'area_report_form.jsp';
		form1.target = '';
		form1.submit();
	}

	function f_rpt() {
		form1.action = 'rpt.jsp';
		form1.target = 'q';
		form1.submit();
	}

	function f_save() {
		var obj = window.frames["reportq"].window.document
				.getElementById('div_excel_content');
		//alert(obj);
		form2.txt_excel_content.value = obj.innerHTML;

		form2.action = '/swj/pages/commons/save2excel.jsp';
		form2.submit();

	}

	function f_print() {
		//document.frames['q'].print();
		//window.frames["q"].window.print();
		//window.frames["q"].window.f_print();
		window.frames["reportq"].document.execCommand('print');
	}
</script>





