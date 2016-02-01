<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
      String v_col,so2_col,nox_col,pm_col,o2_col = null;
      String f = "0.##";
      double r = 1000;
   try{
   
    action = new SxReport();
    action.run(request,response,"rpt07");
   v_col = w.p("v_col");
   so2_col = w.p("so2_col");
   nox_col = w.p("nox_col");
   
   pm_col = w.p("pm_col");
   o2_col = w.p("o2_col");
   }catch(Exception e){
      w.error(e);
      return;
   }
   RowSet rs = w.rs("data");
   
   
%>
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css">
<div id='div_excel_content'>
<div  style="font-size:18px;font-weight:bold;text-align:center">
 <%=SxReportUtil.getTitleTime(request)%>  废气在线监测点完好率统计报表
</div>


<table border=0 cellspacing=1>

<tr class=title>
<td rowspan=2>序号</td>
<td rowspan=2>监测点</td>

<td colspan=5>烟气流速</td>
<td colspan=5>SO<SUB>2</SUB></td>
<td colspan=5>NO<SUB>x</SUB></td>
<td colspan=5>烟尘</td>
<td colspan=5>O<SUB>2</SUB></td>

<td rowspan=2>平均完好率(%)</td>
</tr>

<tr class=title>
<td>应得个数</td>	
<td>实得个数</td>		
<td>缺失个数	</td>	
<td>完好率	</td>	
<td>缺失原因</td>	

<td>应得个数</td>	
<td>实得个数</td>		
<td>缺失个数	</td>	
<td>完好率	</td>	
<td>缺失原因</td>	

<td>应得个数</td>	
<td>实得个数</td>		
<td>缺失个数	</td>	
<td>完好率	</td>	
<td>缺失原因</td>	

<td>应得个数</td>	
<td>实得个数</td>		
<td>缺失个数	</td>	
<td>完好率	</td>	
<td>缺失原因</td>	

<td>应得个数</td>	
<td>实得个数</td>		
<td>缺失个数	</td>	
<td>完好率	</td>	
<td>缺失原因</td>	

</tr>


<%while(rs.next()){%>
<tr>
   <td><%=rs.getIndex()+1%></td>
   <td><%=rs.get("station_desc")%></td>
   
   <td><%=rs.get(v_col+"_num_all")%></td>
   <td><%=rs.get(v_col+"_num")%></td>
   <td><%=rs.get(v_col+"_num_no")%></td>
   <td><%=rs.get(v_col+"_r",1,f)%></td>
   <td></td>
   
   <td><%=rs.get(so2_col+"_num_all")%></td>
   <td><%=rs.get(so2_col+"_num")%></td>
   <td><%=rs.get(so2_col+"_num_no")%></td>
   <td><%=rs.get(so2_col+"_r",1,f)%></td>
   <td></td>
   
   <td><%=rs.get(nox_col+"_num_all")%></td>
   <td><%=rs.get(nox_col+"_num")%></td>
   <td><%=rs.get(nox_col+"_num_no")%></td>
   <td><%=rs.get(nox_col+"_r",1,f)%></td>
   <td></td>
   
     <td><%=rs.get(pm_col+"_num_all")%></td>
   <td><%=rs.get(pm_col+"_num")%></td>
   <td><%=rs.get(pm_col+"_num_no")%></td>
   <td><%=rs.get(pm_col+"_r",1,f)%></td>
   <td></td>
   
     <td><%=rs.get(o2_col+"_num_all")%></td>
   <td><%=rs.get(o2_col+"_num")%></td>
   <td><%=rs.get(o2_col+"_num_no")%></td>
   <td><%=rs.get(o2_col+"_r",1,f)%></td>
   <td></td>
   
   <td><%=rs.get("r_avg",1,f)%></td>
   </tr>
   <%}%>




</table>
</div>