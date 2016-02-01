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

<style>
.btn{

             BORDER-RIGHT: #2C59AA 1px solid;  BORDER-LEFT: #2C59AA 
            1px solid; CURSOR: hand; COLOR: black; 
            BORDER-BOTTOM: #2C59AA 1px solid
            } 
            
.search {font-family: "宋体"; font-size: 12px; BEHAVIOR: url('<%=request.getContextPath() %>/styles/selectBox.htc'); cursor: hand; }
.input {
   border: #ccc 1px solid;
   font-family: "微软雅黑";
   font-size: 13px;
   width: 150px;
   background:expression((this.readOnly &&this.readOnly==true)?"#f9f9f9":"")
}
</style>

<script>
var type = "5";
var bt = "查看修改审核信息";
function f_v(){
  form1.action="xgxx_list.jsp";
  var station_type = f_text("station_type");
  var area_name = f_text("area_id");
  //var date = f_text("date1");
  var title = area_name+" "+station_type+" 查看修改审核信息";
  form1.title.value=title;
  form1.submit();
}
function f_cs(){
	form1.action="cs.jsp";
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
	 form1.action="xgxx_list.jsp?type=7";
  var station_type = f_text("station_type");
  var area_name = f_text("area_id");
  var title = area_name+" "+station_type+" 查看修改审核信息";
  form1.title.value=title;
  form1.target="qq";
  form1.submit();
}


</script>

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
<select name=ctl_type onChange="search()" class="search" style="width:120px;">
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
  <select name=hour1 id='hour1' class="search" style="width:50px;">
  <%=w.get("hour1Option")%>
  </select>时
 <input type='text' class='input' name='date2' id='date2' value='<%=f.today() %>' onclick="new Calendar().show(this);">
 <select name=hour2 id='hour2' class="search" style="width:50px;">
 <%=w.get("hour2Option")%>
 </select>时
 <br>
<%--<input type=button value='查看修改审核信息' onclick="f_v()" class=btn>
<input type=button value='生成审核数据' onclick="f_cs()" class=btn>
--%>
  <input type=button value='查看修改审核信息' onclick="f_v()" class=btn>
<input type=button value='生成审核数据' onclick="f_cs()" class=btn>

<span style="color:blue;font-size: 12px;">{}内为二次审核数据;[]内为一次审核数据;()内为原始数据</span>

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
search();//黄宝修改
</script>
