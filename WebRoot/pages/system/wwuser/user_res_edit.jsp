<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
   try{
    SysAclUtil.user_res_view(request);
   }catch(Exception e){
    w.error(e);
    return;
   }
   
   RowSet rs = w.rs("list");
   String res_ids = w.get("res_ids");
   String user_id = w.get("user_id");
   String flag = null;
   String res_id = null;
   
   
   
%>

<body class=left>
<form name=form1 method=post action='user_res_update.jsp'>
<input type=hidden name='user_id' value='<%=user_id%>'>
  <table border=0 cellspacing=1 style='width:100%'>
      <%while(rs.next()){
         res_id = rs.get("res_id");
         flag = UserRes.getCheckedFlag(res_ids,res_id);
         
      %>
        <tr>
         <td style='width:30px'><input type=checkbox name='resids' value='<%=res_id%>' <%=flag%>></td>
         <td>
         <%=rs.get("res_name")%> 
         </td>
        </tr>
      <%}%>
      
      <tr>
        <td></td>
        <td>

         <input type=button value='±£´æ' onclick="f_save()" class='btn'>
         
                 <input type=button value='·µ»Ø' onclick='f_user_edit()' class='btn'>
        
        </td>
      </tr>
  </table>
</form>
</body>

<script>
 function f_user_edit(){
    form1.action='user_edit.jsp?objectid=<%=user_id%>';
     form1.submit();
 }
 
 function f_save(){
    form1.action='user_res_update.jsp';
    form1.submit();
 }
</script>


