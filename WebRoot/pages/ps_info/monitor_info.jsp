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
     <td width="10%" class="tdtitle">���߼����������</td>
     <td width="20%"><%=psMonitorInfoList.get("monitorname")%></td>
     <td width="10%" class="tdtitle">���߼�������ͺ�</td>
     <td width="20%"><%=psMonitorInfoList.get("monitortype")%></td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">��С����</td>
     <td width="20%"><%=psMonitorInfoList.get("measuremin")%></td>
     <td width="10%" class="tdtitle">�������</td>
     <td width="20%"><%=psMonitorInfoList.get("measuremax")%></td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">��ά��λ</td>
     <td width="20%"><%=psMonitorInfoList.get("operatemaintenanceunit")%></td>
     <td width="10%" class="tdtitle">��ά��λ��ϵ��</td>
     <td width="20%"><%=psMonitorInfoList.get("operatemaintenancecontact")%></td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">��ά��λ��ϵ�绰</td>
     <td width="20%"><%=psMonitorInfoList.get("operatemaintenancecontactphone")%></td>
     <td width="10%" class="tdtitle">��������</td>
     <td width="20%"><%=psMonitorInfoList.get("firstrundate")%></td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">��������</td>
     <td width="20%"><%=psMonitorInfoList.get("manufacturer")%></td>
     <td width="10%" class="tdtitle">����������ϵ��</td>
     <td width="20%"><%=psMonitorInfoList.get("contact")%></td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">����������ϵ�绰</td>
     <td width="20%"><%=psMonitorInfoList.get("contactphone")%></td>
     <td width="10%" class="tdtitle">״̬</td>
     <td width="20%"><%if(psMonitorInfoList.get("status").equals("1")){%>
     	����
     <%}else{ %>
     	ͣ��
     <%} %>
     </td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">��ע</td>
     <td colspan="3"><%=psMonitorInfoList.get("monitorcomment")%></td>
   </tr>
   </table>
</td>
</tr>
</table>
 <%}%>