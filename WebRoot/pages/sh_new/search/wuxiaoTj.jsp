<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
   try{
    action = new WarnAction();
    action.run(request,response,"getWuxiaoTj");
   
   }catch(Exception e){
      w.error(e);
      return;
   }
   
   RowSet rs1 = w.rs("data");
   //RowSet rs2 = w.rs("infectant");
   String v,col = null;
   String station_id,m_time = null;
   
%>
<table border=0 cellspacing=1>
<tr class="title">
	<td colspan="3"><center><span style="font-size:20px"><%=w.get("title") %></span></center></td>
</tr>
<tr class="title">
    <td>序号</td>
    <td>站位名称</td>
    <td>数据个数</td>
</tr>

  <%while(rs1.next()){
    station_id = rs1.get("station_id");
  %>
  <tr>
        <td><%=rs1.getIndex()+1%></td>
        <td><%=rs1.get("station_desc") %></td>
         <td><%=rs1.get("num") %></td>
  </tr>
  <%}%>
</table>
