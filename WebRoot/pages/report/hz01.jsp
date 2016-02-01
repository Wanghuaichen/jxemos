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
    now = request.getParameter("date");
    try {

        OnlineReport.run(request);

    } catch (Exception e) {
        JspUtil.go2error(request, response, e);
        return;
    }
    m = (Map) request.getAttribute("bean");
    b = new XBean(m);
%>
<link rel="stylesheet" href="../../web/index.css" />

<!--<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css">
<style>
body{text-align:left;}
.h{
   font-size:20px;
   font-weight:bold;
}
</style>
-->
<div id='div_excel_content'>
	<span style="visibility: hidden;">hold space</span>
	<div style="color: red">
		ע:����Сʱ����ͳ��
	</div>
	<span style="visibility: hidden;">hold space</span>
	<div class=h><%=now%>
		��ȾԴ���߼�����������
	</div>

	<table class="nui-table-inner major">
		<thead class="nui-table-head">
			<tr class="nui-table-row">
				<th class="nui-table-cell" style="width: 10%" rowspan=3></th>
				<th class="nui-table-cell" style="width: 50%" colspan=3>
					������ҵ
				</th>

				<th class="nui-table-cell" style="width: 40%" colspan=2>
					����
				</th>
			</tr>
			<tr class="nui-table-row">
				<th class="nui-table-cell" colspan=2>
					����
				</th>

				<th class="nui-table-cell" rowspan=2>
					�ѻ�
				</th>
				<th class="nui-table-cell" rowspan=2>
					�ѻ�
				</th>
				<th class="nui-table-cell" rowspan=2>
					COD/SO2Ϊ0
				</th>
			</tr>
			<tr class="nui-table-row">
				<th class="nui-table-cell">
					������
				</th>
				<th class="nui-table-cell">
					COD/SO2Ϊ0
				</th>
			</tr>
		</thead>
		<tbody class="nui-table-body">
			<tr class="nui-table-row">
				<th class="nui-table-cell">
					ˮ
				</th>
				<th class="nui-table-cell"><%=b.get("waterOnlineNum")%></th>
				<th class="nui-table-cell"><%=b.get("waterZeroNum")%></th>
				<th class="nui-table-cell"><%=b.get("waterOfflineNum")%></th>
				<th class="nui-table-cell"><%=b.get("waterOfflineNumNation")%></th>
				<th class="nui-table-cell"><%=b.get("waterZeroNumNation")%></th>
			</tr>
			<tr class="nui-table-row">
				<th class="nui-table-cell">
					��
				</th>
				<th class="nui-table-cell"><%=b.get("gasOnlineNum")%></th>
				<th class="nui-table-cell"><%=b.get("gasZeroNum")%></th>
				<th class="nui-table-cell"><%=b.get("gasOfflineNum")%></th>
				<th class="nui-table-cell"><%=b.get("gasOfflineNumNation")%></th>
				<th class="nui-table-cell"><%=b.get("gasZeroNumNation")%></th>
			</tr>
			<tr class="nui-table-row">
				<th class="nui-table-cell">
					�ϼ�
				</th>
				<th class="nui-table-cell"><%=b.get("onlineNum")%></th>
				<th class="nui-table-cell"><%=b.get("zeroNum")%></th>
				<th class="nui-table-cell"><%=b.get("offlineNum")%></th>
				<th class="nui-table-cell"><%=b.get("offlineNumNation")%></th>
				<th class="nui-table-cell"><%=b.get("zeroNumNation")%></th>
			</tr>
		</tbody>
	</table>

	<span style="visibility: hidden;">hold space</span>
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
					<tr class="nui-table-row">
						<th class="nui-table-cell">
							<%=rs.getIndex() + 1%>
						</th>
						<th class="nui-table-cell">
							<%=rs.get("station_desc")%>
						</th>
						<th class="nui-table-cell">
							<%=rs.get("station_bz")%>
						</th>
					</tr>
					<%
					    }
					%>
				</tbody>
			</table>


			<span style="visibility: hidden;">hold space</span>
			<div class=h>
				��
			</div>
			<span style="visibility: hidden;">hold space</span>

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

			<span style="visibility: hidden;">hold space</span>
			<div class=h>
				������ȾԴ���߼�����������
			</div>
			<span style="visibility: hidden;">hold space</span>

			<div class=h>
				CODΪ0��<%=b.get("waterZeroNumNation")%>��
			</div>
			<span style="visibility: hidden;">hold space</span>

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
							����
						</th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>

			<span style="visibility: hidden;">hold space</span>

			<div class=h>
				SO2Ϊ0��<%=b.get("gasZeroNumNation")%>��
			</div>
			<span style="visibility: hidden;">hold space</span>


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
							����
						</th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>

			<span style="visibility: hidden;">hold space</span>

			<div class=h>
				�ѻ���<%=b.get("offlineNumNation")%></div>
			<span style="visibility: hidden;">hold space</span>

			<div class=h>
				ˮ
			</div>
			<span style="visibility: hidden;">hold space</span>
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
							����
						</th>
					</tr>
				</thead>
				<tbody>
					<%
					    list = (List) request.getAttribute("waterZeroListNation");
					    rs = new RowSet(list);
					    while (rs.next()) {
					%>
					<tr>
						<th class="nui-table-cell"><%=rs.getIndex() + 1%></th>
						<th class="nui-table-cell"><%=rs.get("station_desc")%></th>

						<th class="nui-table-cell"><%=rs.get("area_name")%></th>

					</tr>
					<%
					    }
					%>
				</tbody>
			</table>

			<span style="visibility: hidden;">hold space</span>

			<div class=h>
				��
			</div>
			<span style="visibility: hidden;">hold space</span>

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
							����
						</th>
					</tr>
				</thead>
				<tbody class="nui-table-body">
					<%
					    list = (List) request.getAttribute("gasZeroListNation");
					    rs = new RowSet(list);
					    while (rs.next()) {
					%>
					<tr>
						<th class="nui-table-cell"><%=rs.getIndex() + 1%></th>

						<th class="nui-table-cell"><%=rs.get("station_desc")%></th>

						<th class="nui-table-cell"><%=rs.get("area_name")%></th>

					</tr>
					<%
				    }
				%>
				</tbody>
			</table>

		</div>
	</div>
</div>
