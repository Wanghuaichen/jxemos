<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%
    String cod = request.getParameter("w_cod");
    String ph = request.getParameter("w_ph");
    String q = request.getParameter("w_q");
    Timestamp time = (Timestamp) request.getAttribute("time");
    Map infectantInfo = (Map) request.getAttribute("infectantInfo");
    String station_id = null;
    String s1, s2 = null;
    List data = null;
    RowSet rs = null;
    String v = null;
    String format = "0.####";
    double r = 1000 * 1000;
    int totalnum = AreaReport.getTotalNum(request);
    data = (List) request.getAttribute("data");
    rs = new RowSet(data);
%>
<link rel="stylesheet" href="../../../web/index.css" />
<div id='div_excel_content'>
	<span style="visibility: hidden;">hold space</span>
	<div align="center" style="font-size: 20px; font-weight: bold">
		<%=request.getAttribute("report_name")%>
	</div>
	<span style="visibility: hidden;">hold space</span>
	<div class=left>
		地区:<%=request.getAttribute("area_name")%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 日期：<%=time.getYear() + 1900%>
		年
		<%=time.getMonth() + 1%>
		月
		<%=time.getDate()%>
		日
	</div>
	<table class="nui-table-inner major">
		<thead class="nui-table-head">
			<tr class="nui-table-row">
				<th class="nui-table-cell" rowspan=2 width="140px">
					地区
				</th>
				<th class="nui-table-cell" rowspan=2 width="240px">
					单位名称
				</th>

				<th class="nui-table-cell" colspan=2>
					COD
				</th>
				<th class="nui-table-cell" rowspan=2>
					ph
				</th>
				<th class="nui-table-cell" rowspan=2>
					累积流量M
					<sup>
						3
					</sup>
				</th>
				<th class="nui-table-cell" colspan=3>
					在线率(%)
				</th>
				<th class="nui-table-cell" colspan=2>
					超标率(%)
				</th>
			</tr>
			<tr class="nui-table-row">
				<th class="nui-table-cell">
					mg/L
				</th>
				<th class="nui-table-cell">
					t/d
				</th>
				<th class="nui-table-cell">
					流量
				</th>
				<th class="nui-table-cell">
					PH
				</th>
				<th class="nui-table-cell">
					COD
				</th>
				<th class="nui-table-cell">
					PH
				</th>
				<th class="nui-table-cell">
					COD
				</th>
			</tr>
		</thead>
		<tbody class="nui-table-body">
			<%
			    while (rs.next()) {
			        station_id = rs.get("station_id");
			%>
			<tr>
				<th class="nui-table-cell"><%=rs.get("area_name")%></th>
				<th class="nui-table-cell"><%=rs.get("station_desc")%></th>
				<%
				    v = rs.get(cod);
				        v = AreaReport.v(v, 1, format);
				        v = AreaReport.flag(v, station_id, cod, infectantInfo);
				%>
				<th class="nui-table-cell"><%=v%></th>
				<%
				    v = rs.get(cod + "_q");
				        v = AreaReport.v(v, r, format);
				        v = AreaReport.flag(v, station_id, cod, q, infectantInfo);
				%>
				<th class="nui-table-cell"><%=v%></th>
				<%
				    v = rs.get(ph);
				        v = AreaReport.v(v, 1, format);
				        v = AreaReport.flag(v, station_id, ph, infectantInfo);
				%>
				<th class="nui-table-cell"><%=v%></th>
				<%
				    v = rs.get(q);
				        v = AreaReport.v(v, 1, format);
				        v = AreaReport.flag(v, station_id, q, infectantInfo);
				%>
				<th class="nui-table-cell"><%=v%></th>
				<%
				    s1 = rs.get(q + "_num");
				        s2 = totalnum + "";
				        v = AreaReport.percentv(s1, s2);
				        v = AreaReport.flag(v, station_id, q, infectantInfo);
				%>
				<th class="nui-table-cell"><%=v%></th>
				<%
				    s1 = rs.get(ph + "_num");
				        s2 = totalnum + "";
				        v = AreaReport.percentv(s1, s2);
				        v = AreaReport.flag(v, station_id, ph, infectantInfo);
				%>
				<th class="nui-table-cell"><%=v%></th>
				<%
				    s1 = rs.get(cod + "_num");
				        s2 = totalnum + "";
				        v = AreaReport.percentv(s1, s2);
				        v = AreaReport.flag(v, station_id, cod, infectantInfo);
				%>
				<th class="nui-table-cell"><%=v%></th>
				<%
				    s1 = rs.get(ph + "_over_num");
				        s2 = rs.get(ph + "_num");
				        v = AreaReport.percentv(s1, s2);
				        v = AreaReport.flag(v, station_id, ph, infectantInfo);
				%>
				<th class="nui-table-cell"><%=v%></th>
				<%
				    s1 = rs.get(cod + "_over_num");
				        s2 = rs.get(cod + "_num");
				        v = AreaReport.percentv(s1, s2);
				        v = AreaReport.flag(v, station_id, cod, infectantInfo);
				%>
				<th class="nui-table-cell"><%=v%></th>
			</tr>
			<%
			    }
			%>
			<tr>
				<th class="nui-table-cell">
					合计
				</th>
				<th class="nui-table-cell"><%=data.size()%></th>
				<th class="nui-table-cell">
					-
				</th>
				<%
				    v = AreaReport.sum(data, cod + "_q", r, format);
				    v = AreaReport.flag(v, station_id, cod, q, infectantInfo);
				%>
				<th class="nui-table-cell"><%=v%></th>
				<th class="nui-table-cell">
					-
				</th>
				<%
				    v = AreaReport.sum(data, q, 1, format);
				    v = AreaReport.flag(v, station_id, q, infectantInfo);
				%>
				<th class="nui-table-cell"><%=v%></th>
				<th class="nui-table-cell"></th>
				<th class="nui-table-cell"></th>
				<th class="nui-table-cell"></th>
				<th class="nui-table-cell"></th>
				<th class="nui-table-cell"></th>
			</tr>
		</tbody>
	</table>
</div>