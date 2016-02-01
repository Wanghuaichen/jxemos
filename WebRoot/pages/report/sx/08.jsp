<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%
    BaseAction action = null;
    String q_col, toc_col, ph_col, cod_col, nh3n_col = null;
    String f = "0.##";
    double r = 1000;
    try {

        action = new SxReport();
        action.run(request, response, "rpt08");
        q_col = w.p("q_col");
        toc_col = w.p("toc_col");
        cod_col = w.p("cod_col");
        ph_col = w.p("ph_col");
        nh3n_col = w.p("nh3n_col");

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
		��ˮ���߼���������ͳ�Ʊ���(��Ч������δ�������ݡ�����ʣ���Ч����/ʵ�ø���)
	</div>


	<table class="nui-table-inner major">
		<thead class="nui-table-head">
			<tr class="nui-table-row">
				<th class="nui-table-cell" rowspan=2 style="width: 15px">
					���
				</th>
				<th class="nui-table-cell" rowspan=2 style="width: 190px">
					����
				</th>
				<th class="nui-table-cell" colspan=5>
					��������
				</th>
				<th class="nui-table-cell" colspan=5>
					PH
				</th>
				<th class="nui-table-cell" colspan=5>
					COD����
				</th>

				<th class="nui-table-cell" rowspan=2>
					ƽ��������(%)
				</th>
				<th class="nui-table-cell" rowspan=2>
					ƽ�������(%)
				</th>

				<th class="nui-table-cell" rowspan=2>
					��ע
				</th>
			</tr>

			<tr class=title>

				<th class="nui-table-cell">
					Ӧ�ø���
				</th>
				<th class="nui-table-cell">
					ʵ�ø���
				</th>
				<th class="nui-table-cell">
					��Ч����
				</th>
				<th class="nui-table-cell">
					������
				</th>
				<th class="nui-table-cell">
					�����
				</th>

				<th class="nui-table-cell">
					Ӧ�ø���
				</th>
				<th class="nui-table-cell">
					ʵ�ø���
				</th>
				<th class="nui-table-cell">
					��Ч����
				</th>
				<th class="nui-table-cell">
					������
				</th>
				<th class="nui-table-cell">
					�����
				</th>

				<th class="nui-table-cell">
					Ӧ�ø���
				</th>
				<th class="nui-table-cell">
					ʵ�ø���
				</th>
				<th class="nui-table-cell">
					��Ч����
				</th>
				<th class="nui-table-cell">
					������
				</th>
				<th class="nui-table-cell">
					�����
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
				<th class="nui-table-cell"><%=rs.get(q_col + "_num_ok")%></th>
				<th class="nui-table-cell"><%=rs.get(q_col + "_r", 1, f)%></th>
				<th class="nui-table-cell"><%=rs.get(q_col + "_r_ok", 1, f)%></th>

				<th class="nui-table-cell"><%=rs.get(ph_col + "_num_all")%></th>
				<th class="nui-table-cell"><%=rs.get(ph_col + "_num")%></th>
				<th class="nui-table-cell"><%=rs.get(ph_col + "_num_ok")%></th>
				<th class="nui-table-cell"><%=rs.get(ph_col + "_r", 1, f)%></th>
				<th class="nui-table-cell"><%=rs.get(ph_col + "_r_ok", 1, f)%></th>

				<th class="nui-table-cell"><%=rs.get(cod_col + "_num_all")%></th>
				<th class="nui-table-cell"><%=rs.get(cod_col + "_num")%></th>
				<th class="nui-table-cell"><%=rs.get(cod_col + "_num_ok")%></th>
				<th class="nui-table-cell"><%=rs.get(cod_col + "_r", 1, f)%></th>
				<th class="nui-table-cell"><%=rs.get(cod_col + "_r_ok", 1, f)%></th>

				<th class="nui-table-cell"><%=rs.get("r_avg", 1, f)%></th>
				<th class="nui-table-cell"><%=rs.get("r_ok_avg", 1, f)%></th>
				<th class="nui-table-cell"></th>
			</tr>
			<%
			    }
			%>
		</tbody>
	</table>
</div>