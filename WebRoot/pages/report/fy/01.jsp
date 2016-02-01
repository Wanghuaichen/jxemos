<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%
    BaseAction action = null;
    try {

        action = new FyReport();
        action.run(request, response, "rpt01");

    } catch (Exception e) {
        w.error(e);
        return;
    }
    RowSet rs = w.rs("dataList");
    int i, num = 0;
    num = 24;
    String key = null;
%>
<link rel="stylesheet" href="../../../web/index.css" />
<div id='div_excel_content'>
	<span style="visibility: hidden;">hold space</span>
	<div align=center style="font-size: 18px; font-weight: bold">
		<%=w.get("yy")%>
		年
		<%=w.get("mm")%>
		月份在线监控企业月报表
	</div>
	<span style="visibility: hidden;">hold space</span>
	<div class=left>
		站位名称:<%=w.get("station_name")%>
		<!--统计月份:-->
	</div>

	<table class="nui-table-inner major">
		<thead class="nui-table-head">
			<tr class="nui-table-row">
				<th class="nui-table-cell">
					序号
				</th>
				<th class="nui-table-cell">
					日期
				</th>
				<%
				    for (i = 0; i < 24; i++) {
				%>
				<th class="nui-table-cell"><%=i%></th>

				<%
				    }
				%>
				<th class="nui-table-cell">
					超标COD日数据
				</th>
				<th class="nui-table-cell">
					备注
				</th>
			</tr>
		</thead>
		<tbody class="nui-table-body">
			</tr>
			<%
			    while (rs.next()) {
			%>
			<tr>
				<th class="nui-table-cell"><%=rs.getIndex() + 1%></th>
				<th class="nui-table-cell"><%=rs.get("date")%></th>
				<%
				    for (i = 0; i < 24; i++) {
				            key = i + "";
				%>
				<th class="nui-table-cell"><%=rs.get(key)%></th>
				<%
				    }
				%>
				<th class="nui-table-cell"><%=f.format(rs.get("avg"), "0.##")%></th>
				<th class="nui-table-cell"></th>
			</tr>
			<%
			    }
			%>
			<tr>
				<th class="nui-table-cell" colspan=27>
					<%=w.get("yy")%>
					年
					<%=w.get("mm")%>
					月份共有
					<%=rs.size()%>
					天出现<%=w.get("std")%>&lt=COD标准值&lt=<%=w.get("std2")%>
					mg/L排污情况

				</th>
				<th class="nui-table-cell">
					<%=f.format(w.get("avg"), "0.##")%>
				</th>
			</tr>
		</tbody>
	</table>

</div>




