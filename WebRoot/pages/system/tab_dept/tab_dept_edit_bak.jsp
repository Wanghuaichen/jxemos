<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
String sql = null;
Map dynaBean = null;
String objectid = null;
String msg = null;
try{
objectid = JspUtil.getParameter(request,"objectid");
sql = "select * from t_sys_dept where dept_id='"+objectid+"'";
dynaBean = DBUtil.queryOne(sql,null,request);
if(dynaBean==null){
 //out.println("指定的记录不存在 objectid="+objectid);
 msg = "指定的记录不存在 objectid="+objectid;
 JspUtil.go2error(request,response,msg);
return;
}
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
<form name="form1" method="post" action="tab_dept_update.jsp">
<input type=hidden name=objectid>
<table border="0" cellspacing="1">
   <tr class=tr0>
<td  class='tdtitle'>部门编号</td>
<td class=left>
<input type="text" name="dept_id"  readonly   value="<%=dynaBean.get("dept_id")%>">
</td>
</tr>


<tr class=tr1>
<td  class='tdtitle'>部门名称</td>
<td class=left>
<input type="text" name="dept_name"     value="<%=dynaBean.get("dept_name")%>">
<%=App.require()%>
</td>
</tr>

<tr class=tr0>
<td  class='tdtitle'>描述</td>
<td class=left>
<input type="text" name="dept_desc"     value="<%=dynaBean.get("dept_desc")%>">
</td>
</tr>


<tr class=tr1>
      <td class='tdtitle'></td>
      <td class=left>
          <input type="button" value="返回" onclick="history.back()" class=btn>
 <input type="button"  value="保存" class=btn onclick="f_save()">
 <input type="button"  value="删除" class=btn  onclick="f_del()">

 </td>
    </tr>
</table>
</form>
</body>
</html>


<script>

function f_save(){
form1.action="tab_dept_update.jsp";
form1.submit();
}


function f_del(){
var msg = "您确认要删除吗?";
if(!confirm(msg)){return;}
form1.objectid.value=form1.dept_id.value;
form1.action="tab_dept_del.jsp";
form1.submit();
}


</script>






