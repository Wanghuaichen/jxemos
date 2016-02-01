<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<body scroll=no>
<form name=form1 methos=post action='add.jsp'>
<div class='input_error_msg'><%=w.msg()%></div>
<table border=0  cellspacing=1>
 <tr>
  <td width=100 class='tdtitle'>公式名称</td>
  <td><input type=text name='jsgs_name' value='<%=w.get("jsgs_name")%>' style='width:250px'></td>
 </tr>
 <tr>
  <td class='tdtitle'>公式描述</td>
  <td><textarea name='jsgs_desc'  cols=80 rows=9><%=w.get("jsgs_desc")%></textarea></td>
 </tr>
 
 <tr>
  <td class='tdtitle'></td>
  <td>
    <input type=button value='添加' onclick='f_add()' class=btn>
    <a href='index.jsp'>返回</a>
  </td>
 </tr>
 
</table>
</form>
<script>
 function f_add(){
  //alert('add');
  form1.submit();
 }
</script>