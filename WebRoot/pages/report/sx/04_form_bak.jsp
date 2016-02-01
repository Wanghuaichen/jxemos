<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc_empty.jsp" %>
<%
      
BaseAction action = null;
String cod = "val02";
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
<input type=hidden name='station_type' value='1'>
<input type=hidden name='q_col' value='val04'>
<input type=hidden name='cod_col' value='<%=cod%>'>
<input type=hidden name='cols' value='val02,val04'>

<input type=hidden name='tableName' value='<%=request.getParameter("tableName")%>'>

<table border=0 width=100% height=100%>
      <tr>
      <td height=20>

      
      <select name=area_id onchange=rpt()>
      <%=w.get("areaOption")%>
      </select>
      

      <input type=text class=date name=date1 value='<%=w.get("date1")%>'  onclick="new Calendar().show(this);">
      <select name=h1  onchange=rpt()>
      <%=f.getHourOption(0)%>
      </select>
      
      <input type=text class=date name=date2 value='<%=w.get("date2")%>'  onclick="new Calendar().show(this);">
        <select name=h2  onchange=rpt()>
      <%=f.getHourOption(23)%>
      </select>
      
       排序
 
      <select name=sort_col onchange=rpt()>
      <option value='<%=cod%>_p_over' selected>排放量
      <option value='<%=cod%>_over_r'>排放率
   
      </select>
      
      
      <input type=button value='查看' onclick=rpt() class="btn" >

      
      
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