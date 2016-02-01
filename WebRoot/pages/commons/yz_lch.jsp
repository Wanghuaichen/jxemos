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
   <tr><td colspan=6 class='type'><%=name%></td></tr>
   
   
 <tr class=title>
  <td>因子</td>
  <td>量程下限</td>
  <td>量程上限</td>
  <td></td>
 </tr>
 <%while(rs.next()){%>
 
  <tr>
  <form name=<%="form_"+rs.get("infectant_id")%> method=post>
  <input type=hidden name=infectant_id value=<%=rs.get("infectant_id")%>>
    <td><%=rs.get("infectant_name")%></td>
    <td><input type="text" name="lo_min" value="<%=rs.get("lo_min")%>"></td>
    <td><input type="text" name="hi_max" value="<%=rs.get("hi_max")%>"></td>
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
	f.action="u.jsp";
	f.target="u";
	f.submit();
}
</script>