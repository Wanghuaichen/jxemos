<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
   try{
   
    action = new FyReport();
    action.run(request,response,"data");
   
   
   }catch(Exception e){
      w.error(e);
      return;
   }
   RowSet rs1 = w.rs("infectantList");
   RowSet rs2 = w.rs("dataList");
   String col = null;
   String v = null;
   String m_time = null;
   String times = "";
   String gz_flag = null;
   

%>


<table border=0 cellspacing=1>
 <tr class=title>
 <td style="width:30px">ÐòºÅ</td>
 <td style="width:80px">Ê±¼ä</td>
 <%while(rs1.next()){%>
 <td>
 <%=rs1.get("infectant_name")%><br>
 <%=rs1.get("infectant_unit")%>
 </td>
 <%}%>
 
 </tr>
 
 <%while(rs2.next()){
 rs1.reset();
 
 %>
 <tr>
 <td><%=rs2.getIndex()+1%></td>
 <td><%=rs2.get("m_time")%></td>
   <%while(rs1.next()){
     col = rs1.get("infectant_column");
     if(col==null){col="";}
     col=col.toLowerCase();
     v = rs2.get(col);
     v=f.v(v);
   %>
    <td><%=v%></td>
    <%}%>
    

 </tr>
 <%}%>
 
 
</table>

