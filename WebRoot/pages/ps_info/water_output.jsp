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

   // RowSet psWaterOutputSet;
    Map m = null;
    XBean b = null;
    String id,m_time,m_value;
    try{
    
      lshUpdate.getPsWaterOutput(request);
      m = (Map)request.getAttribute("psWaterOutput");
      b = new XBean(m);
    //  psWaterOutputSet = w.rs("psWaterOutputSet");
    }catch(Exception e){
     w.error(e);
     return;
    }
   
%>

  <table border=0 cellspacing=1 >
   <tr> 
     <td width="10%" class="tdtitle">排放口名称</td>
     <td width="20%"><%=b.get("outputname")%></td>
     <td width="10%" class="tdtitle">排放口位置</td>
     <td width="20%"><%=b.get("outputposition")%></td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">经度</td>
     <td width="20%"><%=b.get("longitude")%></td>
     <td width="10%" class="tdtitle">纬度</td>
     <td width="20%"><%=b.get("latitude")%></td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">排放去向</td>
     <td width="20%"><%=b.get("let_place")%></td>
     <td width="10%" class="tdtitle">排放规律</td>
     <td width="20%"><%=b.get("let_rule")%></td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">水域功能区类别</td>
     <td width="20%"><%=b.get("function_area_type")%></td>
     <td width="10%" class="tdtitle">标志牌安装形式</td>
     <td width="20%"><%=b.get("flag_install")%></td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">流域</td>
     <td width="20%"><%=b.get("valley_name")%></td>
     <td width="10%" class="tdtitle">状态</td>
     <td width="20%">
		<%if(b.get("status").equals("1")){%>
     		在用
     	<%}else{ %>
     		停用
     	<%} %>
	</td>
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
   <%while(psWaterOutputSet.next()){%>
	   <tr> 
	     <td><%=psWaterOutputSet.get("pollutantcode") %></td>
	     <td><%=psWaterOutputSet.get("exceptionminvalue") %></td>
	     <td><%=psWaterOutputSet.get("exceptionmaxvalue") %></td>
	     <td><%=psWaterOutputSet.get("concenalarmlowerlimit") %></td>
	     <td><%=psWaterOutputSet.get("concenalarmupperlimit") %></td>
	     <td><%=psWaterOutputSet.get("status") %></td>
	   </tr>
    <%}%>
   </table>
--%>

