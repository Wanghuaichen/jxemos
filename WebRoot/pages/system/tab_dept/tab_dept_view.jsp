<%@ page contentType="text/html;charset=GBK" %>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="com.hoson.*"%>
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
<link href="/<%=JspUtil.getCtx(request)%>/styles/css1.css" rel="stylesheet" type="text/css">
<body><br><br>

<table border="0" cellspacing="1">
<tr class=tr0>
<td class=center>部门编号</td>
<td class=left>&nbsp;&nbsp;
<input type="text" name="dept_id"  value="<%=dynaBean.get("dept_id")%>">
</td>
</tr>


<tr class=tr1>
<td class=center>部门名称</td>
<td class=left>&nbsp;&nbsp;
<input type="text" name="dept_name"  value="<%=dynaBean.get("dept_name")%>">
</td>
</tr>

<tr class=tr0>
<td class=center>行业说明</td>
<td class=left>&nbsp;&nbsp;
<input type="text" name="dept_desc"  value="<%=dynaBean.get("dept_desc")%>">
</td>
</tr>


<tr class=tr1>
      <td></td>
      <td class=left>&nbsp;&nbsp;
    <input type="button" name="Submit2" value=" 返 回 " onclick="history.back()" class=btn>
 </td>
    </tr>
</table>

</body>
</html>
