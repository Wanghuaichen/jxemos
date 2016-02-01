<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

    try{
    
      SHUpdate.sh_index(request);
    
    }catch(Exception e){
     w.error(e);
     return;
    }

    
%>
<body scroll=no>
<form name=form1 method=post target='frm_real_data'>
<table style='width:100%;height:100%' border=0 cellspacing=0>
   <tr>
     <td style='height:20px' colspan="2">
   
<select name=station_type  onchange=f_r()>
<%=w.get("stationTypeOption")%>
</select>
               
<select name=area_id onchange=f_r()>
<%=w.get("areaOption")%>
</select>

<select name=ctl_type onchange=f_r()>
<option value=''>重点源属性</option>
<%=w.get("ctlTypeOption")%>
</select>


<select name=valley_id onchange=f_r()>
<option value=''>流域</option>
<%=w.get("valleyOption")%>
</select>

<select name=trade_id onchange=f_r() >
<option value=''>行业
<%=w.get("tradeOption")%>
</select>   
<input type="text" name="station_name" style="width:150px" /> 
<br>
<br>
<select name=station_id onchange=h_query() style="width:150px">
<%=w.get("stationOption")%>
</select> 
<input type="text" name="date1" value="<%=f.today()%>" style="width:70px;cursor:hand;" onclick="Calendar.Show(this)" /> 
<input type="text" name="date2" value="<%=f.today()%>" style="width:70px;cursor:hand;" onclick="Calendar.Show(this)" /> 
<input type="button" value="查看" class="btn" onclick="h_query()" />
</td></tr>
   
   <tr>
     <td style='height:100%' colspan="2">
      <iframe name='frm_real_data' id='frm_real_data' width=100% height=100% frameborder=0></iframe>
     </td>
   </tr>
   
</table>
</form>
</body>
<script>
	function f_r()
	{
		form1.action="index.jsp";
		form1.target='';
		form1.submit();
		h_query();
	}
	function h_query()
	{
		form1.action="data.jsp";
		form1.target="frm_real_data";
		form1.submit();
	}
</script>
