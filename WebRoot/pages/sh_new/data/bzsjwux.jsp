<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.f,java.util.*,com.hoson.zdxupdate.*,com.hoson.XBean"%>
<%

    RowSet data,flist;
    String col,m_time,m_value;
    String cols = "station_id,data_table,date1,date2,date3,hour1,hour2,hour3,infectant_id,zh_flag";
	SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	//request.setCharacterEncoding("gb2312");
	String station_desc = request.getParameter("station_desc_title");
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
    String station_type = request.getParameter("station_type");
    
    //System.out.println(station_type+"=======");
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
.selected{
background-color:#CFDBF1;
font-weight:bold;
} 
 .up{color:#FF8000;}
 .yc{color:red;};
 .drop{color:#B5B5B5;}
</style>
<form name=form1 method=post action='bzsjwux.jsp'>
<%=f.hide(cols,request)%>
<input type="hidden" name="station_type" value="<%=station_type %>">
<table border=0 cellspacing=1>
    <tr class=title> 
    <td width=5%  > <%if(data_table.equals("t_monitor_real_hour_v")) {%> 
                          <input type=button value=标识无效  class=btn onclick=u2()>
                    <%} %>
    <input name=check_all id=check_all type=checkbox onclick="check1(this)" value=''/></td>
     <td width=13%  >序号</td>
     <td width=18% >监测时间</td>
     <td width=15% >补录原因</td>
     <%while(flist.next()){
     	if(!flist.get("infectant_name").equals("流量2"))
     	{
     %>
      	<td>
	       <%=flist.get("infectant_name")%><br>
	       <%=flist.get("infectant_unit")%>
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
  
   <tr onClick="selected('<%=i %>')" style="cursor: pointer;" title="双击进入数据修改"  id="tr<%=i %>" ondblclick="sh_data('<%=station_id %>','<%=station_desc %>','<%=m_time %>','<%=data_table %>','<%=data.get("v_flag") %>','<%=data.get("operator") %>','<%=data.get("operator2") %>','<%=station_type%>')">
     <td>
         <%if(state_flag !=null && !"".equals(state_flag) && state_flag.equals("5")){ %>
              <input name=m_time id=m_time type=checkbox  value='<%=data.get("m_time")%>' disabled="disabled"/>
          <%}else{ %>
              <input name=m_time id=m_time type=checkbox  value='<%=data.get("m_time")%>'/>
          <%} %>
         </td>
      <td > 
          <%=data.getIndex()+1%>
          <%if(state_flag !=null && !"".equals(state_flag) && state_flag.equals("5")){ %>
             (无效数据）
          <%}else if(state_flag !=null && !"".equals(state_flag) && state_flag.equals("7")) {%>
             (补录数据)
          <%}else{ %>
             (原始数据)
          <%} %>
       </td>
      <td><%=format.format(format.parse(data.get("m_time").toString()))%></td>
      <td><%=data.get("v_desc").toString()%> </td>
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
      <td class=right colspan=100><%=w.get("bar")%>
        <input type="hidden" value="<%=station_desc %>" name="station_desc">
      </td>
  </tr>
</table>
<input type="hidden" id="check" name="check" >
<input type="hidden" id="no_check" name="no_check" >
<input type="hidden" id="type" name="type" value="wuxiao">

<!--         浮层框架开始         -->
    <div id="ly" style="position: absolute; top: 0px; filter: alpha(opacity=20); background-color: #ccc;
        z-index: 5; left: 0px; display: none;">
    </div>
    <div id="Layer2" align="center" style="position: absolute; z-index: 6; left: expression((document.body.offsetWidth-500)/2); top: expression((document.body.offsetHeight-350)/2);background-color: #DDF0FF; display: none;width:200px" >
        <table border="0" cellpadding="0" cellspacing="0" style="border: 0   solid   #e7e3e7;
            border-collapse: collapse">
            <tr>
                <td style="background-color: #37c; color: #fff; padding-left: 4px; padding-top: 2px;
                    font-weight: bold; font-size: 14px;" height="27" valign="middle">
                    [&nbsp;无效原因&nbsp;]
                </td>
            </tr>
            <tr>
               <td>
               
                  <div style="position:relative;">
					<br>
					<span style="margin-left:300px;width:18px;overflow:hidden;">   
					   <select id="fake" name="fake" style="width:318px;margin-left:-300px" onchange="chgSelect();">
					    <option value="">
	
					    </option>
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
                   <br>
               </td>               
            </tr>
            <tr>
                <td style="text-align: center" id="show_msg">
                     <input type="button" value="确定" class=btn onclick="u()">&nbsp;&nbsp;<input type="button" value="取消" class=btn onclick="Lock_CheckForm()">
                </td>
            </tr>
        </table>
    </div>
    <!--         浮层框架结束         -->
</form>
<%--<iframe name="q"  width=96% height=60%  scrolling="auto" frameborder="0"   style="border:0px" allowtransparency="true">

</iframe>
--%><script>
function selected(id){
	var i = <%=i%>;
	for(var n=1;n<=i;n++){
		document.getElementById("tr"+n).className='';
	}
	document.getElementById("tr"+id).className='selected';
}
function sh_data(station_id,station_desc,m_time,data_table,v_flag,operator,operator2,station_type){
if(data_table!='t_monitor_real_hour_v'||'<%=v_flag%>'=='true'){
	return false;
}

//alert(operator);
//if(!('<%=b.get("10150")%>'=='yes'||operator==""||'<%=user_name%>'==operator)){
	//alert("没有权限");
	//return false;

//}

//alert(station_type);
//alert(operator+"=="+operator2+"=="+v_flag);
if(operator !="" && operator2=="" && (v_flag =="7" || v_flag =="0")){
	alert("已被一次审核过,不能再审核！");
	return false;
}
//alert(operator+"=="+operator2+"=="+v_flag);
if(operator !="" && operator2 !=""){
	alert("已被二次审核过,不能再审核！");
	return false;
}

 var url = "sjsh.jsp";
	url = url+"?station_id="+station_id+"&station_desc="+escape(escape(station_desc))+"&m_time="+m_time+"&data_table="+data_table+"&v_flag="+v_flag+"&operator="+operator+"&station_type="+station_type;
	var width = 1024;
	var height = 568;
	window.open(url,"","scrollbars=yes,resizable=yes"+",height="+height+",width="+width+",left="+(window.screen.width-width)/2+",top="+(window.screen.height-height)/2);
	
}
function f_go_page(i){
 	form1.page.value=i;
 	var url = "bzsjwux.jsp"+"?station_id="+<%=station_id %>+"&date1="+"<%=date1%>"+"&date2="+"<%=date2%>"+"&hour1="+'<%=hour1%>'+"&hour2="+'<%=hour2%>'+"&data_table="+'<%=data_table%>'+"&page="+i;
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

var v_desc = form1.v_desc.value;
	if(v_desc == ""){
	   alert("无效原因不能为空！");
	   return false;
	}else{
	     var flag = window.confirm("是否把勾选的数据标识为无效?");
		 if(flag){
				for (var i = 0; i < smObj.length; i++){
				   		if(smObj[i].checked ==true){
				   			check  = check +smObj[i].value+ ",";
				   		}
				   		if(smObj[i].checked ==false){
				   			//no_check  = no_check +smObj[i].value+ ",";//把没有勾选的变为有效
				   		}
				    }
				form1.check.value = check;
				form1.no_check.value = no_check;
				form1.target="q";
				form1.action="hour_station_update.jsp?v_desc="+encodeURI(encodeURI(v_desc));
				//alert(form1.action);
				form1.submit();
		 }
    }
}

function u2(){
   locking();
}

function   locking(){   
     document.all.ly.style.display="block";   
     document.all.ly.style.width=document.body.offsetWidth;   
     document.all.ly.style.height=document.body.offsetHeight;   
     document.all.Layer2.style.display='block';   
  }   
  function   Lock_CheckForm(){   
     document.all.ly.style.display='none';document.all.Layer2.style.display='none';
     return   false;   
  }   
function chgSelect(){
	var fake=document.getElementById("fake");
	var real=document.getElementById("v_desc");
	var ind=fake.selectedIndex;
	real.value=fake.options(ind).value;
}
</script>