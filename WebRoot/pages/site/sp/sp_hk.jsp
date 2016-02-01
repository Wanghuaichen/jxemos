<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.hoson.action.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.hoson.*"%>
<%@page import="com.hoson.app.*"%>
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
						<%		
			String strIP = "";			
			String js = null;
			String sql = null;
			String option = null;
			String station_type = null;
			String userID = "";
			String pwd = "";
			String port  = "";
			
			if(request.getParameter("station_id") != null && request.getParameter("station_id") != "")
			{
				ViewHCNetViewActiveX_action vva = new ViewHCNetViewActiveX_action(request);
				strIP = vva.getIP();
			}
			int tree_type = JspUtil.getInt(request, "tree_type", 0);
			if (tree_type < 0 || tree_type > 1) {
				tree_type = 0;
			}
			String treeTypeRadioBox = null;
			String target = "";

			String url = "";
			treeTypeRadioBox = App.getRadioBox("0,1", "地区,流域", "tree_type",
					tree_type + "", "form1.submit()", "  ");
			try {
				station_type = request.getParameter("station_type");
				if (station_type == null) {
					station_type = App.getDefStationId(request);
				}
				sql = App.getTreeSql(request);

				option = JspUtil.getOption(sql, station_type, request);
				userID = "admin";
				pwd = "12345";
				port = "8000";
				if (tree_type == 0) {
					js = SiteTree.getAreaAndSiteTreeSP(station_type, url,
							target, request, userID, pwd, port);
				} else {
					js = LyTree.getAreaAndSiteTreeSP(station_type, url, target,
							request, userID, pwd, port);
				}
			} catch (Exception e) {
				//out.println(e);
				JspUtil.go2error(request,response,e);
				return;
			}
%>
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
				Form1.dvrTest.SetPanelShow(lNum);
				document.getElementById("tbxWinNumber").value = lNum;
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
				Form1.dvrTest.ClientYTKZ(YTZDBM,cStop);
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
				Form1.dvrTest.EndPlay();
				Form1.dvrTest.StartPlay();
				Form1.dvrTest.SelectWindow(1);//选中第一个窗口
			}
			
			function StopPlay()
			{
				MM_preloadImages('images/sp_ico_up0.png','images/sp_ico_base0.png','images/sp_ico_left0.png','images/sp_ico_right0.png');
				Form1.dvrTest.EndPlay();
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

			function showtext() 
			{
				var cn = d.aNodes[d.selectedNode];  //显示当前选中节点的文字   
				alert(cn.name); //选择的节点索引
			}
				
			function addplayinfo() 
			{
				if(selTitle ==null || selTitle == '')
				{
					alert("请选择要播放的通道！")
				}
				else
				{
					var s = selTitle;
					s = s + Form1.dvrTest.CurrentWindow+","; //当前窗口
					
					AddChannelInfo(s,'',true);
					
					document.getElementById("tbxInitValue").value = document.getElementById("tbxInitValue").value+s+"-";
					
					StartPlay();
				}			   
			}
				
			function showtext() 
			{
				var cn = d.aNodes[d.selectedNode];  //显示当前选中节点的文字 		   
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
			
			/*
			function InitObjSize()
			{
				var objWidth = Form1.dvrTest.offsetWidth;
				var objHeight = Form1.dvrTest.offsetHeight;
				var objBodyHeight = window.document.body.offsetHeight;
				var objBodyWidth = window.document.body.offsetWidth;
				if(parseInt(objBodyWidth) > parseInt(objBodyHeight))
				{
					Form1.dvrTest.style.width = objBodyHeight+"px";
				}
				else
				{ 
					Form1.dvrTest.style.height = objBodyWidth+"px";
				}
			}
			*/
			
			function InitObjSize()
			{
				var objWidth = Form1.dvrTest.offsetWidth;
				var objHeight = Form1.dvrTest.offsetHeight;
				var objBodyHeight = parseInt(window.document.body.offsetHeight);
				var objBodyWidth = parseInt(window.document.body.offsetWidth);

				if(parseInt((objBodyWidth * 407) / 627) < parseInt(objBodyHeight))
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
			--></style>
	</HEAD>
	<body onLoad="MM_preloadImages('images/sp_ico_up0.png','images/sp_ico_base0.png','images/sp_ico_left0.png','images/sp_ico_right0.png');" leftMargin="0" onunload="StopPlay();" 

topMargin="0" MS_POSITIONING="GridLayout">
		<div style="width:100%;height:100%;BACKGROUND-IMAGE: url(img/conral_bg_new.jpg)">
			<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
				<tr>
					<td style="width:70%;height:100%" id="tdObj" align="left" valign="top">
						<form id="Form1" method="post">
							<OBJECT id="dvrTest" data="data:application/x-oleobject;base64,KxvzI6tkz0aEGL73q69Nc1RQRjALVGZybU1QNFBsYXkKZnJtTVA0UGxheQRMZWZ0A9sAA1RvcAOXAAVXaWR0aAOgAgZIZWlnaHQD+AEFQ29sb3IEAP9AAAxGb250LkNoYXJzZXQHDkdCMjMxMl9DSEFSU0VUCkZvbnQuQ29sb3IHDGNsV2luZG93VGV4dAtGb250LkhlaWdodAL0CUZvbnQuTmFtZRICAAAAi1tTTwpGb250LlN0eWxlCwAOT2xkQ3JlYXRlT3JkZXIIDVBpeGVsc1BlckluY2gCYApUZXh0SGVpZ2h0AgwAAA=="
								classid="CLSID:23F31B2B-64AB-46CF-8418-BEF7ABAF4D73" style="width:100%;height:100%" VIEWASTEXT>
							</OBJECT>
							<input id="serverip" type=hidden value='<%=strIP%>' name="serverip"> <input id="iChannel" type="hidden" name="iChannel" value="0">
							<input id="port" type=hidden value='<%=port%>' name="port"> <input id="userID" type=hidden value='<%=userID%>' name="userID">
							<input id="userPwd" type=hidden value='<%=pwd%>' name="userPwd">
						</form>
					</td>
					<td style="width:30%;align:left;text-align:center;valign:top" valign="top" id="tdControl">
						<!--div id="control1"-->
							<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td> </td>
									<td></td>
									<td align="center"><img src="img/con_top.gif" style="WIDTH:44px;CURSOR:hand;HEIGHT:35px" border="0" id="btnUp"
											name="btnUp" title="向上" onmousedown="ClientYTKZ(21,0)" onmouseup="ClientYTKZ(21,1)" onmouseover="MM_swapImage('btnUp','','img/y_top2.gif',1)"
											onmouseout="MM_swapImgRestore()"></td>
									<td align="right" noWrap><img src="img/big2.gif" title="镜头拉近" onmousedown="ClientYTKZ(11,0)" onmouseup="ClientYTKZ(11,1)"
											style="WIDTH:25px;CURSOR:hand;HEIGHT:24px" border="0"></td>
									<td align="right">    <img src="img/focusout2.gif" onmousedown="ClientYTKZ(16,0)" onmouseup="ClientYTKZ(16,1)"
											style="WIDTH:41px;CURSOR:hand;HEIGHT:20px" border="0" alt="散焦"></td>
									<td> </td>
								</tr>
								<tr>
									<td> </td>
									<td noWrap align="right"><img src="img/con_left.gif" style="WIDTH:35px;CURSOR:hand;HEIGHT:43px" height="38" border="0"
											name="btnLeft" id="btnLeft" title="向左" onmousedown="ClientYTKZ(23,0)" onmouseup="ClientYTKZ(23,1)" onmouseover="MM_swapImage('btnLeft','','img/con_left2.gif',1)"
											onmouseout="MM_swapImgRestore()"></td>
									<td align="center" noWrap><img src="img/con_middle.gif" style="WIDTH:44px;CURSOR:hand;HEIGHT:43px" id="btnStop"
											onclick="StopPlay();" title="断开"></td>
									<td align="left"><img src="img/con_right.gif" style="WIDTH:35px;CURSOR:hand;HEIGHT:43px" name="btnRight"
											border="0" id="btnRight" title="向右" onmousedown="ClientYTKZ(24,0)" onmouseup="ClientYTKZ(24,1)"
											onmouseover="MM_swapImage('btnRight','','img/con_right2.gif',1)" onmouseout="MM_swapImgRestore()"></td>
									<td align="right">    <img style="display:none" src="img/auto2.gif" style="WIDTH:41px;CURSOR:hand;HEIGHT:20px" 
											height="35" border="0" alt="自动对焦"></td>
									<td> </td>
								</tr>
								<tr>
									<td> </td>
									<td></td>
									<td align="center"><img src="img/con_down.gif" style="WIDTH:44px;CURSOR:hand;HEIGHT:36px" border="0" name="btnDown"
											id="btnDown" onmousedown="ClientYTKZ(22,0)"	onmouseup="ClientYTKZ(22,1)" onmouseover="MM_swapImage('btnDown','','img/con_down2.gif',1)"
											onmouseout="MM_swapImgRestore()"></td>
									<td align="right"><img src="img/small2.gif" title="镜头拉远" onmousedown="ClientYTKZ(12,0)"	onmouseup="ClientYTKZ(12,1)"
											style="WIDTH:25px;CURSOR:hand;HEIGHT:24px" border="0"></td>
									<td align="right">    <img src="img/focus2.gif" onmousedown="ClientYTKZ(15,0)" onmouseup="ClientYTKZ(15,1)" style="cursor:hand;WIDTH:41px;HEIGHT:20px"
											border="0" alt="聚焦" width="37"></td>
									<td> </td>
								</tr>
							</table>
						<!--/div-->
						<div id="control2" style="TEXT-ALIGN:center">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td width="36">
										<img src="img/screen_one.gif" onclick="ChangeWindow(1)" style="cursor:hand;WIDTH:35px;CURSOR:hand;HEIGHT:34px"
											border="0" alt="单屏">
									</td>
									<td width="36">
										<img src="img/screen_four.gif" onclick="ChangeWindow(4)" style="cursor:hand;WIDTH:36px;CURSOR:hand;HEIGHT:34px"
											border="0" alt="四屏">
									</td>
									<td width="36">
										<img src="img/screen_six.gif" onclick="ChangeWindow(6)" style="cursor:hand;WIDTH:36px;CURSOR:hand;HEIGHT:34px"
											border="0" alt="六屏">
									</td>
									<td width="36">
										<img src="img/screen_nine.gif" onclick="ChangeWindow(9)" style="cursor:hand;WIDTH:36px;CURSOR:hand;HEIGHT:34px"
											border="0" alt="九屏">
									</td>
									<td width="36">
										<img src="img/scre_sixteenen.gif" onclick="ChangeWindow(16)" style="cursor:hand;WIDTH:36px;CURSOR:hand;HEIGHT:34px"
											border="0" alt="十六屏">
									</td>
								</tr>
							</table>
						</div>
						<div id="control33" style="valign:top">
							<div id="listhead" style="text-align:center;valign:middle">
								<table width="100%" cellpadding="0" cellspacing="0" border="0">
									<tr>
										<td align="left" width="30%"><img style="width:7px;height:26px;" src="img/List_Head_Left.JPG" border="0"></td>
										<td align="center" valign="middle" width="30%"><img style="width:104px;height:16px;" src="img/listhead_logo.JPG" border="0"></td>
										<td align="right" width="30%"><img style="width:7px;height:26px;" src="img/List_Head_Right.JPG" border="0"></td>
									</tr>
								</table>
							</div>
							<div style="width;100%;height:300px;OVERFLOW:auto;text-align:left;valign:top" id="list"
								onresize="InitObjSize();">
								<%
									if(request.getParameter("station_id") != null && request.getParameter("station_id") != "")
									{
								%>

<!--
								<script type="text/javascript">
										d = new dTree('d');
										d.add(0,-1,'浙江省');
										d.add(1,0,document.getElementById("serverip").value,'#0');
										d.add(2,1,'1','#',document.getElementById("serverip").value+','+document.getElementById("port").value+',1,0,'+document.getElementById("userID").value+','+document.getElementById("userPwd").value+',101,');
										d.add(2,1,'2','#',document.getElementById("serverip").value+','+document.getElementById("port").value+',2,0,'+document.getElementById("userID").value+','+document.getElementById("userPwd").value+',101,');
										d.add(2,1,'3','#',document.getElementById("serverip").value+','+document.getElementById("port").value+',3,0,'+document.getElementById("userID").value+','+document.getElementById("userPwd").value+',101,');
										document.write(d);
								</script>
-->
<script type="text/javascript">
										d = new TreeView('d','node0');
										d.add('node33','node0','浙江省');
										d.add('node33001','node33',document.getElementById("serverip").value,'',false,false,'./js_tree/image/close.gif','./js_tree/image/open.gif');
										d.add2('node3300101','node33001','1','#',document.getElementById("serverip").value+','+document.getElementById("port").value+',1,0,'+document.getElementById("userID").value+','+document.getElementById("userPwd").value+',101,',false,true,'','','','');
										d.add2('node3300102','node33001','2','#',document.getElementById("serverip").value+','+document.getElementById("port").value+',2,0,'+document.getElementById("userID").value+','+document.getElementById("userPwd").value+',101,',false,true,'','','','');
										d.add2('node3300103','node33001','3','#',document.getElementById("serverip").value+','+document.getElementById("port").value+',3,0,'+document.getElementById("userID").value+','+document.getElementById("userPwd").value+',101,',false,true,'','','','');
										document.write(d);
								</script>


								<%
									}
									else
									{
								%>
								<form name="form2" ID="Form2">
									<select name="station_type" onchange="form2.submit()" ID="Select1">
										<%=option%>
									</select>
									<div>
										<script type="text/javascript">										
												<%=js%>
										</script>
									</div>
								</form>
								<%}%>
							</div>
							<div style="width:100%;text-align:center">
								<a href="Videosetup.exe"><font color="red">视频控件下载</font></a>
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

			//InitObjSize();
			
                                ChangeWindow(4);
		</script>
	</body>
</HTML>