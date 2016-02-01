<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.ps.*" %>
<%@page import="com.hoson.*" %>
<style>
td{
text-align:left;
}
</style>
<%

   // RowSet psGasOutputSet;
    Map m = null;
    XBean b = null;
    String id,m_time,m_value;
    try{
    
      lshUpdate.getPsGasOutput(request);
      m = (Map)request.getAttribute("psGasOutput");
      b = new XBean(m);
    //  psGasOutputSet = w.rs("psGasOutputSet");
    }catch(Exception e){
     w.error(e);
     return;
    }
   
%>

  <table border=0 cellspacing=1 >
   <tr> 
     <td width="10%" class="tdtitle">排放口名称</td>
     <td width="20%"><%=b.get("outputname")%></td>
     <td width="10%" class="tdtitle">是否两控区</td>
     <td width="20%">
     <%if(b.get("iftwoarea").equals("1")){%>
     	是
     <%}else{ %>
     	否
     <%} %>
     </td>
     <td width="10%" class="tdtitle">经度</td>
     <td width="20%"><%=b.get("longitude")%></td>
   </tr>
   <tr> 
   <td width="10%" class="tdtitle">排放口位置</td>
     <td width="20%"><%=b.get("outputposition")%></td>
     <td width="10%" class="tdtitle">燃料分类</td>
     <td width="20%"><%=b.get("fuel_type")%></td>
     <td width="10%" class="tdtitle">纬度</td>
     <td width="20%"><%=b.get("latitude")%></td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">气域功能区分类</td>
     <td width="20%"><%=b.get("gas_function")%></td>
     <td width="10%" class="tdtitle">标志牌安装形式</td>
     <td width="20%"><%=b.get("flag_install")%></td>
      <td width="10%" class="tdtitle">燃烧方式</td>
     <td width="20%"><%=b.get("burning_mode")%></td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">排放口高度(米)</td>
     <td width="20%"><%=b.get("outputhigh")%></td>
     <td width="10%" class="tdtitle">废气排放口类型</td>
     <td width="20%"><%=b.get("gasoutput_type")%></td>
     <td width="10%" class="tdtitle">两控区类型</td>
     <td width="20%"><%=b.get("twoarea_type")%></td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">出口内径</td>
     <td width="20%"><%=b.get("outputdiameter")%></td>
     <td width="10%" class="tdtitle">设备名称</td>
     <td width="20%"><%=b.get("equipmentname")%></td>
     <td width="10%" class="tdtitle">燃烧设备用途</td>
     <td width="20%"><%=b.get("burntequipment_user")%></td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">排放规律</td>
     <td width="20%"><%=b.get("let_rule")%></td>
     <td width="10%" class="tdtitle">状态</td>
     <td width="20%">
		<%if(b.get("status").equals("1")){%>
     		在用
     	<%}else{ %>
     		停用
     	<%} %>
	</td>
     <td width="10%" class="tdtitle">车间工段名称</td>
     <td width="20%"><%=b.get("workshopname")%></td>
   </tr>
   </table>
   <%-- 
<br/>
<table border=0 cellspacing=1 >
   <tr class="title"> 
     <td>污染物名称</td>
     <td>异常值下限</td>
     <td>异常值上限</td>
     <td>浓度报警下限</td>
     <td>浓度报警上限</td>
     <td>状态</td>
   </tr>
   <%while(psGasOutputSet.next()){%>
	   <tr> 
	     <td><%=psGasOutputSet.get("pollutantcode") %></td>
	     <td><%=psGasOutputSet.get("exceptionminvalue") %></td>
	     <td><%=psGasOutputSet.get("exceptionmaxvalue") %></td>
	     <td><%=psGasOutputSet.get("concenalarmlowerlimit") %></td>
	     <td><%=psGasOutputSet.get("concenalarmupperlimit") %></td>
	     <td><%=psGasOutputSet.get("status") %></td>
	   </tr>
    <%}%>
   </table>
--%>

