<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
         String user_id = null;
         
         user_id = (String)session.getAttribute("user_id");
         if(StringUtil.isempty(user_id)){
         response.sendRedirect("./nologin.jsp");
         return;
         
         }

%>
<br><br>

<form name=form1 method=post action=pwd_update.jsp>
<input type=hidden name=user_id value="<%=user_id%>">

<table border=0 cellspacing=1 style="width:50%">
<!--
<tr class=title>
<td colspan=2><b>�޸�����</b></td>
</tr>
-->

<tr>
<td class='tdtitle'>ԭ����</td>
<td><input type=password name=pwd_old></td>
</tr>

<tr>
<td class='tdtitle'>������</td>
<td><input type=password name=pwd1></td>
</tr>

<tr>
<td class='tdtitle'>�ظ�����</td>
<td><input type=password name=pwd2></td>
</tr>


<tr>
<td class='tdtitle'></td>
<td><input type=submit value=' �� �� ' class=btn></td>
</tr>


</table>