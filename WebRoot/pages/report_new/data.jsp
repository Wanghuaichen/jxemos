<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
    try{
    
      ReportUpdate.getData(request);
    
    }catch(Exception e){
     w.error(e);
     return;
    }
    RowSet rs = w.rs("dataList");
    RowSet rsf = w.rs("paramList");
%>
<body>
<form name="form1" action="../commons/save_excel.jsp" method=post>
<input type="hidden" name="txt_excel_content" />
</form1>
<div style="float:left;padding-left:10px;height:30px"><input type="button" value="����" class="btn" onclick="window.history.back()" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="����ΪExcel" onclick="save_excel()" class="btn" /></div>
<div id="div_excel_content">
<div style="float:left;width:100%;"><center><font style="font-weight:bold;font-size;14px"><%=w.get("date1") %>&nbsp;&nbsp;��&nbsp;&nbsp;<%=w.get("date2") %> �ۺϲ�ѯ����</center></div>
<table border=0 cellspacing=1>
  <tr class='title'> 
  <td>վλ����</td>
  <%
  	while(rsf.next())
  	{
  	if(!rsf.get("infectant_name").equals("����2"))
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
  <%
  		rsf.reset();
  		while(rsf.next())
  		{
  			String col = rsf.get("infectant_column");
  			if(!rsf.get("infectant_name").equals("����2"))
  			{
  %>
  <td><%=rs.get(col) %></td> 
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