<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp" %>
<%
String sql = null;
String areaOption = null;
String valleyOption = null;
String infectantOption = null;
Connection cn = null;
java.sql.Date dateNow  = StringUtil.getNowDate();
String station_type = null;
String dataTypeOption = null;
String vs = "T_MONITOR_REAL_TEN_MINUTE,t_monitor_real_hour,t_monitor_real_day,t_monitor_real_month";
String ts = "十分钟数据,小时数据,日数据,月数据";
String stationTypeOption = null;
String data_type = request.getParameter("data_type");
String area_id = request.getParameter("area_id");
String valley_id = request.getParameter("valley_id");
String station_name = null;
String stationOption = null;
String date1 = null;
String date2 = null;
String now = StringUtil.getNowDate()+"";
String sh_flag = null;
String shOption = null;

try{

  date1 = JspUtil.getParameter(request,"date1",now);
  date2 = JspUtil.getParameter(request,"date2",now);
  if(StringUtil.isempty(area_id)){
  area_id=App.getAreaId();

  }

station_name = JspUtil.getParameter(request,"station_name","");
if(StringUtil.isempty(data_type)){data_type="hour";}

station_type = request.getParameter("station_type");
if(station_type==null){
station_type = App.getDefStationId(request);
}

 dataTypeOption = JspUtil.getOption(vs,ts,data_type);
 stationTypeOption = App.getStationTypeOption(station_type,request);
cn = DBUtil.getConn(request);
sql = "select area_id,area_name from t_cfg_area where area_pid='33'";
//areaOption = JspUtil.getOption(cn,sql,"");
areaOption = JspPageUtil.getAreaOption(cn,area_id);


sql = "select valley_id,valley_name from t_cfg_valley ";
sql=sql+"where valley_level='2' or valley_level='3' order by valley_level";
valleyOption = f.getValleyOption(valley_id);

sql = "select infectant_id,infectant_name from t_cfg_infectant_base ";
sql=sql+"where station_type='"+station_type+"' order by infectant_type desc";
infectantOption = JspUtil.getOption(cn,sql,"");

  sql = "select station_id,station_desc from t_cfg_station_info where 2>1 ";
  sql = sql +" and station_type='"+station_type+"' ";
  sql = sql+ DataAclUtil.getStationIdInString(request,station_type,"station_id");

  if(!StringUtil.isempty(area_id)){
   sql = sql +" and area_id like '"+area_id+"%' ";
  }
  if(!StringUtil.isempty(valley_id)){
   sql = sql +" and valley_id like '"+valley_id+"%' ";
  }
  sql = sql +" order by station_desc ";
  stationOption = JspUtil.getOption(cn,sql,null);
  sh_flag = request.getParameter("sh_flag");
  shOption = SwjUpdate.getShState(sh_flag);

}catch(Exception e){
	//out.println(e);
	        JspUtil.go2error(request,response,e);
	return;
	}finally{
	DBUtil.close(cn);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title></title>
<link href="../styles/reset-min.css" rel="stylesheet" type="text/css" />
<link href="../styles/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
<link href="../styles/common/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../scripts/core/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../scripts/core/jquery.ui.core.js"></script>
<script type="text/javascript" src="../scripts/core/jquery.ui.widget.js"></script>
<script type="text/javascript" src="../scripts/core/jquery.ui.tabs.js"></script>
<script type="text/javascript" src="../scripts/core/jquery.ui.check.js"></script>
<script type="text/javascript" src="../scripts/common.js"></script>
<script type="text/javascript" src="../../../scripts/calendar.js"></script>
<style>
.search { font-size: 14px; BEHAVIOR: url('<%=request.getContextPath() %>/styles/selectBox.htc'); cursor: hand;}
.input {
   border: #ccc 1px solid;
   font-size: 12px;
   padding-top:2px;
   width:80px;
   height:22px;
   background:expression((this.readOnly &&this.readOnly==true)?"#f9f9f9":"")
}

.btn1{ background:url(<%=request.getContextPath() %>/images/common/btn1.gif) no-repeat; border:none; text-align:center; }


</style>
</head>
<body onload=form1.submit() style="background-color: #f7f7f7"  scroll=no >

<form name="form1" method="post" target="data_query_iframe" action="data_query.jsp">

<!--<input type="hidden" name="station_type" value="<%=station_type%>">-->



<!--
<input type=radio name="chart_type" value="hour" onclick="form1.submit()">时均值线图
<input type=radio name="chart_type" value="day" checked onclick="form1.submit()">日均值线图
<input type=radio name="chart_type" value="week" onclick="form1.submit()">周均值线图
<input type=radio name="chart_type" value="month" onclick="form1.submit()">月均值线图
-->

<table style="width: 100%;margin-top:10px;font-size: 13px;color: #01538a;font-weight: bold">
<tr>

<td>
		站位类型:
		<select name="station_type" onchange=getStationOption() class="search" >
		<%=stationTypeOption%>
		</select>
		
		
		&nbsp;均值类型:
		<select name="data_type"  onchange=form1.submit() class="search" >
		<%=dataTypeOption%>
		</select>
		
		<!--
		<input type="radio" name="query_type" value="0" checked>地区
		<input type="radio" name="query_type" value="1">流域
		-->
		
		&nbsp;地区:
		<select name="area_id"  onchange=getStationOption() class="search" >
		<%=areaOption%>
		</select>
		
		
		<%--<div class="item">
		流域:
		<select name="valley_id"  onchange=getStationOption() class="search" >
		<option value="">全部</option>
		<%=valleyOption%>
		</select>
		</div>
		--%>
		
		&nbsp;数据状态:
		<select name="sh_flag"  onchange=getStationOption() class="search" >
		<%=shOption %>
		</select>
		
		
		<%--<input type=button value="数据指标解释" title="数据指标解释" style=" background:url(<%=request.getContextPath() %>/images/common/btn1.gif) no-repeat; border:none;  width:80px;height:25px " onclick=f_onload() />--%>
		
		
		
</td>
</tr>

<tr style="height: 50px">
<td>
站位名称：<input type=text name="station_name" style="width:110px" value="<%=station_name%>" class=input />
		
		
		<select name=station_id onchange=form1.submit() class="search">
		<option value="">请选择一个站位</option>
		<%=stationOption%>
		</select>
		
		
		<!--
		
		<select name="infectant_id">
		<%=infectantOption%>
		</select>
		上限 <input type=text name="min_val">
		下限 <input type=text name="max_val">
		
		<br>
		-->
		
		
		<!--
		从
		<input name="date1" type="text" value="<%=App.getDate(session,"date1",dateNow)%>" class=date onclick="new Calendar().show(this);">
		到
		<input name="date2" type="text" value="<%=App.getDate(session,"date2",dateNow)%>" class=date  onclick="new Calendar().show(this);" >
		-->
		从
		<input name="date1" type="text" id="date1" value="<%=date1%>" class=input readonly="readonly" onclick="new Calendar().show(this);" />
		到
		<input name="date2" type="text" id="date2" value="<%=date2%>" class=input readonly="readonly" onclick="new Calendar().show(this);" />
		
		
		
		<input type=hidden name=show_minmax_flag value=0 />
		<!--
		<input type=checkbox name=show_minmax_flag value=1>
		<span  onclick="form1.show_minmax_flag.checked=!form1.show_minmax_flag.checked">显示最小最大值</span>
		-->
		
		
		<input type=submit value="查看" title="查看" style=" background:url(<%=request.getContextPath() %>/images/common/btn1.gif) no-repeat; border:none;  width:80px;height:25px " />
		
		<input type=button value="保存为excel" title="保存为excel" style=" background:url(<%=request.getContextPath() %>/images/common/btn1.gif) no-repeat; border:none;  width:80px;height:25px " onclick=f_save() />
		<!--    (修改过的用红色标示)-->
</td>
</tr>

</table>

</form>


<div >
<iframe name="data_query_iframe" id="data_query_iframe" width=100% height="400" scrolling="auto" frameborder="0">
</iframe>
</div>
<form name=form2 method=post>
<input type=hidden name='txt_excel_content' />
<input type=hidden name='title' value="监测数据" />
</form>

</body>
</html>
<script>
function getStationOption(){
             form1.action="data.jsp";
             form1.target="";
             form1.submit();
             form1.target="data_query_iframe";
             form1.action="data_query.jsp";
}

function f_save(){
    var obj = window.frames["data_query_iframe"].window.document.getElementById('div_excel_content');
    //alert(obj);
    form2.txt_excel_content.value=obj.innerHTML;

    form2.action='/<%=ctx%>/pages/commons/save2excel.jsp';
    var date1 = form1.date1.value;
    var date2 = form1.date2.value;
    if(date1 == date2){
        form2.title.value = date1+"的监测数据";
    }else {
        form2.title.value = "从"+date1+"到"+date2+"间的监测数据";
    }

    form2.submit();
}
function f_onload(){
	form1.action="loadFile1.jsp";
	form1.submit();
}

if(screen.height>=900 && screen.height<=1024 ){
   document.getElementById("data_query_iframe").height=550;
}else if(screen.height>=800 && screen.height<900){
  //alert("800");
  document.getElementById("data_query_iframe").height=380;
}else if(screen.height>=768 && screen.height<800){
  document.getElementById("data_query_iframe").height=350;
}else if(screen.height>=720 && screen.height<768){
  document.getElementById("data_query_iframe").height=354;
}
</script>