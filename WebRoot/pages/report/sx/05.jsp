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

<link rel="stylesheet" href="../../../web/index.css" />
<div id='div_excel_content'>
	<span style="visibility: hidden;">hold space</span>
<div  style="font-size:18px;font-weight:bold;text-align:center">
 <%=SxReportUtil.getTitleTime(request)%> 废气在线监测点SO2、Nox、烟尘排放浓度分段统计排放统计报表
</div>
	<span style="visibility: hidden;">hold space</span>


	<table class="nui-table-inner major">
		<thead class="nui-table-head">
			<tr class="nui-table-row">
<th class="nui-table-cell" width="30px">序号</th>
<th class="nui-table-cell" width="200px">监测点</th>
<th class="nui-table-cell" style="padding: 1.5px">排放量(nm<sup>3</sup>)</th>

<th class="nui-table-cell" style="padding: 1.5px">SO2排放标准</th>
<th class="nui-table-cell" style="padding: 1.5px">SO2折算浓度分段</th>
<th class="nui-table-cell" style="padding: 1.5px">排放流量(nm<sup>3</sup>)</th>
<th class="nui-table-cell" style="padding: 1.5px">SO2实测排放量(KG)</th>
<th class="nui-table-cell" style="padding: 1.5px">排放率%</th>



<th class="nui-table-cell" style="padding: 1.5px">NOX排放标准</th>
<th class="nui-table-cell" style="padding: 1.5px">NOX折算浓度分段</th>
<th class="nui-table-cell" style="padding: 1.5px">排放流量(nm<sup>3</sup>)</th>
<th class="nui-table-cell" style="padding: 1.5px">NOX实测排放量(KG)</th>
<th class="nui-table-cell" style="padding: 1.5px">排放率%</th>


<th class="nui-table-cell" style="padding: 1.5px">烟尘排放标准</th>
<th class="nui-table-cell" style="padding: 1.5px">烟尘折算浓度分段</th>
<th class="nui-table-cell" style="padding: 1.5px">排放流量(nm<sup>3</sup>)</th>
<th class="nui-table-cell" style="padding: 1.5px">烟尘实测排放量(KG)</th>
<th class="nui-table-cell" style="padding: 1.5px">排放率%</th>

<th class="nui-table-cell">备注</th>

</tr>
		</thead>
		<tbody class="nui-table-body">

<%while(rs.next()){%>
<tr>
   <th class="nui-table-cell" rowspan=2><%=rs.getIndex()+1%></th>
   <th class="nui-table-cell" rowspan=2><%=rs.get("station_desc")%></th>
   <th class="nui-table-cell" rowspan=2><%=rs.get(q_col+"_sum",1,f)%></th>

      <th class="nui-table-cell" rowspan=2><%=rs.get(so2_col+"_std",1,f)%></th>
   <th class="nui-table-cell"> <排放标准 </th>
   <th class="nui-table-cell"><%=rs.get(so2_col+"_q_ok",1,f)%></th>
   <th class="nui-table-cell"><%=rs.get(so2_col+"_p_ok",r,f)%></th>
   <th class="nui-table-cell"><%=rs.get(so2_col+"_ok_r",1,f)%></th>
   
      <th class="nui-table-cell" rowspan=2><%=rs.get(nox_col+"_std",1,f)%></th>
   <th class="nui-table-cell"> <排放标准 </th>
   <th class="nui-table-cell"><%=rs.get(nox_col+"_q_ok",1,f)%></th>
   <th class="nui-table-cell"><%=rs.get(nox_col+"_p_ok",r,f)%></th>
   <th class="nui-table-cell"><%=rs.get(nox_col+"_ok_r",1,f)%></th>
   
   
      <th class="nui-table-cell" rowspan=2><%=rs.get(pm_col+"_std",1,f)%></th>
   <th class="nui-table-cell"> <排放标准 </th>
   <th class="nui-table-cell"><%=rs.get(pm_col+"_q_ok",1,f)%></th>
   <th class="nui-table-cell"><%=rs.get(pm_col+"_p_ok",r,f)%></th>
   <th class="nui-table-cell"><%=rs.get(pm_col+"_ok_r",1,f)%></th>
   
   
   
   <th class="nui-table-cell" rowspan=2></th>
   
   </tr>
   <tr>
   
    <th class="nui-table-cell"> >排放标准 </th>
   <th class="nui-table-cell"><%=rs.get(so2_col+"_q_over",1,f)%></th>
   <th class="nui-table-cell"><%=rs.get(so2_col+"_p_over",r,f)%></th>
   <th class="nui-table-cell"><%=rs.get(so2_col+"_over_r",1,f)%></th>
   
    <th class="nui-table-cell"> >排放标准 </th>
   <th class="nui-table-cell"><%=rs.get(nox_col+"_q_over",1,f)%></th>
   <th class="nui-table-cell"><%=rs.get(nox_col+"_p_over",r,f)%></th>
   <th class="nui-table-cell"><%=rs.get(nox_col+"_over_r",1,f)%></th>
   
    <th class="nui-table-cell"> >排放标准 </th>
   <th class="nui-table-cell"><%=rs.get(pm_col+"_q_over",1,f)%></th>
   <th class="nui-table-cell"><%=rs.get(pm_col+"_p_over",r,f)%></th>
   <th class="nui-table-cell"><%=rs.get(pm_col+"_over_r",1,f)%></th>
   
   </tr>
   <%}%>

</tbody>
</table>
</div>