<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
String sql = "select dept_id,dept_name,dept_desc from t_sys_dept order by dept_id ";
String tableHtml = null;
String[]arr = null;
String pageBar = null;
Map map = null;
try{
/*
arr = PagedUtil.query(sql,request,1);
tableHtml=arr[0];
pageBar=arr[1];
*/
map =PagedUtil2.queryStringWithUrl(sql, 1,1,request);
tableHtml=(String)map.get("data");
pageBar=(String)map.get("page_bar");
}catch(Exception e){
JspUtil.go2error(request,response,e);
return;
}

%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body scroll=no>


<form name=form1 method=post action="tab_dept_query.jsp">
<input type=hidden name=objectid>


<div class='page_bar'>
<%=pageBar%>
<input type=button value="添加部门" onclick=f_input() class=btn>
</div>


<table border=0 cellspacing=1>

<tr class=title>
<!--<td></td>-->
<td style="width:50%">部门名称</td>
<td>描述</td>

</tr>
<%=tableHtml%>




</table>
</form>

<script>
function f_view_object(id){
form1.objectid.value=id;
form1.action="tab_dept_edit.jsp";
form1.submit();
}

function f_input(){
form1.action="tab_dept_input.jsp";
form1.submit();
}

</script>

