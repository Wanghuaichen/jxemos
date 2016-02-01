<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
      String q_col,so2_col,nox_col,pm_col = null;
      String f = "0.##";
      double r = 1000*1000;
   try{
   
    action = new SxReport();
    action.run(request,response,"rpt03");
   q_col = w.p("q_col");
   so2_col = w.p("so2_col");
   nox_col = w.p("nox_col");
   pm_col = w.p("pm_col");
   }catch(Exception e){
      w.error(e);
      return;
   }
   RowSet rs = w.rs("data");
   
   
%>
<link rel="stylesheet" href="../../../web/index.css" />
<div id='div_excel_content'>
	<span style="visibility: hidden;">hold space</span>
<div  style="font-size:18px;font-weight:bold;text-align:center">
  <%=SxReportUtil.getTitleTime(request)%>  �������߼�ؼ�����ݱ���
</div>
	<span style="visibility: hidden;">hold space</span>

	<table class="nui-table-inner major">
		<thead class="nui-table-head">
			<tr class="nui-table-row">
<th class="nui-table-cell" rowspan=2 width="30px">���</th>
 <th class="nui-table-cell" rowspan=2 width="200px">����</th>
 <th class="nui-table-cell" rowspan=2 width="80px">�������</th>
 
 <th class="nui-table-cell" rowspan=2 style="width: 50px">�����ŷ���(���m<sup>3</sup>)</th>
 <th class="nui-table-cell" rowspan=2 style="width: 50px">ʵ��SO2�ŷ���(KG)</th>
 <th class="nui-table-cell" rowspan=2 style="width: 50px">ʵ��NOx�ŷ���(KG)</th>
 <th class="nui-table-cell" rowspan=2 style="width: 50px">ʵ���̳��ŷ���(KG)</th>
 
 <th class="nui-table-cell" colspan=3>SO<sub>2</sub>����Ũ��(mg/��m<sup>3</sup>)</th>
 <th class="nui-table-cell" colspan=3>�̳�����Ũ��(mg/��m<sup>3</sup>)</th>
 <th class="nui-table-cell" colspan=3>Nox����Ũ��(mg/��m<sup>3</sup>)</th>
 
 <th class="nui-table-cell" colspan=2>��Ƶͼ��</th>
 
 <th class="nui-table-cell" rowspan=2>��ע</th>
 
</tr>

<tr class=title>


<th class="nui-table-cell">���</th>
<th class="nui-table-cell">��С</th>
<th class="nui-table-cell">ƽ��</th>

<th class="nui-table-cell">���</th>
<th class="nui-table-cell">��С</th>
<th class="nui-table-cell">ƽ��</th>

<th class="nui-table-cell">���</th>
<th class="nui-table-cell">��С</th>
<th class="nui-table-cell">ƽ��</th>

<th class="nui-table-cell">�������</th>
<th class="nui-table-cell">����ԭ��</th>

</tr>
		</thead>
		<tbody class="nui-table-body">

<%while(rs.next()){%>
<tr>
   <th class="nui-table-cell"><%=rs.getIndex()+1%></th>
   <th class="nui-table-cell"><%=rs.get("station_desc")%></th>
   <th class="nui-table-cell"></th>
   <th class="nui-table-cell"><%=rs.get(q_col+"_sum",10000,f)%></th>
   <th class="nui-table-cell"><%=rs.get(so2_col+"_q_sum",r,f)%></th>
   <th class="nui-table-cell"><%=rs.get(nox_col+"_q_sum",r,f)%></th>
   <th class="nui-table-cell"><%=rs.get(pm_col+"_q_sum",r,f)%></th>
   
   <th class="nui-table-cell"><%=rs.get(so2_col+"_max")%></th>
    <th class="nui-table-cell"><%=rs.get(so2_col+"_min")%></th>
    <th class="nui-table-cell"><%=rs.get(so2_col+"_avg",1,f)%></th>
   
    <th class="nui-table-cell"><%=rs.get(pm_col+"_max")%></th>
    <th class="nui-table-cell"><%=rs.get(pm_col+"_min")%></th>
    <th class="nui-table-cell"><%=rs.get(pm_col+"_avg",1,f)%></th>
    
    <th class="nui-table-cell"><%=rs.get(nox_col+"_max")%></th>
    <th class="nui-table-cell"><%=rs.get(nox_col+"_min")%></th>
    <th class="nui-table-cell"><%=rs.get(nox_col+"_avg",1,f)%></th>
    
    <th class="nui-table-cell"></th>
    <th class="nui-table-cell"></th>
    <th class="nui-table-cell"></th>
    
   </tr> 
   <%}%>

</tbody>
</table>

</div>
