<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
   try{
   
    action = new ReportNbAction();
    action.run(request,response,"rpt01");
   
   
   }catch(Exception e){
      w.error(e);
      return;
   }
   RowSet rs = w.rs("data");
   int i,num=0;
   num = 24;
   
   
%>
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css">
<style>
.h1{font-size:18px;font-weight:bold}
.h2{font-size:16px;font-weight:bold}
</style>
<div id='div_excel_content'>
<!--
<div class=h2 align=right>
����ʱ��:<%=request.getParameter("date1")%>
</div>
-->

<table border=0 cellspacing=1>

 <tr class=title>
  <td>վλ����</td>
  <td>����</td>
  <td>ʱ��</td>
  <%for(i=0;i<num;i++){%>
  <td><%=i%></td>
  <%}%>
  <td>�ѻ���</td>
  <td>������%</td>
 </tr>

  <%while(rs.next()){%>
  <tr>
    <td><%=rs.get("station_desc")%></td>
    <td><%=rs.get("area_name")%> </td>
     <td><%=rs.get("m_time")%> </td>
    <%for(i=0;i<num;i++){%>
  <td><%=rs.get(i+"")%></td>
  <%}%>
    
    <td><%=rs.get("off")%></td>
    <td><%=rs.get("online")%></td>
  </tr>
  <%}%>
</table>
</div>