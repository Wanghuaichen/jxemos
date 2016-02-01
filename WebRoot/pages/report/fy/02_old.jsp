<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
   try{
   
    action = new FyReport();
    action.run(request,response,"rpt02");
   
   
   }catch(Exception e){
      w.error(e);
      return;
   }
   RowSet rs = w.rs("list");
   int i,num=0;
   num = 24;
   String key = null;
   
   
%>
<div id='div_excel_content'>
<div class=center style="font-size:18px;font-weight:bold">
 <%=w.get("yy")%> �� <%=w.get("mm")%>  �·����߼����ҵ��Ⱦ���ŷ�ͳ�ƻ��ܱ�
</div>


<table border=0 cellspacing=1>
<tr class=title>
<td rowspan=2>���</td>
<td rowspan=2>��ˮ�Ѽ������</td>
<td rowspan=2>վλ����</td>
<td rowspan=2>��ַ</td>
<td rowspan=2>COD�»�������</td>

<td colspan=3>������������</td>
<td colspan=3>�쳣��������</td>
<td colspan=3>���߹���</td>

<td rowspan=2>����ˮ��</td>
<td rowspan=2>COD> <%=w.get("cod_std")%> ����</td>
<td rowspan=2>COD> <%=w.get("cod_std")%>ƽ��ֵ</td>
<td rowspan=2>��ע</td>
</tr>

<tr class=title>
<td>����</td>
<td>�վ�����</td>
<td>��ˮ��</td>

<td>����</td>
<td>�վ�����</td>
<td>��ˮ��</td>

<td>����</td>
<td>�վ�����</td>
<td>��ˮ��</td>


</tr>


<%while(rs.next()){%>
<tr>
  <td><%=rs.getIndex()+1%></td>
  <td></td>
  <td><%=rs.get("station_name")%></td>
  <td></td>
  
  <td><%=f.format(rs.get("avg_cod"),"0.##")%></td>
  
  
  <td><%=rs.get("count_q_zc")%></td>
  <td><%=f.format(rs.get("avg_q_zc"),"0.##")%></td>
  <td><%=f.format(rs.get("sum_q_zc"),"0.##")%></td>
  
  <td><%=rs.get("count_q_yc")%></td>
  <td><%=f.format(rs.get("avg_q_yc"),"0.##")%></td>
  <td><%=f.format(rs.get("sum_q_yc"),"0.##")%></td>
  
  
  <td><%=rs.get("count_q_gz")%></td>
  <td><%=f.format(rs.get("avg_q_gz"),"0.##")%></td>
  <td><%=f.format(rs.get("sum_q_gz"),"0.##")%></td>
  
  <td><%=f.format(rs.get("sum_q"),"0.##")%></td>
  
  <td><%=rs.get("count_cod_over")%></td>
  <td><%=f.format(rs.get("avg_cod_over"),"0.##")%></td>
  
  <td></td>
</tr>
<%}%>


</table>

</div>




