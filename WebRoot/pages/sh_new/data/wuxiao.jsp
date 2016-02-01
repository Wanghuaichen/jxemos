<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.util.Scape"%>
<%

    RowSet data,flist;
    String col,m_time,m_value,v_desc="";
    String cols = "station_id,data_table";
	SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	String station_desc = request.getParameter("station_desc_title");
    
    if(station_desc !=null && !"".equals(station_desc)){
      station_desc= Scape.unescape(station_desc);
    }
    try{
    
      SwjUpdate.getWuXiao(request);
    }catch(Exception e){
     w.error(e);
     return;
    }
   // data = w.rs("data");
    flist = w.rs("flist");
    int i = 0;
    String station_id = request.getParameter("station_id");
    
%>
<style>
<!--
.selected{
background-color:#CFDBF1;
font-weight:bold;
} 
.time{
font-size:16;
font-weight:bold;
} 
-->
</style>

<div style="width: 35%;text-align: center">
<form name=form1 method=post action='wuxiao_update.jsp'>
<%=f.hide(cols,request)%>
<input type=hidden name='v_flag' id='v_flag' value='0'>
<input type=hidden name='type' id='type' value='wuxiao'>
<table border=0 cellspacing=0 align="center">
<tr >
<td align="center">

<font style="font-weight: bold;font-size:15px">数据无效标识--站位名称为：<%=station_desc %></font><br><br>

选择时间：
从
<input type='text' class='date' name='date1' id='date1' value='<%=f.today()%>' onclick="new Calendar().show(this);">
                       <select name=hour1 id='hour1'>
                       <%=w.get("hour1Option")%>
                       </select>
  到                    
 <input type='text' class='date' name='date2' id='date2' value='<%=f.today()%>' onclick="new Calendar().show(this);">
	 <select name=hour2 id='hour2'>
	 <%=w.get("hour2Option")%>
	 </select>
	 </td>
	 </tr>
	 <tr>
<td>
<br>
 无效原因：
 <br>
 <div style="position:relative;">
<span style="margin-left:300px;width:18px;overflow:hidden;">   
   <select id="fake" name="fake" style="width:318px;margin-left:-300px" onchange="chgSelect();">
    <option value="校准过程，即校零、跨度、量程、校标的情况。">
     校准过程，即校零、跨度、量程、校标的情况。
    </option>
    <option value="生产设备停运，但在线监测设备仍在运行的情况。">
    生产设备停运，但在线监测设备仍在运行的情况。
    </option>
    <option value="工况未变但在线数据变化过大的情况。">
    工况未变但在线数据变化过大的情况。
    </option>
    <option value=" 数据超标等情况。">
    数据超标等情况。
    </option>
    <option value=" 比对监测不合格仍在上传数据的情况。">
    比对监测不合格仍在上传数据的情况。
    </option>
   </select>
</span>
<input id="v_desc" type="text" name="v_desc" size="150" style="width:300px;position:absolute;left:0px;">
</div>

</td>
</tr>
</table>
<table border=0 cellspacing=0 style="text-align: center">
<tr>
<td style="text-align:right;">
 <input type=button value=保存 class=btn onclick=f_update()>
</td>
</tr>
</table>
</form>
</div>
<script>
function f_update(){
	var v_desc = form1.v_desc.value;
	if(v_desc == ""){
	   alert("无效原因不能为空！");
	}else{
	   form1.action='wuxiao_update.jsp?v_desc='+encodeURI(encodeURI(v_desc));
	   form1.submit();
	   //window.opener.location.reload(); 
	   window.close();
	}
	
}
function f_view(){
 	form2.target='frm_station';
	form2.submit();
 }
function chgSelect(){
var fake=document.getElementById("fake");
var real=document.getElementById("v_desc");
var ind=fake.selectedIndex;
real.value=fake.options(ind).value;
}
</script>
