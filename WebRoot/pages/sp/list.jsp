<%@page import="com.crystaldecisions.jakarta.poi.util.StringUtil"%>
<%@page import="com.mysql.jdbc.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="sp_inc.jsp"%>
<%
        String ip,port,user,pwd,puid,td;
        
        String user_area_id = (String)request.getSession().getAttribute("area_id");
        if(f.empty(user_area_id)){
        	user_area_id=f.getDefaultAreaId();
        }
        try{
                JiangXi.list(request);
                ip=f.cfg("sp_ip_jx","");
                port=f.cfg("sp_port_jx","");
                user=f.cfg("sp_user_jx","");
                pwd=f.cfg("sp_pwd_jx","");
                
                
        }catch(Exception e){
          w.error(e);
          return;
        }
        RowSet rs = null;
        rs = w.rs("list");
        String s = null;
        String stationTypeOption,areaOption;
        stationTypeOption = w.get("stationTypeOption");
        areaOption = w.get("areaOption");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title></title>
</head>

<body onunload=f_stopall() onload='f_login()'>
	<form name=form1 method=post action='list.jsp'>
		<input type=hidden name='ip' value='<%=ip%>'> 
		<input type=hidden name='port' value='<%=port%>'> 
		<input type=hidden name='user' value='<%=user%>'> 
		<input type=hidden name='pwd' value='<%=pwd%>'>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="12" height="31">
								<img src="images/sp_l_03.gif" width="12" height="31" alt="" />
							</td>
							<td height="31" align="left" background="images/sp_l_05.gif">
								<table width="100%" height="31" border="0" cellpadding="0"	cellspacing="0">
									<tr>
										<td width="130" align="left" background="images/sp_l_05.gif"></td>
										<td width="515">&nbsp;</td>
										<td width="207" valign="bottom"></td>
									</tr>
								</table>
							</td>
							<td width="7" height="31"><img src="images/sp_m_01.gif"
								width="14" height="31" alt="" />
							</td>
						</tr>
						<tr>
							<td background="images/sp_l_13.gif"></td>
							<td height="100%">
								<!--sp control--> <!--<div style="width:100%;height:300"></div>	-->
								<table width=100% height=100%>
									<tr>
										<td width=80%>
											<OBJECT id="spobj" codeBase="jiangxi.cab#version=1,0,0,36" height="400"
												width="100%" classid="clsid:731B048F-7419-41FB-88C7-F74A852CF09A">
												<param name="_Version" value="65536">
												<param name="_ExtentX" value="15875">
												<param name="_ExtentY" value="13229">
												<param name="_StockProps" value="0">
											</OBJECT>
										</td>
										<td>
											<!--start sp list table-->
											<table width=100% height=100%>
												<tr>
													<td height=20px>
														<select name=station_type onchange=f_r()>
															<%=stationTypeOption%>
													</select> 
													<%--<br>
          											<select name=area_id onchange=f_r()>
           												<%=areaOption%>
           											</select>--%> 
           											<%if(!"".equals(user_area_id) && user_area_id.equals("36")) {%>
													<select name=area_id onchange=f_r()>
															<%=areaOption%>
													</select> 
													<%}else{ %> 
													<input type="hidden" name="area_id"	value="<%=user_area_id %>">
													 <%} %> 
													 <br> 
													 <input	type=text name=p_station_name value='<%=w.get("p_station_name")%>'> 
													 <br> 
													 <input type=button value=' 查 看 ' onclick=f_r()></td>
												</tr>
												<tr>
													<td>
														<select size=500 id='sp_sb' onclick='f_play()'	style='width:100%;height:100%'>
															<%while(rs.next()){
               													td = rs.get("td");
               													puid=rs.get("puid");
               													s = puid+","+td;
               													if(!"".equals(td) && td.equals("0")){
               												%>
															<option value='<%=s%>'
																title="<%=rs.get("station_name")%>_通道<%=td%>"><%=rs.get("station_name")%>_通道<%=td%>
															<%}
                											}
               												%>
														</select>
													</td>
												</tr>
											</table> <!--start sp list table--></td>
								</table></td>
							<td width="7" background="images/sp_m_02.gif"></td>
						</tr>
						<tr>
							<td height="3"><img src="images/sp_l_27.gif" width="12"
								height="3" />
							</td>
							<td height="3" background="images/sp_l_29.gif"><img
								src="images/sp_l_28.gif" width="8" height="3" />
							</td>
							<td height="3"><img src="images/sp_m_04.gif" />
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td><table width="100%" border="0" cellpadding="0"
						cellspacing="0" background="images/sp_l_3401.jpg">
						<tr>
							<td width="178" height="68"><img src="images/sp_l_32.gif"
								alt="" width="178" height="68" border="0" usemap="#Map" />
							</td>
							<td width="132"><img src="images/sp_l_33.gif" alt=""
								width="132" height="68" border="0" usemap="#Map3" />
							</td>
							<td width="221"><img src="images/sp_l_34.gif" alt=""
								width="221" height="68" border="0" usemap="#Map2" />
							</td>
							<td><a href='loadFile.jsp'>控件下载</a>
								<div style="width:200px"></div></td>
							<td width="7"><img src="images/sp_m_03.gif" width="36"
								height="68" alt="" />
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>

	<map name="Map" id="Map">
		<area shape="circle" coords="35,23,13" onmousedown='f_up()'
			onmouseup='f_up_stop()' />
		<area shape="circle" coords="162,20,13" onmousedown='f_right()'
			onmouseup='f_right_stop()' />
		<area shape="circle" coords="133,21,13" onmousedown='f_left()'
			onmouseup='f_left_stop()' />
		<area shape="circle" coords="64,22,13" onmousedown='f_down()'
			onmouseup='f_down_stop()' />
		<area shape="circle" coords="98,35,16" onclick="javascript:f_stop()" />
	</map>
	<map name="Map2" id="Map2">
		<area shape="circle" coords="139,29,12"
			href="javascript:ChangeWindow(6)" alt="p6" title="p6" />
		<area shape="circle" coords="112,29,12"
			href="javascript:ChangeWindow(4)" alt="p4" title="p4" />
		<area shape="circle" coords="170,30,12"
			href="javascript:ChangeWindow(9)" alt="p9" title="p9" />
		<area shape="circle" coords="197,30,12"
			href="javascript:ChangeWindow(16)" alt="p16" title="p16" />
		<area shape="circle" coords="84,30,12"
			href="javascript:ChangeWindow(1)" alt="p1" title="p1" />

	</map>
	<map name="Map3" id="Map3">

		<area shape="circle" coords="112,31,13" onclick='javascript:f_lj()'
			alt="near" title="near" />
		<area shape="circle" coords="82,30,13" onclick='javascript:f_ly()'
			alt="far" title="far" />
	</map>
</body>
</html>

<script>
var loin_flag=false;

function f_login(){
	var ip = form1.ip.value;
    var port = form1.port.value;
    var user = form1.user.value;
    var pwd = form1.pwd.value; 
    var obj = sp_obj();
     
	obj.SetProxyNatInfo(1, 0, "", 0, "","");	
	var flag =  obj.ConnectToServer(ip,port,user,pwd);
    login_flag =flag;
	obj.SetPlayWindowStyle(true,4);
	obj.InitLocalRec(4);
	obj.SetLocalRecSavePath("D:\\temp");
	   
	if(login_flag==false){
		alert("登陆失败!");
	}else{
	    //alert(login_flag);
	   	load_sp_list();
	 }
}
  
function ytkz(flag){
   sp_obj().SendPtzCmd(flag);
}

function sp_obj(){
    return document.getElementById("spobj");
}

function f_stop(){
    sp_obj().StopPlay();
}
    
function f_stopall(){
    sp_obj().DisConnectToServer();
}
    
function f_up(){
   //alert('up');
  	ytkz(1);
}
   
function f_up_stop(){
    //alert('up stop');
	ytkz(6);
}
    
function f_down(){ytkz(2);}
    
   
function f_down_stop(){ytkz(6);}
    
function Sp_full(){
	sp_obj().PlayWndFullShow();
}

function f_left(){
    ytkz(3);
}
     
function f_left_top(){
    ytkz(6);
}
    
    
function f_right(){
     ytkz(4);
}
   
function f_right_stop(){
     ytkz(6);
}
    
function f_lj(){
    sp_obj().SendPtzCmd(7);
    sp_obj().SendPtzCmd(9);
}
    
function f_ly(){
    sp_obj().SendPtzCmd(8);
    sp_obj().SendPtzCmd(9);
}
      
function ChangeWindow(num){
   //sp_obj().WindowNum(num);
	sp_obj().SetPlayWindowStyle(true,num);
}
    
function f_play(){
	var obj = document.getElementById('sp_sb');
	//alert(obj);
	var index = obj.selectedIndex;
	//alert(index);
	if(index<0){return;}
	var s = obj.options[index].value;
	//alert(s);
	var puid,td;
	var arr=s.split(",");
	puid=arr[0];
	td=arr[1];
	var status = sp_obj().GetDeviceStatus(puid,td);
	if(status<=0){
		alert("当前设备不在线,不能请求视频!");
	}else{
      	sp_obj().StartPlay(puid,td);
    }
 }
    
function f_r(){
	form1.submit();
}
    
function load_sp_list(){
	var sp_list = document.getElementById("sp_sb");
	var sels = sp_list.childNodes;
	var num = sels.length-1;
	for(var i=1;i<num+1;i++){
		var sel = sels[i];
		var s = sel.value;
		var t = sel.text;
		var puid,td;
      	var arr=s.split(",");
      	puid=arr[0];
      	td=arr[1];
      	var status = sp_obj().GetDeviceStatus(puid,td);
      	if(status<=0&&t.indexOf("离线")<0)
      	{
      		sel.text = "[离线]"+t;
      	}
      	else if(status>0)
      	{
      		if(t.indexOf("离线")>=0)
      		{
      			t = t.split("[离线]")[1];
      		}
      		if(t.indexOf("在线")<0) 
      		{
      			sel.text = "[在线]"+t;
      		}
      	}
	}
}
    window.setInterval('load_sp_list()',5000);
</script>