<%@ page contentType="text/html;charset=GBK"%>
<%@page import="java.sql.*,com.hoson.*,com.hoson.util.*,com.hoson.app.*,com.hoson.util.*,java.util.*"%>


<%

      // out.println(StringUtil.getNowTime());
          String url_exe = "hk.exe";
      Connection cn = null;
      String station_type = null;
      String area_id =null;
      String stationTypeOption = null;
      String areaOption = null;
      String spTypeOption = null;
      String sp_type = null;
      String top_area_id=App.get("area_id","33");
      String sp_user_name = "admin";
      String sp_user_pwd = "admin";
      String spOption = "";
      String sp_ctl_flag = "0";
      
      
      
      
      
      String sp_ip = App.get("sp_ip_hk","");
      String sp_port0 = App.get("sp_port_hk","");
      String sp_user0 = App.get("sp_user_hk","");
      String sp_pwd0= App.get("sp_pwd_hk","");
      String sql = null;
 
        
      String sp_port2="";
      String sp_user2 = "";
      String sp_pwd2="";
      
      String sp_port,sp_user,sp_pwd=null;
      
      
 
 
      Map map = null;
      Map row = null;
      int i,num,j,cnum=0;
      List list = null;
      
      String station_id,station_name = null;
      String s = "";
      String sptds = null;
      String[]sptdarr = null;
     cnum=3;
      try{
      
      station_type = f.p(request,"station_type",App.get("default_station_type","1"));
      area_id =     f.p(request,"area_id",top_area_id);
      sp_type=f.p(request,"sp_type","1");
      cn = DBUtil.getConn();
      sp_ctl_flag = f.getSpCtlFlag(request,cn);
    
      stationTypeOption = JspPageUtil.getStationTypeOption(cn,station_type);
      areaOption = JspPageUtil.getAreaOption(cn,area_id);
      spTypeOption = SpUtil.getSpTypeOption(cn,sp_type);
      
      sql = "select station_id,station_desc,station_ip,sp_port,sp_user,sp_pwd,sp_channel from t_cfg_station_info where station_type='"+station_type+"' and area_id like '"+area_id+"%' ";
      sql=sql+ DataAclUtil.getStationIdInString(request,station_type,"station_id");
      
      sql=sql+" order by area_id,station_desc";
      
      list = DBUtil.query(cn,sql,null);
      num=list.size();
      //out.println(num);
      for(i=0;i<num;i++){
      row=(Map)list.get(i);
      station_id = (String)row.get("station_id");
      station_name = (String)row.get("station_desc");
      sp_ip = (String)row.get("station_ip");
      //out.println(row);
      if(f.empty(sp_ip)){continue;}
      
      sp_port2=(String)row.get("sp_port");
      sp_user2=(String)row.get("sp_user");
      sp_pwd2=(String)row.get("sp_pwd");
      sptds = (String)row.get("sp_channel");
      
      if(f.empty(sptds)){continue;}
      sptdarr = sptds.split(",");
      cnum = sptdarr.length;
      
      
      if(sp_pwd2==null){sp_pwd2="";}
      
      
      
      sp_port=sp_port0;
       sp_user=sp_user0;
       sp_pwd=sp_pwd0;
       
       
      if(!f.empty(sp_user2)){
        sp_user=sp_user2;
        sp_pwd=sp_pwd2;
      }
      
      if(!f.empty(sp_port2)){
      sp_port=sp_port2;
      }
      
      
      
      //s = sp_ip+","+sp_port+","
      
      
      
      for(j=0;j<cnum;j++){
      //s = sp_ip+","+sp_port+","+(j+1)+",0,"+sp_user+","+sp_pwd+",101,";
      s = sp_ip+","+sp_port+","+sptdarr[j]+",0,"+sp_user+","+sp_pwd+",101,";
      
      //spOption = spOption+"<option value='"+s+"'>"+station_name+"_通道"+(j+1)+"</option>\n";
      spOption = spOption+"<option value='"+s+"'>"+station_name+"_通道"+sptdarr[j]+"</option>\n";
      }//end for j
      
      
      }//end for i
      
      
      
      }catch(Exception e){
      JspUtil.go2error(request,response,e);
      return;
      }finally{DBUtil.close(cn);}



%>






<HTML>
	<HEAD>
		<title>视频监控</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<link href="images/css.css" rel="stylesheet" type="text/css">
		<LINK href="../../../css/css.css" type="text/css" rel="stylesheet">
		<link rel="StyleSheet" href="js_tree/treeview.css" type="text/css">
		<link rel="StyleSheet" href="dtree.css" type="text/css">
		<script type="text/javascript" src="dtree.js"></script>
		<script type="text/javascript" src="js_tree/treeview.js"></script>
		<script language="javascript" src="../../../scripts/Common.js"></script>
		<style type="text/css">
			td{font-size:9pt}
		 <!-- body { background-color: #87b2dd; }
	--></style>
		
		<script type="text/JavaScript">
			<!--
			function MM_preloadImages() { //v3.0
			  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
			    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
			    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
			}
			
			function MM_swapImgRestore() { //v3.0
			  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
			}
			
			function MM_findObj(n, d) { //v4.01
			  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
			    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
			  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
			  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
			  if(!x && d.getElementById) x=d.getElementById(n); return x;
			}
			
			function MM_swapImage() { //v3.0
			  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
			   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
			}
			//-->	
		
			function ChangeWindow(lNum)
			{
				//Form1.dvrTest.SetPanelShow(lNum);
				//document.getElementById("tbxWinNumber").value = lNum;
				
				Form1.dvrTest.WindowNum(lNum);
				
 			} 
			
			function StartCaptureFile()
			{
				dt = new Date();
				var month=dt.getMonth() +1;
				var FileName = "t" +dt.getYear() + month + dt.getDate() +dt.getHours() +dt.getMinutes() +dt.getSeconds() +".mp4";
				Form1.dvrTest.StartCaptureFile(FileName,Form1.dvrTest.CurrentWindow);
			}
			
			function StopCapture()
			{
				Form1.dvrTest.StopCapture(Form1.dvrTest.CurrentWindow);
			}
			
			function ClientYTKZ(YTZDBM,cStop)
			{
			
			    sp_ctl_check();
				//Form1.dvrTest.ClientYTKZ(YTZDBM,cStop);
				var obj = Form1.dvrTest;
				if(YTZDBM==21 && cStop==1){obj.UpStop();}
				if(YTZDBM==21 && cStop==0){obj.Up();}
				
				if(YTZDBM==22 && cStop==1){obj.DownStop();}
				if(YTZDBM==22 && cStop==0){obj.Down();}	
				
				if(YTZDBM==23 && cStop==1){obj.LeftStop();}
				if(YTZDBM==23 && cStop==0){obj.Left();}	
				
				if(YTZDBM==24 && cStop==1){obj.RightStop();}
				if(YTZDBM==24 && cStop==0){obj.Right();}
				
				/*
				if(YTZDBM==11 && cStop==1){obj.FocusNearStop();}
				if(YTZDBM==11 && cStop==0){obj.FocusNear();}	
				
				if(YTZDBM==12 && cStop==1){obj.FocusFarStop();}
				if(YTZDBM==12 && cStop==0){obj.FocusFar();}
				*/
				if(YTZDBM==11 && cStop==1){obj.ZoomInStop();}
				if(YTZDBM==11 && cStop==0){obj.ZoomIn();}	
				
				if(YTZDBM==12 && cStop==1){obj.ZoomOutStop();}
				if(YTZDBM==12 && cStop==0){obj.ZoomOut();}
				
				
			}
			
			function StartAudio()
			{
				Form1.dvrTest.PlayAudio();
			}			

			function StopAudio()
			{
				Form1.dvrTest.StopAudio();
			}	

			function AddChannelInfo(BaseChannelInfo,sMulAddr,alarmState)
			{
				Form1.dvrTest.AddChannelInfo(BaseChannelInfo,sMulAddr,alarmState);
			}
			
			function LinkPlatform(PlatIP,PlatPort,PlatPlayPort)
			{
				Form1.dvrTest.LinkPlatform(PlatIP,PlatPort,PlatPlayPort);
			}
			
			function PlayLocalFile()
			{
				Form1.dvrTest.LocalPlay();
			}
			
			function AfreshPlay()
			{
				if(AfreshPlayState)
					Form1.dvrTest.AfreshPlay();
			}
			
			function CapturePicture()
			{
				Form1.dvrTest.CapturePicture("");
			}
			
			function StartPlay()
			{
				//Form1.dvrTest.EndPlay();
				Form1.dvrTest.StartPlay();
				Form1.dvrTest.SelectWindow(parseInt(selWinObj));//选中第一个窗口
			}
			
			function StopPlay()
			{
				//MM_preloadImages('images/sp_ico_up0.png','images/sp_ico_base0.png','images/sp_ico_left0.png','images/sp_ico_right0.png');
				//ClearChannelsInfo();
				//Form1.dvrTest.EndPlay();
				
				Form1.dvrTest.Stop();
				
			}
			
			function ClearChannelsInfo()
			{
				Form1.dvrTest.ClearChannelsInfo();
				document.getElementById("tbxInitValue").value = "";
				document.getElementById("tbxWinNumber").value = "";
			}			

			function RemoteConfig(dvsip,port,user,passwd)
			{
				Form1.dvrTest.RemoteConfig(dvsip,port,user,passwd);
			}	

			function VoiceChat(dvsip,port,user,passwd)
			{
				Form1.dvrTest.StartVoice(dvsip,port,user,passwd);
			}
			
			var selWinObj = 0;
			
			function addplayinfo() 
			{
				if(selTitle ==null || selTitle == '')
				{
					alert("请选择要播放的通道！")
				}
				else
				{
					
					
					selWinObj = Form1.dvrTest.CurrentWindow;
					var s = selTitle;
					s = s + Form1.dvrTest.CurrentWindow+","; //当前窗口
					
					//ClearChannelsInfo();
					
					AddChannelInfo(s,'',true);
					document.getElementById("tbxInitValue").value = document.getElementById("tbxInitValue").value+s+"-";
					StartPlay();
					
					
				}
			}
			
			function f_stopall(){
			   Form1.dvrTest.StopAll();
			}
			
			function show_sp(objInput)
			{
			
			    var i = objInput.selectedIndex;
			    if(i<0){return;}
				s = objInput.options[i].value;
				
				/*
				s = s + Form1.dvrTest.CurrentWindow+","; //当前窗口
					
				AddChannelInfo(s,'',true);
					
				//document.getElementById("tbxInitValue").value = document.getElementById("tbxInitValue").value+s+"-";
					selWinObj = Form1.dvrTest.CurrentWindow;
				StartPlay();
				*/
				var arr = s.split(",");
				//Form1.dvrTest.Add(0,arr[0],arr[1],arr[],8000,1);
				// hsctl.Add(0,"192.168.1.240","admin","12345",8000,1);
				//short Add(short iWndIndex, LPCTSTR sIP, LPCTSTR sUser, LPCTSTR sPass, short iPort, short iChl); 
				//(停加一个视频,iWndIndex为窗口编号从０开始)
				//<option value='192.168.1.240,8000,1,0,admin,12345,101,'>富阳渔山_通道1</option>
               // <option value='192.168.1.240,8000,2,0,admin,12345,101,'>富阳渔山_通道2</option>
				
				//Form1.dvrTest.Add(0,arr[0],arr[4],arr[5],arr[1],arr[2]);
				//AddActive
				Form1.dvrTest.AddActive(arr[0],arr[4],arr[5],arr[1],arr[2]);
				
				
			}
			
			
			
			function saveInit()
			{
				if(document.getElementById("tbxInitValue").value != "")
				{
					SetCookie("fullHCNetView",document.getElementById("tbxInitValue").value);
				}
				if(document.getElementById("tbxWinNumber").value != "")
				{			
					SetCookie("fullHCNetViewWinNumber",document.getElementById("tbxWinNumber").value);
				}
			}
			
			function InitObjSize()
			{
				var objWidth = Form1.dvrTest.offsetWidth;
				var objHeight = Form1.dvrTest.offsetHeight;
				var objBodyHeight = parseInt(window.document.body.offsetHeight);
				var objBodyWidth = parseInt(window.document.body.offsetWidth);

				if(parseInt((objBodyWidth * 407) / 627) > parseInt(objBodyHeight))
				{
					Form1.dvrTest.style.width = (parseInt(627 * objBodyHeight /407) - 10).toString()+"px";
				}
				else
				{
					Form1.dvrTest.style.height = (parseInt(objBodyWidth * 407 / 627) - 20).toString()+"px";
				}
            }			
            </script>
		<style type="text/css">
				<!--
				#control1 {
					border: 1px solid #0066CC;
					padding-bottom: 5px;
				}
				#control2 {
					background-image: url(img/dot_bg.gif);
					border-top-width: 1px;
					border-right-width: 1px;
					border-bottom-width: 1px;
					border-left-width: 1px;
					border-top-style: solid;
					border-right-style: solid;
					border-bottom-style: solid;
					border-left-style: solid;
					border-top-color: #FFFFFF;
					border-right-color: #0066CC;
					border-bottom-color: #0066CC;
					border-left-color: #0066CC;
				}
				#list {
					height: 205px;
					border-right-width: 1px;
					border-bottom-width: 1px;
					border-left-width: 1px;
					border-right-style: solid;
					border-bottom-style: solid;
					border-left-style: solid;
					border-right-color: #0066CC;
					border-bottom-color: #0066CC;
					border-left-color: #0066CC;
					background-image: url(img/list_bg.gif);
					background-repeat: repeat-x;
					padding-top: 0px;
				}
				#listhead {
					height: 22px;
					border-top-width: 1px;
					border-top-style: solid;
					border-top-color: #FFFFFF;
					background-image: url(img/List_Head_BG.JPG);
					border-bottom-width: 1px;
					border-bottom-style: solid;
					border-bottom-color: #0066CC;
				}
				body {
					margin: 0px;
					padding: 0px;
				}
				-->
			</style>
	</HEAD>
	<body  onLoad="MM_preloadImages('images/sp_ico_up0.png','images/sp_ico_base0.png','images/sp_ico_left0.png','images/sp_ico_right0.png');" leftMargin="0" topMargin="0" MS_POSITIONING="GridLayout" onunload="f_stopall()">
		<div style="width:100%;height:100%;BACKGROUND-IMAGE: url(img/conral_bg_new.jpg)">
			<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
				<tr>
					<td style="width:70%;height:100%" id="tdObj" align="left" valign="top">
						<form id="Form1" method="post">
						<!--
							<OBJECT id="dvrTest"
								data="data:application/x-oleobject;base64,KxvzI6tkz0aEGL73q69Nc1RQRjALVGZybU1QNFBsYXkKZnJtTVA0UGxheQRMZWZ0A9sAA1RvcAOXAAVXaWR0aAOgAgZIZWlnaHQD+AEFQ29sb3IEAP9AAAxGb250LkNoYXJzZXQHDkdCMjMxMl9DSEFSU0VUCkZvbnQuQ29sb3IHDGNsV2luZG93VGV4dAtGb250LkhlaWdodAL0CUZvbnQuTmFtZRICAAAAi1tTTwpGb250LlN0eWxlCwAOT2xkQ3JlYXRlT3JkZXIIDVBpeGVsc1BlckluY2gCYApUZXh0SGVpZ2h0AgwAAA=="
								classid="CLSID:23F31B2B-64AB-46CF-8418-BEF7ABAF4D73" style="width:100%;height:100%" VIEWASTEXT>
							</OBJECT>
							-->
							<!--
							<OBJECT id="dvrTest" data="data:application/x-oleobject;base64,KxvzI6tkz0aEGL73q69Nc1RQRjALVGZybU1QNFBsYXkKZnJtTVA0UGxheQRMZWZ0A9sAA1RvcAOXAAVXaWR0aAOgAgZIZWlnaHQD+AEFQ29sb3IEAP9AAAxGb250LkNoYXJzZXQHDkdCMjMxMl9DSEFSU0VUCkZvbnQuQ29sb3IHDGNsV2luZG93VGV4dAtGb250LkhlaWdodAL0CUZvbnQuTmFtZRICAAAAi1tTTwpGb250LlN0eWxlCwAOT2xkQ3JlYXRlT3JkZXIIDVBpeGVsc1BlckluY2gCYApUZXh0SGVpZ2h0AgwAAA=="
								classid="CLSID:23F31B2B-64AB-46CF-8418-BEF7ABAF4D73" style="width:100%;height:100%"
								VIEWASTEXT>
								
							</OBJECT>
							
							-->
							
							<OBJECT id='dvrTest' classid="clsid:778A37F1-5B7A-4AFF-8181-541DA195E30F" style="width:100%;height:100%">
							</object>
							
							
							
							<input id="serverip" type=hidden value='' name="serverip">
							<input id="iChannel" type="hidden" name="iChannel" value="0">
							<input id="port" type=hidden value='8000' name="port">
							<input id="userID" type=hidden value='admin' name="userID">
							<input id="userPwd" type=hidden value='12345' name="userPwd">
						</form>
					</td>
					<td style="width:30%;align:left;text-align:center;valign:top" valign="top" id="tdControl">
						<!--div id="control1"-->
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td>
								</td>
								<td></td>
								<td align="center">
									<img src="img/con_top.gif" style="WIDTH:44px;CURSOR:hand;HEIGHT:35px" border="0" id="btnUp" name="btnUp" title="向上" onmousedown="ClientYTKZ(21,0)" onmouseup="ClientYTKZ(21,1)" onmouseover="MM_swapImage('btnUp','','img/y_top2.gif',1)"
										onmouseout="MM_swapImgRestore()">
								</td>
								<td align="right" noWrap>
									<img src="img/big2.gif" title="镜头拉近" onmousedown="ClientYTKZ(11,0)" onmouseup="ClientYTKZ(11,1)" style="WIDTH:25px;CURSOR:hand;HEIGHT:24px" border="0">
								</td>
								<td align="right">
									<img src="img/focusout2.gif" onmousedown="ClientYTKZ(16,0)" onmouseup="ClientYTKZ(16,1)" style="WIDTH:41px;CURSOR:hand;HEIGHT:20px" border="0" alt="散焦">
								</td>
								<td>
								</td>
							</tr>
							<tr>
								<td>
								</td>
								<td noWrap align="right">
									<img src="img/con_left.gif" style="WIDTH:35px;CURSOR:hand;HEIGHT:43px" height="38" border="0" name="btnLeft" id="btnLeft" title="向左" onmousedown="ClientYTKZ(23,0)" onmouseup="ClientYTKZ(23,1)"
										onmouseover="MM_swapImage('btnLeft','','img/con_left2.gif',1)" onmouseout="MM_swapImgRestore()">
								</td>
								<td align="center" noWrap>
									<img src="img/con_middle.gif" style="WIDTH:44px;CURSOR:hand;HEIGHT:43px" id="btnStop" onclick="StopPlay();" title="断开">
								</td>
								<td align="left">
									<img src="img/con_right.gif" style="WIDTH:35px;CURSOR:hand;HEIGHT:43px" name="btnRight" border="0" id="btnRight" title="向右" onmousedown="ClientYTKZ(24,0)" onmouseup="ClientYTKZ(24,1)"
										onmouseover="MM_swapImage('btnRight','','img/con_right2.gif',1)" onmouseout="MM_swapImgRestore()">
								</td>
								<td align="right">
									<img style="display:none" src="img/auto2.gif" style="WIDTH:41px;CURSOR:hand;HEIGHT:20px" height="35" border="0" alt="自动对焦">
								</td>
								<td>
								</td>
							</tr>
							<tr>
								<td>
								</td>
								<td></td>
								<td align="center">
									<img src="img/con_down.gif" style="WIDTH:44px;CURSOR:hand;HEIGHT:36px" border="0" name="btnDown" id="btnDown" onmousedown="ClientYTKZ(22,0)" onmouseup="ClientYTKZ(22,1)" onmouseover="MM_swapImage('btnDown','','img/con_down2.gif',1)"
										onmouseout="MM_swapImgRestore()">
								</td>
								<td align="right">
									<img src="img/small2.gif" title="镜头拉远" onmousedown="ClientYTKZ(12,0)" onmouseup="ClientYTKZ(12,1)" style="WIDTH:25px;CURSOR:hand;HEIGHT:24px" border="0">
								</td>
								<td align="right">
									<img src="img/focus2.gif" onmousedown="ClientYTKZ(15,0)" onmouseup="ClientYTKZ(15,1)" style="cursor:hand;WIDTH:41px;HEIGHT:20px" border="0" alt="聚焦" width="37">
								</td>
								<td>
								</td>
							</tr>
						</table>
						<!--/div-->
						<div id="control2" style="TEXT-ALIGN:center">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td width="36">
										<img src="img/screen_one.gif" onclick="ChangeWindow(1)" style="cursor:hand;WIDTH:35px;CURSOR:hand;HEIGHT:34px" border="0" alt="单屏">
									</td>
									<td width="36">
										<img src="img/screen_four.gif" onclick="ChangeWindow(4)" style="cursor:hand;WIDTH:36px;CURSOR:hand;HEIGHT:34px" border="0" alt="四屏">
									</td>
									<td width="36">
										<img src="img/screen_six.gif" onclick="ChangeWindow(6)" style="cursor:hand;WIDTH:36px;CURSOR:hand;HEIGHT:34px" border="0" alt="六屏">
									</td>
									<td width="36">
										<img src="img/screen_nine.gif" onclick="ChangeWindow(9)" style="cursor:hand;WIDTH:36px;CURSOR:hand;HEIGHT:34px" border="0" alt="九屏">
									</td>
									<td width="36">
										<img src="img/scre_sixteenen.gif" onclick="ChangeWindow(16)" style="cursor:hand;WIDTH:36px;CURSOR:hand;HEIGHT:34px" border="0" alt="十六屏">
									</td>
								</tr>
							</table>
						</div>
						<div id="control33" style="valign:top">
							<div id="listhead" style="text-align:center;valign:middle">
								<table width="100%" cellpadding="0" cellspacing="0" border="0">
									<tr>
										<td align="left" width="30%">
											<img style="width:7px;height:26px;" src="img/List_Head_Left.JPG" border="0">
										</td>
										<td align="center" valign="middle" width="30%">
											<img style="width:104px;height:16px;" src="img/listhead_logo.JPG" border="0">
										</td>
										<td align="right" width="30%">
											<img style="width:7px;height:26px;" src="img/List_Head_Right.JPG" border="0">
										</td>
									</tr>
								</table>
							</div>
							
								
								
								
								<form name="form2" id="Form2">
									
									<select name=station_type onchange=r()>
									<%=stationTypeOption%>
									</select>
									
									<select name=area_id onchange=r()>
									<option value=<%=top_area_id%>>全部</option>
									<%=areaOption%>
									</select>
									
									<select name=sp_type  onchange=r() style="display:yes">
									<%=spTypeOption%>
									</select>
									
									
									
									
									
								</form>
								
								
								
								<select size=18 style="width:270px" onchange=show_sp(this)>
								<%=spOption%>
								
								</select>
								
								
								
								
						
							<div style="width:100%;text-align:center">
								<a href="<%=url_exe%>"><font color="red">视频控件下载</font></a>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<input type="hidden" id="tbxInitValue" width="100%" NAME="tbxInitValue" />
		<input type="hidden" id="tbxWinNumber" NAME="tbxWinNumber" />
		<script language="javascript">
			var objfullHCNetView = GetCookie("fullHCNetView");
			var objfullHCNetViewWinNumber = GetCookie("fullHCNetViewWinNumber");
			if(objfullHCNetView != "" && objfullHCNetView != null)
			{
				document.getElementById("tbxInitValue").value = objfullHCNetView;
				var aryView = new Array();
				aryView = objfullHCNetView.split("-");
				
				for(var i = 0; i < aryView.length-1; i ++)
				{
					if(aryView[i] != "")
					AddChannelInfo(aryView[i],'',true);
				}
				if(aryView.length > 16)
				{
					document.getElementById("tbxInitValue").value = "";
					for(var i = aryView.length - 1; i > aryView.length - 16; i --)
					{
						document.getElementById("tbxInitValue").value += aryView[i]+"-";
					}
				}
			}
			
			if(objfullHCNetViewWinNumber != "" && objfullHCNetView != null)
			{
				document.getElementById("tbxWinNumber").value = objfullHCNetViewWinNumber;
				document.getElementById("btnCols").focus();
				ChangeWindow(parseInt(objfullHCNetViewWinNumber));
			}

			ChangeWindow(4);
		</script>
	</body>
</HTML>

<script>
function r(){
form2.action="sp_list.jsp";
form2.submit();
}

function sp_ctl_check(){
var flag = "<%=sp_ctl_flag%>";
if(flag=="1"){return;}
alert("没有视频控制权限");
var s = null;
s.x;

}


</script>