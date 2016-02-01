<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      
	BaseAction action = null;
	String sh_flag = null;
String shOption = null;
   try{
    action = new WarnAction();
    action.run(request,response,"w");
    sh_flag = request.getParameter("sh_flag");
   shOption = SwjUpdate.getShState(sh_flag);
   }catch(Exception e){
      w.error(e);
      return;
   }
   
%>

<script>
var type = "0";
var bt = "预警";
function f_v(type1,bt1){
	type = type1;
	bt = bt1;
  form1.action="q_list.jsp?type="+type1;
  var station_type = f_text("station_type");
  var area_name = f_text("area_id");
  //var date = f_text("date1");
  var title = area_name+" "+station_type+" "+bt1+"数据";
  form1.title.value=title;
  form1.submit();
}

function f_text(obj)
{
	var o = document.getElementById(obj);
	var t = o.type;
	if(t=="select-one")
	{
		return o.options[o.selectedIndex].text;
	}
	if(t=="text")
	{
		return o.value;
	}
}
function search(){
	 form1.action="q_list.jsp?type="+type;
  var station_type = f_text("station_type");
  var area_name = f_text("area_id");
  var title = area_name+" "+station_type+" "+bt+"数据";
  form1.title.value=title;
  form1.target="qq";
  form1.submit();
}

</script>

<style>
.search {font-family: "宋体"; font-size: 12px; BEHAVIOR: url('<%=request.getContextPath() %>/styles/selectBox.htc'); cursor: hand; }
.input {
   border: #ccc 1px solid;
   font-family: "微软雅黑";
   font-size: 13px;
   width: 150px;
   background:expression((this.readOnly &&this.readOnly==true)?"#f9f9f9":"")
}

</style>

<body>
<table border=0  cellspacing=0 style='width:100%;height:100%'>
<tr>
<td style='height:20px'>
<form name=form1 method=post action=q_list.jsp target=qq>
<input type="hidden" name="title">
站位类型:
<select name=station_type id="station_type" onChange="search()" class="search">
<%=w.get("stationTypeOption")%>
</select>

地区:
<select name=area_id id="area_id" onChange="search()" class="search">
<%=w.get("areaOption")%>
</select>
重点源:
<select name=ctl_type onChange="search()" class="search" style="width:120px">
<option value="">重点源属性</option>
<%=w.get("ctlOption")%>
</select>
流域:
<select name=valley_id onChange="search()" class="search">
<option value="">请选择流域</option>
<%=w.get("valleyOption")%>
</select>
行业:
<select name=trade_id onChange="search()" class="search">
<option value="">请选择行业</option>
<%=w.get("tradeOption")%>
</select>
<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;从:
<input type='text' class='input' name='date1' id='date1' value='<%=f.today() %>' onclick="new Calendar().show(this);">
  <select name=hour1 id='hour1' class="search" style="width:50px">
  <%=w.get("hour1Option")%>
  </select>时
  
  到:
 <input type='text' class='input' name='date2' id='date2' value='<%=f.today() %>' onclick="new Calendar().show(this);">
 <select name=hour2 id='hour2' class="search" style="width:50px">
 <%=w.get("hour2Option")%>
 </select>时
 
 &nbsp;&nbsp;&nbsp;均值类型:
 <select name="sh_flag"  onchange=form1.submit() class="search" style="width:120px"> 
<%=shOption %>
</select>
<input type=button value='预警' onclick="f_v('0','预警')" class=btn>
<input type=button value='报警' onclick="f_v('1','报警')" class=btn>
<input type=button value='超量程' onclick="f_v('2','超量程')" class=btn>
</form>
</td>
</tr>

<tr>
<td  style='height:100%'>

<iframe id='qq' name='qq'  width=100% height=100% frameborder=0></iframe>
</td>
</tr>

</table>
</body>
<script type="text/javascript">
search();
</script>
