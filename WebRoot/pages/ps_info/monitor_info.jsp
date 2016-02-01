<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.ps.*" %>
<style>
td{
text-align:left;
}
</style>
<%

    RowSet psMonitorInfoList;
    String id,m_time,m_value;
    try{
    
      lshUpdate.getPsMonitorInfo(request);
    
    }catch(Exception e){
     w.error(e);
     return;
    }
    psMonitorInfoList = w.rs("psMonitorInfoList");
%>
<%while(psMonitorInfoList.next()){%>
<table border=0 cellspacing=0 style="width:100%;height:100%">
<tr>
<td class="top" style="height:50%">
   <table border=0 cellspacing=1 >
   <tr> 
     <td width="10%" class="tdtitle">在线监测仪器名称</td>
     <td width="20%"><%=psMonitorInfoList.get("monitorname")%></td>
     <td width="10%" class="tdtitle">在线监测仪器型号</td>
     <td width="20%"><%=psMonitorInfoList.get("monitortype")%></td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">最小量程</td>
     <td width="20%"><%=psMonitorInfoList.get("measuremin")%></td>
     <td width="10%" class="tdtitle">最大量程</td>
     <td width="20%"><%=psMonitorInfoList.get("measuremax")%></td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">运维单位</td>
     <td width="20%"><%=psMonitorInfoList.get("operatemaintenanceunit")%></td>
     <td width="10%" class="tdtitle">运维单位联系人</td>
     <td width="20%"><%=psMonitorInfoList.get("operatemaintenancecontact")%></td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">运维单位联系电话</td>
     <td width="20%"><%=psMonitorInfoList.get("operatemaintenancecontactphone")%></td>
     <td width="10%" class="tdtitle">启用日期</td>
     <td width="20%"><%=psMonitorInfoList.get("firstrundate")%></td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">生产厂商</td>
     <td width="20%"><%=psMonitorInfoList.get("manufacturer")%></td>
     <td width="10%" class="tdtitle">生产厂商联系人</td>
     <td width="20%"><%=psMonitorInfoList.get("contact")%></td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">生产厂商联系电话</td>
     <td width="20%"><%=psMonitorInfoList.get("contactphone")%></td>
     <td width="10%" class="tdtitle">状态</td>
     <td width="20%"><%if(psMonitorInfoList.get("status").equals("1")){%>
     	在用
     <%}else{ %>
     	停用
     <%} %>
     </td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">备注</td>
     <td colspan="3"><%=psMonitorInfoList.get("monitorcomment")%></td>
   </tr>
   </table>
</td>
</tr>
</table>
 <%}%>