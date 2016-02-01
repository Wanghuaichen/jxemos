<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
   try{
   
    action = new FyReport();
    action.run(request,response,"rpt01");
   
   
   }catch(Exception e){
      w.error(e);
      return;
   }
   RowSet rs = w.rs("dataList");
   int i,num=0;
   num = 24;
   String key = null;
   
   
%>
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css">
<div id='div_excel_content'>
<div class=center style="font-size:18px;font-weight:bold">
 <%=w.get("yy")%> 年 <%=w.get("mm")%>  月份在线监控企业月报表
</div>
<div class=left>
站位名称:<%=w.get("station_name")%>
<!--统计月份:-->
</div>

<table border=0 cellspacing=1>
<tr class=title>
<td>序号</td>
<td>日期</td>
<%for(i=0;i<24;i++){%>
<td><%=i%></td>
<%}%>
<td>超标COD日数据</td>
<td>备注</td>
</tr>

<%while(rs.next()){%>
<tr>
<td><%=rs.getIndex()+1%></td>
<td><%=rs.get("date")%></td>

<%for(i=0;i<24;i++){
 key=i+"";
%>
 <td><%=rs.get(key)%></td>
<%}%>
<td><%=f.format(rs.get("avg"),"0.##")%></td>
<td></td>
</tr>
<%}%>

<tr>
<td colspan=27>
 <%=w.get("yy")%>  年 <%=w.get("mm")%>  月份共有 <%=rs.size()%> 天出现<%=w.get("std")%>&lt=COD标准值&lt=<%=w.get("std2")%> mg/L排污情况
</td>
<td>
<%=f.format(w.get("avg"),"0.##")%>
</td>
</tr>
</table>

</div>




