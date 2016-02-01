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
<link rel="stylesheet" href="../../../web/index.css" />

<script type="text/javascript" src="../../../scripts/calendar.js"></script>
<body onload=rpt() style="overflow: hidden;">
<form name=form1 method=post >
<input type=hidden name='station_type' value='2'>
<input type=hidden name='q_col' value='val11'>

<input type=hidden name='tableName' value='<%=request.getParameter("tableName")%>'>
<!--
<input type=hidden name='so2_col' value='val05'>
<input type=hidden name='nox_col' value='val07'>
<input type=hidden name='pm_col' value='val06'>
<input type=hidden name='cols' value='val05,val06,val07,val11'>
-->


<input type=hidden name='so2_col' value='val01'>
<input type=hidden name='nox_col' value='val03'>
<input type=hidden name='pm_col' value='val02'>
<input type=hidden name='cols' value='val01,val02,val03,val11'>

		<div class="frame-main-content"
			style="left: 0; top: 0; position: static;">
			<div class="nt">
				<p class="tiaojiao-p">
      <select name=area_id onchange=rpt() class="selectoption">
      <%=w.get("areaOption")%>
      </select>
				</p>
				<p class="tiaojiao-p">
      <input type=text class=c1 name=date1 value='<%=w.get("date1")%>'  onclick="new Calendar().show(this);">
      <input type=text class=c1 name=date2 value='<%=w.get("date2")%>'  onclick="new Calendar().show(this);">
				</p>
				<input type=button value='²é¿´' onclick=rpt()
					class="tiaojianbutton">
			</div>
		</div>
      <iframe name=q frameborder=0 width=100% height=90%></iframe>
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
   form1.action='03_form.jsp';
   form1.target='';
   form1.submit();
   
   
 }
 
 function rpt(){
   form1.action='03.jsp';
   form1.target='q';
   form1.submit();
   
   
 }

</script>