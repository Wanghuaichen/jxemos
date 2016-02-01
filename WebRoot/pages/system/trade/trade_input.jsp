<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
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
	<form name="form1" action="trade_insert.jsp" method="post">
		<div class="frame-main-content" style="left:0; top:0;">
			<div class="fankui">
				<ul>
					<li><b>行业编号</b> <span><input type="text" style="width: 220px"
					name="trade_id"> <%=App.require()%></span>
					</li>
					<li><b>行业名称</b> <span><input type="text" style="width: 220px"
					name="trace_name"> <%=App.require()%></span>
					</li>
<!-- 					<li><b>行业说明</b> <span><input type="text" style="width: 220px" -->
<!-- 					name="comments"></span> -->
<!-- 					</li> -->
					<li><b><input type="submit" value="保存"
							class="tiaojianbutton tj1" /> </b>&nbsp;&nbsp;&nbsp;&nbsp;<input
						type="button" value="返回" class="tiaojianbutton tj1"  onclick="history.back()"/>
					</li>
				</ul>
			</div>
		</div>
	</form>
</body>
</html>
