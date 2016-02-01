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
  <td style='width:50px'>序号</td>
  <td style='width:300px'>文件</td>
  <td>文件名</td>
  <td style='width:100px'>下载</td>
  
</tr>
<%while(rs.next()){
  fname = rs.get("name");
%>
   <tr>
    <td><%=rs.getIndex()+1%></td>
    <td><%=rs.get("name")%></td>
    <td><%=rs.get("name3")%></td>
    <td><a href='./file/<%=fname%>' target=new>下载另存为</a></td>
   </tr>
<%}%>