<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc_empty.jsp" %>
<%--<form name=form1 method=post target="frm_home_main" action="advice_add.jsp">--%>
<form name=form1 method=post target="frm_home_main">
<table border=0 width=100%>
	<tr align="center">
		<td style="font-weight:bold;" colspan="2">意见反馈</td>
	</tr>
	<input type="hidden" name="advice_user" value="<%=session.getAttribute("user_name") %>" />
	<tr align="center">
		<td width="60%">
			<table width="60%" style="border:1px solid #B5B5B5;">
				<tr bgcolor="#ffffff">
					<td width="35%" style="font-weight:bold;">反馈用户：</td>
					<td><%=session.getAttribute("user_name") %></td>
				</tr>
				<tr bgcolor="#ffffff">
					<td width="35%" style="font-weight:bold;">环保机构：</td>
					<td><input type="text" id="advice_jg" name="advice_jg" style="width:150px;" /></td>
				</tr>
				<tr bgcolor="#ffffff">
					<td width="35%" style="font-weight:bold;">联系方式：</td>
					<td><input type="text" id="advice_lx" name="advice_lx" style="width:150px;" /></td>
				</tr>
				<tr bgcolor="#ffffff">
					<td width="35%" style="font-weight:bold;">信息内容：</td>
					<td><textarea rows="5" cols="60" id="advice_content"  name="advice_content" style="overflow:hidden"></textarea></td>
				</tr>
				<tr bgcolor="#ffffff">
					<td colspan="2" align="center"><input type="button" value="提交" class="btn" onclick="submit_click(this.form)"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</form>

<script type="text/javascript">

  function submit_click(form){
      var advice_jg = document.getElementById("advice_jg").value;
      var advice_lx = document.getElementById("advice_lx").value;
      var advice_content = document.getElementById("advice_content").value;
      
      //alert(advice_jg);
      
      if(advice_jg == ""){
         alert("请填写环保机构!");
         return false;
      }
      
      if(advice_lx == ""){
         alert("请填写联系方式!");
         return false;
      }
      
      if(advice_content == ""){
         alert("请填写信息内容!");
         return false;
      }
      
      //alert(form);
      
      form.action="advice_add.jsp";
      
      form.submit();
      
  }

</script>

