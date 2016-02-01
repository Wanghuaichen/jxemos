<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
       String[]colids = null;
      int coli,colidnum = 0;
      Map colMap = null;
   try{
   
    action = new FyReport();
   action.run(request,response,"rpt02");
   colids = request.getParameterValues("station_col_id");
   if(colids==null){colids=new String[0];}
   colidnum = colids.length;
   colMap = FyReportUtil.getStationColMap();
   
   }catch(Exception e){
      w.error(e);
      return;
   }
   RowSet rs = w.rs("list");
   int i,num=0;
   num = 24;
   String key = null;
   
   
%>
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css">
<div id='div_excel_content'>
<div class=center style="font-size:18px;font-weight:bold">
 <%=w.get("yy")%> 年 <%=w.get("mm")%>  月份在线监控设施故障发生时段统计表
</div>


<table border=0 cellspacing=1>
<tr class=title>
<td>序号</td>
<td>站位名称</td>


    <%for(coli=0;coli<colidnum;coli++){%>
    <td><%=FyReportUtil.getStationColName(colMap,colids[coli])%></td>
    <%}%>



<td style="width:50px">故障天数</td>
<td style="width:500px">故障详细日期</td>
<td>备注</td>

</tr>



<%while(rs.next()){%>
<tr>
  <td><%=rs.getIndex()+1%></td>
  <td><%=rs.get("station_desc")%></td>
  
  
 <%for(coli=0;coli<colidnum;coli++){%>
    <td><%=rs.get("val"+colids[coli])%></td>
    <%}%>
  
  
  <td><%=rs.get("gznum_all")%></td>
  
  <td><%=rs.get("gz_date")%></td>
  
  
  <td></td>
  
</tr>
<%}%>


</table>

</div>
