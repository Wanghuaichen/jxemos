<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
    SHUpdate.data_update(request);
%>
<script>
	var k = window.dialogArguments;
	k.document.form1.submit();
	window.close();
</script>