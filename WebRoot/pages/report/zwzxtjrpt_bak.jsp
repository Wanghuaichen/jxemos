<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<!--宁波-->
<script>
function h(){
alert(1);
}
function f_submit(){

  var i = form1.rpt_name.selectedIndex;
   var s = form1.rpt_name.options[i].value;
   var i = form1.sh_flag.selectedIndex;
   //alert(form1.sh_flag.options[i].value);
   if(form1.sh_flag.options[i].value=='0'){
   		form1.tableName.value = "t_monitor_real_hour";
   }else{
   		form1.tableName.value = "t_monitor_real_hour_v";
   }
   
    if(s=="./csyzlv/01_form.jsp"){
      document.getElementById("sh_flag").style.display="none";
   }else{
      document.getElementById("sh_flag").style.display="";
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
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css">
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
 
  <option value='./nb/01_form.jsp'>日在线脱机统计报表
  <option value='./hz01_form.jsp'>日污染源脱机联机报表
  <option value='./hz07_form.jsp'>一周内的污染源脱机联机报表
  <option value='./nb/tj_yue_form.jsp'>月在线脱机统计报表
  <option value='./csyzlv/01_form.jsp'>季度数据传输率与设备运转率
 <option value='./sx/06_form.jsp?station_type=1'>废水在线监测点完好率统计报表
 <option value='./sx/07_form.jsp?station_type=2'>废气在线监测点完好率统计报表
  
 <option value='./sx/08_form.jsp?station_type=1'>废水在线监测点在线率统计报表
 <option value='./sx/09_form.jsp?station_type=2'>废气在线监测点在线率统计报表
  
  
  </select>
  <!--
  <input type=button value='查看' onclick=f_submit()>
  -->
  <select name="sh_flag" id="sh_flag"  onchange=f_submit()  style="width:120px">
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
  <td>
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



