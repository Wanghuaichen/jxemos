<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
      String q_col,so2_col,nox_col,pm_col = null;
      String f = "0.##";
      double r = 1000*1000;
   try{
   
    action = new SxReport();
    action.run(request,response,"rpt03");
   q_col = w.p("q_col");
   so2_col = w.p("so2_col");
   nox_col = w.p("nox_col");
   pm_col = w.p("pm_col");
   }catch(Exception e){
      w.error(e);
      return;
   }
   RowSet rs = w.rs("data");
   
   
%>
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css">
<div id='div_excel_content'>
<div  style="font-size:18px;font-weight:bold;text-align:center">
  <%=SxReportUtil.getTitleTime(request)%>  废气在线监控监测数据报表
</div>


<table border=0 cellspacing=1>

<tr class=title>
<td rowspan=2>序号</td>
 <td rowspan=2>监测点</td>
 <td rowspan=2>运行情况</td>
 
 <td rowspan=2>烟气排放量(万标m<sup>3</sup>)</td>
 <td rowspan=2>实测SO2排放量(KG)</td>
 <td rowspan=2>实测NOx排放量(KG)</td>
 <td rowspan=2>实测烟尘排放量(KG)</td>
 
 <td colspan=3>SO<sub>2</sub>折算浓度(mg/标m<sup>3</sup>)</td>
 <td colspan=3>烟尘折算浓度(mg/标m<sup>3</sup>)</td>
 <td colspan=3>Nox折算浓度(mg/标m<sup>3</sup>)</td>
 
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
   <td><%=rs.get(q_col+"_sum",10000,f)%></td>
   <td><%=rs.get(so2_col+"_q_sum",r,f)%></td>
   <td><%=rs.get(nox_col+"_q_sum",r,f)%></td>
   <td><%=rs.get(pm_col+"_q_sum",r,f)%></td>
   
   <td><%=rs.get(so2_col+"_max")%></td>
    <td><%=rs.get(so2_col+"_min")%></td>
    <td><%=rs.get(so2_col+"_avg",1,f)%></td>
   
    <td><%=rs.get(pm_col+"_max")%></td>
    <td><%=rs.get(pm_col+"_min")%></td>
    <td><%=rs.get(pm_col+"_avg",1,f)%></td>
    
    <td><%=rs.get(nox_col+"_max")%></td>
    <td><%=rs.get(nox_col+"_min")%></td>
    <td><%=rs.get(nox_col+"_avg",1,f)%></td>
    
    <td></td>
    <td></td>
    <td></td>
    
   </tr> 
   <%}%>


</table>

</div>
