<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%@page import="com.hoson.bizreport.*"%>
<%
    List list = null;
    RowSet rs = null;
    XBean b = null;
    Map m = null;
    String now = f.time() + "";
    //now =f.sub(now,0,19);

    try {

        OnlineReport.run7(request);

    } catch (Exception e) {
        JspUtil.go2error(request, response, e);
        return;
    }
    m = (Map) request.getAttribute("bean");
    b = new XBean(m);
%>
<link rel="stylesheet" href="../../web/index.css" />
<div id='div_excel_content'>
	<span style="visibility: hidden;">hold space</span>
	<div style="color: red">
		ע:����Сʱ����ͳ��
	</div>
	<span style="visibility: hidden;">hold space</span>
	<div class=h>
		��<%=b.get("date2")%>��<%=b.get("date1")%>
		�ڼ����ȾԴ���߼�����ѻ���������
	</div>
	<span style="visibility: hidden;">hold space</span>
	<div class=h>
		�ѻ�����
	</div>
	<span style="visibility: hidden;">hold space</span>
	<div class=h>
		ˮ
		<div>

			<table class="nui-table-inner major">
				<thead class="nui-table-head">
					<tr class="nui-table-row">
						<th class="nui-table-cell" style="width: 30px">
							���
						</th>
						<th class="nui-table-cell" style="width: 300px">
							վλ����
						</th>

						<th class="nui-table-cell">
							��ע
						</th>
					</tr>
				</thead>
				<tbody class="nui-table-body">
					<%
					    list = (List) request.getAttribute("waterOfflineList");
					    rs = new RowSet(list);
					    while (rs.next()) {
					%>
					<tr>
						<th class="nui-table-cell"><%=rs.getIndex() + 1%></th>

						<th class="nui-table-cell"><%=rs.get("station_desc")%></th>

						<th class="nui-table-cell"><%=rs.get("station_bz")%></th>

					</tr>
					<%
					    }
					%>
				</tbody>
			</table>

			<div class=h>
				<br>��
			</div>

			<table class="nui-table-inner major">
				<thead class="nui-table-head">
					<tr class="nui-table-row">
						<th class="nui-table-cell" style="width: 30px">
							���
						</th>
						<th class="nui-table-cell" style="width: 300px">
							վλ����
						</th>

						<th class="nui-table-cell">
							��ע
						</th>
					</tr>
				</thead>
				<tbody class="nui-table-body">
					<%
					    list = (List) request.getAttribute("gasOfflineList");
					    rs = new RowSet(list);
					    while (rs.next()) {
					%>
					<tr>
						<th class="nui-table-cell"><%=rs.getIndex() + 1%></th>

						<th class="nui-table-cell"><%=rs.get("station_desc")%></th>

						<th class="nui-table-cell"><%=rs.get("station_bz")%></th>

					</tr>
					<%
					    }
					%>
				</tbody>
			</table>
		</div>
	</div>
</div>
