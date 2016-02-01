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
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css">
<div id='div_excel_content'>
<div  style="font-size:18px;font-weight:bold;text-align:center">
  <%=SxReportUtil.getTitleTime(request)%>  �������߼�ؼ�����ݱ���
</div>


<table border=0 cellspacing=1>

<tr class=title>
<td rowspan=2>���</td>
 <td rowspan=2>����</td>
 <td rowspan=2>�������</td>
 
 <td rowspan=2>�����ŷ���(���m<sup>3</sup>)</td>
 <td rowspan=2>ʵ��SO2�ŷ���(KG)</td>
 <td rowspan=2>ʵ��NOx�ŷ���(KG)</td>
 <td rowspan=2>ʵ���̳��ŷ���(KG)</td>
 
 <td colspan=3>SO<sub>2</sub>����Ũ��(mg/��m<sup>3</sup>)</td>
 <td colspan=3>�̳�����Ũ��(mg/��m<sup>3</sup>)</td>
 <td colspan=3>Nox����Ũ��(mg/��m<sup>3</sup>)</td>
 
 <td colspan=2>��Ƶͼ��</td>
 
 <td rowspan=2>��ע</td>
 
</tr>

<tr class=title>


<td>���</td>
<td>��С</td>
<td>ƽ��</td>

<td>���</td>
<td>��С</td>
<td>ƽ��</td>

<td>���</td>
<td>��С</td>
<td>ƽ��</td>

<td>�������</td>
<td>����ԭ��</td>

</tr>

<%while(rs.next()){%>
<tr>
   <td><%=rs.getIndex()+1%></td>
   <td><%=rs.get("station_desc")%></td>
   <td></td>
   <td><%=rs.get(q_col+"_sum",10000,f)%></td>
   <td><%=rs.get(so2_col+"_q_sum",r,f)%></td>
   <td><%=rs.get(nox_col+"_q_sum",r,f)%></td>
   <td><%=rs.get(pm_col+"_q_sum",r,f)%></td>
   
   <td><%=rs.get(so2_col+"_max")%></td>
    <td><%=rs.get(so2_col+"_min")%></td>
    <td><%=rs.get(so2_col+"_avg",1,f)%></td>
   
    <td><%=rs.get(pm_col+"_max")%></td>
    <td><%=rs.get(pm_col+"_min")%></td>
    <td><%=rs.get(pm_col+"_avg",1,f)%></td>
    
    <td><%=rs.get(nox_col+"_max")%></td>
    <td><%=rs.get(nox_col+"_min")%></td>
    <td><%=rs.get(nox_col+"_avg",1,f)%></td>
    
    <td></td>
    <td></td>
    <td></td>
    
   </tr> 
   <%}%>


</table>

</div>
