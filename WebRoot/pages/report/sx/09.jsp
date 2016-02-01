<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%
    BaseAction action = null;
    String v_col, so2_col, nox_col, pm_col, o2_col, p_col = null;
    String f = "0.##";
    double r = 1000;
    try {

        action = new SxReport();
        action.run(request, response, "rpt09");
        v_col = w.p("v_col");
        so2_col = w.p("so2_col");
        nox_col = w.p("nox_col");

        pm_col = w.p("pm_col");
        o2_col = w.p("o2_col");
        p_col = w.p("p_col");
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
		�������߼���������ͳ�Ʊ���
	</div>


	<table class="nui-table-inner major">
		<thead class="nui-table-head">
			<tr class="nui-table-row">
				<th class="nui-table-cell" rowspan=2 style="width: 12px">
					���
				</th>
				<th class="nui-table-cell" rowspan=2 style="width: 170px">
					����
				</th>

				<th class="nui-table-cell" colspan=5>
					��������
				</th>
				<th class="nui-table-cell" colspan=5>
					SO
					<SUB>2</SUB>
				</th>
				<th class="nui-table-cell" colspan=5>
					NO
					<SUB>x</SUB>
				</th>
				<th class="nui-table-cell" colspan=5>
					�̳�
				</th>
				<th class="nui-table-cell" colspan=5>
					O
					<SUB>2</SUB>
				</th>
				<th class="nui-table-cell" colspan=5>
					ѹ��
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

				<th class="nui-table-cell" style="padding: 1.5px">
					Ӧ�ø���
				</th>
				<th class="nui-table-cell" style="padding: 1.5px">
					ʵ�ø���
				</th>
				<th class="nui-table-cell" style="padding: 1.5px">
					��Ч����
				</th>
				<th class="nui-table-cell" style="padding: 1.5px">
					������
				</th>
				<th class="nui-table-cell" style="padding: 1.5px">
					�����
				</th>



				<th class="nui-table-cell" style="padding: 1.5px">
					Ӧ�ø���
				</th>
				<th class="nui-table-cell" style="padding: 1.5px">
					ʵ�ø���
				</th>
				<th class="nui-table-cell" style="padding: 1.5px">
					��Ч����
				</th>
				<th class="nui-table-cell" style="padding: 1.5px">
					������
				</th>
				<th class="nui-table-cell" style="padding: 1.5px">
					�����
				</th>



				<th class="nui-table-cell" style="padding: 1.5px">
					Ӧ�ø���
				</th>
				<th class="nui-table-cell" style="padding: 1.5px">
					ʵ�ø���
				</th>
				<th class="nui-table-cell" style="padding: 1.5px">
					��Ч����
				</th>
				<th class="nui-table-cell" style="padding: 1.5px">
					������
				</th>
				<th class="nui-table-cell" style="padding: 1.5px">
					�����
				</th>



				<th class="nui-table-cell" style="padding: 1.5px">
					Ӧ�ø���
				</th>
				<th class="nui-table-cell" style="padding: 1.5px">
					ʵ�ø���
				</th>
				<th class="nui-table-cell" style="padding: 1.5px">
					��Ч����
				</th>
				<th class="nui-table-cell" style="padding: 1.5px">
					������
				</th>
				<th class="nui-table-cell" style="padding: 1.5px">
					�����
				</th>



				<th class="nui-table-cell" style="padding: 1.5px">
					Ӧ�ø���
				</th>
				<th class="nui-table-cell" style="padding: 1.5px">
					ʵ�ø���
				</th>
				<th class="nui-table-cell" style="padding: 1.5px">
					��Ч����
				</th>
				<th class="nui-table-cell" style="padding: 1.5px">
					������
				</th>
				<th class="nui-table-cell" style="padding: 1.5px">
					�����
				</th>


				<th class="nui-table-cell" style="padding: 1.5px">
					Ӧ�ø���
				</th>
				<th class="nui-table-cell" style="padding: 1.5px">
					ʵ�ø���
				</th>
				<th class="nui-table-cell" style="padding: 1.5px">
					��Ч����
				</th>
				<th class="nui-table-cell" style="padding: 1.5px">
					������
				</th>
				<th class="nui-table-cell" style="padding: 1.5px">
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

				<th class="nui-table-cell"><%=rs.get(v_col + "_num_all")%></th>
				<th class="nui-table-cell"><%=rs.get(v_col + "_num")%></th>
				<th class="nui-table-cell"><%=rs.get(v_col + "_num_ok")%></th>
				<th class="nui-table-cell"><%=rs.get(v_col + "_r", 1, f)%></th>
				<th class="nui-table-cell"><%=rs.get(v_col + "_r_ok", 1, f)%></th>

				<th class="nui-table-cell"><%=rs.get(so2_col + "_num_all")%></th>
				<th class="nui-table-cell"><%=rs.get(so2_col + "_num")%></th>
				<th class="nui-table-cell"><%=rs.get(so2_col + "_num_ok")%></th>
				<th class="nui-table-cell"><%=rs.get(so2_col + "_r", 1, f)%></th>
				<th class="nui-table-cell"><%=rs.get(so2_col + "_r_ok", 1, f)%></th>

				<th class="nui-table-cell"><%=rs.get(nox_col + "_num_all")%></th>
				<th class="nui-table-cell"><%=rs.get(nox_col + "_num")%></th>
				<th class="nui-table-cell"><%=rs.get(nox_col + "_num_ok")%></th>
				<th class="nui-table-cell"><%=rs.get(nox_col + "_r", 1, f)%></th>
				<th class="nui-table-cell"><%=rs.get(nox_col + "_r_ok", 1, f)%></th>

				<th class="nui-table-cell"><%=rs.get(pm_col + "_num_all")%></th>
				<th class="nui-table-cell"><%=rs.get(pm_col + "_num")%></th>
				<th class="nui-table-cell"><%=rs.get(pm_col + "_num_ok")%></th>
				<th class="nui-table-cell"><%=rs.get(pm_col + "_r", 1, f)%></th>
				<th class="nui-table-cell"><%=rs.get(pm_col + "_r_ok", 1, f)%></th>

				<th class="nui-table-cell"><%=rs.get(o2_col + "_num_all")%></th>
				<th class="nui-table-cell"><%=rs.get(o2_col + "_num")%></th>
				<th class="nui-table-cell"><%=rs.get(o2_col + "_num_ok")%></th>
				<th class="nui-table-cell"><%=rs.get(o2_col + "_r", 1, f)%></th>
				<th class="nui-table-cell"><%=rs.get(o2_col + "_r_ok", 1, f)%></th>


				<th class="nui-table-cell"><%=rs.get(p_col + "_num_all")%></th>
				<th class="nui-table-cell"><%=rs.get(p_col + "_num")%></th>
				<th class="nui-table-cell"><%=rs.get(p_col + "_num_ok")%></th>
				<th class="nui-table-cell"><%=rs.get(p_col + "_r", 1, f)%></th>
				<th class="nui-table-cell"><%=rs.get(p_col + "_r_ok", 1, f)%></th>

				<th class="nui-table-cell"><%=rs.get("r_avg", 1, f)%></th>
				<th class="nui-table-cell"><%=rs.get("r_ok_avg", 1, f)%></th>

				<th class="nui-table-cell"></th>

			</tr>
			<%
			    }
			%>
		
	</table>
</div>