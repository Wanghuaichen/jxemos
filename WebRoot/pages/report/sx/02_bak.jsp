<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
      String q_col,cod_col,ph_col = null;
      String f = "0.##";
      double r = 1000;
   try{
   
    action = new SxReport();
    action.run(request,response,"rpt02");
   q_col = w.p("q_col");
   cod_col = w.p("cod_col");
   ph_col = w.p("ph_col");
   
   }catch(Exception e){
      w.error(e);
      return;
   }
   RowSet rs = w.rs("data");
   
   
%>
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css">
<div id='div_excel_content'>
<div  style="font-size:18px;font-weight:bold;text-align:center">
 <%=SxReportUtil.getTitleTime(request)%> 废水在线监控监测数据报表
</div>

<table border=0 cellspacing=1>

<tr class=title>
 <td rowspan=2>序号</td>
 <td rowspan=2>监测点</td>
 <td rowspan=2>运行情况</td>
 <td rowspan=2>污水排放量(m<sup>3</sup>)</td>
 
 <td colspan=3>流量(m<sup>3</sup>/h)</td>
 <td colspan=3>COD(mg/L)</td>
 <td colspan=3>PH</td>
 
 <td rowspan=2>COD排放量(KG)</td>
 
 <td colspan=2>视频图象</td>
 
 <td rowspan=2>备注</td>
 
</tr>

<tr class=title>

<td>最大</td>
<td>最小</td>
<td>平均</td>

<td>最大</td>
<td>最小</td>
<td>平均</td>

<td>最大</td>
<td>最小</td>
<td>平均</td>

<td>运行情况</td>
<td>故障原因</td>


</tr>

<%while(rs.next()){%>
<tr>
   <td><%=rs.getIndex()+1%></td>
   <td><%=rs.get("station_desc")%></td>
   <td></td>
   <td><%=rs.get(q_col+"_sum",1,f)%></td>
   
   <td><%=rs.get(q_col+"_max")%></td>
   <td><%=rs.get(q_col+"_min")%></td>
   <td><%=rs.get(q_col+"_avg",1,f)%></td>
   
     <td><%=rs.get(cod_col+"_max")%></td>
   <td><%=rs.get(cod_col+"_min")%></td>
   <td><%=rs.get(cod_col+"_avg",1,f)%></td>
   
     <td><%=rs.get(ph_col+"_max")%></td>
   <td><%=rs.get(ph_col+"_min")%></td>
   <td><%=rs.get(ph_col+"_avg",1,f)%></td>
   
     <td><%=rs.get(cod_col+"_q_sum",r,f)%></td>
   
   <td></td>
   <td></td>
   <td></td>
</tr>
<%}%>


</table>


</div>