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
		��
		<%=w.get("mm")%>
		�·����߼����ҵ�±���
	</div>
	<span style="visibility: hidden;">hold space</span>
	<div class=left>
		վλ����:<%=w.get("station_name")%>
		<!--ͳ���·�:-->
	</div>

	<table class="nui-table-inner major">
		<thead class="nui-table-head">
			<tr class="nui-table-row">
				<th class="nui-table-cell">
					���
				</th>
				<th class="nui-table-cell">
					����
				</th>
				<%
				    for (i = 0; i < 24; i++) {
				%>
				<th class="nui-table-cell"><%=i%></th>

				<%
				    }
				%>
				<th class="nui-table-cell">
					����COD������
				</th>
				<th class="nui-table-cell">
					��ע
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
					��
					<%=w.get("mm")%>
					�·ݹ���
					<%=rs.size()%>
					�����<%=w.get("std")%>&lt=COD��׼ֵ&lt=<%=w.get("std2")%>
					mg/L�������

				</th>
				<th class="nui-table-cell">
					<%=f.format(w.get("avg"), "0.##")%>
				</th>
			</tr>
		</tbody>
	</table>

</div>




