<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

    try{
    
      SwjUpdate.station_index(request);
    
    }catch(Exception e){
     w.error(e);
     return;
    }

    boolean iswry = f.iswry(w.get("station_type"));
    RowSet rs = w.rs("flist");
    
    
%>

<body scroll=no onload='f_real()'>
<form name=form1 method=post target='frm_real_data'>
<table style='width:100%;height:100%' border=0 cellspacing=0>
   <tr>
     <td style='height:20px' colspan="2">
   
<select name=station_type  onchange=f_rr()>
<%=w.get("stationTypeOption")%>
</select>
               
<select name=area_id id="area_id" onchange=f_r()>
<%=w.get("areaOption")%>
</select>

<select name=ctl_type onchange=f_r()>
<option value=''>重点源属性</option>
<%=w.get("ctlTypeOption")%>
</select>


<select name=valley_id id=valley_id onchange=f_r()>
<option value=''>流域</option>
<%=w.get("valleyOption")%>
</select>

<select name=trade_id onchange=f_r() >
<option value=''>行业
<%=w.get("tradeOption")%>
</select>
<select name=build_type onchange=f_r() >
<option value=''>建设类型
<%=w.get("buildTypeOption")%>
</select>
     <input type=text name='station_desc' value='' style='width:100px'>
      <br/>
     <input type=checkbox value='1' name='focus_flag'>只显示收藏
     <input type=button value='实时数据' onclick='f_real()' class='btn'>
    
     <input type=button value='时均值' onclick='f_hour()' class='btn'>
     <input type=button value='脱机' onclick='f_yc()' class='btn'> 
    <!-- <input type=button value='打印' onclick='f_print()' class='btn'>  -->
     
     <input type=button value='不刷新' name="b_fresh" id="b_fresh" onclick='f_fresh()' class='btn'>  
     
      <input type=button value='导出表格' onclick='f_excel()' class='btn'>  
      <input type=button value='汇总信息' onclick='f_hz()' class='btn'>  
      &nbsp;&nbsp;&nbsp;<span id="decimal"></span>
      <input type="hidden" name="station_ids" id="station_ids">
      <input type="hidden" name="data_flag" id="data_flag" value="real">
     
     </td></tr>
     <tr><td width="70%">
     |
     <%while(rs.next()){
     	if(!rs.get("infectant_name").equals("流量2")){
     %>
       <input type=checkbox name='infectant_id' value='<%=rs.get("infectant_id")%>' checked>
       <%=rs.get("infectant_name")%> | 
     <%}}%>
     <td width="30%">
     <table border=0 cellspacing=0>
     <tr>
     </td>
     <td width="10%" style="padding-left:0px;"><img src="../../images/color_mark01.jpg" />
     </td>
     <td style="padding-left:0px;"><span id="zc" style="font-size:12px;font-weight:bold"></span>
     </td>
     </td>
     <td width="10%" style="padding-left:0px;"><img src="../../images/color_mark03.jpg" />
     </td>
     <td><span id="yj" style="font-size:12px;font-weight:bold"></span>
     </td>
     <td width="10%" style="padding-left:0px;"><img src="../../images/color_mark02.jpg" />
     </td>
     <td><span id="bj" style="font-size:12px;font-weight:bold"></span>
     </td>
     </td>
     <td width="10%" style="padding-left:0px;"><img src="../../images/color_mark04.jpg" />
     </td>
     <td><span id="tj" style="font-size:12px;font-weight:bold"></span>
     </td>
     </td>
     </tr>
     </table>
   </tr>
   
   <tr>
     <td style='height:100%' colspan="2">
      <iframe name='frm_real_data' id='frm_real_data' width=100% height=100% frameborder=0 allowtransparency="true"></iframe>
    
      <iframe name='frm_real_data_excel' id='frm_real_data_excel' width=0% height=0% frameborder=0 ></iframe>
     </td>
   </tr>
   
</table>
</form>
</body>


<script>
function get(zc,yj,bj,tj){ 
	Ob=document.all("zc");
	Ob.innerHTML=zc;
	Ob=document.all("yj");
	Ob.innerHTML=yj;
	Ob=document.all("bj");
	Ob.innerHTML=bj;
	Ob=document.all("tj");
	Ob.innerHTML=tj;
} 

function f_rr(){
 by_excel();
 form1.action='index.jsp';
 form1.target='';
 form1.submit();
}
function f_submit(){
	document.all("frm_real_data_excel").src= "";
	by_excel();
 	form1.submit();
}
function f_r(){
	by_excel();
 	form1.submit();
}
 function f_real(){
   	form1.data_flag.value= "real";
    by_excel();
    form1.submit();
 }
 
  function f_hour(){
   	form1.data_flag.value= "hour";
   	by_excel();
    form1.submit();
 }
 
  function f_yc(){
	by_excel();
    form1.action='offline.jsp';
    form1.submit();
 }
 function f_print(){
  by_excel();
  var obj = getobj("frm_real_data");
  //window.frames["q"].document.execCommand('print');
  obj.document.execCommand('print');
}
 
 function by_excel(){
 	if(form1.data_flag.value=='real'){
		form1.action="real.jsp";
	}else{
		form1.action="hour.jsp";
	}
	form1.station_ids.value = "";
	form1.target='frm_real_data';
 }
 //刷新
 var thread = window.setInterval('f_submit()',60000);
 function f_fresh(){
 	if(form1.b_fresh.value=="不刷新"){
 		window.clearInterval(thread);
 		form1.b_fresh.value = "刷新";
 	}else{
 		thread = window.setInterval('f_submit()',60000);
 		form1.b_fresh.value = "不刷新";
 	}
 }
 
 function f_excel(){
 if(form1.data_flag.value=='real'){
 var r = window.frames["frm_real_data"].window.document.all('station_ids');
 var str = "";
 	for(var i=0;i<r.length;i++){
 	if(r[i].checked){
		str = str + r[i].value + ",";
 	}
    }
    form1.station_ids.value = str;
 	form1.action='select_real.jsp';
 	form1.target='frm_real_data_excel';
 	form1.submit();
 	}
 }
 function f_hz(){
 	var url = "../map/all_area_info.jsp";
	var width = 1024;
	var height = 668;
	window.open(url,"","scrollbars=yes,resizable=yes"+",height="+height+",width="+width+",left="+(window.screen.width-width)/2+",top="+(window.screen.height-height)/2);
}
 <%--
 Ext.onReady(function(){
  var combo = new Ext.form.ComboBox({
 	emptyText:'请选择',
    mode:'local',
    triggerAction:'all',
    transform:'area_id'
    });
  });
  --%>
</script>


