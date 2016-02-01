<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>



<script>
function f_add(){
  form1.action='insert.jsp';
  form1.submit();
}
function f_back(){
  form1.action='q.jsp';
  form1.submit();
  //history.back();
}
</script>


<form name=form1 method=post action=insert.jsp>
 <table border=0 cellspacing=1>
  <tr>
  <td class='tdtitle'>手机号</td>
  <td><input type=text name=phone_no></td>
  </tr>
  
   <tr>
  <td class='tdtitle'>用户</td>
  <td><input type=text name=user_name></td>
  </tr>
  
   <tr>
  <td class='tdtitle'>备注</td>
  <td><input type=text name=user_desc></td>
  </tr>
  
   <tr>
  <td class='tdtitle'></td>
  <td>
  <input type=button value='添加' onclick='form1.submit()' class='btn'>
  <input type=button value='返回' onclick='history.back()' class='btn'>
  
  </td>
  </tr>
  
  
 </table>
</form>
