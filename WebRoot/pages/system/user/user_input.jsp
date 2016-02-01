<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%
	String optionDept = null;
	String sql = null;
	try {

		sql = "select dept_id,dept_name from t_sys_dept";
		optionDept = JspUtil.getOption(sql, "", request);

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
	<form name=form1 method=post action="user_insert.jsp">
		<div class="frame-main-content" style="left:0; top:0;">
			<div class="fankui">
				<ul>
					<li><b>用户名</b> <span><input type="text"
							name="user_name"> <%=App.require()%></span>
					</li>
					<li><b>用户密码</b> <span><input type="password"
							name="user_pwd"> <%=App.require()%> </span>
					</li>
					<li><b>重复密码</b> <span><input type="password"
							name="user_pwd2"> <%=App.require()%> </span>
					</li>
					<li><b>用户中文名</b> <span><input type="text"
							name="user_cn_name"> </span>
					</li>
					<li><b>所属部门</b> <span><select name=dept_id><%=optionDept%></select> </span>
					</li>
					<li><b>用户说明</b> <span><input type="text" name="user_desc"> </span>
					</li>
					<li><b><input type="submit" value="保存"
							class="tiaojianbutton tj1" /> </b>&nbsp;&nbsp;&nbsp;&nbsp;<input
						type="button" value="返回" class="tiaojianbutton tj1" onclick="history.back()" />
					</li>
				</ul>
			</div>
		</div>
	</form>
</body>
</html>
