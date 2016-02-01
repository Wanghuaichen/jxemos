<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
    try{
    
      ReportUpdate.zl_tj(request);
    
    }catch(Exception e){
     w.error(e);
     return;
    }
    RowSet rs = w.rs("stationList");
    RowSet rsf = w.rs("paramList");
%>
<body>
<form name="form1" action="../commons/save_excel.jsp" method=post>
<input type="hidden" name="txt_excel_content" />
</form1>
<div style="float:left;padding-left:10px;height:30px"><input type="button" value="返回" class="btn" onclick="window.history.go(-1)" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="保存为Excel" onclick="save_excel()" class="btn" /></div>
<div id="div_excel_content">
<div style="float:left;width:100%;"><center><font style="font-weight:bold;font-size;14px"><%=w.get("date1") %>至<%=w.get("date2") %>总量统计报表</center></div>
<table border=0 cellspacing=1>
  <tr class='title'> 
  <td width="100px">站位名称</td>
  <%
  	while(rsf.next())
  	{
  %>
    <td><%=rsf.get("infectant_name") %><br><%=rsf.get("infectant_unit") %></td>
   <%
   }
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
  			String col = rsf.get("infectant_column").toLowerCase();
  			if(!rsf.get("infectant_name").equals("流量2"))
  			{
  				String v = rs.get(col);
  				double d_v = 0d;
  				if(!f.empty(v)&&StringUtil.isNum(v))
  				{
  					d_v = Double.parseDouble(v);
  					d_v = StyleUtil.dformat(d_v);
  				}
  				if(d_v==0d)
  				{
  					v = "";
  				}
  				else
  				{
  					v = d_v+"";
  				}
  %>
  <td><%=v %></td> 
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