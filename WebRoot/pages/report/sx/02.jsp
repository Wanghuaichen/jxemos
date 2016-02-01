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
<link rel="stylesheet" href="../../../web/index.css" />
<div id='div_excel_content'>
	<span style="visibility: hidden;">hold space</span>
<div  style="font-size:18px;font-weight:bold;text-align:center">
 <%=SxReportUtil.getTitleTime(request)%> 废水在线监控监测数据报表
</div>
	<span style="visibility: hidden;">hold space</span>

	<table class="nui-table-inner major">
		<thead class="nui-table-head">
			<tr class="nui-table-row">
 <th class="nui-table-cell" rowspan=2 width="30px">序号</th>
 <th class="nui-table-cell" rowspan=2 width="240px">监测点</th>
 <th class="nui-table-cell" rowspan=2 width="100px">运行情况</th>
 <th class="nui-table-cell" rowspan=2>污水排放量(m<sup>3</sup>)</th>
 
 <th class="nui-table-cell" colspan=3>流量(m<sup>3</sup>/h)</th>
 <th class="nui-table-cell" colspan=3>COD(mg/L)</th>
 <th class="nui-table-cell" colspan=3>PH</th>
 
 <th class="nui-table-cell" rowspan=2>COD排放量(KG)</th>
 
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
   <th class="nui-table-cell"><%=rs.get(q_col+"_sum",1,f)%></th>
   
   <th class="nui-table-cell"><%=rs.get(q_col+"_max")%></th>
   <th class="nui-table-cell"><%=rs.get(q_col+"_min")%></th>
   <th class="nui-table-cell"><%=rs.get(q_col+"_avg",1,f)%></th>
   
     <th class="nui-table-cell"><%=rs.get(cod_col+"_max")%></th>
   <th class="nui-table-cell"><%=rs.get(cod_col+"_min")%></th>
   <th class="nui-table-cell"><%=rs.get(cod_col+"_avg",1,f)%></th>
   
     <th class="nui-table-cell"><%=rs.get(ph_col+"_max")%></th>
   <th class="nui-table-cell"><%=rs.get(ph_col+"_min")%></th>
   <th class="nui-table-cell"><%=rs.get(ph_col+"_avg",1,f)%></th>
   
     <th class="nui-table-cell"><%=rs.get(cod_col+"_q_sum",r,f)%></th>
   
   <th class="nui-table-cell"></th>
   <th class="nui-table-cell"></th>
   <th class="nui-table-cell"></th>
</tr>
<%}%>
</tbody>

</table>


</div>