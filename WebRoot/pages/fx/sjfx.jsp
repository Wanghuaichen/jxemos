<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>

<%
String js = null;
String vs = "1,2,3,4,5,6,7,8";
String ts = "污染源污水,污染源污气,污染源嗓声,污染源废渣,环境质量水断面,环境质量大气,环境质量嗓声,环境质量固废";
String option = null;
String station_type = null;

station_type = request.getParameter("station_type");
if(StringUtil.isempty(station_type)){
station_type = (String)session.getAttribute("fx_station_type");
}
if(station_type==null){
station_type = App.getDefStationId(request);
}
String infectantOption = null;
java.sql.Date dateNow  = StringUtil.getNowDate();
String infectant_id = null;
String sql = null;
Connection cn = null;
String sh_flag = null;
String shOption = null;
try{
sql = "select infectant_id,infectant_name from t_cfg_infectant_base where station_type='"+station_type+"'";
infectant_id =request.getParameter("infectant_id");
if(infectant_id==null){infectant_id="301";}
infectantOption = JspUtil.getOption(sql,infectant_id,request);
sh_flag = request.getParameter("sh_flag");
   shOption = SwjUpdate.getShState(sh_flag);
}catch(Exception e){
//out.println(e);
        JspUtil.go2error(request,response,e);
return;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<link rel="stylesheet" href="../../web/index.css"/>
<script type="text/javascript" src="../../scripts/calendar.js"></script>
<title>在线检测和监控管理系统</title>
</head>
<body onload="form1.submit()" style="overflow: hidden;">
<form name="form1" method=post action="../compare/compare_action.jsp" target="sjfx">
<input type="hidden" name="hour1" value="0">
<input type="hidden" name="hour2" value="23">
<input type="hidden" name="station_type" value="">
<input type="hidden" name="station_ids" value="">

<input type=hidden name='w'>
<input type=hidden name='h'>
	<div class="frame-main-content" style="left:0; top:0;position: static;" >
		<div class="nt">
	      <ul class="">
	        <li>
	          <label>
	         	<input type=radio name=chart_type value="T_MONITOR_REAL_TEN_MINUTE"  checked onclick="f_compare()"><span onclick="f_check_submit('T_MONITOR_REAL_TEN_MINUTE')">十分钟数据</span>
	          </label>
	        </li>
	        <li>
	          <label>
	         	 <input type=radio name=chart_type value="t_monitor_real_hour"  checked onclick="f_compare()"><span onclick="f_check_submit('t_monitor_real_hour')">小时数据</span>
	          </label>
	        </li>
	        <li>
	          <label>
	          	<input type=radio name=chart_type value="t_monitor_real_day" onclick="f_compare()"><span onclick="f_check_submit('t_monitor_real_day')">日数据</span>
          </label>
	        </li>
	        <li>
	          <label>
	          	<input type=radio name=chart_type value="t_monitor_real_month"  onclick="f_compare()"><span onclick="f_check_submit('t_monitor_real_month')">月汇总数据</span>
          	</label>
	        </li>
	      </ul>    
	    </div>
	    
	    <div class="tiaojian">
	    	 <p class="tiaojiao-p">
	    	 	从 <input name="date1" type="text" value="<%=dateNow%>" class="c1" readonly="readonly" onclick="new Calendar().show(this);" >

				到 <input name="date2" type="text" value="<%=dateNow%>" class="c1" readonly="readonly" onclick="new Calendar().show(this);">
	    	 </p>
	    	 <p class="tiaojiao-p">
	    	 	监测因子:
				<select name="infectant_id" onchange="f_compare()" class="selectoption"><%=infectantOption%></select>
	    	 </p>
	    	  <p class="tiaojiao-p">
	    	 	数据状态:
				<select name="sh_flag"  onchange=form1.submit() class="selectoption">
				<%=shOption %>
				</select>
	    	 </p>
	    	 <input type=button value="数据比较" class="tiaojianbutton" onclick="f_compare()">
	    	 
	    </div>
	    
	    
	</div>
	</form>
	<iframe name="sjfx" id="sjfx" width=100% height=90%  scrolling="auto" frameborder="0"  style="border:0px" allowtransparency="true">
	</iframe>


<script>
function f_compare(){

f_get_wh();

//alert(parent.parent.fx_left.tree_form.txt_station_type.value);

//parent.parent.fx_left.f_getValue();
parent.fx_left.f_getValue();
form1.station_type.value=parent.fx_left.tree_form.txt_station_type.value;
form1.station_ids.value=parent.fx_left.tree_form.txt_station_ids.value;
//alert(form1.station_type.value);
//alert(form1.station_ids.value);
form1.submit();
}

function f_check_submit(val){
setValue(form1,"chart_type",val);
f_compare();
}

function f_get_wh(){
  var obj  = document.getElementById('sjfx');
        var w = obj.offsetWidth;
        var h = obj.offsetHeight;

        form1.w.value = w;
        form1.h.value = h;
        //if(w>50){w=w-50;}
        //if(h>50){h=h-50;}
 }



</script>
</body>
</html>