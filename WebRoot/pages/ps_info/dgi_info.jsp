<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.ps.*" %>
<style>
td{
text-align:left;
}
</style>
<%

    RowSet psDgiInfoList;
    String id,m_time,m_value;
    try{
    
      lshUpdate.getPsDgiInfo(request);
    
    }catch(Exception e){
     w.error(e);
     return;
    }
    psDgiInfoList = w.rs("psDgiInfoList");
%>
<%while(psDgiInfoList.next()){%>
<table border=0 cellspacing=0 style="width:100%;height:100%">
<tr>
<td class="top" style="height:50%">
   <table border=0 cellspacing=1 >
   <tr> 
     <td width="10%" class="tdtitle">数据采集仪序号</td>
     <td width="20%"><%=psDgiInfoList.get("dgimn")%></td>
     <td width="10%" class="tdtitle">上报IP地址</td>
     <td width="20%"><%=psDgiInfoList.get("ipaddress")%></td>
     <td width="10%" class="tdtitle">上报端口号</td>
     <td width="20%"><%=psDgiInfoList.get("port")%></td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">SIM(UIM)卡号</td>
     <td width="20%"><%=psDgiInfoList.get("simnum")%></td>
     <td width="10%" class="tdtitle">数据传输方式</td>
     <td width="20%"><%=psDgiInfoList.get("dgi_type")%></td>
     <td width="10%" class="tdtitle">状态</td>
     <td width="20%">
     <%if(psDgiInfoList.get("status").equals("1")){%>
     	在用
     <%}else{ %>
     	停用
     <%} %>
     </td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">生产厂商联系电话</td>
     <td width="20%"><%=psDgiInfoList.get("contactphone")%></td>
     <td width="10%" class="tdtitle">生产厂商联系人</td>
     <td width="20%"><%=psDgiInfoList.get("contact")%></td>
     <td width="10%" class="tdtitle">启用日期</td>
     <td width="20%"><%=psDgiInfoList.get("firstrundate")%></td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">生产厂商</td>
     <td colspan="5"><%=psDgiInfoList.get("manufacturer")%></td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">运维单位</td>
     <td  colspan="5"><%=psDgiInfoList.get("operatemaintenanceunit")%></td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">运维单位联系人</td>
     <td width="20%"><%=psDgiInfoList.get("operatemaintenancecontact")%></td>
     <td width="10%" class="tdtitle">运维单位联系电话</td>
     <td colspan="3"><%=psDgiInfoList.get("operatemaintenancecontactphone")%></td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">备注</td>
     <td  colspan="5"><%=psDgiInfoList.get("dgicomment")%></td>
   </tr>
   </table>
</td>
</tr>
</table>
 <%}%>