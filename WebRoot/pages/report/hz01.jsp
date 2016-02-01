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
		注:根据小时数据统计
	</div>
	<span style="visibility: hidden;">hold space</span>
	<div class=h><%=now%>
		污染源在线监测监控数据情况
	</div>

	<table class="nui-table-inner major">
		<thead class="nui-table-head">
			<tr class="nui-table-row">
				<th class="nui-table-cell" style="width: 10%" rowspan=3></th>
				<th class="nui-table-cell" style="width: 50%" colspan=3>
					所有企业
				</th>

				<th class="nui-table-cell" style="width: 40%" colspan=2>
					国控
				</th>
			</tr>
			<tr class="nui-table-row">
				<th class="nui-table-cell" colspan=2>
					联网
				</th>

				<th class="nui-table-cell" rowspan=2>
					脱机
				</th>
				<th class="nui-table-cell" rowspan=2>
					脱机
				</th>
				<th class="nui-table-cell" rowspan=2>
					COD/SO2为0
				</th>
			</tr>
			<tr class="nui-table-row">
				<th class="nui-table-cell">
					联网数
				</th>
				<th class="nui-table-cell">
					COD/SO2为0
				</th>
			</tr>
		</thead>
		<tbody class="nui-table-body">
			<tr class="nui-table-row">
				<th class="nui-table-cell">
					水
				</th>
				<th class="nui-table-cell"><%=b.get("waterOnlineNum")%></th>
				<th class="nui-table-cell"><%=b.get("waterZeroNum")%></th>
				<th class="nui-table-cell"><%=b.get("waterOfflineNum")%></th>
				<th class="nui-table-cell"><%=b.get("waterOfflineNumNation")%></th>
				<th class="nui-table-cell"><%=b.get("waterZeroNumNation")%></th>
			</tr>
			<tr class="nui-table-row">
				<th class="nui-table-cell">
					气
				</th>
				<th class="nui-table-cell"><%=b.get("gasOnlineNum")%></th>
				<th class="nui-table-cell"><%=b.get("gasZeroNum")%></th>
				<th class="nui-table-cell"><%=b.get("gasOfflineNum")%></th>
				<th class="nui-table-cell"><%=b.get("gasOfflineNumNation")%></th>
				<th class="nui-table-cell"><%=b.get("gasZeroNumNation")%></th>
			</tr>
			<tr class="nui-table-row">
				<th class="nui-table-cell">
					合计
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
				气
			</div>
			<span style="visibility: hidden;">hold space</span>

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

			<span style="visibility: hidden;">hold space</span>
			<div class=h>
				国控污染源在线监测监控数据情况
			</div>
			<span style="visibility: hidden;">hold space</span>

			<div class=h>
				COD为0：<%=b.get("waterZeroNumNation")%>家
			</div>
			<span style="visibility: hidden;">hold space</span>

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
							地区
						</th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>

			<span style="visibility: hidden;">hold space</span>

			<div class=h>
				SO2为0：<%=b.get("gasZeroNumNation")%>家
			</div>
			<span style="visibility: hidden;">hold space</span>


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
							地区
						</th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>

			<span style="visibility: hidden;">hold space</span>

			<div class=h>
				脱机：<%=b.get("offlineNumNation")%></div>
			<span style="visibility: hidden;">hold space</span>

			<div class=h>
				水
			</div>
			<span style="visibility: hidden;">hold space</span>
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
							地区
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
				气
			</div>
			<span style="visibility: hidden;">hold space</span>

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
							地区
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
