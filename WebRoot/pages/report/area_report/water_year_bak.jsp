<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
   String cod = request.getParameter("w_cod");
   String ph = request.getParameter("w_ph");
   String q = request.getParameter("w_q");
   Timestamp time = (Timestamp)request.getAttribute("time");
     Map infectantInfo = (Map)request.getAttribute("infectantInfo");
   String station_id = null;
   String s1,s2 = null;
   List data = null;
   RowSet rs = null;
   String v = null;
   String format = "0.####";
   double r = 1000*1000;
   int totalnum = AreaReport.getTotalNum(request);
   data = (List)request.getAttribute("data");
   rs = new RowSet(data);
   
   
   
%>
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css">
<div id='div_excel_content'>
<div style="font-size:20px;font-weight:bold">
<%=request.getAttribute("report_name")%>
</div>
<div class=left>
地区:<%=request.getAttribute("area_name")%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
日期：<%=time.getYear()+1900%> 年
   

</div>

<table border=0 cellspacing=1>
<tr class=title>
<td rowspan=2>地区</td>
<td rowspan=2>单位名称</td>

<td colspan=2>COD</td>
<td rowspan=2>ph</td>
<td rowspan=2>累积流量M<sup>3</sup></td>

<td colspan=3>在线率(%)</td>
<td colspan=2>超标率(%)</td>

</tr>

<tr class=title>
<td>mg/L</td>
<td>t/y</td>

<td>流量</td>
<td>PH</td>
<td>COD</td>

<td>PH</td>
<td>COD</td>

</tr>

<%while(rs.next()){
station_id = rs.get("station_id");
%>
<tr>
<td><%=rs.get("area_name")%></td>
<td><%=rs.get("station_desc")%></td>
<%
       v = rs.get(cod);
       v = AreaReport.v(v,1,format);
       v = AreaReport.flag(v,station_id,cod,infectantInfo);
%>
<td><%=v%></td>
<%
       v = rs.get(cod+"_q");
       v = AreaReport.v(v,r,format);
       v = AreaReport.flag(v,station_id,cod,q,infectantInfo);
%>
<td><%=v%></td>
<%
       v = rs.get(ph);
       v = AreaReport.v(v,1,format);
       v = AreaReport.flag(v,station_id,ph,infectantInfo);
%>
<td><%=v%></td>
<%
       v = rs.get(q);
       v = AreaReport.v(v,1,format);
       v = AreaReport.flag(v,station_id,q,infectantInfo);
%>
<td><%=v%></td>
<%
s1 = rs.get(q+"_num");
s2 = totalnum+"";
  v = AreaReport.percentv(s1,s2);
  v = AreaReport.flag(v,station_id,q,infectantInfo);
%>
<td><%=v%></td>
<%
s1 = rs.get(ph+"_num");
s2 = totalnum+"";
  v = AreaReport.percentv(s1,s2);
 v = AreaReport.flag(v,station_id,ph,infectantInfo);
%>
<td><%=v%></td>
<%
s1 = rs.get(cod+"_num");
s2 = totalnum+"";
  v = AreaReport.percentv(s1,s2);
 v = AreaReport.flag(v,station_id,cod,infectantInfo);
%>
<td><%=v%></td>
<%
s1 = rs.get(ph+"_over_num");
s2 = rs.get(ph+"_num");
  v = AreaReport.percentv(s1,s2);
 v = AreaReport.flag(v,station_id,ph,infectantInfo);
%>
<td><%=v%></td>
<%
s1 = rs.get(cod+"_over_num");
s2 = rs.get(cod+"_num");
  v = AreaReport.percentv(s1,s2);
  v = AreaReport.flag(v,station_id,cod,infectantInfo);
%>
<td><%=v%></td>

</tr>
<%}%>

<tr>
<td>合计</td>
<td><%=data.size()%></td>

<td>-</td>
<%
  v = AreaReport.sum(data,cod+"_q",r,format);
  v = AreaReport.flag(v,station_id,cod,q,infectantInfo);
%>
<td><%=v%></td>

<td>-</td>
<%
  v = AreaReport.sum(data,q,1,format);
 v = AreaReport.flag(v,station_id,q,infectantInfo);
%>
<td><%=v%></td>

<td></td>
<td></td>
<td></td>

<td></td>
<td></td>


</tr>

</table>
</div>