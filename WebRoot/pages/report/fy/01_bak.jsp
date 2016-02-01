<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
   try{
   
    action = new FyReport();
    action.run(request,response,"rpt01");
   
   
   }catch(Exception e){
      w.error(e);
      return;
   }
   RowSet rs = w.rs("dataList");
   int i,num=0;
   num = 24;
   String key = null;
   
   
%>
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css">
<div id='div_excel_content'>
<div class=center style="font-size:18px;font-weight:bold">
 <%=w.get("yy")%> �� <%=w.get("mm")%>  �·����߼����ҵ�±���
</div>
<div class=left>
վλ����:<%=w.get("station_name")%>
<!--ͳ���·�:-->
</div>

<table border=0 cellspacing=1>
<tr class=title>
<td>���</td>
<td>����</td>
<%for(i=0;i<24;i++){%>
<td><%=i%></td>
<%}%>
<td>����COD������</td>
<td>��ע</td>
</tr>

<%while(rs.next()){%>
<tr>
<td><%=rs.getIndex()+1%></td>
<td><%=rs.get("date")%></td>

<%for(i=0;i<24;i++){
 key=i+"";
%>
 <td><%=rs.get(key)%></td>
<%}%>
<td><%=f.format(rs.get("avg"),"0.##")%></td>
<td></td>
</tr>
<%}%>

<tr>
<td colspan=27>
 <%=w.get("yy")%>  �� <%=w.get("mm")%>  �·ݹ��� <%=rs.size()%> �����<%=w.get("std")%>&lt=COD��׼ֵ&lt=<%=w.get("std2")%> mg/L�������
</td>
<td>
<%=f.format(w.get("avg"),"0.##")%>
</td>
</tr>
</table>

</div>




