<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
    try{
    
      SHUpdate.query(request);
    
    }catch(Exception e){
     w.error(e);
     return;
    }
    
    RowSet rs = w.rs("data");
    RowSet prs = w.rs("paramsList");
    Map m = (Map)request.getAttribute("model");
%>
<form name=form1 method=post action='data.jsp'>
<input type="hidden" name="station_type" value="<%=m.get("station_type") %>" />
<input type="hidden" name="date1" value="<%=m.get("date1") %>" />
<input type="hidden" name="date2" value="<%=m.get("date2") %>" />
<input type="hidden" name="station_id" value="<%=m.get("station_id") %>" />
<table border=0 cellspacing=1>
    <tr class=title> 
     <td width=40px>序号</td>
     <td width=120px>监测时间</td>
     <%while(prs.next()){
     	if(!prs.get("infectant_name").equals("流量2"))
     	{
     %>
       <td>
       <%=prs.get("infectant_name")%><br>
       <%=prs.get("infectant_unit")%>
       </td>
     <%}}%>
     
   </tr>
   
    <%while(rs.next()){
     prs.reset();
     
   %>
   <tr>
      <td><%=rs.getIndex()+1%></td>
      <td><%=rs.get("m_time")%></td>
      <%while(prs.next()){
        String col = prs.get("infectant_column");
        if(col==null){col="";}
        col=col.toLowerCase();
        String m_value=rs.get(col);
        m_value=f.v(m_value);
        if(!col.equals("val14")){
      %>
      <td onclick="data_sh('<%=rs.get("station_id") %>','<%=rs.get("m_time") %>','<%=col %>')"><%=m_value%></td>
      <%}}%>
    </tr>
   <%}%>
   
   <tr><td class=right colspan=100><%=w.get("bar")%></td></tr>
</table>
</form>
<script>
	function data_sh(id,time,col)
	{
		if(confirm("是否要对此数据审核？"))
		{
			var station_type = form1.station_type.value;
			window.showModalDialog("data_sh.jsp?station_id="+id+"&m_time="+time+"&param="+col+"&station_type="+station_type+"&x="+Math.random(),window,"DialogHeight:500px;DialogWidth:600px;status:no");
		}
	}
</script>