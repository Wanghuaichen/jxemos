<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%
    BaseAction action = null;
    String q_col, toc_col, ph_col, cod_col = null;
    String f = "0.##";
    double r = 1000;
    try {

        action = new SxReport();
        action.run(request, response, "rpt06");
        q_col = w.p("q_col");
        toc_col = w.p("toc_col");
        cod_col = w.p("cod_col");
        ph_col = w.p("ph_col");

    } catch (Exception e) {
        w.error(e);
        return;
    }
    RowSet rs = w.rs("data");
%>
<link rel="stylesheet" href="../../../web/index.css" />
<div id='div_excel_content'>
	<span style="visibility: hidden;">hold space</span>
	<div style="font-size: 18px; font-weight: bold; text-align: center">
		<%=SxReportUtil.getTitleTime(request)%>
		废水在线监测点完好率统计报表
	</div>


	<table class="nui-table-inner major">
		<thead class="nui-table-head">
			<tr class="nui-table-row">
				<th class="nui-table-cell" rowspan=2 style="width: 15">
					序号
				</th>
				<th class="nui-table-cell" rowspan=2 style="width: 190">
					监测点
				</th>
				<th class="nui-table-cell" colspan=5>
					流量数据
				</th>
				<th class="nui-table-cell" colspan=5>
					COD数据
				</th>
				<th class="nui-table-cell" colspan=5>
					PH
				</th>
				<th class="nui-table-cell" rowspan=2 style="padding: 4px">
					平均完好率(%)
				</th>
			</tr>
			<tr class="nui-table-row">
				<th class="nui-table-cell" style="padding: 4px">
					应得个数
				</th>
				<th class="nui-table-cell" style="padding: 4px">
					实得个数
				</th>
				<th class="nui-table-cell" style="padding: 4px">
					缺失个数
				</th>
				<th class="nui-table-cell" style="padding: 4px">
					完好率
				</th>
				<th class="nui-table-cell" style="padding: 4px">
					缺失原因
				</th>

				<th class="nui-table-cell" style="padding: 4px">
					应得个数
				</th>
				<th class="nui-table-cell" style="padding: 4px">
					实得个数
				</th>
				<th class="nui-table-cell" style="padding: 4px">
					缺失个数
				</th>
				<th class="nui-table-cell" style="padding: 4px">
					完好率
				</th>
				<th class="nui-table-cell" style="padding: 4px">
					缺失原因
				</th>

				<th class="nui-table-cell" style="padding: 4px">
					应得个数
				</th>
				<th class="nui-table-cell" style="padding: 4px">
					实得个数
				</th>
				<th class="nui-table-cell" style="padding: 4px">
					缺失个数
				</th>
				<th class="nui-table-cell" style="padding: 4px">
					完好率
				</th>
				<th class="nui-table-cell" style="padding: 4px">
					缺失原因
				</th>
			</tr>
		</thead>
		<tbody class="nui-table-body">
			<%
			    while (rs.next()) {
			%>
			<tr>
				<th class="nui-table-cell"><%=rs.getIndex() + 1%></th>
				<th class="nui-table-cell"><%=rs.get("station_desc")%></th>
				<th class="nui-table-cell"><%=rs.get(q_col + "_num_all")%></th>
				<th class="nui-table-cell"><%=rs.get(q_col + "_num")%></th>
				<th class="nui-table-cell"><%=rs.get(q_col + "_num_no")%></th>
				<th class="nui-table-cell"><%=rs.get(q_col + "_r", 1, f)%></th>
				<th class="nui-table-cell"></th>
				<th class="nui-table-cell"><%=rs.get(cod_col + "_num_all")%></th>
				<th class="nui-table-cell"><%=rs.get(cod_col + "_num")%></th>
				<th class="nui-table-cell"><%=rs.get(cod_col + "_num_no")%></th>
				<th class="nui-table-cell"><%=rs.get(cod_col + "_r", 1, f)%></th>
				<th class="nui-table-cell"></th>
				<th class="nui-table-cell"><%=rs.get(ph_col + "_num_all")%></th>

				<th class="nui-table-cell"><%=rs.get(ph_col + "_num")%></th>

				<th class="nui-table-cell"><%=rs.get(ph_col + "_num_no")%></th>

				<th class="nui-table-cell"><%=rs.get(ph_col + "_r", 1, f)%></th>

				<th class="nui-table-cell"></th>
				<th class="nui-table-cell"><%=rs.get("r_avg", 1, f)%></th>

			</tr>
			<%
			    }
			%>
		</tbody>
	</table>
</div>