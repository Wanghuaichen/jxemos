<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%
	try
	{
		zdxUpdate.query_advice(request);
	}
	catch(Exception e)
	{
		w.error(e);
		return;
	}
    @SuppressWarnings("rawtypes")
	List list = (List)request.getAttribute("adviceCol");
	RowSet rs = new RowSet(list);
	String stateOpts = (String)request.getAttribute("stateOpts");
	/*
	String date1 = null;
	String date2 = null;
	String now = StringUtil.getNowDate()+"";
	date1 = JspUtil.getParameter(request,"date1",now);
	date2 = JspUtil.getParameter(request,"date2",now);
	*/
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<link rel="stylesheet" href="../../web/index.css" />
<title>在线检测和监控管理系统</title>
<link href="../../styles/reset-min.css" rel="stylesheet" type="text/css" />
<link href="../../styles/base/jquery.ui.all.css" rel="stylesheet"
	type="text/css" />
<link href="../../styles/common/common.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript"
	src="../../scripts/core/jquery-1.4.2.min.js"></script>
<script type="text/javascript"
	src="../../scripts/core/jquery.ui.core.js"></script>
<script type="text/javascript"
	src="../../scripts/core/jquery.ui.widget.js"></script>
<script type="text/javascript"
	src="../../scripts/core/jquery.ui.tabs.js"></script>
<script type="text/javascript"
	src="../../scripts/core/jquery.ui.check.js"></script>
<script type="text/javascript" src="../../scripts/common.js"></script>
<script type="text/javascript" src="../../scripts/calendar.js"></script>
<style>
.select {
	font-family: "宋体";
	font-size: 12px;
	BEHAVIOR: url('<%=request.getContextPath()%>/styles/selectBox.htc');
	cursor: hand;
}
</style>

<script type="text/javascript">
	function submit_check() {
		form1.submit();
	}
</script>
</head>
<body style="overflow: hidden;">
	<div class="frame-main-content" style="left:0; top:0;">
		<form name="form1" action="query_advice.jsp" method="post">
			<div class="tiaojian" style="padding-top: 9px;">
				<p class="tiaojiao-p">
					从:<input type="text" class="c1" name="date1" value=""
						readonly="readonly" onclick="new Calendar().show(this);" /> 到:<input
						type="text" class="c1" name="date2" value=""
						readonly="readonly" onclick="new Calendar().show(this);" />
				</p>
				<p class="tiaojiao-p">
					意见状态:<select name="advice_state" class="selectoption"
						onchange="form1.submit()">
						<%=stateOpts%>
					</select>
				</p>
				<input type="submit" class="tiaojianbutton" value="查询" />
			</div>
		</form>

		<table class="nui-table-inner">
			<thead class="nui-table-head">
				<tr id="trHead" class="nui-table-row">
					<th class="nui-table-cell">编号</th>
					<th class="nui-table-cell  ">上传时间</th>
					<th class="nui-table-cell  ">上传人员</th>
					<th class="nui-table-cell  ">环保机构</th>
					<th class="nui-table-cell  ">状态</th>
					<th class="nui-table-cell  ">详细</th>
				</tr>
			</thead>
			<%
				while (rs.next()) {
					String state = "未查阅";
					if (rs.get("advice_state").equals("1")) {
						state = "已处理";
					}
					if (rs.get("advice_state").equals("2")) {
						state = "处理中";
					}
					String time = rs.get("advice_time").toString();
					time = time.substring(0, 16);
			%>
			<tbody class="nui-table-body">
				<tr class="nui-table-row">
					<td class="nui-table-cell"><%=rs.get("advice_id")%>
					</td>
					<td class="nui-table-cell "><%=time%></td>
					<td class="nui-table-cell "><%=rs.get("advice_user")%></td>
					<td class="nui-table-cell "><%=rs.get("advice_jg")%></td>
					<td class="nui-table-cell "><%=state%></td>
					<%
						if (rs.get("advice_state").equals("0")) {
					%>
					<td class="nui-table-cell "><a
						class="nui-txt-link"
						href="advice_detail_pt.jsp?advice_id=<%=rs.get("advice_id")%>"
						id="_mail_link_1305_4843"><font style="color:red">详细 </font> </a>
					</td>
					<%
						}
							if (rs.get("advice_state").equals("2")
									|| rs.get("advice_state").equals("1")) {
					%><td class="nui-table-cell "><a
						class="nui-txt-link"
						href="advice_detail_pt.jsp?advice_id=<%=rs.get("advice_id")%>"
						id="_mail_link_1305_4843"><font style="color:gray;">详细</font>  </a>
					</td>
					<%
						}
					%>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</div>
</body>
</html>
