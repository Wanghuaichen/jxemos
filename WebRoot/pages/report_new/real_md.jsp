<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
    try{
    
      ReportUpdate.real_md(request);
    
    }catch(Exception e){
     w.error(e);
     return;
    }
    RowSet rs = w.rs("datalist");
    RowSet rsf = w.rs("paramlist");
%>
<body>
<form name="form1" action="../commons/save_excel.jsp" method=post>
<input type="hidden" name="txt_excel_content" />
</form1>
<div style="float:left;padding-left:10px;height:30px"><input type="button" value="返回" class="btn" onclick="window.history.back()" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="保存为Excel" onclick="save_excel()" class="btn" /></div>
<div id="div_excel_content">
<div style="float:left;width:100%;"><center><font style="font-weight:bold;font-size;14px"><%=w.get("date1") %>至<%=w.get("date2") %><%=w.get("bb_name") %></center></div>
<table border=0 cellspacing=1>
  <tr class='title'> 
  <td width="100px">站位名称</td>
  <td>监测时间</td>
  <%
  	while(rsf.next())
  	{
  	if(!rsf.get("infectant_name").equals("流量2"))
  	{
  %>
    <td><%=rsf.get("infectant_name") %><br><%=rsf.get("infectant_unit") %></td>
   <%
   	}}
   %>
  </tr>
  </tr>
  <%
  	while(rs.next())
  	{
  %>
  <tr>
  <td><%=rs.get("station_desc") %></td>
  <td><%=rs.get("m_time") %></td>
  <%
  		rsf.reset();
  		while(rsf.next())
  		{
  			String col = rsf.get("infectant_column").toLowerCase();
  			if(!rsf.get("infectant_name").equals("流量2"))
  			{
  %>
  <td><%=f.v(rs.get(col)) %></td> 
  <%
  			}
  		}
  %>
   </tr>
  <%
  	}
  %>
</table>
</div>
</body>
<script>
	function save_excel()
	{
		form1.txt_excel_content.value = document.getElementById("div_excel_content").innerHTML.replace("border=0","border=1");
		form1.submit();
	}
</script>