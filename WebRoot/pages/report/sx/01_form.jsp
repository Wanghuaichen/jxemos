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
<body onload=rpt()  scroll=no style="background-color: #f7f7f7">
<form name=form1 method=post >
<input type=hidden name=no_data_string value="--">
<input type=hidden name=not_config_string value="△">
<input type=hidden name=offline_string value="×">
<input type=hidden name=online_string value="√">
<input type=hidden name='tableName' value='<%=request.getParameter("tableName")%>'>

<table border=0 width=100% height=100%>
      <tr>
      <td height=20>
      
       <select name=station_type onchange=r()>
     
      <%=w.get("stationTypeOption")%>
      </select>
      
      <select name=area_id onchange=r()>
      <%=w.get("areaOption")%>
      </select>
      
      
      <!--
      <select name=station_id onchange=rpt()>
      <option value=''>全部企业
      <%=w.get("stationOption")%>
      </select>
      -->
      <br>
      <input type=text class=date name=date1 value='<%=w.get("date1")%>'  onclick="new Calendar().show(this);">
      <input type=text class=date name=date2 value='<%=w.get("date2")%>'  onclick="new Calendar().show(this);">
      <input type=button value='查看' onclick=form1.submit() class="btn" >

      
      
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
   form1.action='01_form.jsp';
   form1.target='';
   form1.submit();
   
   
 }
 
 function rpt(){
   form1.action='01.jsp';
   form1.target='q';
   form1.submit();
   
   
 }

</script>