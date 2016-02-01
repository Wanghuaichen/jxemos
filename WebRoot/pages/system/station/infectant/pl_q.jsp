<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.search.InfectantLch" %>
<%
        try{
    
      InfectantLch.infectan_lch(request);
      
      }catch(Exception e){
      w.error(e);
      return;
      }
      String types="1,2,5,6";
      String[]arr=types.split(",");
      RowSet rs = null;
      XBean b = w.b("map");
      String type,name;
      int i,num=0;
      num=arr.length;
  
%>
<style>
  .type{font-weight:bold;font-size:15px;text-align:center;padding:8px;
  /*background-color:#FDCC7E;*/
  }

</style>
<table border=0 cellspacing=1>
 
<%for(i=0;i<num;i++){
  type=arr[i];
    rs = w.rs("list_"+type);
    name = b.get(type);
  %>
   <tr><td colspan=9 class='type'><%=name%></td></tr>
   
   
 <tr class=title>
	<td>因子</td>
	<td>标准值</td>
	<td>预警下限</td>
	<td>预警上限</td>
	<td>报警下限</td>
	<td>报警上限</td>
	<td>量程下限</td>
	<td>量程上限</td>
  <td></td>
 </tr>
 <%while(rs.next()){%>
 
  <tr>
  <form name=<%="form_"+rs.get("infectant_id")%> method=post>
  <input type=hidden name=infectant_id value=<%=rs.get("infectant_id")%>>
    <td><%=rs.get("infectant_name")%></td>
    <td><input type="text" name="standard_value" value="<%=rs.get("standard_value")%>"></td>
    <td><input type="text" name="lo" value="<%=rs.get("lo")%>"></td>
    <td><input type="text" name="hi" value="<%=rs.get("hi")%>"></td>
    <td><input type="text" name="lolo" value="<%=rs.get("lolo")%>"></td>
    <td><input type="text" name="hihi" value="<%=rs.get("hihi")%>"></td>
    <td><input type="text" name="lolololo" value="<%=rs.get("lolololo")%>"></td>
    <td><input type="text" name="hihihihi" value="<%=rs.get("hihihihi")%>"></td>
    <td><input type="button" name="button1" value="保存" class="btn" onclick="f_save(<%="form_"+rs.get("infectant_id")%>)"/></td>
   </form>
  </tr>
 <%}%>  


<%}%>
 </table>
 
 
<iframe name="u"  width=0 height=0  scrolling="auto" frameborder="0"  style="border:0px" allowtransparency="true">
</iframe>
<script>
function f_save(f){
	if(confirm("批量设置会覆盖掉单独设置的所有值，您确定要执行此操作么？")){
		f.action="pl_u.jsp";
		f.target="u";
		f.submit();
	}
}
</script>