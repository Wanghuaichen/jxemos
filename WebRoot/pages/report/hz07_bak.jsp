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
<font color=red>ע:����Сʱ����ͳ��</font>
<div  class=h>��<%=b.get("date2") %>��<%=b.get("date1") %> �ڼ����ȾԴ���߼�����ѻ���������</div>

<%--<table border=0 cellspacing=1>

<tr class=title>
<td rowspan=3></td>
<td colspan=3>������ҵ</td>

<td colspan=2>����</td>

</tr>


<tr class=title>

<td colspan=2>����</td>

<td rowspan=2>�ѻ�</td>
<td rowspan=2>�ѻ�</td>
<td rowspan=2>COD/SO2Ϊ0</td>
</tr>



<tr class=title>

<td>������</td>
<td>COD/SO2Ϊ0</td>

</tr>



<tr>
<td>ˮ</td>
<td><%=b.get("waterOnlineNum")%></td>
<td><%=b.get("waterZeroNum")%></td>
<td><%=b.get("waterOfflineNum")%></td>
<td><%=b.get("waterOfflineNumNation")%></td>
<td><%=b.get("waterZeroNumNation")%></td>
</tr>



<tr>
<td>��</td>
<td><%=b.get("gasOnlineNum")%></td>
<td><%=b.get("gasZeroNum")%></td>
<td><%=b.get("gasOfflineNum")%></td>
<td><%=b.get("gasOfflineNumNation")%></td>
<td><%=b.get("gasZeroNumNation")%></td>
</tr>



<tr>
<td>�ϼ�</td>
<td><%=b.get("onlineNum")%></td>
<td><%=b.get("zeroNum")%></td>
<td><%=b.get("offlineNum")%></td>
<td><%=b.get("offlineNumNation")%></td>
<td><%=b.get("zeroNumNation")%></td>
</tr>



</table>


--%><div  class=h>�ѻ�����</div>

<div  class=h>ˮ<div>

<table border=0  cellspacing=1>
<tr class=title>
 <td style="width:30px">���</td>
 <td style="width:300px">վλ����</td>
 <td>��ע</td>
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


<div  class=h>��</div>


<table border=0  cellspacing=1>
<tr class=title>
 <td style="width:30px">���</td>
 <td style="width:300px">վλ����</td>
 <td>��ע</td>
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



<%--<div  class=h>������ȾԴ���߼�����������</div>

<div  class=h>CODΪ0��<%=b.get("waterZeroNumNation")%>��</div>


<table border=0  cellspacing=1>
<tr class=title>
 <td style="width:30px">���</td>
 <td style="width:300px">վλ����</td>
 <td>����</td>
</tr>

</table>


<div  class=h>SO2Ϊ0��<%=b.get("gasZeroNumNation")%>��</div>


<table border=0  cellspacing=1>
<tr class=title>
 <td style="width:30px">���</td>
 <td style="width:300px">վλ����</td>
 <td>����</td>
</tr>

</table>


<div  class=h>�ѻ���<%=b.get("offlineNumNation")%></div>

<div  class=h>ˮ</div>
<table border=0  cellspacing=1>
<tr class=title>
 <td style="width:30px">���</td>
 <td style="width:300px">վλ����</td>
 <td>����</td>
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


<div  class=h>��</div>

<table border=0  cellspacing=1>
<tr class=title>
 <td style="width:30px">���</td>
 <td style="width:300px">վλ����</td>
 <td>����</td>
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














