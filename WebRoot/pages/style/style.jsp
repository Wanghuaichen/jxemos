<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp" %>
<%
    try{
    
      StyleUpdate.getPercentOfStyle(request);
      
      }catch(Exception e){
      w.error(e);
      return; 
      }
      RowSet typers = w.rs("typeList");
      RowSet arears = w.rs("areaList");
      Map stationMap = (Map)request.getAttribute("stationMap");
%>
<style>
  .type{font-weight:bold;font-size:15px;text-align:center;padding:8px;
  /*background-color:#FDCC7E;*/
  }

</style>
<form name="form1" action="style.jsp" method="post">
<table border=0 cellspacing=1>
 <tr><td colspan="3">
 <select name="ctl_type" onchange="form1.submit()"><option value="null">重点源属性</option><%=w.get("ctlOption") %><select/>
 <input type="text" name="date1" value="<%=w.get("date1") %>" onclick="Calendar.Show(this)" style="width:100px"/>
 <select name="hour1"><%=w.get("hour1") %></select>
 <input type="text" name="date2" value="<%=w.get("date2") %>" onclick="Calendar.Show(this)" style="width:100px"/>
 <select name="hour1"><%=w.get("hour2") %></select>
 <input type="button" value="汇总" onclick="form1.submit()" class="btn" />
 </td></tr>
<%
    while(typers.next()){
    String name=typers.get("type_name");
    String type = typers.get("type_id");
    Map typemap = (Map)stationMap.get(type);
%>
  <tr><td colspan=6 class='type'><%=name%></td></tr> 
  <tr class=title>
  <td>地区</td>
  <td>联网率</td>
  <td>有效数据获取率</td>
 </tr>
 <%
 	arears.reset();
 	while(arears.next())
 	{
 		String area_id = arears.get("area_id");
 		String area_name = arears.get("area_name");
 		Map areamap = (Map)typemap.get(area_id);
 %>
  <tr>
    <td><%=area_name %></td>
    <td><%=areamap.get("sd_percent")%></td>
    <td><%=areamap.get("yx_percent")%></td>
  </tr>
 <%
 	}
 }
 %>  
 </table>
 </form>
