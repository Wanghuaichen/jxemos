<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.util.Scape"%>
<%
    
    request.setCharacterEncoding("GBK");
    
    RowSet data,flist;
    String col,m_time,m_value,v_desc="";
    String cols = "station_id,m_time";
	SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    try{
    
      SwjUpdate.getShData(request);
    }catch(Exception e){
     w.error(e);
     return;
    }
    data = w.rs("data");
    flist = w.rs("flist");
    int i = 0;
    
    String station_id = request.getParameter("station_id");
    String station_desc = request.getParameter("station_desc");
    
    String operator = request.getParameter("operator");
    
    String v_flag = request.getParameter("v_flag");
    
    String station_type = request.getParameter("station_type");
    
    if(station_desc !=null && !"".equals(station_desc)){
      station_desc= Scape.unescape(station_desc);
    }
    
    m_time = request.getParameter("m_time");
    String data_table = request.getParameter("data_table");
    
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
<div style="width: 80%">
<form name=form1 method=post action='update.jsp'>
<%=f.hide(cols,request)%>

<input type=hidden name='type' id='type' value='bulu'>
<input type=hidden name='operator' id='operator' value='<%=(String)session.getAttribute("user_name") %>'>
<input type=hidden name='operator3' id='operator3' value='<%=(String)session.getAttribute("user_name")  %>'>
<input type=hidden name='v_flag' id='v_flag' value='<%=v_flag %>'>
<input type=hidden name='operator2' id='operator2' value='<%=(String)session.getAttribute("user_name") %>'>
<input type=hidden name='station_type' value='<%=station_type %>'>
<span class="time">站位名称：<%=station_desc %>----监测数据时间：<%=m_time %></span>
<table border=0 cellspacing=1>
    <tr class=title> 
     <td width=120px >监测因子</td>
     <td width=120px >量程下限</td>
     <td width=120px >量程上限</td>
     <td width=120px >报警下限</td>
     <td width=120px >报警上限</td>
     <td width=120px >预警下限</td>
     <td width=120px >预警上限</td>
     <td width=120px >原始值</td>
     <td width=120px >当前值</td>
   </tr>
   
    <%
    while(data.next()){
    v_desc = (String)data.get("v_desc");
     flist.reset();
     while(flist.next()){
   %>
  
   <tr>
    	<td><%=flist.get("infectant_name") %></td>
    	<td><%=flist.get("lolololo") %></td>
    	<td><%=flist.get("hihihihi") %></td>
    	<td><%=flist.get("lolo") %></td>
    	<td><%=flist.get("hihi") %></td>
    	<td><%=flist.get("lo") %></td>
    	<td><%=flist.get("hi") %></td>
      <%
        col = flist.get("infectant_column");
        if(col==null){col="";}
        col=col.toLowerCase();
        m_value=data.get(col);
        String m_value1 = "";
        //m_value=f.v(m_value);
        if(!flist.get("infectant_name").equals("流量2"))
        {
        if (m_value.indexOf(",") >= 0) {
       		String[] arr = m_value.split(",");
       		//if(arr[2].equals("-9")){
       		if(arr.length>=2){
       			m_value1 = arr[0];
       			m_value = arr[1];
       		}
       }
       //if(m_value1.equals("")){
       		//m_value1 = m_value;
       //}
       m_value=f.v(m_value);
       m_value1=f.v(m_value1);
      %>
      <td><%=m_value%></td>
      <%}%>
      <%if(!"".equals(m_value1) && m_value1 !=null){ %>
         <td><input type="text" name='<%=col%>' id='<%=col%>' value="<%=m_value1%>" onkeyup="value=value.replace(/[^\d\.]/g,'')"></td>
      <%}else{ %>
          <td><input type="text" name='<%=col%>' id='<%=col%>' value="<%=m_value%>" onkeyup="value=value.replace(/[^\d\.]/g,'')"></td>
      <%} %>
    </tr>
   <input type=hidden name='y_<%=col%>' id='y_<%=col%>' value='<%=m_value%>'>
   <%}}%>
   
</table>
<table border=0 cellspacing=0 >
<tr>
<td>
 审核说明：
 <br>
 <textarea id="V_DESC" name="V_DESC" rows="5" cols="150"><%=v_desc%></textarea>
</td>
</tr>
</table>
<table border=0 cellspacing=0 >
<tr>
<td style="text-align:right;">
 <input type=button value=保存 class=btn onclick=f_update()>
</td>
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
                       <select name='data_table' id='data_table' onchange='f_btn();f_view()'>
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
	var y_value = document.getElementById('y_<%=col%>').value;
	if(value!=y_value){
		//document.getElementById('<%=col%>').value = value+','+y_value+',-9';
		//alert(document.getElementById('<%=col%>').value);
		
	}
	<%}%>
	//alert('<%=cols1%>');
	if(document.getElementById('V_DESC').value==''){
			alert('审核说明不能为空！');
			return false;
	}
	form1.action='update.jsp?cols='+'<%=cols1%>'+'&data_table='+'<%=data_table%>';
	form1.submit();
	//window.opener.location.href = window.opener.location.href; 
	//window.opener.location.href = "his.jsp";
	//window.opener.location.reload(); 
	window.close();
}
function f_view(){
 	form2.target='frm_station';
	form2.submit();
 }
  function f_btn_real(){
        //f_hide_all();
      f_ajf_show("date1,date2,hour1,hour2");
 }
 function f_btn_avg(){
   // f_hide_all();
   f_ajf_hide("hour1,hour2");
    f_ajf_show("date1,date2");
 }
 
 function f_btn(){
  var obj = form2.data_table;
   var i = obj.selectedIndex;
   if(i>=1){
    f_btn_avg()
   }else{
   f_btn_real();
   }
 }
  f_btn_real(); 
   
 
</script>
