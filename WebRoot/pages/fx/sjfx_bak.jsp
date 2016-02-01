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


<style>
.search {font-family: "宋体"; font-size: 12px;
    BEHAVIOR: url('<%=request.getContextPath() %>/styles/selectBox.htc'); cursor: hand;
 }
.input {
   border: #ccc 1px solid;
   font-family: "微软雅黑";
   font-size: 12px;
   padding-top:2px;
   width: 100px;
   background:expression((this.readOnly &&this.readOnly==true)?"#f9f9f9":"")
}

.btn1{width:80px; height:23px; line-height:23px; background:url(<%=request.getContextPath() %>/images/common/btn1.gif) no-repeat; border:none; text-align:center; }

</style>
<script type="text/javascript" src="../../scripts/calendar.js"></script>
<body onload="form1.submit()" style="overflow-y:visible;background-color: #f7f7f7;overflow-x:hidden">

<form name="form1" method=post action="../compare/compare_action.jsp" target="sjfx">
<input type="hidden" name="hour1" value="0">
<input type="hidden" name="hour2" value="23">
<input type="hidden" name="station_type" value="">
<input type="hidden" name="station_ids" value="">

<input type=hidden name='w'>
<input type=hidden name='h'>

<table border=0 cellspacing=0 style="width:100%;font-size: 12px">



<tr><td class=left>

<!--<input type=radio name=chart_type value="minute" >分均值线图 -->
<!--<input type=radio name=chart_type value="hour" >时均值线图 -->
<input type=radio name=chart_type value="T_MONITOR_REAL_TEN_MINUTE"  checked onclick="f_compare()"><span onclick="f_check_submit('T_MONITOR_REAL_TEN_MINUTE')">十分钟数据</span>
<input type=radio name=chart_type value="t_monitor_real_hour"  checked onclick="f_compare()"><span onclick="f_check_submit('t_monitor_real_hour')">小时数据</span>
<input type=radio name=chart_type value="t_monitor_real_day" onclick="f_compare()"><span onclick="f_check_submit('t_monitor_real_day')">日数据</span>
<%--<input type=radio name=chart_type value="week"onclick="f_compare()"><span onclick=f_check_submit("week")>周均值</span>
--%><input type=radio name=chart_type value="t_monitor_real_month"  onclick="f_compare()"><span onclick="f_check_submit('t_monitor_real_month')">月汇总数据</span>
<br>
从 <input name="date1" type="text" value="<%=dateNow%>" class=input readonly="readonly" onclick="new Calendar().show(this);" >

到 <input name="date2" type="text" value="<%=dateNow%>" class=input readonly="readonly" onclick="new Calendar().show(this);">
监测因子:
<select name="infectant_id" onchange="f_compare()" class="search" style="width:120px"><%=infectantOption%></select>

  <%--
             <select name="date_axis_fix_flag">
             <option value="1">时间轴固定</option>
             <option value="0">时间轴自动调整</option>
             </select>
          --%>
数据状态:
<select name="sh_flag"  onchange=form1.submit() class="search" style="width:120px">
<%=shOption %>
</select>

<input type=button value="数据比较" class=btn1 onclick="f_compare()">

</td></tr>
</table>

</form>

<iframe name="sjfx" id="sjfx" width=100% height=90%  scrolling="auto" frameborder="0"  style="border:0px" allowtransparency="true">
</iframe>
</body>

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
form1.submit()
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








