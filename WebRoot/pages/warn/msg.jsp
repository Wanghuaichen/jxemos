<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
   try{
    action = new WarnAction();
    action.run(request,response,"msg");
   
   }catch(Exception e){
      w.error(e);
      return;
   }
   
   
   
%>
<form name=form1 method=post target=msgq action=send.jsp>
<table border=0 cellspacing=1>
  <tr>
  <td style="width:120px">短信内容</td>
  <td>
  <textarea cols=50 rows=6 readonly name=content><%=w.get("msg")%></textarea>
  </td>
  </tr>
  
  <tr>
  <td>手机号</td>
  <td>
    <input type=text name=mobile>
  </td>
  </tr>
  
  <tr>
  <td></td>
  <td>
    <input type=button value='发送' onclick=f_send() class=btn>
  </td>
  </tr>
  
</table>
</form>
<iframe name=msgq frameborder=0 width=100% height=100px></iframe>

<script>
function f_send(){
 //alert('send');
 form1.submit();
}
</script>