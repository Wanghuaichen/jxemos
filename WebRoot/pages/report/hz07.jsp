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
		注:根据小时数据统计
	</div>
	<span style="visibility: hidden;">hold space</span>
	<div class=h>
		从<%=b.get("date2")%>到<%=b.get("date1")%>
		期间的污染源在线监测监控脱机联机报表
	</div>
	<span style="visibility: hidden;">hold space</span>
	<div class=h>
		脱机名单
	</div>
	<span style="visibility: hidden;">hold space</span>
	<div class=h>
		水
		<div>

			<table class="nui-table-inner major">
				<thead class="nui-table-head">
					<tr class="nui-table-row">
						<th class="nui-table-cell" style="width: 30px">
							序号
						</th>
						<th class="nui-table-cell" style="width: 300px">
							站位名称
						</th>

						<th class="nui-table-cell">
							备注
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
				<br>气
			</div>

			<table class="nui-table-inner major">
				<thead class="nui-table-head">
					<tr class="nui-table-row">
						<th class="nui-table-cell" style="width: 30px">
							序号
						</th>
						<th class="nui-table-cell" style="width: 300px">
							站位名称
						</th>

						<th class="nui-table-cell">
							备注
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
