<%@ page contentType="text/html;charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.hoson.*"%>
<%
session.setAttribute("url_index", "6");

String station_id = null;
String v = null;

v = request.getParameter("station_id");
if(StringUtil.isempty(v)){v=(String)session.getAttribute("station_id");}
if(StringUtil.isempty(v)){
    out.println("请从左边选择一个站位");
	return;
}

String url = "fullHCNetViewFlag.jsp?station_id="+v;
        url = "sp_dx_one.jsp?station_id="+v;
        url = "sp_one.jsp?station_id="+v;
response.sendRedirect(url);


if(2>1){return;}

%>
<html>
	<head>
		<title>视频</title>
	</head>
	<body leftmargin=0 topmargin=0>
		<form id="Form1" name="Form1">
			<%if (request.getParameter("station_id") == null) {
				if (session.getAttribute("station_id") == null) {
					out.println("请从左边选择一个站位");
					return;
				} else
					response.sendRedirect("index.jsp?station_id="
							+ session.getAttribute("station_id"));
			}

			String strStation_id = "";
			if (request.getParameter("station_id") != null)
				strStation_id = request.getParameter("station_id");
			if (session.getAttribute("station_id") != null)
				strStation_id = String.valueOf(session
						.getAttribute("station_id"));

			%>
			<script language="javascript">
				<%if(strStation_id.compareTo("") != 0){%>
					//window.document.location = "NewVideo.jsp?station_id=<%=strStation_id%>";
					
					window.document.location = "fullHCNetView.jsp?station_id=<%=strStation_id%>";
				<%}else{%>
					//window.document.location = "NewVideo.jsp?station_id=<%=strStation_id%>";
					window.document.location = "fullHCNetView.jsp?station_id=<%=strStation_id%>";
				<%}%>
			</script>
			</Form1>
	</body>
</html>