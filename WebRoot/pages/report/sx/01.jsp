<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
   try{
   
    action = new SxReport();
    action.run(request,response,"rpt01");
   
   
   }catch(Exception e){
      w.error(e);
      return;
   }
   RowSet rs = w.rs("data");
   String daynum = request.getParameter("daynum");
   
%>

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
<tr>
 <tr class=title>
  <td>���</td>
  <td>վλ����</td>
  <td>����</td>
  <td>Сʱ���ݸ���</td>
  <td>���������%</td>
  <td>��ע</td>
 </tr>
</tr>
  <%while(rs.next()){%>
  <tr>
    <td><%=rs.getIndex()+1%></td>
    <td><%=rs.get("station_desc")%></td>
    <td><%=daynum%> </td>
     <td><%=f.format(rs.get("r"),"0.##")%></td>
    <td></td>
  </tr>
  <%}%>
</table>
</div>


