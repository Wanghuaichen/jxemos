<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
   try{
    action = new WarnAction();
    action.run(request,response,"getWarnData");
   
   }catch(Exception e){
      w.error(e);
      return;
   }
   
   RowSet rs1 = w.rs("data");
   RowSet rs2 = w.rs("infectant");
   String v,col = null;
   String station_id,m_time = null;
   
%>
<table border=0 cellspacing=1>
<tr class="title">
	<td colspan="<%=rs2.size()+3 %>"><center><span style="font-size:20px"><%=w.get("title") %></span></center></td>
</tr>
<tr class="title">
    <td>序号</td>
    <td>站位名称</td>
    <td>监测时间</td>
    
    <%while(rs2.next()){%>
    <td>
        <%=rs2.get("infectant_name")%><br>
        <%=rs2.get("infectant_unit")%>
     </td>
    <%}%>
    <!--
   <td></td>
   -->
   
</tr>

  <%while(rs1.next()){
    station_id = rs1.get("station_id");
    m_time = rs1.get("m_time");
  %>
  <tr>
        <td><%=rs1.getIndex()+1%></td>
        <td><%=rs1.get("station_desc") %></td>
        <td><%=rs1.get("m_time")%></td>
        <%
        	rs2.reset();
        	while(rs2.next()){
        	col = rs2.get("infectant_column").toLowerCase();
        	v = rs1.get(col);
        	v= f.format(v,"#.####");
        	%>
        	<td><%=v%></td>
        	<%}%>
  </tr>
  <%}%>
</table>
