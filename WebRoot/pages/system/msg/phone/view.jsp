<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>


<form name=form1 method=post action=insert.jsp>
 <table border=0 cellspacing=1>
  <tr>
  <td>手机号</td>
  <td><input type=text name=phone_no></td>
  </tr>
  
   <tr>
  <td>用户</td>
  <td><input type=text name=user_name></td>
  </tr>
  
   <tr>
  <td>备注</td>
  <td><input type=text name=user_desc></td>
  </tr>
  
   <tr>
  <td></td>
  <td>
  <input type=button value='添加' onclick='form1.submit()'>
  <input type=button value='返回' onclick='history.back()'>
  
  </td>
  </tr>
  
  
 </table>
</form>