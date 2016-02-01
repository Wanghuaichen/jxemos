<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
    try{
    
      ReportUpdate.getStationList(request);
    
    }catch(Exception e){ 
     w.error(e);
     return;
    }
    RowSet rs = w.rs("stationList");
%>
<html>
<head>
<style>
	body,table,tr{
		background:#ffffff;
	}
	tr{
		padding-top:0px;
		padding-bottom:0px;
		margin-top:0px;
		margin-bottom:0px;
	}
	select{
		width:146px;
	}
</style>
</head>
<body>
<form name="form1" action="real_hour.jsp" method=post>
<table border=0 cellspacing=0>
<tr style="display:none"><td><input type="checkbox" name="stations" value="null" /></td></tr>
  <%
  	while(rs.next())
  	{
  %>
  <%if(!rs.get("station_desc").equals("")){ %>
  	<tr><td>
  	
  	<input type="checkbox" name="stations" value="<%=rs.get("station_id") %>" /><%=rs.get("station_desc") %>
  
  	</td></tr>
  		<%} %>
  <%
  	}
  %>
</table>
</form>
</body>
</html>