<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.ps.*" %>
<style>
td{
text-align:left;
}
</style>
<%

    RowSet psPteInfoList;
    String id,m_time,m_value;
    try{
    
      lshUpdate.getPsPteInfo(request);
    
    }catch(Exception e){
     w.error(e);
     return;
    }
    psPteInfoList = w.rs("psPteInfoList");
%>
<%while(psPteInfoList.next()){%>
<table border=0 cellspacing=0 style="width:100%;height:100%">
<tr>
<td class="top" style="height:50%">
   <table border=0 cellspacing=1 >
   <tr> 
     <td width="10%" class="tdtitle">��Ⱦ������ʩ����</td>
     <td width="20%"><%=psPteInfoList.get("equipname")%></td>
     <td width="10%" class="tdtitle">��Ⱦ���</td>
     <td width="20%"><%=psPteInfoList.get("pollutant_type")%></td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">������</td>
     <td width="20%"><%=psPteInfoList.get("manage_method")%></td>
     <td width="10%" class="tdtitle">��ƴ�������(��/��)</td>
     <td width="20%"><%=psPteInfoList.get("designdealability")%></td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">Ͷ��ʹ������</td>
     <td width="20%"><%=psPteInfoList.get("rundate")%></td>
     <td width="10%" class="tdtitle">���������</td>
     <td width="20%"><%=psPteInfoList.get("dgicode")%></td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">ͨ����</td>
     <td width="20%"><%=psPteInfoList.get("channelnum")%></td>
     <td width="10%" class="tdtitle">״̬</td>
     <td width="20%">
     <%if(psPteInfoList.get("status").equals("1")){%>
     	����
     <%}else{ %>
     	ͣ��
     <%} %>
     </td>
   </tr>
   </table>
</td>
</tr>
</table>
 <%}%>