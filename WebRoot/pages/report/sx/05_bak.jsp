<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
      String q_col,so2_col,nox_col,pm_col = null;
      String f = "0.##";
      double r = 1000*1000;
       List list = null;
       String sort_col = null;
       
   try{
   
    action = new SxReport();
    action.run(request,response,"rpt05");
   q_col = w.p("q_col");
   so2_col = w.p("so2_col");
   nox_col = w.p("nox_col");
   pm_col = w.p("pm_col");
   sort_col = w.p("sort_col");
   

   }catch(Exception e){
      w.error(e);
      return;
   }
   //RowSet rs = w.rs("data");
   RowSet rs =null;
   list = (List)w.a("data");
   //System.out.println(list.size());
   if(list==null){list=new ArrayList();}
   RowCompare c = new RowCompare();
   //c.setCompareCol(sort_col+"_p_over");
   c.setCompareCol(sort_col+"_q_over");
    //System.out.println(c);
   Collections.sort(list,c);
   rs  =new RowSet(list);
   
   
%>

<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css">
<div id='div_excel_content'>
<div  style="font-size:18px;font-weight:bold;text-align:center">
 <%=SxReportUtil.getTitleTime(request)%> 废气在线监测点SO2、Nox、烟尘排放浓度分段统计排放统计报表
</div>


<table border=0 cellspacing=1>

<tr class=title>
<td>序号</td>
<td>监测点</td>
<td>排放量(nm<sup>3</sup>)</td>

<td>SO2排放标准</td>
<td>SO2折算浓度分段</td>
<td>排放流量(nm<sup>3</sup>)</td>
<td>SO2实测排放量(KG)</td>
<td>排放率%</td>



<td>NOX排放标准</td>
<td>NOX折算浓度分段</td>
<td>排放流量(nm<sup>3</sup>)</td>
<td>NOX实测排放量(KG)</td>
<td>排放率%</td>


<td>烟尘排放标准</td>
<td>烟尘折算浓度分段</td>
<td>排放流量(nm<sup>3</sup>)</td>
<td>烟尘实测排放量(KG)</td>
<td>排放率%</td>

<td>备注</td>

</tr>

<%while(rs.next()){%>
<tr>
   <td rowspan=2><%=rs.getIndex()+1%></td>
   <td rowspan=2><%=rs.get("station_desc")%></td>
   <td rowspan=2><%=rs.get(q_col+"_sum",1,f)%></td>

      <td rowspan=2><%=rs.get(so2_col+"_std",1,f)%></td>
   <td> <排放标准 </td>
   <td><%=rs.get(so2_col+"_q_ok",1,f)%></td>
   <td><%=rs.get(so2_col+"_p_ok",r,f)%></td>
   <td><%=rs.get(so2_col+"_ok_r",1,f)%></td>
   
      <td rowspan=2><%=rs.get(nox_col+"_std",1,f)%></td>
   <td> <排放标准 </td>
   <td><%=rs.get(nox_col+"_q_ok",1,f)%></td>
   <td><%=rs.get(nox_col+"_p_ok",r,f)%></td>
   <td><%=rs.get(nox_col+"_ok_r",1,f)%></td>
   
   
      <td rowspan=2><%=rs.get(pm_col+"_std",1,f)%></td>
   <td> <排放标准 </td>
   <td><%=rs.get(pm_col+"_q_ok",1,f)%></td>
   <td><%=rs.get(pm_col+"_p_ok",r,f)%></td>
   <td><%=rs.get(pm_col+"_ok_r",1,f)%></td>
   
   
   
   <td rowspan=2></td>
   
   </tr>
   <tr>
   
    <td> >排放标准 </td>
   <td><%=rs.get(so2_col+"_q_over",1,f)%></td>
   <td><%=rs.get(so2_col+"_p_over",r,f)%></td>
   <td><%=rs.get(so2_col+"_over_r",1,f)%></td>
   
    <td> >排放标准 </td>
   <td><%=rs.get(nox_col+"_q_over",1,f)%></td>
   <td><%=rs.get(nox_col+"_p_over",r,f)%></td>
   <td><%=rs.get(nox_col+"_over_r",1,f)%></td>
   
    <td> >排放标准 </td>
   <td><%=rs.get(pm_col+"_q_over",1,f)%></td>
   <td><%=rs.get(pm_col+"_p_over",r,f)%></td>
   <td><%=rs.get(pm_col+"_over_r",1,f)%></td>
   
   </tr>
   <%}%>


</table>
</div>