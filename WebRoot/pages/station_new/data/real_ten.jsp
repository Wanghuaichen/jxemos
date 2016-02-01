<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

    RowSet data,flist;
    String id,m_time,m_value;
    try{
    
      SwjUpdate.real_ten(request);
    
    }catch(Exception e){
     w.error(e);
     return;
    }
    data = w.rs("data");
    flist = w.rs("flist");
    //boolean iswry = f.iswry(w.get("station_type"));
 
%>
<table border=0 cellspacing=1>
   <tr class=title> 
     <td width=40px>–Ú∫≈</td>
     <td width=120px>º‡≤‚ ±º‰</td>
     <%while(flist.next()){%>
       <td>
       <%=flist.get("infectant_name")%><br>
       <%=flist.get("infectant_unit")%>
       </td>
     <%}%>
     
   </tr>
   
   <%while(data.next()){
     flist.reset();
     
   %>
   <tr>
      <td><%=data.getIndex()+1%></td>
      <td><%=data.get("m_time")%></td>
      <%while(flist.next()){
        id = flist.get("infectant_id");
        m_value=data.get(id);
        m_value=f.v(m_value);
          m_value=f.format(m_value,"0.#####");
      %>
      <td><%=m_value%></td>
      <%}%>
    </tr>
   <%}%>
   
   
   
</table>