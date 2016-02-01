<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.JspUtil" %>
<%@ page import="com.hoson.RowSet" %>
<%@ page import="com.hoson.StringUtil" %>
<%@ page import="com.hoson.ww.user" %>
<%@ page import="java.util.Map" %>
<%
	String sql =null;
	String[]arr=null;
	String data = null;
	String pageBar = null;
	Map map = null;
	RowSet users;
    
    String user_name = JspUtil.getParameter(request, "p_user_name", "");
    
	sql = "select ";
	sql=sql+"user_id,user_name,user_allname ";
	sql=sql+"from t_sys_ww_user ";
	if(!StringUtil.isempty(user_name)){
	    sql =sql +" where user_name like '%"+user_name+"%' ";
	}
	sql=sql+ " order by user_name";
	try{
	user.getUsers(sql,request);

	}catch(Exception e){

		JspUtil.go2error(request,response,e);
		return;
	}
	users = w.rs("users");
	pageBar = request.getAttribute("page_bar").toString();

%>


<form name=form1 method=post action="user_query.jsp">
<input type=hidden name=objectid>
<div class='query_form'>
<input type=text name=p_user_name value="<%=user_name%>">
<input type=button value=查看 onclick=form1.submit() class=btn>
<input type=button value="添加用户" class=btn onclick=f_input()>
</div>

<div class='page_bar'>
<%=pageBar%>
</div>

<table border=0 cellspacing=1>


<tr class=title>
<!--<td></td>-->


<td>用户名</td>
<td>用户全名</td>
<td>操作</td>

</tr>
<%while(users.next()){%>
<tr>
<td><a href="javascript:f_view_object('<%=users.get("user_id")%>')"><%=users.get("user_name") %></a></td>
<td><%=users.get("user_allname") %></td>
<td><a href="javascript:f_del('<%=users.get("user_id")%>')">删除</a></td>
</tr>
<%} %>
</table>
</form>

<script>
//----------
function f_power_view(){
var num = getSelectedNum("objectid");
if(num!=1){alert("请选择一个用户");return;}
form1.action="./user_res/user_res_view.jsp";
form1.submit();
}
//-------
function f_power_edit(){
var num = getSelectedNum("objectid");
if(num!=1){alert("请选择一个用户");return;}
form1.action="./user_res/user_res_edit.jsp";
form1.submit();
}
//-------------
function f_pwd(){
var num = getSelectedNum("objectid");
if(num!=1){alert("请选择一个用户");return;}
form1.action="./user_pwd_edit.jsp";
form1.submit();
}
//-------------


function f_view_object(id){
form1.objectid.value=id;
form1.action="user_edit.jsp";
form1.submit();
}

function f_input(){
form1.action="user_input.jsp";
form1.submit();
}
function f_del(id){
var msg = "您确认要删除吗?";
if(!confirm(msg)){return;}
form1.target="";
form1.objectid.value=id;
form1.action="user_del.jsp";
form1.submit();
}

</script>