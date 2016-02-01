<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.search.searchAction"%>
<%
			searchAction.getComments(DBUtil.getConn(request), request
			.getParameter("station_id"), request);
	RowSet data;
	data = w.rs("data");
%>
<title>备注信息</title>
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css" />
<body>
<table border=0 cellspacing=1>
<tr class=title>
<td width=200px>日期</td>
<td width=100px>添加人</td>
<td width=724px>内容</td>
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