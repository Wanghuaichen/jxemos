<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc_advice.jsp"%>
<%
	try
	{
		zdxUpdate.query_detail(request);
	}
	catch(Exception e)
	{
		w.error(e);
		return;
	}
	@SuppressWarnings("rawtypes")
	Map mp = (Map)request.getAttribute("advice");
	XBean b = new XBean(mp);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<link rel="stylesheet" href="../../web/index.css" />
<title>在线检测和监控管理系统</title>
<script type="text/javascript">
	function f_back() {
		window.history.back();
	}
	function f_delete(advice_id) {
		if (confirm("是否删除此建议？")) {
			window.location.href = "advice_delete.jsp?advice_id=" + advice_id
					+ "&x=1";
		}
	}
</script>
<style type="text/css">
.tj1 {
	height: 30px;
	line-height: 30px;
	font-weight: bold;
	margin-left: 80px;
}
</style>
</head>

<body style="overflow: hidden;">
	<div class="frame-main-content" style="left:0; top:0;">
		<form name="form1" action="advice_update.jsp?x=1"
			target="frm_home_main" method="post">
			<div class="fankui">
				<input type="hidden" name="advice_id"
					value="<%=b.get("advice_id")%>" /> <input type="hidden"
					name="advice_user" value="<%=b.get("advice_user")%>" /> <input
					type="hidden" name="advice_time" value="<%=b.get("advice_time")%>" />
				<ul>
					<li><b>反馈用户：</b><span><%=session.getAttribute("user_name")%></span>
					</li>
					<li><b>环保机构：</b><span><input type="text"
							name="advice_jg" value="<%=b.get("advice_jg")%>"
							style="width:150px;" readonly="readonly" /> </span>
					</li>
					<li><b>联系方式：</b><span><input type="text"
							name="advice_lx" value="<%=b.get("advice_lx")%>"
							style="width:150px;" readonly="readonly" /> </span>
					</li>
					<li class="text"><b>信息内容：</b><span><textarea rows="5" cols="60"
								name="advice_content" readonly="readonly" class="textar"
								><%=b.get("advice_content")%></textarea>
					</span>
					</li>
					<li class="text"><b>回复信息：</b><span><textarea rows="5" cols="60"
								name="deal_advice" readonly="readonly" class="textar"
								><%=b.get("deal_advice")%></textarea>
					</span>
					</li>
					<li>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" onclick="f_back()"
						value="返回" class="tiaojianbutton tj" />
					</li>
				</ul>
			</div>
		</form>
	</div>
</body>
</html>
