<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
      String now = StringUtil.getNowDate()+"";
      String date1 = request.getParameter("date1");
      if(f.empty(date1)){date1 = now;}
   try{
   
   
    action = new StdReportAction();
    action.run(request,response,"form");
   
   }catch(Exception e){
      w.error(e);
      return;
   }
   
  
%>

<script>
function r(){
 form1.action='index.jsp';
 form1.target='';
 form1.submit();
}

function f_rpt(){
 //alert('rpt');
 form1.action='rpt.jsp';
 form1.target='q';
 form1.submit();
  //alert('rpt');
}

function f_save(){
    var obj = window.frames["q"].window.document.getElementById('div_excel_content');
   //alert(obj);
    form2.txt_excel_content.value=obj.innerHTML;
    
    form2.action='/swj/pages/commons/save2excel.jsp';
    form2.submit();
    
    
}

function f_print(){
  //document.frames['q'].print();
  //window.frames["q"].window.print();
  //window.frames["q"].window.f_print();
  window.frames["q"].document.execCommand('print');
}


</script>
<link rel="stylesheet" href="../../../web/index.css" />
<script type="text/javascript" src="../../../scripts/calendar.js"></script>
<body onload=f_rpt() style="overflow: hidden;">
<form name=form1 method=post >

<input type=hidden name='tableName' value='<%=request.getParameter("tableName")%>'>
<input type=hidden name='gas_cols' value='g_pm,g_so2,g_nox,g_pm2,g_so22,g_nox2,g_q,g_op,g_t,g_wp'>
<input type=hidden name='water_cols' value='w_cod,w_ss,w_tn,w_tp,w_nh3n,w_q,w_ph'>

<input type=hidden name='gas_q_cols' value='g_pm_q,g_so2_q,g_nox_q,g_pm2_q,g_so22_q,g_nox2_q'>
<input type=hidden name='water_q_cols' value='w_cod_q,w_ss_q,w_tn_q,w_tp_q,w_nh3n_q'>


<input type=hidden name=g_pm value='val02'>
<input type=hidden name=g_so2 value='val01'>
<input type=hidden name=g_nox value='val03'>

<input type=hidden name=g_pm2 value='val06'>
<input type=hidden name=g_so22 value='val05'>
<input type=hidden name=g_nox2 value='val07'>

<input type=hidden name=g_q value='val11'>
<input type=hidden name=g_op value='val04'>
<input type=hidden name=g_t value='val09'>
<input type=hidden name=g_wp value='val22'>



<input type=hidden name=w_cod value='val02'>
<input type=hidden name=w_ss value=''>
<input type=hidden name=w_tn value='val17'>
<input type=hidden name=w_tp value='val16'>
<input type=hidden name=w_nh3n value='val05'>
<input type=hidden name=w_q value='val04'>
<input type=hidden name=w_ph value='val03'>


		<div class="frame-main-content"
			style="left: 0; top: 0; position: static;">
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
<select name=station_id onchange=f_rpt() class="selectoption">
<%=w.get("stationOption")%>
</select>
				</p>
				<p class="tiaojiao-p">
<select name=report_type onchange=f_rpt() class="selectoption">
<%=w.get("reportTypeOption")%>
</select>
				</p>
				<p class="tiaojiao-p">
<input name="date1" type="text" value="<%=date1%>" class=c1 onclick="new Calendar().show(this);">
				</p>
				<input type=button value='²é¿´' onclick=f_rpt()
					class="tiaojianbutton">
			</div>
		</div>
  <iframe id=q name=q width=100% height=90% frameborder=0></iframe>
</form>


<form name=form2 method=post>
<input type=hidden name='txt_excel_content'>
</form>

