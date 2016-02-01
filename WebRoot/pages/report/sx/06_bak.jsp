<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
      String q_col,toc_col,ph_col,cod_col = null;
      String f = "0.##";
      double r = 1000;
   try{
   
    action = new SxReport();
    action.run(request,response,"rpt06");
   q_col = w.p("q_col");
   toc_col = w.p("toc_col");
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
 <%=SxReportUtil.getTitleTime(request)%> 废水在线监测点完好率统计报表
</div>


<table border=0 cellspacing=1>

<tr class=title>
<td rowspan=2>序号</td>
<td rowspan=2>监测点</td>
<td colspan=5>流量数据</td>
<td colspan=5>COD数据</td>
<%--<td colspan=5>TOC数据</td>--%>
<td colspan=5>PH</td>
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


<%--<td>应得个数</td>	
<td>实得个数</td>		
<td>缺失个数	</td>	
<td>完好率	</td>	
<td>缺失原因</td>	--%>


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
   
   <td><%=rs.get(q_col+"_num_all")%></td>
   <td><%=rs.get(q_col+"_num")%></td>
   <td><%=rs.get(q_col+"_num_no")%></td>
   <td><%=rs.get(q_col+"_r",1,f)%></td>
   <td></td>
   
     <td><%=rs.get(cod_col+"_num_all")%></td>
   <td><%=rs.get(cod_col+"_num")%></td>
   <td><%=rs.get(cod_col+"_num_no")%></td>
   <td><%=rs.get(cod_col+"_r",1,f)%></td>
   <td></td>
   
   <%--<td><%=rs.get(toc_col+"_num_all")%></td>
   <td><%=rs.get(toc_col+"_num")%></td>
   <td><%=rs.get(toc_col+"_num_no")%></td>
   <td><%=rs.get(toc_col+"_r",1,f)%></td>
   <td></td> --%>
   
  <td><%=rs.get(ph_col+"_num_all")%></td>
   <td><%=rs.get(ph_col+"_num")%></td>
   <td><%=rs.get(ph_col+"_num_no")%></td>
   <td><%=rs.get(ph_col+"_r",1,f)%></td>
   <td></td>
   
   <td><%=rs.get("r_avg",1,f)%></td>
   </tr>
   <%}%>


</table>
</div>