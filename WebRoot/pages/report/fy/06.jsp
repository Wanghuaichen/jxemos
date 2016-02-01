<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%
    BaseAction action = null;

			try {

				action = new FyReport();
				action.run(request, response, "rpt06");

			} catch (Exception e) {
				w.error(e);
				return;
			}
			RowSet rs = w.rs("stationList");
			XBean b = w.b("dataMap");
			Integer iobj = (Integer) request.getAttribute("daynum");
			int daynum = 30;
			int i = 0;

			if (iobj != null) {
				daynum = iobj.intValue();
			}
			String id = null;
			String key = null;
			String v = null;
			String date1 = request.getParameter("date1");
%>
<link rel="stylesheet" href="../../../web/index.css" />
<form name=form1 method=post action=07.jsp target=new>
	<input type=hidden name=station_type
		value='<%=request.getParameter("station_type")%>'>
	<input type=hidden name=area_id
		value='<%=request.getParameter("area_id")%>'>
	<input type=hidden name=cod_col
		value='<%=request.getParameter("cod_col")%>'>
	<input type=hidden name=cod_std
		value='<%=request.getParameter("cod_std")%>'>
	<input type=hidden name=ww value='<%=request.getParameter("ww")%>'>
	<input type=hidden name=date1
		value='<%=request.getParameter("date1")%>'>
	<input type=hidden name=dd value='1'>
	<input type=hidden name=station_id value='1'>

</form>
<div id='div_excel_content'>
	<span style="visibility: hidden;">hold space</span>
	<div style="font-size: 18px; font-weight: bold; text-align: center">

		<%=f.df(date1, "yy年mm月")%>
		COD超标月报表
	</div>


	<table class="nui-table-inner major" style="width:<%=w.p("ww")%>%">
		<thead class="nui-table-head">
			<tr class="nui-table-row">
				<th class="nui-table-cell" style="width: 30px"></th>
				<th class="nui-table-cell" style="width: 240px"></th>
				<%
				    for (i = 1; i <= daynum; i++) {
				%>
				<th class="nui-table-cell"><%=i%></th>
				<%
				    }
				%>
				<th class="nui-table-cell">
					备注
				</th>

			</tr>
		</thead>
		<tbody class="nui-table-body">
			<%
			    while (rs.next()) {
							id = rs.get("station_id");
			%>
			<tr>
				<th class="nui-table-cell"><%=rs.getIndex() + 1%></th>
				<th class="nui-table-cell"><%=rs.get("station_desc")%></th>
				<%
				    for (i = 1; i <= daynum; i++) {
									key = id + "_dd_" + i;
									v = b.get(key);
									if (f.eq(v, "1")) {
										v = "√";
									}
				%>
				<th class="nui-table-cell"><%=v%></th>
				<%
				    }
				%>
				<th class="nui-table-cell"></th>
			</tr>
			<%
			    }
			%>
		</tbody>
	</table>
</div>

<script>
	function f_day_rpt(dd) {

		form1.action = '07.jsp';
		form1.dd.value = dd;
		form1.submit();

	}

	function f_station_rpt(station_id) {

		form1.action = '08.jsp';
		form1.station_id.value = station_id;
		form1.submit();

	}
</script>
