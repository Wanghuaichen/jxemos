<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>


<form name=form1 method=post action=insert.jsp>
 <table border=0 cellspacing=1>
  <tr>
  <td>�ֻ���</td>
  <td><input type=text name=phone_no></td>
  </tr>
  
   <tr>
  <td>�û�</td>
  <td><input type=text name=user_name></td>
  </tr>
  
   <tr>
  <td>��ע</td>
  <td><input type=text name=user_desc></td>
  </tr>
  
   <tr>
  <td></td>
  <td>
  <input type=button value='���' onclick='form1.submit()'>
  <input type=button value='����' onclick='history.back()'>
  
  </td>
  </tr>
  
  
 </table>
</form>