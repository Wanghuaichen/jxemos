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
<link rel="stylesheet" href="../../../web/index.css" />
<script type="text/javascript" src="../../../scripts/calendar.js"></script>
<body onload=rpt()  style="overflow: hidden;" >
<form name=form1 method=post >
<input type=hidden name='station_type' value='1'>
<input type=hidden name='q_col' value='val04'>
<input type=hidden name='cod_col' value='<%=cod%>'>
<input type=hidden name='cols' value='val02,val04'>

<input type=hidden name='tableName' value='<%=request.getParameter("tableName")%>'>
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
				</p>
				<p class="tiaojiao-p">
      <select name=h1  onchange=rpt() class="selectoption">
      <%=f.getHourOption(0)%>
      </select>
				</p>
				<p class="tiaojiao-p">
      <input type=text class=c1 name=date2 value='<%=w.get("date2")%>'  onclick="new Calendar().show(this);">
				</p>
				<p class="tiaojiao-p">
        <select name=h2  onchange=rpt() class="selectoption">
      <%=f.getHourOption(23)%>
      </select>
				</p>
				<p class="tiaojiao-p">
       排序
      <select name=sort_col onchange=rpt() class="selectoption">>
      <option value='<%=cod%>_p_over' selected>排放量
      <option value='<%=cod%>_over_r'>排放率
   
      </select>
				</p>
				<input type=button value='查看' onclick=rpt()
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