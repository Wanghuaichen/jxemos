<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%
	String sql = null;
	Map<?, ?> dynaBean = null;
	String objectid = null;
	String msg = null;
	try {
		objectid = JspUtil.getParameter(request, "objectid");
		sql = "select * from t_cfg_trade where trade_id='" + objectid
				+ "'";
		dynaBean = DBUtil.queryOne(sql, null, request);
		if (dynaBean == null) {
			//out.println("ָ���ļ�¼������ objectid="+objectid);
			msg = "ָ���ļ�¼������ objectid=" + objectid;
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
<title></title>
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
	<form name="form1" action="trade_update.jsp" method="post">
		<div class="frame-main-content" style="left:0; top:0;">
			<div class="fankui">
				<input type=hidden name=objectid
					value="<%=JspUtil.get(dynaBean, "trade_id", "")%>">
				<ul>
					<li><b>��ҵ���</b> <span><input type="text"
							name="trade_id" style="width: 220px" readonly
							value="<%=JspUtil.get(dynaBean, "trade_id", "")%>"> </span>
					</li>
					<li><b>��ҵ����</b> <span><input type="text"
							name="trace_name" style="width: 220px"
							value="<%=JspUtil.get(dynaBean, "trace_name", "")%>"> <%=App.require()%></span>
					</li>
<!-- 					<li><b>��ҵ˵��</b> <span><input type="text" -->
<!-- 							name="trade_desc" style="width: 220px" -->
<!-- 							value="<%=JspUtil.get(dynaBean, "trade_desc", "")%>"> </span> -->
<!-- 					</li> -->
					<li><b><input type="button" value="����"
							class="tiaojianbutton tj1" onclick="f_update()" /> </b>&nbsp;&nbsp;&nbsp;&nbsp;<input
						type="button" value="ɾ��" class="tiaojianbutton tj1"
						onclick="f_del()" />&nbsp;&nbsp;&nbsp;&nbsp;<input type="button"
						value="����" class="tiaojianbutton tj1" onclick="history.back();" />
					</li>
				</ul>
			</div>
		</div>
	</form>
	<script>
		function f_update() {
			form1.action = "trade_update.jsp";
			form1.submit();
		}

		function f_del() {
			var msg = "��ȷ��Ҫɾ����?";
			if (!confirm(msg)) {
				return;
			}
			form1.action = "trade_del.jsp";
			form1.submit();
		}
	</script>
</body>
</html>
