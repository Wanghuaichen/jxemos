<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc_empty.jsp" %>
<%
      
BaseAction action = null;
   try{
    action = new FormAction();
    action.run(request,response,"area");
   
   }catch(Exception e){
      w.error(e);
      return;
   }
%>

<body onload=form1.submit() scroll=no style="background-color: #f7f7f7">
<form name=form1 method=post target=q action=02.jsp>
<input type=hidden name=station_type value='1'>
<input type=hidden name=ph_col value='val03'>
<input type=hidden name=cod_col value='val02'>
<input type=hidden name=q_col value='val04'>

<input type=hidden name=no_data_string value="--">
<input type=hidden name=not_config_string value="¡÷">
<input type=hidden name=offline_string value="¡Á">
<input type=hidden name=online_string value="¡Ì">
<input type=hidden name='tableName' value='<%=request.getParameter("tableName")%>'>
<table border=0 width=100% height=100%>
      <tr>
      <td height=20>
      
      <select name=area_id onchange=form1.submit()>
      <%=w.get("areaOption")%>
      </select>
      
      
      
      <input type=text class=date name=date1 value='<%=w.get("date1")%>'  onclick="new Calendar().show(this);">

      <input type=button value='²é¿´' onclick=form1.submit() class="btn" >

      
      </td>
      </tr>
      
      <tr>
      <td>
      <iframe name=q frameborder=0 width=100% height=100%></iframe>
      </td>
      </tr>
</table>
</form>


<script>
function f_save(){
    var obj = window.frames["q"].window.document.getElementById('div_excel_content');
   //alert(obj);
    form2.txt_excel_content.value=obj.innerHTML;
    
    form2.action='/<%=ctx%>/pages/commons/save2excel.jsp';
    form2.submit();
}
</script>