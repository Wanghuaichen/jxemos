<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%
	BaseAction action = null;
	String sh_flag = null;
	String shOption = null;
	try {
		action = new WarnAction();
		action.run(request, response, "p_wh");//完好率
		sh_flag = (String) request.getAttribute("sh_flag");
		shOption = SwjUpdate.getShState(sh_flag);

	} catch (Exception e) {
		w.error(e);
		return;
	}

	RowSet rs2 = w.rs("infectant");
	Map map = (Map) request.getAttribute("pm");
	XBean b = new XBean(map);
	String station_id, m_time = null;
%>
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css" />
<form name=form1 method=post action=p_wh.jsp>
	<div style="width: 60%">
		<table border=0 cellspacing=1 width="60%">
			<tr class="title">
				<td colspan="3">
					<input type=hidden name="station_id" value="<%=request.getAttribute("station_id")%>"> 
					<input type=hidden name="date1" value="<%=request.getAttribute("date1")%>"> 
					<input type=hidden name="hour1" value="<%=request.getAttribute("hour1")%>"> 
					<input type=hidden name="date2" value="<%=request.getAttribute("date2")%>"> 
					<input type=hidden name="hour2"	value="<%=request.getAttribute("hour2")%>"> 
					<input type=hidden name="station_desc" value="<%=request.getAttribute("station_desc")%>"> 
					<input type=hidden name="sh_flag" value="<%=sh_flag%>">
						<center><%=w.get("title")%>
							<select name="sh_flag" onchange="data_type(this.form)">
								<%=shOption%>
							</select>
					</center>
				</td>
			</tr>
			<tr class="title">
				<td>监测因子</td>
				<td>完好率</td>
				<td>缺失的时间</td>
			</tr>

			<%
				while (rs2.next()) {
					String col = rs2.get("infectant_column").toLowerCase();
			%>
			<tr>
				<td width="45%"><%=rs2.get("infectant_name")%></td>
				<td><%=b.get(col)%></td>
				<td><select>
						<%=b.get("dateOption" + col)%>
				</select></td>
			</tr>
			<%
				}
			%>
		</table>
	</div>
</form>


<script>
	function data_type(form) {
		var sh_flag =<%=sh_flag%>;

		if (sh_flag == 0) {
			sh_flag = '1';
		} else {
			sh_flag = '0';
		}

		form.action = "p_wh.jsp?sh_flag=" + sh_flag;
		//alert(form.action);
		form.submit();
	}
</script>