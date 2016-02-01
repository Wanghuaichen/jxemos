<%@ page contentType="text/html;charset=GBK"%>
<%@page import="com.hoson.app.*"%>
<%@page import="com.hoson.*"%>
<%
  String site_url = "../site/zw_home.jsp";
  site_url = "../station_new/";
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<link href="/<%=JspUtil.getCtx(request)%>/styles/css.css" rel="stylesheet" type="text/css">

		<title></title>
		<style type="text/css">
A {COLOR: blue; TEXT-DECORATION: none;font-size: 9pt;border:0}
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->

.xx {

/* margin-top: 5px;*/
padding-top: 3px;
text-align:right;

 }

</style>
	</head>


	<body>
		<input type=hidden name="show_flag" value="1">

		<table width="100%" border="0" cellpadding="0" cellspacing="0">


			<tr name="top_logo_bg" id="top_logo_bg">
				<td height="31" colspan="2" valign="top">
					<div align="left">


						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td><img src="/<%=JspUtil.getCtx(request)%>/images/top.gif" width="100%" height="60"></td>
							</tr>
						</table>
					</div>
				</td>
			</tr>
			
			
			
			<tr>
				<td height=30px valign="top" background="/<%=JspUtil.getCtx(request)%>/images/top-bg.gif">
				<img src="/<%=JspUtil.getCtx(request)%>/images/top-ar.gif" width="570px" height="30">
				
				</td>
				
				
				<td valign="top" class=xx background="/<%=JspUtil.getCtx(request)%>/images/top-bg.gif">
					
				
							
								<a href="../map/index.jsp" target=middle onclick="f_swap_img(0)">
								<img src="/<%=JspUtil.getCtx(request)%>/images/button-zh0.gif" height="19" id="img1" border=0>
								</a> 
								
								<a href="<%=site_url%>" target=middle onclick="f_swap_img(1)">
								<img src="/<%=JspUtil.getCtx(request)%>/images/button-zw.gif" height="19" class=hand id="img2" border=0>
										</a> 
										
										<!--
										<a href="../check_all/index.jsp" target="middle" onclick="f_swap_img(2)">
										 <img src="/<%=JspUtil.getCtx(request)%>/images/button-she.gif"
										height="19" class=hand id="img3" border=0>
										</a>
										-->
										
										
										<a href="../system/" target=middle onclick="f_swap_img(3)">
										<img src="/<%=JspUtil.getCtx(request)%>/images/an_sx.gif" height="19" class=hand id="img4" border=0></a> <a href="javascript:f_logout()">
										<img src="/<%=JspUtil.getCtx(request)%>/images/button-tc.gif" height="19" class=hand id="img5" border=0></a> <a href="#"><img name="flex_img" src="/<%=JspUtil.getCtx(request)%>/images/flex2.gif" width="14" height="14" border="0"
										style="cursor:hand" onclick="f_show()">
										</a> 

                     <img width=20px height=0>
			<br>
					<img width=420px height=0>
				</td>
			</tr>
		</table>
		
		
		<script>
//------------
function f_swap_img(inum){
//alert("hello");

var i =0;
var num =0;
var obj = null;
var imgPath="/<%=JspUtil.getCtx(request)%>/images/";

var obj_ids = "img1,img2,img3,img4";
var click_res01 = "button-zh0.gif,button-zw0.gif,button-she0.gif,an_sx0.gif";
var unclick_res01 = "button-zh.gif,button-zw.gif,button-she.gif,an_sx.gif";


var arr_obj_ids = obj_ids.split(",");
var arr_click_res01 = click_res01.split(",");
var arr_unclick_res01 = unclick_res01.split(",");
num = arr_obj_ids.length;
//alert(num);
if(inum>=num){alert("索引超出资源数");return;}
if(arr_click_res01.length!=num || arr_unclick_res01.length!=num){
alert("资源数量不匹配");
return;
}

for(i=0;i<num;i++){
obj = document.getElementById(arr_obj_ids[i]);
if(inum==i){
obj.src=imgPath+arr_click_res01[i];
}else{
if(i<arr_unclick_res01.length && obj!=null)
{
obj.src=imgPath+arr_unclick_res01[i];
}
}
}//end for

}
//----------------------------
/*
function f_show(){
//alert("hello");
var show_flag = 0;

show_flag = document.all.show_flag.value;
//alert(show_flag);
if(show_flag>0){
document.all.top_logo_bg.style.display="none";
document.all.show_flag.value=0;
}else{
document.all.top_logo_bg.style.display="";
document.all.show_flag.value=1;
}

}
*/
//--------------

//----------------------------
function f_show(){

var imgPath="/<%=JspUtil.getCtx(request)%>/images/";

//alert("hello");
var show_flag = 0;
show_flag = document.all.show_flag.value;
//alert(show_flag);
if(show_flag>0){
//document.all.top_logo_bg.style.display="none";
//parent.parent.main.rows="0,30,*,0,0";
parent.parent.main.rows="30,*,0,0";
document.all.top_logo_bg.style.display="none";
document.all.show_flag.value=0;
document.all.flex_img.src=imgPath+"flex3.gif";
}else{
//document.all.top_logo_bg.style.display="";
parent.parent.main.rows="90,*,18,2";
document.all.top_logo_bg.style.display="block";
document.all.show_flag.value=1;
document.all.flex_img.src=imgPath+"flex2.gif";
}

}
//--------------
function f_logout(){
if(confirm("您确认要退出系统吗?")){
		window.location = "./logout.jsp";
	 }else{}
}
</script>