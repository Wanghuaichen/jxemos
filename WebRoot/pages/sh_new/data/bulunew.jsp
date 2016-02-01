<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%@page import="com.hoson.util.Scape"%>

<head>
<base target="_self" />
</head>

<%

    RowSet data,flist;
    String col,m_time,m_value,v_desc="";
    String cols = "station_id,data_table";
	SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	String station_desc = request.getParameter("station_desc_title");
	String station_type= request.getParameter("station_type");
    if(station_desc !=null && !"".equals(station_desc)){
      station_desc= Scape.unescape(station_desc);
    }
    try{
    
      SwjUpdate.getBulu(request);
    }catch(Exception e){
     w.error(e);
     return;
    }
   // data = w.rs("data");
    flist = w.rs("flist");
    int i = 0;
    String station_id = request.getParameter("station_id");
    m_time = request.getParameter("m_time");
    String user_name = (String)session.getAttribute("user_name");
    
%>
<style>
<!--
.selected {
	background-color: #CFDBF1;
	font-weight: bold;
}

.time {
	font-size: 16;
	font-weight: bold;
}
-->
</style>
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="<%=request.getContextPath() %>/scripts/calendar.js"></script>
<div style="width: 70%">
	<form name=form1 method=post action='bulu_update.jsp'>
		<%=f.hide(cols,request)%>
		<input type=hidden name='v_flag' id='v_flag' value='7'> <input
			type=hidden name='type' id='type' value='bulu'> <font
			style="font-weight: bold;font-size: 15px">站位名称为：<%=station_desc %>--请选择补录的时间：</font>
		<input type='text' class='date' name='date1' id='date1'
			value='<%=w.get("date1")%>' onclick="new Calendar().show(this);">
		日<select name="hour1" id="hour1">
			<option value="">--请选择--</option>
			<option value="0">0</option>
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
			<option value="6">6</option>
			<option value="7">7</option>
			<option value="8">8</option>
			<option value="9">9</option>
			<option value="10">10</option>
			<option value="11">11</option>
			<option value="12">12</option>
			<option value="13">13</option>
			<option value="14">14</option>
			<option value="15">15</option>
			<option value="16">16</option>
			<option value="17">17</option>
			<option value="18">18</option>
			<option value="19">19</option>
			<option value="20">20</option>
			<option value="21">21</option>
			<option value="22">22</option>
			<option value="23">23</option>
		</select> 点到 <select name="hour2" id="hour2">
			<option value="">--请选择--</option>
			<%--<%=w.get("hour2Option")%>
        --%>
			<option value="0">0</option>
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
			<option value="6">6</option>
			<option value="7">7</option>
			<option value="8">8</option>
			<option value="9">9</option>
			<option value="10">10</option>
			<option value="11">11</option>
			<option value="12">12</option>
			<option value="13">13</option>
			<option value="14">14</option>
			<option value="15">15</option>
			<option value="16">16</option>
			<option value="17">17</option>
			<option value="18">18</option>
			<option value="19">19</option>
			<option value="20">20</option>
			<option value="21">21</option>
			<option value="22">22</option>
			<option value="23">23</option>
		</select>点
		<table border=0 cellspacing=1>
			<tr class=title>
				<td width=120px>监测因子</td>
				<td width=120px>量程上限</td>
				<td width=120px>量程下限</td>
				<td width=120px>报警上限</td>
				<td width=120px>报警下限</td>
				<td width=120px>预警下限</td>
				<td width=120px>预警上限</td>

				<td width=120px>当前值</td>
			</tr>

			<%
     flist.reset();
     while(flist.next()){
   %>

			<tr>
				<td><%=flist.get("infectant_name") %></td>
				<td><%=flist.get("hihihihi") %></td>
				<td><%=flist.get("lolololo") %></td>
				<td><%=flist.get("hihi") %></td>
				<td><%=flist.get("lolo") %></td>
				<td><%=flist.get("lo") %></td>
				<td><%=flist.get("hi") %></td>
				<%
        col = flist.get("infectant_column");
        if(col==null){col="";}
        col=col.toLowerCase();
        //m_value=f.v(m_value);
        if(!flist.get("infectant_name").equals("流量2"))
        {
      %>

				<%}%>
				<td><input type="text" name='<%=col%>' id='<%=col%>' value=""
					onkeyup="value=value.replace(/[^\d\.]/g,'')">
				</td>
			</tr>
			<%}%>

		</table>
		<table border=0 cellspacing=0>
			<tr>
				<td>补录原因： <br> <textarea id="V_DESC" name="V_DESC"
						rows="5" cols="100%"><%=v_desc%></textarea></td>
			</tr>
		</table>
		<table border=0 cellspacing=0>
			<tr>
				<td style="text-align:right;"><input type=button value=保存
					class=btn onclick=f_update()></td>
			</tr>
		</table>
	</form>
	<%--<form name=form2 method=post action='his.jsp'>
<input type=hidden name='station_id' id='station_id' value='<%=station_id%>'>
<input type=hidden name='flag' id='flag' value='true'>
<table border=0 style='width:100%;height=100%' cellspacing=0>
 <tr>
 <td rowspan=2>
                 <table style='width:100%;height:100%;border:solid 0px red' border=0 cellspacing=0>
                 <tr>
                   <td height=10px>
                   <div style='padding-top:8px'>
                       <select name='data_table' id='data_table' onchange='f_btn();f_submit()'>
                         <!--  <option value='t_monitor_real_minute'>实时数据-->
                         <option value='t_monitor_real_hour_v' selected>时均值
                         <option value='t_monitor_real_day_v'>日均值
                         <option value='t_monitor_real_month_v'>月均值
                       </select>
                       
                       <input type='text' class='date' name='date1' id='date1' value='<%=w.get("date1")%>' onclick="new Calendar().show(this);">
                       <select name=hour1 id='hour1'>
                       <%=w.get("hour1Option")%>
                       </select>
                       
                       <input type='text' class='date' name='date2' id='date2' value='<%=w.get("date2")%>' onclick="new Calendar().show(this);">
                       <select name=hour2 id='hour2'>
                       <%=w.get("hour2Option")%>
                       </select>
                       
                       
                       <input type='button' value='查看' class='btn' onclick='f_view()' id='btn_view'>

                       
                    </div>
                       <div style='height:10px;width:100%'></div>
                   </td>
                 </tr>
                 
                 <tr>
                   <td style='height:100%;padding:0px'>
                     <iframe id='frm_station_id' name='frm_station' src='../../commons/empty.jsp' width=100% height=100% frameborder=0></iframe>
                     <iframe id="frm_station_target" name="frm_station_target"></iframe>
                   </td>
                 </tr>
                 </table>
  </td>
  </tr>
  </table>
</form>
--%>
</div>
<script>
function f_update(){
	<%
	 flist.reset();
	 String cols1 = "";
     while(flist.next()){
     	col = flist.get("infectant_column");
        if(col==null){col="";}
        col=col.toLowerCase();
        //cols1 = col;
        cols1 = cols1+","+col;
	%>
	var value = document.getElementById('<%=col%>').value;
	//var y_value = document.getElementById('y_<%=col%>').value;
	//if(value!=y_value){
		//document.getElementById('<%=col%>').value = value+','+value+',-9';
		//alert(document.getElementById('<%=col%>').value);
        
        var hour1 = document.getElementById("hour1").value;
        var hour2 = document.getElementById("hour2").value;
        
        //alert("==="+hour1+"==="+hour2+"===");
        
        if(hour1=="" || hour2==""){
           alert("请选择时间段!");
           return false;
        }
        
        if(hour1 - hour2 >0){
           alert("开始时间不能比结束时间大！");
           return false;
        }

		if(document.getElementById('V_DESC').value==''){
			alert('补录原因不能为空！');
			return false;
		}
	//}
	<%}%>
	//alert('<%=cols1%>');
	//alert('<%=user_name%>');
	form1.action='bulu_update.jsp?cols='+'<%=cols1%>'+'&operator='+'<%=user_name%>';
	form1.submit();
	form1.target="frm_station_target";
	//window.opener.location.href = window.opener.location.href; 
	window.close();
}
function f_view(){
 	form2.target='frm_station';
	form2.submit();
 }
</script>
