<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
   
   try{
 
   TianJinDataFile.list(request);
   
   }catch(Exception e){
      w.error(e);
      return;
   }
   RowSet rs = w.rs("list");
   String fname = null;
%>
<table border=0 cellspacing=1>
<tr class='title'>
  <td style='width:50px'>���</td>
  <td style='width:300px'>�ļ�</td>
  <td>�ļ���</td>
  <td style='width:100px'>����</td>
  
</tr>
<%while(rs.next()){
  fname = rs.get("name");
%>
   <tr>
    <td><%=rs.getIndex()+1%></td>
    <td><%=rs.get("name")%></td>
    <td><%=rs.get("name3")%></td>
    <td><a href='./file/<%=fname%>' target=new>�������Ϊ</a></td>
   </tr>
<%}%>