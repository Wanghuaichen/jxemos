<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

    RowSet data,flist;
    String id,m_time,m_value;
    SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    try{
    
      SwjUpdate.real(request);
    }catch(Exception e){
     w.error(e);
     return;
    }
    data = w.rs("data");
    flist = w.rs("flist");
    //boolean iswry = f.iswry(w.get("station_type"));
 
%>
<style>
.trayyellow12{ color:#ce4f00; font-weight:bold;}
</style>
<table border=0 cellspacing=1>
   <tr class=title style="position: relative; top: expression(this.offsetParent.scrollTop);" > 
     <td width=40px background="../../../images/index_table_bg.jpg" class="trayyellow12">–Ú∫≈</td>
     <td width=120px background="../../../images/index_table_bg.jpg" class="trayyellow12">º‡≤‚ ±º‰</td>
     <%while(flist.next()){%>
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
     <%}}%>
     
   </tr>
   
   <%while(data.next()){
     flist.reset();
     
   %>
   <tr>
      <td><%=data.getIndex()+1%></td>
      <td><%=format.format(format.parse(data.get("m_time").toString()))%></td>
      <%while(flist.next()){
        id = flist.get("infectant_id");
        m_value=data.get(id);
        m_value=f.v(m_value);
          m_value=f.format(m_value,"0.#####");
      %>
      <%
      if(request.getParameter("zh_flag").equals("yes")){
      if(flist.get("infectant_id").equals(request.getParameter("infectant_id"))){ %>
      <td><%=m_value%></td>
      <%}}else{%>
      <td><%=m_value%></td>
      <%}}%>
    </tr>
   <%}%>
   
   
   
</table>