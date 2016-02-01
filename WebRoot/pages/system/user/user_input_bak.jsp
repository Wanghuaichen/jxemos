<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
    String optionDept = null;
	String sql = null;
	try{

	sql = "select dept_id,dept_name from t_sys_dept";
	optionDept = JspUtil.getOption(sql,"",request);

	}catch(Exception e){
	JspUtil.go2error(request,response,e);
	return;
	}

%>



<body scroll=no>

<form name=form1 method=post action="user_insert.jsp">

<table border=0 cellspacing=1>

<tr class=tr0>
<td class='tdtitle'>用户名</td>
<td class=left>

<input type="text" name="user_name">
<%=App.require()%>
</td>
</tr>


<tr class=tr1>
<td class='tdtitle'>用户密码</td>
<td class=left>

<input type="password" name="user_pwd">
<%=App.require()%>
</td>
</tr>


<tr class=tr0>
<td class='tdtitle'>重复密码</td>
<td class=left>

<input type="password" name="user_pwd2">
<%=App.require()%>
</td>
</tr>




<tr class=tr1>
<td class='tdtitle'>用户中文名</td>
<td class=left>

<input type="text" name="user_cn_name">
</td>
</tr>



<tr class=tr0>
<td class='tdtitle'>所属部门</td>
<td class=left>

<select name=dept_id><%=optionDept%></select>
</td>
</tr>


<tr class=tr1>
<td class='tdtitle'>用户说明</td>
<td class=left>

<input type="text" name="user_desc">
</td>
</tr>

<tr class=tr0>
<td class='tdtitle'></td>
<td class=left>

<input type="submit" value="保存" class="btn">
<input type="button" value="返回" onclick="history.back()" class="btn">
</td>
</tr>
</table>
</form>