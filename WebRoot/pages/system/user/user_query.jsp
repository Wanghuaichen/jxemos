<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%
	String sql =null;
	String[]arr=null;
	String data = null;
	String pageBar = null;
	Map<?,?> map = null;
    //String area_name = JspUtil.getParameter(request,"p_area_name");
    //if(area_name==null){area_name="";}
    
    String user_name = JspUtil.getParameter(request,"p_user_name","");
    
	sql = "select ";
	sql=sql+"a.user_id,a.user_name,b.dept_name,a.user_desc ";
	sql=sql+"from t_sys_user a,t_sys_dept b ";
	sql=sql+"where a.dept_id=b.dept_id ";
	if(!StringUtil.isempty(user_name)){
	    sql =sql +" and a.user_name like '%"+user_name+"%' ";
	}
	sql=sql+ " order by user_name";
	try{
	/*
	arr=PagedUtil.query(sql,request,1);
	data=arr[0];
	pageBar=arr[1];
	*/
	map =PagedUtil2.queryStringWithUrl(sql, 1,1,request);
    data=(String)map.get("data");
    pageBar=(String)map.get("page_bar");

	}catch(Exception e){

		JspUtil.go2error(request,response,e);
		return;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>在线检测和监控管理系统</title>
<link rel="stylesheet" href="../../../web/index.css" />
<style type="text/css">
tbody tr td {
	border-bottom: 1px solid #EEE;
	line-height: 1.666;
	padding: 8px;
	display: table-cell;
	vertical-align: inherit;
	font-family: Arial, Helvetica, sans-serif;
}
</style>
</head>
<body>
	<form name=form1 method=post action="user_query.jsp">
		<input type=hidden name=objectid />
		<div style="margin: 10px 10px 10px 10px;">
			<input type=text name=p_user_name value="<%=user_name%>" /> <input
				type=button value=查找用户 onclick="form1.submit()" class=tiaojianbutton />
			<input type=button value="添加用户" class=tiaojianbutton
				onclick="f_input()" />
		</div>
		<div id='div_excel_content'>
			<table class="nui-table-inner">
				<thead class="nui-table-head">
					<tr class="nui-table-row">
						<th class="nui-table-cell">用户名</th>
						<th class="nui-table-cell">所属部门</th>
						<th class="nui-table-cell">用户说明</th>
						<th class="nui-table-cell">编辑</th>
					</tr>
				</thead>
				<tbody class="nui-table-body">
					<%=data%>
					<tr class="nui-table-row">
						<th class="nui-table-cell" colspan="4"><%=pageBar%></th>
					</tr>
				</tbody>
			</table>
		</div>
	</form>
	<script>
		//----------
		function f_power_view() {
			var num = getSelectedNum("objectid");
			if (num != 1) {
				alert("请选择一个用户");
				return;
			}
			form1.action = "./user_res/user_res_view.jsp";
			form1.submit();
		}
		//-------
		function f_power_edit() {
			var num = getSelectedNum("objectid");
			if (num != 1) {
				alert("请选择一个用户");
				return;
			}
			form1.action = "./user_res/user_res_edit.jsp";
			form1.submit();
		}
		//-------------
		function f_pwd() {
			var num = getSelectedNum("objectid");
			if (num != 1) {
				alert("请选择一个用户");
				return;
			}
			form1.action = "./user_pwd_edit.jsp";
			form1.submit();
		}
		//-------------

		function f_view_object(id) {
			form1.objectid.value = id;
			form1.action = "user_edit.jsp";
			form1.submit();
		}

		function f_input() {
			form1.action = "user_input.jsp";
			form1.submit();
		}
	</script>
</body>
</html>
