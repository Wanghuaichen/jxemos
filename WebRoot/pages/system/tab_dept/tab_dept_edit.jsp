<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%
	String sql = null;
	Map<?, ?> dynaBean = null;
	String objectid = null;
	String msg = null;
	try {
		objectid = JspUtil.getParameter(request, "objectid");
		sql = "select * from t_sys_dept where dept_id='" + objectid
		+ "'";
		dynaBean = DBUtil.queryOne(sql, null, request);
		if (dynaBean == null) {
	//out.println("指定的记录不存在 objectid="+objectid);
	msg = "指定的记录不存在 objectid=" + objectid;
	JspUtil.go2error(request, response, msg);
	return;
		}
	} catch (Exception e) {
		JspUtil.go2error(request, response, e);
		return;
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../../../web/index.css" />
<style type="text/css">
.tj1 {
	height: 30px;
	line-height: 30px;
	font-weight: bold;
	margin-left: 80px;
}
</style>
</head>

<body>
	<form name=form1 method=post action="tab_dept_update.jsp">
		<input type=hidden name=objectid />
		<div class="frame-main-content" style="left:0; top:0;">
			<div class="fankui">
				<ul>
					<li><b>部门编号</b> <span><input type="text" name="dept_id"
							readonly value="<%=dynaBean.get("dept_id")%>" /> </span>
					</li>
					<li><b>部门名称</b> <span><input type="text"
							name="dept_name" value="<%=dynaBean.get("dept_name")%>" /><%=App.require()%>
					</span>
					</li>
					<li><b>描述</b> <span><input type="text" name="dept_desc"
							value="<%=dynaBean.get("dept_desc")%>" /> </span>
					</li>
					<li>
					<b><input type="button" value="保存" class="tiaojianbutton tj1" onclick="f_save()" /></b>&nbsp;&nbsp;&nbsp;&nbsp;<input
						type="button" value="删除" onclick="f_del()"
						class="tiaojianbutton tj1" />&nbsp;&nbsp;&nbsp;&nbsp;<input
						type="button" value="返回" onclick="history.back()"
						class="tiaojianbutton tj1" />
					</li>
				</ul>
			</div>
		</div>
	</form>
	<script>
		function f_save() {
			form1.action = "tab_dept_update.jsp";
			form1.submit();
		}

		function f_del() {
			var msg = "您确认要删除吗?";
			if (!confirm(msg)) {
				return;
			}
			form1.objectid.value = form1.dept_id.value;
			form1.action = "tab_dept_del.jsp";
			form1.submit();
		}
	</script>
</body>
</html>
