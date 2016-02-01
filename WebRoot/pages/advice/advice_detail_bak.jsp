<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc_advice.jsp" %>
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
	Map mp = (Map)request.getAttribute("advice");
	XBean b = new XBean(mp);
%>
<script>
	function f_back()
	{
		window.history.back();
	}
	function f_delete(advice_id)
	{
		if(confirm("是否删除此建议？"))
		{
			window.location.href="advice_delete.jsp?advice_id="+advice_id;
		}
	}
</script>
<style>
.btn1{width:80px; height:23px; line-height:23px; background:url(<%=request.getContextPath() %>/images/common/btn1.gif) no-repeat; border:none; text-align:center; }
</style>
<form name="form1" action="advice_update.jsp" target="frm_home_main" method="post" >
<table border=0 width=96%>
	<tr align="center">
		<td style="font-weight:bold;" colspan="2">意见详细</td>
	</tr>
	<input type="hidden" name="advice_id" value="<%=b.get("advice_id") %>" />
	<input type="hidden" name="advice_user" value="<%=b.get("advice_user") %>" />
	<input type="hidden" name="advice_lx" value="<%=b.get("advice_lx") %>" />
	<input type="hidden" name="advice_time" value="<%=b.get("advice_time") %>" />
	<input type="hidden" name="advice_content" value="<%=b.get("advice_content") %>" />
	<input type="hidden" name="advice_jg" value="<%=b.get("advice_jg") %>" />
	<tr align="center">
		<td width="60%">
			<table bgcolor="#B5B5B5">
				<tr bgcolor="#ffffff">
					<td width="35%" style="font-weight:bold;">反馈用户：</td>
					<td><%=b.get("advice_user") %></td>
				</tr>
				<tr bgcolor="#ffffff">
					<td width="35%" style="font-weight:bold;">环保机构：</td>
					<td><%=b.get("advice_jg") %></td>
				</tr>
				<tr bgcolor="#ffffff">
					<td width="35%" style="font-weight:bold;">联系方式：</td>
					<td><%=b.get("advice_lx") %></td>
				</tr>
				<tr bgcolor="#ffffff">
					<td width="35%" style="font-weight:bold;">上传时间：</td>
					<td><%=b.get("advice_time") %></td>
				</tr>
				<tr bgcolor="#ffffff">
					<td width="35%" style="font-weight:bold;">信息内容：</td>
					<td><textarea rows="5" cols="60" name="advice_content" style="overflow:hidden;border:0px;" readonly><%=b.get("advice_content") %></textarea></td>
				</tr>
				<tr bgcolor="#ffffff">
					<td width="35%" style="font-weight:bold;">回复信息：</td>
					<td><textarea rows="5" cols="60" name="deal_advice" style="overflow:hidden;"><%=b.get("deal_advice") %></textarea></td>
				</tr>
				<tr bgcolor="#ffffff">
					<td width="35%" style="font-weight:bold;">信息状态：</td>
					<td><input type="radio" name="advice_state" value="2" checked />处理中<input type="radio" name="advice_state" value="1" />已处理</td>
				</tr>
				<tr bgcolor="#ffffff">
					<td colspan="2" align="center"><input type="submit" value="意见回复" class="btn1 button">&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="返回" onclick="f_back()" class="btn1 button" >&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="删除" onclick="f_delete(<%=b.get("advice_id") %>)" class="btn1 button" ></td>
				</tr>
			</table>
		</td>
	</tr>
</table>