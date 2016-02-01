<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.bizreport.*"%>
<%
           List list = null;
           RowSet rs = null;
           XBean b = null;
           Map m = null;
           String now = f.time()+"";
           //now =f.sub(now,0,19);
          
          try{
          
                  OnlineReport.run7(request);

          }catch(Exception e){
                JspUtil.go2error(request,response,e);
                return;
          }  
          m = (Map)request.getAttribute("bean");
          b = new XBean(m);
          
          
          
      
%>
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css">
<style>
body{text-align:left;}
.h{
   font-size:20px;
   font-weight:bold;
}
</style>
<div id='div_excel_content'>
<font color=red>注:根据小时数据统计</font>
<div  class=h>从<%=b.get("date2") %>到<%=b.get("date1") %> 期间的污染源在线监测监控脱机联机报表</div>

<%--<table border=0 cellspacing=1>

<tr class=title>
<td rowspan=3></td>
<td colspan=3>所有企业</td>

<td colspan=2>国控</td>

</tr>


<tr class=title>

<td colspan=2>联网</td>

<td rowspan=2>脱机</td>
<td rowspan=2>脱机</td>
<td rowspan=2>COD/SO2为0</td>
</tr>



<tr class=title>

<td>联网数</td>
<td>COD/SO2为0</td>

</tr>



<tr>
<td>水</td>
<td><%=b.get("waterOnlineNum")%></td>
<td><%=b.get("waterZeroNum")%></td>
<td><%=b.get("waterOfflineNum")%></td>
<td><%=b.get("waterOfflineNumNation")%></td>
<td><%=b.get("waterZeroNumNation")%></td>
</tr>



<tr>
<td>气</td>
<td><%=b.get("gasOnlineNum")%></td>
<td><%=b.get("gasZeroNum")%></td>
<td><%=b.get("gasOfflineNum")%></td>
<td><%=b.get("gasOfflineNumNation")%></td>
<td><%=b.get("gasZeroNumNation")%></td>
</tr>



<tr>
<td>合计</td>
<td><%=b.get("onlineNum")%></td>
<td><%=b.get("zeroNum")%></td>
<td><%=b.get("offlineNum")%></td>
<td><%=b.get("offlineNumNation")%></td>
<td><%=b.get("zeroNumNation")%></td>
</tr>



</table>


--%><div  class=h>脱机名单</div>

<div  class=h>水<div>

<table border=0  cellspacing=1>
<tr class=title>
 <td style="width:30px">序号</td>
 <td style="width:300px">站位名称</td>
 <td>备注</td>
</tr>
           <%
              list = (List)request.getAttribute("waterOfflineList");
              rs = new RowSet(list);
              while(rs.next()){
           %>
                   <tr>
                   <td><%=rs.getIndex()+1%></td>
                   <td><%=rs.get("station_desc")%></td>
                   <td><%=rs.get("station_bz")%></td>
                   </tr>          
           <%}%>
</table>


<div  class=h>气</div>


<table border=0  cellspacing=1>
<tr class=title>
 <td style="width:30px">序号</td>
 <td style="width:300px">站位名称</td>
 <td>备注</td>
</tr>

<%
              list = (List)request.getAttribute("gasOfflineList");
              rs = new RowSet(list);
              while(rs.next()){
           %>
                   <tr>
                   <td><%=rs.getIndex()+1%></td>
                   <td><%=rs.get("station_desc")%></td>
                   <td><%=rs.get("station_bz")%></td>
                   </tr>          
           <%}%>

</table>



<%--<div  class=h>国控污染源在线监测监控数据情况</div>

<div  class=h>COD为0：<%=b.get("waterZeroNumNation")%>家</div>


<table border=0  cellspacing=1>
<tr class=title>
 <td style="width:30px">序号</td>
 <td style="width:300px">站位名称</td>
 <td>区域</td>
</tr>

</table>


<div  class=h>SO2为0：<%=b.get("gasZeroNumNation")%>家</div>


<table border=0  cellspacing=1>
<tr class=title>
 <td style="width:30px">序号</td>
 <td style="width:300px">站位名称</td>
 <td>区域</td>
</tr>

</table>


<div  class=h>脱机：<%=b.get("offlineNumNation")%></div>

<div  class=h>水</div>
<table border=0  cellspacing=1>
<tr class=title>
 <td style="width:30px">序号</td>
 <td style="width:300px">站位名称</td>
 <td>区域</td>
</tr>

    <%
              list = (List)request.getAttribute("waterZeroListNation");
              rs = new RowSet(list);
              while(rs.next()){
           %>
                   <tr>
                   <td><%=rs.getIndex()+1%></td>
                   <td><%=rs.get("station_desc")%></td>
                   <td><%=rs.get("area_name")%></td>
                   </tr>          
           <%}%>
    

</table>


<div  class=h>气</div>

<table border=0  cellspacing=1>
<tr class=title>
 <td style="width:30px">序号</td>
 <td style="width:300px">站位名称</td>
 <td>区域</td>
</tr>

    <%
              list = (List)request.getAttribute("gasZeroListNation");
              rs = new RowSet(list);
              while(rs.next()){
           %>
                   <tr>
                   <td><%=rs.getIndex()+1%></td>
                   <td><%=rs.get("station_desc")%></td>
                   <td><%=rs.get("area_name")%></td>
                   </tr>          
           <%}%>
    

</table>

--%></div>














