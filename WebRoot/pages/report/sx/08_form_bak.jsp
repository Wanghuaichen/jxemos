<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc_empty.jsp" %>
<%
      
BaseAction action = null;
   try{
    action = new FormAction();
    action.run(request,response,"form");
   
   }catch(Exception e){
      w.error(e);
      return;
   }
%>
<script type="text/javascript" src="../../../scripts/calendar.js"></script>
<body onload=rpt()  scroll=no style="background-color: #f7f7f7">
<form name=form1 method=post >
<input type=hidden name='station_type' value='1'>
<input type=hidden name='q_col' value='val04'>
<input type=hidden name='toc_col' value='val01'>
<input type=hidden name='cod_col' value='val02'>
<input type=hidden name='ph_col' value='val03'>
<input type=hidden name='nh3n_col' value='val05'>
<input type=hidden name='cols' value='val01,val02,val03,val04'>

<input type=hidden name='tableName' value='<%=request.getParameter("tableName")%>'>
<table border=0 width=100% height=100%>
      <tr>
      <td height=20>

      
      <select name=area_id onchange=rpt()>
      <%=w.get("areaOption")%>
      </select>
      

      <input type=text class=date name=date1 value='<%=w.get("date1")%>'  onclick="new Calendar().show(this);">
      <input type=text class=date name=date2 value='<%=w.get("date2")%>'  onclick="new Calendar().show(this);">
      <input type=button value='�鿴' onclick=rpt() class="btn" >

      
      
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

 function r(){
   form1.action='08_form.jsp';
   form1.target='';
   form1.submit();
   
   
 }
 
 function rpt(){
   form1.action='08.jsp';
   form1.target='q';
   form1.submit();
   
   
 }

</script>