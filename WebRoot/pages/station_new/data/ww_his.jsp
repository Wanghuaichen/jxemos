<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

    RowSet data,flist;
    String col,m_time,m_value;
    String cols = "station_id,data_table,date1,date2,date3,hour1,hour2,hour3,infectant_id,zh_flag";
	SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    try{
    
      SwjUpdate.his(request);
    }catch(Exception e){
     w.error(e);
     return;
    }
    data = w.rs("data");
    flist = w.rs("flist");
    
%>
<style>
.trayyellow12{ color:#ce4f00; font-weight:bold;}
</style>
<form name=form1 method=post action='his.jsp'>
<%=f.hide(cols,request)%>
<table border=0 cellspacing=1>
    <tr class=title> 
     <td width=40px background="../../../images/index_table_bg.jpg" class="trayyellow12">序号</td>
     <td width=120px background="../../../images/index_table_bg.jpg" class="trayyellow12">监测时间</td>
     <%while(flist.next()){
     	if(!flist.get("infectant_name").equals("流量2"))
     	{
     %>
     <%
     if(request.getParameter("zh_flag").equals("yes")){
     if(flist.get("infectant_id").equals(request.getParameter("infectant_id"))){ %>
       <td background="../../../images/index_table_bg.jpg" class="trayyellow12">
       <%=flist.get("infectant_name")%><br>
       <%=flist.get("infectant_unit")%>
       </td>
     <%}}else{%>
      	<td background="../../../images/index_table_bg.jpg" class="trayyellow12">
	       <%=flist.get("infectant_name")%><br>
	       <%=flist.get("infectant_unit")%>
       </td>
     <%}}}%>
     
   </tr>
   
    <%while(data.next()){
     flist.reset();
     
   %>
   <tr>
      <td><%=data.getIndex()+1%></td>
      <td><%=format.format(format.parse(data.get("m_time").toString()))%></td>
      <%while(flist.next()){
        col = flist.get("infectant_column");
        if(col==null){col="";}
        col=col.toLowerCase();
        m_value=data.get(col);
        m_value=f.v(m_value);
        if(!flist.get("infectant_name").equals("流量2"))
        {
      %>
      <%
      if(request.getParameter("zh_flag").equals("yes")){
      if(flist.get("infectant_id").equals(request.getParameter("infectant_id"))){ %>
      <td><%=m_value%></td>
      <%}}else{%>
      <td><%=m_value%></td>
      <%}}}%>
    </tr>
   <%}%>
   
   <tr><td class=right colspan=100><%=w.get("bar")%></td></tr>
</table>
</form>