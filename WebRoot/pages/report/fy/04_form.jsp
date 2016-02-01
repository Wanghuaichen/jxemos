<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc_empty.jsp" %>
<%
      
BaseAction action = null;
String cod_std = request.getParameter("cod_std");
double d = 0;
String ss=null;
   try{
    action = new FormAction();
    action.run(request,response,"form");
    d = f.getDouble(cod_std,0);
    if(d<=0){d=1000;}
    cod_std=d+"";
    cod_std = f.format(cod_std,"0");
    ss = FyReportUtil.getStationColCheckBox();
   }catch(Exception e){
      w.error(e);
      return;
   }
%>
<body onload=rpt()  scroll=no style="background-color: #f7f7f7">
<form name=form1 method=post >

<input type=hidden name=station_type value='1'>
<input type=hidden name=cod_col value='val02'>
<input type=hidden name=q_col value='val04'>
<input type=hidden name='tableName' value='<%=request.getParameter("tableName")%>'>
<table border=0 width=100% height=100%>
      <tr>
      <td height=20>
      
     <select name=area_id onchange=rpt()>
      <%=w.get("areaOption")%>
      </select>
      
    
      <input type=text class=date name=date1 value='<%=w.get("date1")%>'  onclick="new Calendar().show(this);">
      <!--<input type=text class=date name=date2 value='<%=w.get("date2")%>'  onclick="new Calendar().show(this);">-->
 <!--    
异常小于 <input type=text name=yc_v value='0.2' style='width:40px'>
-->

故障大于 <input type=text name=gz_v value='5'  style='width:40px'>
<!--
 COD标准值<input type=text name=cod_std value='<%=cod_std%>' style="width:50px">
  -->
      <input type=button value='查看' onclick=form1.submit() class="btn" >

      <br>
      <%=ss%>
      
      </td>
      </tr>
      <tr>
      <td>
      <iframe name=q frameborder=0 width=100% height=90%></iframe>
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
   form1.action='04_form.jsp';
   form1.target='';
   form1.submit();
   
   
 }
 
 function rpt(){
   form1.action='04.jsp';
   form1.target='q';
   form1.submit();
   
   
 }

</script>