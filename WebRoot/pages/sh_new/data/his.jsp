<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%@page
	import="com.hoson.f,java.util.*,com.hoson.zdxupdate.*,com.hoson.XBean"%>
<%

    RowSet data,flist;
    String col,m_time,m_value;
    String cols = "station_id,data_table,date1,date2,date3,hour1,hour2,hour3,infectant_id,zh_flag";
	SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	//request.setCharacterEncoding("gb2312");
	String station_desc = request.getParameter("station_desc");
	if(!"".equals(station_desc) && station_desc != null){
	   station_desc = new String(station_desc.getBytes("ISO-8859-1"), "gbk"); 
    }
    try{    
      SwjUpdate.his(request);
    }catch(Exception e){
     w.error(e);
     return;
    }
    data = w.rs("data");
    flist = w.rs("flist");
    String data_table = request.getParameter("data_table");
    int i = 0;
    String station_id = "";
    String date1,date2,hour1,hour2;
		 date1 = request.getParameter("date1");
		 date2 = request.getParameter("date2");
		 hour1 = request.getParameter("hour1");
		 hour2 = request.getParameter("hour2");
	String v_flag = request.getParameter("flag");	 
	//String drop_css = "";
	String checked = "";
	
	 String user_name = (String)session.getAttribute("user_name");
	 String session_id = (String)session.getAttribute("session_id");
  	//Map map = zdxUpdate.getRight(user_name,session_id);
  	Map map = null;
  	XBean b = new XBean(map);
%>
<style>
.selected {
	background-color: #CFDBF1;
	font-weight: bold;
}

.up {
	color: #FF8000;
}

.yc {
	color: red;
}

;
.drop {
	color: #B5B5B5;
}
</style>
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css" />
<form name=form1 method=post action='his.jsp'>
	<%=f.hide(cols,request)%>
	<table border=0 cellspacing=1>
		<tr class=title>
			<%--<td width=5%  >  <input type=button value=保存 class=btn onclick=u()>
    <input name=check_all id=check_all type=checkbox onclick="check1(this)" value=''/></td>--%>
			<td width=13%>序号</td>
			<td width=15%>监测时间</td>
			<td width=15%>补录原因</td>
			<%while(flist.next()){
     	if(!flist.get("infectant_name").equals("流量2"))
     	{
     %>
			<td><%=flist.get("infectant_name")%><br> <%=flist.get("infectant_unit")%>
			</td>
			<%}}%>

		</tr>

		<%while(data.next()){
     flist.reset();
     i++;
     station_id = (String)data.get("station_id");
     //station_desc = (String) data.get("station_desc");
     m_time = (String)data.get("m_time");
     //String st_css = zdxUpdate.getStandardByStation(m_time,null,station_id,request);
     String state_flag = data.get("v_flag");
     if(state_flag.equals("5")){
     	//drop_css = "drop";
     	checked = "checked";
     }
   %>

		<%--<tr onClick="selected('<%=i %>')" style="cursor: pointer;" title="双击进入数据审核"  id="tr<%=i %>" ondblclick="sh_data('<%=station_id %>','<%=station_desc %>','<%=m_time %>','<%=data_table %>','<%=data.get("v_flag") %>','<%=data.get("operator") %>')">
     --%>
		<%--<td><input name=m_time id=m_time type=checkbox <%=checked %> value='<%=data.get("m_time") %>'/></td>--%>
		<tr onClick="selected('<%=i %>')" id="tr<%=i %>">
			<td><%=data.getIndex()+1%> <%if(state_flag !=null && !"".equals(state_flag) && state_flag.equals("5")){ %>
				(无效数据) <%}else if(state_flag !=null && !"".equals(state_flag) && state_flag.equals("7")) {%>
				(补录数据) <%}else{ %> (原始数据) <%} %>
			</td>
			<td><%=format.format(format.parse(data.get("m_time").toString()))%></td>
			<td><%=data.get("v_desc").toString()%></td>
			<%while(flist.next()){
        		col = flist.get("infectant_column");
        		int flag = 0;
        		if(col==null){col="";}
        		col=col.toLowerCase();
        		m_value=data.get(col);
        		//m_value=f.v(m_value);
        		if(!flist.get("infectant_name").equals("流量2"))
       			{
         			if (m_value.indexOf(",") >= 0) {
       				String[] arr = m_value.split(",");
       				//if(arr[2].equals("-9")){
       				if(arr.length>=2){
       					m_value = arr[0]+"["+arr[1]+"]";
       					flag = 1;
       				}else{
       					m_value = arr[0];
       				}
     		  	}else{
       				m_value=f.v(m_value);
       			}
      		%>

			<%
       			if(flag==0){
       				String css = zdxUpdate.get_css(m_time,m_value,null,col,request,data.get("v_flag").toString());
     		%>
			<td class='<%=css%>'><%=m_value%></td>
			<%}else{ %>
			<td><font style='color:blue'><%=m_value%></font></td>
			<%}%>
		<%}}%>

		</tr>
		<%
   			//drop_css = "";
   			checked = "";
   		}%>

		<tr>
			<td class=right colspan=100><%=w.get("bar")%> <input
				type="hidden" value="<%=station_desc %>" name="station_desc">
			</td>
		</tr>
	</table>
	<input type="hidden" id="check" name="check"> <input
		type="hidden" id="no_check" name="no_check">
</form>
<%--<iframe name="q"  width=96% height=60%  scrolling="auto" frameborder="0"   style="border:0px" allowtransparency="true">

</iframe>
--%>
<script>
function selected(id){
	var i = <%=i%>;
	for(var n=1;n<=i;n++){
		document.getElementById("tr"+n).className='';
	}
	document.getElementById("tr"+id).className='selected';
}
function sh_data(station_id,station_desc,m_time,data_table,v_flag,operator){
if(data_table!='t_monitor_real_hour_v'||'<%=v_flag%>'=='true'){
	return false;
}

//alert(operator);
//if(!('<%=b.get("10150")%>'=='yes'||operator==""||'<%=user_name%>'==operator)){
	//alert("没有权限");
	//return false;
//}
if(operator !="" && v_flag !="5"){
	alert("已被审核过,不能再审核！");
	return false;
}

 var url = "sjsh.jsp";
	url = url+"?station_id="+station_id+"&station_desc="+escape(escape(station_desc))+"&m_time="+m_time+"&data_table="+data_table+"&v_flag="+v_flag;
	var width = 1024;
	var height = 568;
	window.open(url,"","scrollbars=yes,resizable=yes"+",height="+height+",width="+width+",left="+(window.screen.width-width)/2+",top="+(window.screen.height-height)/2);
	
}

function f_go_page(i){
 	form1.page.value=i;
 	var url = "his.jsp"+"?station_id="+<%=station_id %>+"&date1="+"<%=date1%>"+"&date2="+"<%=date2%>"+"&hour1="+'<%=hour1%>'+"&hour2="+'<%=hour2%>'+"&data_table="+'<%=data_table%>'+"&page="+i;
 	form1.action = url;
 	form1.submit();
}

function check1(obj){
	if (obj.checked == false) {
		var smObj = document.getElementsByName("m_time");
            for (var i = 0; i < smObj.length; i++){
               		smObj[i].checked = false;
                }
	}
	if (obj.checked == true) {
		var smObj = document.getElementsByName("m_time");
            for (var i = 0; i < smObj.length; i++){
               		smObj[i].checked = true;
                }
	}
}

function u(){
var smObj = document.getElementsByName("m_time");
var check = "";
var no_check = "";
for (var i = 0; i < smObj.length; i++){
   		if(smObj[i].checked ==true){
   			check  = check +smObj[i].value+ ",";
   		}
   		if(smObj[i].checked ==false){
   			no_check  = no_check +smObj[i].value+ ",";
   		}
    }
form1.check.value = check;
form1.no_check.value = no_check;
form1.target="q";
form1.action="hour_station_update.jsp";
form1.submit();
}
</script>