<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
   try{
    action = new ReportNbAction();
    action.run(request,response,"rpt02");
   
   }catch(Exception e){
      w.error(e);
      return;
   }
   RowSet rs = w.rs("data");
   
   
%>

<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css">
<body>



<div class="tableSty1" id='div_excel_content'>

<div align=center style="font-size: 16px">污染源在线监测日报表</div>
<table border=0 cellspacing=0>
<tr>
<td colspan=5 align=left class=h2>
区名:<%=w.get("area_name")%>
</td>
<td colspan=5 style="text-align:right" class=h2>
报表日期:<%=w.get("date1")%>
</td>
</tr>
</table>



<table border=0 cellspacing=1>
<tr>
 <tr class=title>
  <td>站位名称</td>
  <td>PH超标率</td>
  <td>COD超标率</td>
  <td>COD平均值 mg/L</td>
  <td>COD累积量 kg</td>
  <td>COD计算值 kg</td>
  <td>流量累积量 m<sup>3</sup></td>
  <td>流量计算值 m<sup>3</sup></td>
  <td>流量获取率</td>
  <td>COD获取率</td>
 </tr>

  <%while(rs.next()){%>
  <tr>
    <td><%=rs.get("station_desc")%></td>
    <td><%=f.format(rs.get("ph_up"),"#")%> </td>
    <td><%=f.format(rs.get("cod_up"),"#")%> </td>
    <td><%=f.format(rs.get("cod_avg"),"#.##")%></td>
    <td><%=f.format(rs.get("cod1"),"#.##")%></td>
    <td><%=f.format(rs.get("cod2"),"#.##")%></td>
    <td><%=rs.get("q")%></td>
    <td><%=f.format(rs.get("q2"),"#.##")%></td>
    <td><%=f.format(rs.get("r"),"#")%></td>
    <td><%=f.format(rs.get("r_cod"),"#")%></td>
  </tr>
  <%}%>
</table>
</div>