<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<!--宁波-->
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css">
<script>
function h(){
alert(1);
}
function f_submit(){

  var i = form1.rpt_name.selectedIndex;
   var s = form1.rpt_name.options[i].value;
   var i = form1.sh_flag.selectedIndex;
   if(form1.sh_flag.options[i].value=='0'){
   		form1.tableName.value = "t_monitor_real_hour";
   }else{
   		form1.tableName.value = "t_monitor_real_hour_v";
   }
   form1.action=s;
   form1.submit();
}

function f_save(){
//alert(window.frames["reportq"]);
    var obj = window.frames["reportq"].window.frames["q"].window.document.getElementById('div_excel_content');
    //alert(obj);
    //alert(obj.innerHTML);
    //var form2 = window.document.getElementById('excel_form');
    //alert(form2);
    var i = form1.rpt_name.selectedIndex;
    form1.title.value = form1.rpt_name.options[i].text;
    form1.txt_excel_content.value=obj.innerHTML;
    
    form1.action='/<%=ctx%>/pages/commons/save2excel.jsp';
    form1.submit();
}
function f_onload(){
	form1.action="<%=request.getContextPath() %>/pages/report/loadFile.jsp";
	form1.submit();
}
</script>
<%
		String shOption = SwjUpdate.getShState(request.getParameter("sh_flag"));
		
 %>

<style>
.search {font-family: "宋体"; font-size: 12px;
    BEHAVIOR: url('<%=request.getContextPath() %>/styles/selectBox.htc'); cursor: hand;
 }
.input {
   border: #ccc 1px solid;
   font-family: "微软雅黑";
   font-size: 13px;
   width: 150px;
   background:expression((this.readOnly &&this.readOnly==true)?"#f9f9f9":"")
}

</style>
 
 
 
<body scroll=no onload=f_submit()>

<form name=form1  method=post target=reportq>
<input type=hidden name='txt_excel_content'>
<input type=hidden name='title' value="报表" />
<input type=hidden name='tableName' value=''>

<table border=0 width=100% height=100% cellspacing=0>
<tr>
<td style='height:20px'>
  <select name=rpt_name onchange=f_submit() >
      <option value='./fy/05_form.jsp?station_type=1'>站位流量日报
  <option value='./nb/02_form.jsp'>污染源污水在线监测日报表 
  <option value='./fy/06_form.jsp?station_type=1'>cod超标月报表
    <option value='./fy/01_form.jsp?station_type=1'>在线监控企业月报表
    <option value='./fy/02_form.jsp?station_type=1'>在线监控企业污染物排放统计汇总月报表

      <option value='./fy/04_form.jsp?station_type=1'>在线监控设施故障发生时段统计表



  <%--<option value='./std/index.jsp'>污染源废水烟气报表--%>
  <option value='./area_report/form.jsp'>污染源废水烟气监测报表
  <option value='./std/index.jsp'>污染源废水烟气排放监测报表
  <option value='./fy/03_form.jsp?station_type=1'>故障数据审核
  <option value='./sx/02_form.jsp?station_type=1'>废水在线监控监测数据报表
  <option value='./sx/03_form.jsp?station_type=2'>废气在线监控监测数据报表
  <option value='./sx/04_form.jsp?station_type=1'>废水在线监测点COD浓度分段统计报表
  <option value='./sx/05_form.jsp?station_type=2'>废气在线监测点SO2、Nox、烟尘排放浓度分段统计排放统计报表

  
  
  </select>
  <!--
  <input type=button value='查看' onclick=f_submit()>
  -->
  <select name="sh_flag"  onchange=f_submit()  style="width:120px">
					<%=shOption %>
					</select>
  <input type=button value="保存为excel" class="btn" onclick=f_save()>
  <input type=button value="名词解释下载" class="btn" onclick=f_onload()>
  &nbsp;&nbsp;&nbsp;
     <img src="../../images/bb_mark01.png" />
     <img src="../../images/bb_mark04.png" />
          <img src="../../images/bb_mark03.png" />
     <img src="../../images/bb_mark02.png" />
  </td>
  </tr>
  
  <tr>
  <td style='height:100%'>
  <iframe name=reportq width=100% height=100% frameborder=0>
  </td>
  </tr>
</table>
</form>
<form action="" name="form2"></form>


<form id='excel_form' method=post>
<input type=hidden name='txt_excel_content'>
</form>

</body>



