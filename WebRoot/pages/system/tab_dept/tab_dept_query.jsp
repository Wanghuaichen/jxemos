<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%
	String sql = "select dept_id,dept_name,dept_desc from t_sys_dept order by dept_id ";
	String tableHtml = null;
	String[] arr = null;
	String pageBar = null;
	Map<?, ?> map = null;
	try {
		/*
		 arr = PagedUtil.query(sql,request,1);
		 tableHtml=arr[0];
		 pageBar=arr[1];
		 */
		map = PagedUtil2.queryStringWithUrl(sql, 1, 1, request);
		tableHtml = (String) map.get("data");
		pageBar = (String) map.get("page_bar");
	} catch (Exception e) {
		JspUtil.go2error(request, response, e);
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
	<form name=form1 method=post action="tab_dept_query.jsp">
		<input type=hidden name=objectid />
		<div style="margin: 10px 10px 10px 10px;">
			<input type=button value="添加部门" onclick=f_input()
				class=tiaojianbutton />
		</div>
		<div id='div_excel_content'>
			<table class="nui-table-inner">
				<thead class="nui-table-head">
					<tr class="nui-table-row">
						<th class="nui-table-cell">部门名称</th>
						<th class="nui-table-cell">描述</th>
						<th class="nui-table-cell">编辑</th>
					</tr>
				</thead>
				<tbody class="nui-table-body">
					<%=tableHtml%>
					<tr class="nui-table-row">
						<th class="nui-table-cell" colspan="3"><%=pageBar%></th>
					</tr>
				</tbody>
			</table>
		</div>
	</form>
	<script>
		function f_view_object(id) {
			form1.objectid.value = id;
			form1.action = "tab_dept_edit.jsp";
			form1.submit();
		}
		function f_input() {
			form1.action = "tab_dept_input.jsp";
			form1.submit();
		}
	</script>
</body>
</html>
