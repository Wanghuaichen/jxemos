<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.search.searchAction"%>
<%
			searchAction.getComments(DBUtil.getConn(request), request
			.getParameter("station_id"), request);
	RowSet data;
	data = w.rs("data");
%>
<title>��ע��Ϣ</title>
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css" />
<body>
<table border=0 cellspacing=1>
<tr class=title>
<td width=200px>����</td>
<td width=100px>�����</td>
<td width=724px>����</td>
</tr>
<%
while (data.next()) {
%>
<tr>
<td><%=data.get("insert_time")%></td>
<td><%=data.get("username")%></td>
<td><%=data.get("info")%></td>
</tr>
<%
}
%>
</table>
</body>