<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
       
       String sql = "select * from t_cfg_jsgs";
       Map m = null;
       RowSet rs = null;
       String bar = null;
       List list = null;
       String id = null;
       try{
       
         m = f.query(sql,null,request);
         bar = (String)m.get("bar");
         list = (List)m.get("data");
         rs = new RowSet(list);
       
     }catch(Exception e){
     w.error(e);
     return;
    }
    
%>


<body scroll=no>
<form name=form1 method=post action="index.jsp">

<div class=page_bar>
<%=bar%>
<a href='input.jsp'>添加公式</a>
</div>

<table border=0  cellspacing=1>

 <tr class=title>
   <td>序号</td>
   <td>公式名称</td>
   <td>公式描述</td>
   <td>
    
   </td>
 </tr>
  <%while(rs.next()){
    id = rs.get("jsgs_id");
  %>
   <tr>
   <td><%=rs.getIndex()+1%></td>
   <td><%=rs.get("jsgs_name")%></td>
   <td><%=rs.get("jsgs_desc")%></td>
   <td>
   <a href='view.jsp?jsgs_id=<%=id%>'>查看</a>
   </td>
   </tr>
  <%}%>
 
</table>
</form>

