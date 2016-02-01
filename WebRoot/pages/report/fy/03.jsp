<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%
	BaseAction action = null;
	try {

		action = new FyReport();
		action.run(request, response, "dataList");

	} catch (Exception e) {
		w.error(e);
		return;
	}
	RowSet rs1 = w.rs("infectantList");
	RowSet rs2 = w.rs("dataList");
	String col = null;
	String v = null;
	String m_time = null;
	String times = "";
	String gz_flag = null;
	String m_time2 = null;
	String station_id = w.p("station_id");
%>
<link rel="stylesheet" href="../../../web/index.css" />
<form name=form1 method=post action=update.jsp target=qqq>
	<input type=hidden name=station_id value='<%=w.p("station_id")%>'>
	<input type=hidden name=start value='<%=w.get("start")%>'> <input
		type=hidden name=end value='<%=w.get("end")%>'> <input
		type=hidden name=row_num value='<%=rs2.size()%>'>
	<table class="nui-table-inner major">
		<thead class="nui-table-head">
			<tr class="nui-table-row">
				<th class="nui-table-cell" style="width:30px">序号</th>
				<th class="nui-table-cell" style="width:80px">时间</th>
				<%
					while (rs1.next()) {
				%>
				<th class="nui-table-cell"><%=rs1.get("infectant_name")%><br>
					<%=rs1.get("infectant_unit")%></th>
				<%
					}
				%>
				<th class="nui-table-cell">是否为故障<br> <input type=button
					value='保存' class=btn onclick=f_update()></th>
			</tr>
		</thead>
		<tbody class="nui-table-body">
			<%
				while (rs2.next()) {
					rs1.reset();
					m_time = rs2.get("m_time");
					//m_time = f.sub(m_time,0,10);
					//times = times+m_time+",";
					m_time2 = f.sub(m_time, 0, 10);
					if (f.eq(rs2.get("is_gz"), "1")) {
						gz_flag = " checked";
					} else {
						gz_flag = "";
					}
			%>
			<tr>
				<th class="nui-table-cell"><%=rs2.getIndex() + 1%></th>
				<th class="nui-table-cell"><a
					href='data.jsp?station_id=<%=station_id%>&m_time=<%=m_time2%>'
					target=new><%=m_time2%></a>
				</th>
				<%
					while (rs1.next()) {
							col = rs1.get("infectant_column");
							if (col == null) {
								col = "";
							}
							col = col.toLowerCase();
							v = rs2.get(col);
							v = f.v(v);
				%>
				<th class="nui-table-cell"><%=v%></th>
				<%
					}
				%>

				<th class="nui-table-cell"><input type=checkbox name=m_time
					value='<%=m_time%>' <%=gz_flag%>>
				</th>
			</tr>
			<%
				}
			%>

		</tbody>
	</table>

</form>

<iframe name=qqq width=0 height=0></iframe>
<script>
	function f_update() {
		if (form1.row_num.value < 1) {
			alert("没有数据");
			return;
		}
		var msg = "确认将选中的数据作为故障数据";
		if (!confirm(msg)) {
			return;
		}
		form1.submit();
	}
</script>



