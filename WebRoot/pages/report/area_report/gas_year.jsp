<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%
    String q = request.getParameter("g_q");
    String pm = request.getParameter("g_pm");
    String so2 = request.getParameter("g_so2");
    String nox = request.getParameter("g_nox");
    Timestamp time = (Timestamp) request.getAttribute("time");
    List data = null;
    RowSet rs = null;
    Map infectantInfo = (Map) request.getAttribute("infectantInfo");
    //System.out.println(infectantInfo);
    String v = null;
    String s1, s2 = null;
    String station_id = null;
    String format = "0.####";
    int totalnum = AreaReport.getTotalNum(request);
    double r = 1000 * 1000 * 1000;
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
					SO
					<sub>2</sub>
				</th>

				<th class="nui-table-cell" colspan=2>
					烟尘
				</th>
				<th class="nui-table-cell" colspan=2>
					NO
					<sub>x</sub>
				</th>

				<th class="nui-table-cell" rowspan=2>
					标况流量

				</th>
				<th class="nui-table-cell" colspan=4>
					在线率(%)
				</th>
				<th class="nui-table-cell" colspan=3>
					超标率(%)

				</th>
			</tr>


			<tr class=title>
				<th class="nui-table-cell">
					mg/m
					<sup>
						3
					</sup>
				</th>

				<th class="nui-table-cell">
					t/y

				</th>
				<th class="nui-table-cell">
					mg/m
					<sup>
						3
					</sup>
				</th>

				<th class="nui-table-cell">
					t/y

				</th>
				<th class="nui-table-cell">
					mg/m
					<sup>
						3
					</sup>
				</th>

				<th class="nui-table-cell">
					t/y



				</th>
				<th class="nui-table-cell">
					流量
				</th>
				<th class="nui-table-cell">
					SO
					<sub>2</sub>
				</th>

				<th class="nui-table-cell">
					烟尘
				</th>
				<th class="nui-table-cell">
					NO
					<sub>x</sub>
				</th>


				<th class="nui-table-cell">
					SO
					<sub>2</sub>
				</th>

				<th class="nui-table-cell">
					烟尘
				</th>
				<th class="nui-table-cell">
					NO
					<sub>x</sub>
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
				    v = rs.get(so2);
				        v = AreaReport.v(v, 1, format);
				        v = AreaReport.flag(v, station_id, so2, infectantInfo);
				%>
				<th class="nui-table-cell"><%=v%></th>

				<%
				    v = rs.get(so2 + "_q");
				        v = AreaReport.v(v, r, format);
				        v = AreaReport.flag(v, station_id, so2, q, infectantInfo);
				%>
				<th class="nui-table-cell"><%=v%></th>

				<%
				    v = rs.get(pm);
				        v = AreaReport.v(v, 1, format);
				        v = AreaReport.flag(v, station_id, pm, infectantInfo);
				%>
				<th class="nui-table-cell"><%=v%></th>

				<%
				    v = rs.get(pm + "_q");
				        v = AreaReport.v(v, r, format);
				        v = AreaReport.flag(v, station_id, pm, q, infectantInfo);
				%>
				<th class="nui-table-cell"><%=v%></th>

				<%
				    v = rs.get(nox);
				        v = AreaReport.v(v, 1, format);
				        v = AreaReport.flag(v, station_id, nox, infectantInfo);
				%>
				<th class="nui-table-cell"><%=v%></th>

				<%
				    v = rs.get(nox + "_q");
				        v = AreaReport.v(v, r, format);
				        v = AreaReport.flag(v, station_id, nox, q, infectantInfo);
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
				    s1 = rs.get(so2 + "_num");
				        s2 = totalnum + "";
				        v = AreaReport.percentv(s1, s2);
				        v = AreaReport.flag(v, station_id, so2, infectantInfo);
				%>
				<th class="nui-table-cell"><%=v%></th>

				<th class="nui-table-cell"><%=v%></th>

				<%
				    s1 = rs.get(nox + "_num");
				        s2 = totalnum + "";
				        v = AreaReport.percentv(s1, s2);
				        v = AreaReport.flag(v, station_id, nox, infectantInfo);
				%>
				<th class="nui-table-cell"><%=v%></th>



				<%
				    s1 = rs.get(so2 + "_over_num");
				        s2 = rs.get(so2 + "_num");
				        v = AreaReport.percentv(s1, s2);
				        v = AreaReport.flag(v, station_id, so2, infectantInfo);
				%>
				<th class="nui-table-cell"><%=v%></th>

				<%
				    s1 = rs.get(pm + "_over_num");
				        s2 = rs.get(pm + "_num");
				        v = AreaReport.percentv(s1, s2);
				        v = AreaReport.flag(v, station_id, pm, infectantInfo);
				%>
				<th class="nui-table-cell"><%=v%></th>

				<%
				    s1 = rs.get(nox + "_over_num");
				        s2 = rs.get(nox + "_num");
				        v = AreaReport.percentv(s1, s2);
				        v = AreaReport.flag(v, station_id, nox, infectantInfo);
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
				    v = AreaReport.sum(data, so2 + "_q", r, format);
				    //v = AreaReport.flag(v,station_id,so2,q,infectantInfo);
				%>
				<th class="nui-table-cell"><%=v%></th>


				<th class="nui-table-cell">
					-
				</th>
				<%
				    v = AreaReport.sum(data, pm + "_q", r, format);
				    //v = AreaReport.flag(v,station_id,pm,q,infectantInfo);
				%>
				<th class="nui-table-cell"><%=v%></th>


				<th class="nui-table-cell">
					-
				</th>
				<%
				    v = AreaReport.sum(data, nox + "_q", r, format);
				    //v = AreaReport.flag(v,station_id,nox,q,infectantInfo);
				%>
				<th class="nui-table-cell"><%=v%></th>


				<%
				    v = AreaReport.sum(data, q, 1, format);
				    //v = AreaReport.flag(v,station_id,q,infectantInfo);
				%>
				<th class="nui-table-cell"><%=v%></th>


				<th class="nui-table-cell"></th>

				<th class="nui-table-cell"></th>

				<th class="nui-table-cell"></th>

				<th class="nui-table-cell"></th>


				<th class="nui-table-cell"></th>

				<th class="nui-table-cell"></th>

				<th class="nui-table-cell"></th>




			</tr>
		</tbody>

	</table>

</div>


