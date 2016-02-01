<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
   try{
   
    action = new FyReport();
    action.run(request,response,"rpt02");
   
   
   }catch(Exception e){
      w.error(e);
      return;
   }
   RowSet rs = w.rs("list");
   int i,num=0;
   num = 24;
   String key = null;
   
   
%>
<div id='div_excel_content'>
<div class=center style="font-size:18px;font-weight:bold">
 <%=w.get("yy")%> 年 <%=w.get("mm")%>  月份在线监控企业污染物排放统计汇总表
</div>


<table border=0 cellspacing=1>
<tr class=title>
<td rowspan=2>序号</td>
<td rowspan=2>污水费计征序号</td>
<td rowspan=2>站位名称</td>
<td rowspan=2>地址</td>
<td rowspan=2>COD月汇总数据</td>

<td colspan=3>正常生产排污</td>
<td colspan=3>异常生产排污</td>
<td colspan=3>在线故障</td>

<td rowspan=2>月污水量</td>
<td rowspan=2>COD> <%=w.get("cod_std")%> 天数</td>
<td rowspan=2>COD> <%=w.get("cod_std")%>平均值</td>
<td rowspan=2>备注</td>
</tr>

<tr class=title>
<td>天数</td>
<td>日均流量</td>
<td>污水量</td>

<td>天数</td>
<td>日均流量</td>
<td>污水量</td>

<td>天数</td>
<td>日均流量</td>
<td>污水量</td>


</tr>


<%while(rs.next()){%>
<tr>
  <td><%=rs.getIndex()+1%></td>
  <td></td>
  <td><%=rs.get("station_name")%></td>
  <td></td>
  
  <td><%=f.format(rs.get("avg_cod"),"0.##")%></td>
  
  
  <td><%=rs.get("count_q_zc")%></td>
  <td><%=f.format(rs.get("avg_q_zc"),"0.##")%></td>
  <td><%=f.format(rs.get("sum_q_zc"),"0.##")%></td>
  
  <td><%=rs.get("count_q_yc")%></td>
  <td><%=f.format(rs.get("avg_q_yc"),"0.##")%></td>
  <td><%=f.format(rs.get("sum_q_yc"),"0.##")%></td>
  
  
  <td><%=rs.get("count_q_gz")%></td>
  <td><%=f.format(rs.get("avg_q_gz"),"0.##")%></td>
  <td><%=f.format(rs.get("sum_q_gz"),"0.##")%></td>
  
  <td><%=f.format(rs.get("sum_q"),"0.##")%></td>
  
  <td><%=rs.get("count_cod_over")%></td>
  <td><%=f.format(rs.get("avg_cod_over"),"0.##")%></td>
  
  <td></td>
</tr>
<%}%>


</table>

</div>




