<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      
	BaseAction action = null;
   try{
    action = new WarnAction();
    action.run(request,response,"w");
   
   }catch(Exception e){
      w.error(e);
      return;
   }
   
%>

<script>
var type = "5";
var bt = "无效数据";
function f_v(type1,bt1){
	type = type1;
	bt = bt1;
  form1.action="hz_list.jsp?type="+type1;
  var station_type = f_text("station_type");
  var area_name = f_text("area_id");
  //var date = f_text("date1");
  var title = area_name+" "+station_type+" "+bt1;
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
	 form1.action="hz_list.jsp?type="+type;
  var station_type = f_text("station_type");
  var area_name = f_text("area_id");
  var title = area_name+" "+station_type+" "+bt;
  form1.title.value=title;
  form1.target="qq";
  form1.submit();
}

function f_wuxiao(type1,bt1){
	  form1.action="wuxiaoTj.jsp?type="+type1;
	  var station_type = f_text("station_type");
	  var area_name = f_text("area_id");
	  var title = area_name+" "+station_type+" "+bt1;
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
<select name=station_type id="station_type" onChange="search()" class="search">
<%=w.get("stationTypeOption")%>
</select>
<select name=area_id id="area_id" onChange="search()" class="search">
<%=w.get("areaOption")%>
</select>
<select name=ctl_type onChange="search()" class="search" style="width:120px">
<option value="">重点源属性</option>
<%=w.get("ctlOption")%>
</select>
<select name=valley_id onChange="search()" class="search">
<option value="">请选择流域</option>
<%=w.get("valleyOption")%>
</select>
<select name=trade_id onChange="search()" class="search">
<option value="">请选择行业</option>
<%=w.get("tradeOption")%>
</select>

<input type='text' class='input' name='date1' id='date1' value='<%=f.today() %>' onclick="new Calendar().show(this);">
  <select name=hour1 id='hour1' class="search" style="width:50px">
  <%=w.get("hour1Option")%>
  </select>时
 <input type='text' class='input' name='date2' id='date2' value='<%=f.today() %>' onclick="new Calendar().show(this);">
 <select name=hour2 id='hour2' class="search" style="width:50px">
 <%=w.get("hour2Option")%>
 </select>时
 <br/>
<input type=button value='无效数据' onclick="f_v('5','无效数据')" class=btn>
<input type=button value='补录数据' onclick="f_v('7','补录数据')" class=btn>
<input type=button value='无效数据统计' onclick="f_wuxiao('5','无效数据统计')" class=btn>
<input type=button value='补录数据统计' onclick="f_wuxiao('7','补录数据统计')" class=btn>

</form>
</td>
</tr>

<tr>
<td  style='height:100%'><iframe id='qq' name='qq'  width=100% height=100% frameborder=0></iframe>
</td>
</tr>

</table>
</body>
<script type="text/javascript">
search();
</script>

<script type="text/javascript">

function f_wh(){
	 	var station_id = form1.station_id.value;
	 	var date1 = form1.date1.value;
		var date2 = form1.date2.value;
		var hour1 = form1.hour1.value;
		var hour2 = form1.hour2.value;
	 	var url = "./search/p_wh.jsp"+"?station_id="+station_id+"&date1="+date1+"&date2="+date2+"&hour1="+hour1+"&hour2="+hour2;
	 	//form1.action=url+"?station_id="+station_id;
	 	//form1.submit();
	 	var width = 800;
		var height = 400;
		window.open(url,"","scrollbars=yes,resizable=yes"+",height="+height+",width="+width+",left="+(window.screen.width-width)/2+",top="+(window.screen.height-height)/2);
	 }

</script>
