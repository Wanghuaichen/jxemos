<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
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
	<form name=form1 method=post action="tab_dept_insert.jsp">
		<input type=hidden name=objectid />
		<div class="frame-main-content" style="left:0; top:0;">
			<div class="fankui">
				<ul>
					<li><b>部门名称</b> <span><input type="text"
							name="dept_name" /> <%=App.require()%> </span>
					</li>
					<li><b>描述</b> <span><input type="text" name="dept_desc" />
					</span>
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
