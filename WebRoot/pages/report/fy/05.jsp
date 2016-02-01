<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%
    BaseAction action = null;

    try {

        action = new FyReport();
        action.run(request, response, "rpt05");

    } catch (Exception e) {
        w.error(e);
        return;
    }
    RowSet rs = w.rs("data");
    String q = (String) w.get("q_col");
%>
<link rel="stylesheet" href="../../../web/index.css" />
<div id='div_excel_content'>
	<span style="visibility: hidden;">hold space</span>
	<div style="font-size: 18px; font-weight: bold; text-align: center;">
		<%=request.getParameter("date1")%>
		�����ձ���
	</div>
	<table class="nui-table-inner major">
		<thead class="nui-table-head">
			<tr class="nui-table-row">
				<th class="nui-table-cell" style="width: 30px">
					���
				</th>
				<th class="nui-table-cell" style="width: 350px">
					վλ����
				</th>
				<th class="nui-table-cell">
					�ŷ�ʱ��(Сʱ����)
				</th>
				<th class="nui-table-cell">
					����(L/S)
				</th>
				<th class="nui-table-cell">
					��ע
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
				<th class="nui-table-cell"><%=rs.get(q + "_count")%></th>
				<th class="nui-table-cell"><%=rs.get(q + "_sum", 1, "0.#")%></th>
				<th class="nui-table-cell"></th>
			</tr>
			<%
			    }
			%>
		</tbody>
	</table>
</div>
