<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc_empty.jsp" %>
<%
      
BaseAction action = null;
   try{
    action = new FormAction();
    action.run(request,response,"form");
    //System.out.println("tableName====="+request.getParameter("tableName"));
   }catch(Exception e){
      w.error(e);
      return;
   }
%>

 <link rel="stylesheet" href="../../../web/index.css" />
<script type="text/javascript" src="../../../scripts/calendar.js"></script>
<body onload=rpt()  scroll=no>
<form name=form1 method=post >
<input type=hidden name=no_data_string value="--">
<input type=hidden name=not_config_string value="△">
<input type=hidden name=offline_string value="×">
<input type=hidden name=online_string value="√">
<input type=hidden name='tableName' value='<%=request.getParameter("tableName")%>'>

<div class="frame-main-content" style="left:0; top:0;position: static;" >
		<div class="nt">
	      <p class="tiaojiao-p">
		<select name=station_type onchange=r() class="selectoption">
		     
		      <%=w.get("stationTypeOption")%>
		      </select>
		   </p>
	    	<p class="tiaojiao-p">   
		       <select name=area_id onchange=r() class="selectoption">
		      <%=w.get("areaOption")%>
		      </select>
			</p>
	    	<p class="tiaojiao-p">  
	    	 <select name=trade_id onchange=r() class="selectoption">
		       <option value=''>行业
		      <%=w.get("tradeOption")%>
		      </select>
		      </p>
	    	<p class="tiaojiao-p">  
		      <select name=station_id onchange=rpt() class="selectoption">
		      <option value=''>企业
		      <%=w.get("stationOption")%>
		      </select> 
		       </p>
		     <p class="tiaojiao-p">  
		      <input type=text class=c1 name=date1 value='<%=w.get("date1")%>'  onclick="new Calendar().show(this);">
     		 <input type=text class=c1 name=date2 value='<%=w.get("date2")%>'  onclick="new Calendar().show(this);">
		      </p>
	    	 <input type=button value='查看' onclick=form1.submit() class="tiaojianbutton" >
	    	 </div>
	   </div>
	   <iframe name=q id=q frameborder=0 width=100% height=400px frameborder=0 allowtransparency="true"></iframe>  	

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
</body>