<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%
	String so2, pm, nox, op, t, q, q_lj, temp;
	String avg_so2, avg_pm, avg_nox, sum_q, data_table;

	try {
		SjReport.gas(request);
		so2 = w.p("g_so2");
		pm = w.p("g_pm");
		nox = w.p("g_nox");
		q = w.p("g_q");
		q_lj = w.p("g_q_lj");
		op = w.p("g_op");
		t = w.p("g_t");
		data_table = request.getAttribute("r_data_table") + "";

	} catch (Exception e) {
		w.error(e);
		return;
	}
	RowSet rs = w.rs("list");
	XBean tj = w.b("tj");
	int r = 1000 * 1000;
	String format = "0.0000";
	Integer lenobj = (Integer) request.getAttribute("len");
	int len = lenobj.intValue();
	String v_flag = "";//状态标志
	String css = "zc";
	double llzl = 0;//流量总量
	String t_ljz = "";//某时间段的累积值
	float z_ljz = 0;//总的累积值
	String t_so2 = "";
	float z_so2 = 0;
	String t_pm = "";
	float z_pm = 0;
	String t_nox = "";
	float z_nox = 0;

	avg_so2 = tj.get(so2 + "_avg", 1, format);
	avg_pm = tj.get(pm + "_avg", 1, format);
	avg_nox = tj.get(nox + "_avg", 1, format);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>在线检测和监控管理系统</title>
<!-- <link rel="stylesheet" href="../../web/index.css" /> -->
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div id="div_excel_content">
		<table class="nui-table-inner">
			<thead class="nui-table-head">
				<tr class="nui-table-row">
					<th colspan=9 class="nui-table-cell">当前统计：<%=w.get("station_name")%>
						<%=w.get("area_name")%> <%=w.get("data_table")%> <%=w.get("date1")%>
						到 <%=w.get("date2")%></th>
				</tr>
				<tr class="nui-table-row">
					<!--
   <td rowspan=3>站位名称</th>
   <td rowspan=3>区域</th>
   -->

					<th class="nui-table-cell">监测时间</th>
					<th colspan=4 class="nui-table-cell">排放浓度</th>
					<th colspan=4 class="nui-table-cell">排放量</th>
				</tr>

				<tr class="nui-table-row">
					<th class="nui-table-cell"></th>
					<th class="nui-table-cell">烟尘折算浓度(mg/m<sup>3</sup>)</th>
					<th class="nui-table-cell">SO<sub>2</sub>折算浓度(mg/m<sup>3</sup>)</th>
					<th class="nui-table-cell">NO<sub>x</sub>折算浓度(mg/m<sup>3</sup>)</th>
					<%--<th class="nui-table-cell">烟气温度</th>
    <th class="nui-table-cell">含氧量</th>--%>
					<th class="nui-table-cell">标况流量(Nm<sup>3</sup>/h)</th>


					<th class="nui-table-cell">烟尘(Kg)</th>
					<th class="nui-table-cell">SO<sub>2</sub>(Kg)</th>
					<th class="nui-table-cell">NO<sub>x</sub>(Kg)</th>
					<th class="nui-table-cell">累积流量(m<sup>3</sup>)</th>
				</tr>

				<!--   <tr class="nui-table-row"> -->

				<!--     <th class="nui-table-cell"></th> -->
				<!--     <th class="nui-table-cell">mg/m<sup>3</sup></th> -->
				<!--     <th class="nui-table-cell">mg/m<sup>3</sup></th> -->
				<!--     <th class="nui-table-cell">mg/m<sup>3</sup></th> -->
				<!--     <%--<th class="nui-table-cell">mg/m<sup>3</sup></th> -->
<!--     <th class="nui-table-cell">mg/m<sup>3</sup></th> -->
<!--     --%><%--<th class="nui-table-cell">m<sup>3</sup></th> --%> -->
				<!-- <th class="nui-table-cell">Nm<sup>3</sup>/h</th> -->

				<!--    <th class="nui-table-cell">Kg</th> -->
				<!--     <th class="nui-table-cell">Kg</th> -->
				<!--     <th class="nui-table-cell">Kg</th> -->
				<!--     <th class="nui-table-cell">m<sup>3</sup></th> -->

				<!--   </tr> -->
			</thead>

			<tbody class="nui-table-body">
				<%
					while (rs.next()) {

						v_flag = rs.get("v_flag");
						if (!"".equals(v_flag) && v_flag.equals("5")) {
							css = "wx";
						} else if (!"".equals(v_flag) && v_flag.equals("7")) {
							css = "bl";
						}

						t_ljz = f.format(
								f.getljll(rs.get(q, 1, format), data_table,
										rs.get("m_time"))
										+ "", "0.0000");
						if (t_ljz != null && !"".equals(t_ljz) && !"null".equals(t_ljz)) {
							z_ljz = z_ljz + Float.valueOf(t_ljz);
						}

						t_pm = f.format(
								f.getljll(rs.get(pm + "_q", r, format), data_table,
										2 + "") + "", "0.0000");
						if (t_pm != null && !"".equals(t_pm) && !"null".equals(t_pm)) {
							z_pm = z_pm + Float.valueOf(t_pm);
						}

						t_so2 = f.format(
								f.getljll(rs.get(so2 + "_q", r, format), data_table,
										2 + "") + "", "0.0000");
						if (t_so2 != null && !"".equals(t_so2) && !"null".equals(t_so2)) {
							z_so2 = z_so2 + Float.valueOf(t_so2);
						}

						t_nox = f.format(
								f.getljll(rs.get(nox + "_q", r, format), data_table,
										2 + "") + "", "0.0000");
						if (t_nox != null && !"".equals(t_nox) && !"null".equals(t_nox)) {
							z_nox = z_nox + Float.valueOf(t_nox);
						}
				%>
				<tr class="nui-table-row">
					<th class="nui-table-cell"><%=f.sub(rs.get("m_time"), 0, len)%></th>

					<th class="nui-table-cell"><%=rs.get(pm, 1, format)%></th>
					<th class="nui-table-cell"><%=rs.get(so2, 1, format)%></th>
					<th class="nui-table-cell"><%=rs.get(nox, 1, format)%></th>
					<%-- <th class="nui-table-cell"><%=rs.get(t,1,format)%></th>
      <th class="nui-table-cell"><%=rs.get(op,1,format)%></th>--%>
					<th class="nui-table-cell"><%=rs.get(q, 1, format)%></th>

					<%--<th class="nui-table-cell"><%=rs.get(pm+"_q",r,format)%></th>
      <th class="nui-table-cell"><%=rs.get(so2+"_q",r,format)%></th>
      <th class="nui-table-cell"><%=rs.get(nox+"_q",r,format)%></th>--%>


					<%--<th class="nui-table-cell"><%=f.format(f.getljll(rs.get(pm+"_q",r,format),data_table,2+"")+"","0.0000")%></th>
      <th class="nui-table-cell"><%=f.format(f.getljll(rs.get(so2+"_q",r,format),data_table,2+"")+"","0.0000")%></th>
      <th class="nui-table-cell"><%=f.format(f.getljll(rs.get(nox+"_q",r,format),data_table,2+"")+"","0.0000")%></th>
      
      --%>
					<th class="nui-table-cell"><%=t_pm%></th>
					<th class="nui-table-cell"><%=t_so2%></th>
					<th class="nui-table-cell"><%=t_nox%></th>

					<th class="nui-table-cell"><%=t_ljz%></th>
				</tr>
				<%
					}
				%>

				<tr class="nui-table-row">
					<th class="nui-table-cell">最小值</th>


					<th class="nui-table-cell"><%=tj.get(pm + "_min", 1, format)%></th>
					<th class="nui-table-cell"><%=tj.get(so2 + "_min", 1, format)%></th>
					<th class="nui-table-cell"><%=tj.get(nox + "_min", 1, format)%></th>
					<%--
        <th class="nui-table-cell"><%=tj.get(t+"_min")%></th>
        <th class="nui-table-cell"><%=tj.get(op+"_min")%></th>
        --%>
					<th class="nui-table-cell"><%=tj.get(q + "_min", 1, format)%></th>

					<%--<th ><%=f.format((z_pm/r)+"",format)%></th>
        <th ><%=f.format((z_so2/r)+"",format)%></th>
        <th ><%=f.format((z_nox/r)+"",format)%></th>--%>

					<th colspan=4 class="nui-table-cell"></th>
				</tr>

				<tr class="nui-table-row">
					<th class="nui-table-cell">最大值</th>


					<th class="nui-table-cell"><%=tj.get(pm + "_max", 1, format)%></th>
					<th class="nui-table-cell"><%=tj.get(so2 + "_max", 1, format)%></th>
					<th class="nui-table-cell"><%=tj.get(nox + "_max", 1, format)%></th>
					<%--<th class="nui-table-cell"><%=tj.get(t+"_max")%></th>
        <th class="nui-table-cell"><%=tj.get(op+"_max")%></th>
        --%>
					<th class="nui-table-cell"><%=tj.get(q + "_max", 1, format)%></th>
					<%--
        
        <th ><%=f.format(f.getljll((z_pm/r)+"",data_table,2+"")+"","0.0000")%></th>
        <th ><%=f.format(f.getljll((z_so2/r)+"",data_table,2+"")+"","0.0000")%></th>
        <th ><%=f.format(f.getljll((z_nox/r)+"",data_table,2+"")+"","0.0000")%></th>

        --%>
					<th colspan=4 class="nui-table-cell"></th>
				</tr>


				<tr class="nui-table-row">
					<th class="nui-table-cell">平均值</th>

					<th class="nui-table-cell"><%=tj.get(pm + "_avg", 1, format)%></th>
					<th class="nui-table-cell"><%=tj.get(so2 + "_avg", 1, format)%></th>
					<th class="nui-table-cell"><%=tj.get(nox + "_avg", 1, format)%></th>
					<%--<th class="nui-table-cell"><%=tj.get(t+"_avg",1,format)%></th>
        <th class="nui-table-cell"><%=tj.get(op+"_avg",1,format)%></th>
        --%>
					<th class="nui-table-cell"><%=tj.get(q + "_avg", 1, format)%></th>
					<th colspan=4 class="nui-table-cell"></th>
				</tr>
				<tr class='nui-table-row'>
					<th class="nui-table-cell">总计</th>
					<th colspan="4" class="nui-table-cell"></th>
					<th class="nui-table-cell"><%=z_pm%></th>
					<th class="nui-table-cell"><%=z_so2%></th>
					<th class="nui-table-cell"><%=z_nox%></th>
					<th class="nui-table-cell"><%=z_ljz%></th>
				</tr>

			</tbody>
		</table>

	</div>
</body>
</html>
