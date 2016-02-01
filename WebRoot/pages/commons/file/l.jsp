<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/file/inc.jsp" %>
<%
        List list = null;
        int i,num=0;
        String s= "";
        String file = request.getParameter("file");
        if(StringUtil.isempty(file)){
          out.println("file is null");
          return;
        }
        try{
        file=file.trim();
        list = FileMgrUtil.getFiles(file);
        num = list.size();
        for(i=0;i<num;i++){
        s=s+list.get(i)+"\n";
        }
        }catch(Exception e){
        JspUtil.go2error(request,response,e);
        return;
        }
        RowSet rs = new RowSet(list);
        
%>


<table>
<%while(rs.next()){%>
<tr>
<td><%=rs.getIndex()+1%></td>
<td><%=rs.get("name")%></td>
<td><%=rs.get("update")%></td>
<td><%=rs.get("type")%></td>


</tr>

<%}%>

</table>
