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
<link rel="stylesheet" href="../../../web/index.css" />
<div id='div_excel_content'>
	<span style="visibility: hidden;">hold space</span>
<div  style="font-size:18px;font-weight:bold;text-align:center">
  <%=SxReportUtil.getTitleTime(request)%>  废气在线监控监测数据报表
</div>
	<span style="visibility: hidden;">hold space</span>

	<table class="nui-table-inner major">
		<thead class="nui-table-head">
			<tr class="nui-table-row">
<th class="nui-table-cell" rowspan=2 width="30px">序号</th>
 <th class="nui-table-cell" rowspan=2 width="200px">监测点</th>
 <th class="nui-table-cell" rowspan=2 width="80px">运行情况</th>
 
 <th class="nui-table-cell" rowspan=2 style="width: 50px">烟气排放量(万标m<sup>3</sup>)</th>
 <th class="nui-table-cell" rowspan=2 style="width: 50px">实测SO2排放量(KG)</th>
 <th class="nui-table-cell" rowspan=2 style="width: 50px">实测NOx排放量(KG)</th>
 <th class="nui-table-cell" rowspan=2 style="width: 50px">实测烟尘排放量(KG)</th>
 
 <th class="nui-table-cell" colspan=3>SO<sub>2</sub>折算浓度(mg/标m<sup>3</sup>)</th>
 <th class="nui-table-cell" colspan=3>烟尘折算浓度(mg/标m<sup>3</sup>)</th>
 <th class="nui-table-cell" colspan=3>Nox折算浓度(mg/标m<sup>3</sup>)</th>
 
 <th class="nui-table-cell" colspan=2>视频图象</th>
 
 <th class="nui-table-cell" rowspan=2>备注</th>
 
</tr>

<tr class=title>


<th class="nui-table-cell">最大</th>
<th class="nui-table-cell">最小</th>
<th class="nui-table-cell">平均</th>

<th class="nui-table-cell">最大</th>
<th class="nui-table-cell">最小</th>
<th class="nui-table-cell">平均</th>

<th class="nui-table-cell">最大</th>
<th class="nui-table-cell">最小</th>
<th class="nui-table-cell">平均</th>

<th class="nui-table-cell">运行情况</th>
<th class="nui-table-cell">故障原因</th>

</tr>
		</thead>
		<tbody class="nui-table-body">

<%while(rs.next()){%>
<tr>
   <th class="nui-table-cell"><%=rs.getIndex()+1%></th>
   <th class="nui-table-cell"><%=rs.get("station_desc")%></th>
   <th class="nui-table-cell"></th>
   <th class="nui-table-cell"><%=rs.get(q_col+"_sum",10000,f)%></th>
   <th class="nui-table-cell"><%=rs.get(so2_col+"_q_sum",r,f)%></th>
   <th class="nui-table-cell"><%=rs.get(nox_col+"_q_sum",r,f)%></th>
   <th class="nui-table-cell"><%=rs.get(pm_col+"_q_sum",r,f)%></th>
   
   <th class="nui-table-cell"><%=rs.get(so2_col+"_max")%></th>
    <th class="nui-table-cell"><%=rs.get(so2_col+"_min")%></th>
    <th class="nui-table-cell"><%=rs.get(so2_col+"_avg",1,f)%></th>
   
    <th class="nui-table-cell"><%=rs.get(pm_col+"_max")%></th>
    <th class="nui-table-cell"><%=rs.get(pm_col+"_min")%></th>
    <th class="nui-table-cell"><%=rs.get(pm_col+"_avg",1,f)%></th>
    
    <th class="nui-table-cell"><%=rs.get(nox_col+"_max")%></th>
    <th class="nui-table-cell"><%=rs.get(nox_col+"_min")%></th>
    <th class="nui-table-cell"><%=rs.get(nox_col+"_avg",1,f)%></th>
    
    <th class="nui-table-cell"></th>
    <th class="nui-table-cell"></th>
    <th class="nui-table-cell"></th>
    
   </tr> 
   <%}%>

</tbody>
</table>

</div>
