<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
      String q_col,cod_col = null;
      String f = "0.##";
      double r = 1000;
      List list = null;
      
   try{
   
    action = new SxReport();
    action.run(request,response,"rpt04");
   q_col = w.p("q_col");
   cod_col = w.p("cod_col");

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
   //c.setCompareCol(cod_col+"_p_over");
   //c.setCompareCol(cod_col+"_q_over");
   String sort_col = request.getParameter("sort_col");
   c.setCompareCol(sort_col);
   //System.out.println(sort_col);
    //System.out.println(c);
   Collections.sort(list,c);
   rs  =new RowSet(list);
   
%>
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css">
<div id='div_excel_content'>
<div  style="font-size:18px;font-weight:bold;text-align:center">
  <%=SxReportUtil.getTitleTime(request)%> 废水在线监测点COD浓度分段统计报表
</div>


<table border=0 cellspacing=1>

<tr class=title>
<td>序号</td>
<td>监测点</td>
<td>排放量(m<sup>3</sup>)</td>
<td>COD排放标准</td>
<td>COD浓度分段</td>
<td>平均浓度</td>
<td>排放流量(m<sup>3</sup>)</td>
<td>COD排放量(KG)</td>
<td>排放率%</td>
<td>备注</td>
</tr>
<%while(rs.next()){%>
<tr>
   <td rowspan=2><%=rs.getIndex()+1%></td>
   <td rowspan=2><%=rs.get("station_desc")%></td>
   <td rowspan=2><%=rs.get(q_col+"_sum",1,f)%></td>
   <td rowspan=2><%=rs.get(cod_col+"_std",1,f)%></td>
   
   <td> <排放标准 </td>
   
   <td><%=rs.get(cod_col+"_avg_c_ok",1,f)%></td>
   <td><%=rs.get(cod_col+"_q_ok",1,f)%></td>
   <td><%=rs.get(cod_col+"_p_ok",r,f)%></td>
   <td><%=rs.get(cod_col+"_ok_r",1,f)%></td>
   
   <td rowspan=2></td>
   
   </tr>
   <tr>
    <td> >排放标准 </td>
   <td><%=rs.get(cod_col+"_avg_c_over",1,f)%></td>
   <td><%=rs.get(cod_col+"_q_over",1,f)%></td>
   <td><%=rs.get(cod_col+"_p_over",r,f)%></td>
   <td><%=rs.get(cod_col+"_over_r",1,f)%></td>
   </tr>
   <%}%>
</table>
</div>

