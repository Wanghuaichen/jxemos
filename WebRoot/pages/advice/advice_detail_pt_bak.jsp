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
		if(confirm("�Ƿ�ɾ���˽��飿"))
		{
			window.location.href="advice_delete.jsp?advice_id="+advice_id+"&x=1";
		}
	}
</script>
<form name="form1" action="advice_update.jsp?x=1" target="frm_home_main" method="post" >
<table border=0 width=96%>
	<tr align="center">
		<td style="font-weight:bold;" colspan="2">�����ϸ</td>
	</tr>
	<input type="hidden" name="advice_id" value="<%=b.get("advice_id") %>" />
	<input type="hidden" name="advice_user" value="<%=b.get("advice_user") %>" />
	<input type="hidden" name="advice_time" value="<%=b.get("advice_time") %>" />
	<input type="hidden" name="advice_state" value="<%=b.get("advice_state") %>" />
	<tr align="center">
		<td width="60%">
			<table bgcolor="#B5B5B5">
				<tr bgcolor="#ffffff">
					<td width="35%" style="font-weight:bold;">�����û���</td>
					<td><%=session.getAttribute("user_name") %></td>
				</tr>
				<tr bgcolor="#ffffff">
					<td width="35%" style="font-weight:bold;">����������</td>
					<td><input type="text" name="advice_jg" value="<%=b.get("advice_jg") %>" style="width:150px;" /></td>
				</tr>
				<tr bgcolor="#ffffff">
					<td width="35%" style="font-weight:bold;">��ϵ��ʽ��</td>
					<td><input type="text" name="advice_lx" value="<%=b.get("advice_lx") %>" style="width:150px;" /></td>
				</tr>
				<tr bgcolor="#ffffff">
					<td width="35%" style="font-weight:bold;">��Ϣ���ݣ�</td>
					<td><textarea rows="5" cols="60" name="advice_content" style="overflow:hidden"><%=b.get("advice_content") %></textarea></td>
				</tr>
				<tr bgcolor="#ffffff">
					<td width="35%" style="font-weight:bold;">�ظ���Ϣ��</td>
					<td><textarea rows="5" cols="60" name="deal_advice" style="overflow:hidden"><%=b.get("deal_advice") %></textarea></td>
				</tr>
				<tr bgcolor="#ffffff" style="display:none">
					<td colspan="2" align="center"><input type="submit" value="����" class="btn">&nbsp;&nbsp;&nbsp;<input type="button" onclick="f_delete(<%=b.get("advice_id") %>)" value="ɾ��" class="btn">&nbsp;&nbsp;&nbsp;<input type="button" onclick="f_back()" value="����" class="btn"></td>
				</tr>
				
			</table>
		</td>
	</tr>
</table>