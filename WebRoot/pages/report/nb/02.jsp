<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%
    BaseAction action = null;
    try {
        action = new ReportNbAction();
        action.run(request, response, "rpt02");

    } catch (Exception e) {
        w.error(e);
        return;
    }
    RowSet rs = w.rs("data");
%>

<link rel="stylesheet" href="../../../web/index.css" />
<body>
	<div class="tableSty1" id='div_excel_content'>
		<span style="visibility: hidden;">hold space</span>

		<div align=center style="font-size: 16px; font-weight: bold;">
			污染源在线监测日报表
		</div>
		<table class="nui-table-inner major">
			<thead class="nui-table-head">
				<tr class="nui-table-row">
					<th class="nui-table-cell" style="width: 250px">
						站位名称
					</th>
					<th class="nui-table-cell">
						PH超标率
					</th>
					<th class="nui-table-cell">
						COD超标率
					</th>
					<th class="nui-table-cell">
						COD平均值 mg/L
					</th>
					<th class="nui-table-cell">
						COD累积量 kg
					</th>
					<th class="nui-table-cell">
						COD计算值 kg
					</th>
					<th class="nui-table-cell">
						流量累积量 m
						<sup>
							3
						</sup>
					</th>
					<th class="nui-table-cell">
						流量计算值 m
						<sup>
							3
						</sup>
					</th>
					<th class="nui-table-cell">
						流量获取率
					</th>
					<th class="nui-table-cell">
						COD获取率
					</th>
				</tr>
			</thead>
			<tbody class="nui-table-body">
				<%
				    while (rs.next()) {
				%>
				<tr>
					<th class="nui-table-cell"><%=rs.get("station_desc")%></th>
					<th class="nui-table-cell"><%=f.format(rs.get("ph_up"), "#")%>
					</th>
					<th class="nui-table-cell"><%=f.format(rs.get("cod_up"), "#")%>
					</th>
					<th class="nui-table-cell"><%=f.format(rs.get("cod_avg"), "#.##")%></th>
					<th class="nui-table-cell"><%=f.format(rs.get("cod1"), "#.##")%></th>
					<th class="nui-table-cell"><%=f.format(rs.get("cod2"), "#.##")%></th>
					<th class="nui-table-cell"><%=rs.get("q")%></th>
					<th class="nui-table-cell"><%=f.format(rs.get("q2"), "#.##")%></th>
					<th class="nui-table-cell"><%=f.format(rs.get("r"), "#")%></th>
					<th class="nui-table-cell"><%=f.format(rs.get("r_cod"), "#")%></th>

				</tr>
				<%
				    }
				%>
			</tbody>
		</table>
	</div>
</body>