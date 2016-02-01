<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.hoson.action.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="com.hoson.*"%>
<%@page import="com.hoson.util.*"%>
<%@page import="com.hoson.app.*"%>
<%

    	String url_exe = "Videosetup.exe";
      String sp_ip = App.get("sp_ip_hk","");
      String sp_port = App.get("sp_port_hk","");
      String sp_user = App.get("sp_user_hk","");
      String sp_pwd= App.get("sp_pwd_hk","");
      
      String sp_port2="";
      String sp_user2 = "";
      String sp_pwd2="";
      
      
      String sql = null;
      Connection cn = null;
      Map map = null;
      String station_id = request.getParameter("station_id");
      try{
      
      if(f.empty(station_id)){
      throw new Exception("请选择一个站位");
      }
      cn = DBUtil.getConn();
      sql = "select station_ip,sp_port,sp_user,sp_pwd from t_cfg_station_info where station_id='"+station_id+"'";
      map = DBUtil.queryOne(cn,sql,null);
      if(map==null){
      sp_ip="";
      }else{
      sp_ip=(String)map.get("station_ip");
      sp_port2 = (String)map.get("sp_port");
      sp_user2 = (String)map.get("sp_user");
       sp_pwd2 = (String)map.get("sp_pwd");
       if(sp_pwd2==null){sp_pwd2="";}
      }
      
      if(f.empty(sp_ip)){
      throw new Exception("该站位没有视频");
      }
      
      
      if(!f.empty(sp_user2)){
        sp_user=sp_user2;
        sp_pwd=sp_pwd2;
      }
      
      if(!f.empty(sp_port2)){
      sp_port=sp_port2;
      }
      
      
      }catch(Exception e){
      JspUtil.go2error(request,response,e);
      return;     
      }finally{DBUtil.close(cn);}
      
      
      
      
      
      
      
      
               
%>



<HTML>
	<HEAD>
		<title>视频</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<link href="images/css.css" rel="stylesheet" type="text/css">
		<LINK href="../../../css/css.css" type="text/css" rel="stylesheet">
		<link rel="StyleSheet" href="js_tree/treeview.css" type="text/css">
		<link rel="StyleSheet" href="dtree.css" type="text/css">
		<script type="text/javascript" src="dtree.js"></script>
		<script type="text/javascript" src="js_tree/treeview.js"></script>
		<script language="javascript" src="../../../scripts/Common.js"></script>
		<style type="text/css">
			<!-- body { background-color: #87b2dd; }
	-->
			td{font-size:9pt}
		</style>
		
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
				//MM_preloadImages('images/sp_ico_up0.png','images/sp_ico_base0.png','images/sp_ico_left0.png','images/sp_ico_right0.png');
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
				
			var channel = 1;
			
			function addplayinfo() 
			{	
				var s = document.getElementById("serverip").value+','+document.getElementById("port").value+','+channel+',0,'
					+document.getElementById("userID").value+','+document.getElementById("userPwd").value+',101,';
				s = s + Form1.dvrTest.CurrentWindow+","; //当前窗口
				AddChannelInfo(s,'',true);
				StartPlay();		   
			}
			
			function selChannel(objInput)
			{
				channel = objInput;
				addplayinfo();
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
	<body onLoad="MM_preloadImages('images/sp_ico_up0.png','images/sp_ico_base0.png','images/sp_ico_left0.png','images/sp_ico_right0.png');"
		leftMargin="0" topMargin="0" MS_POSITIONING="GridLayout" onunload="StopPlay();">
		<div style="width:100%;height:100%;BACKGROUND-IMAGE: url(img/conral_bg_new.jpg)">
			<input type ="button" onclick ="addplayinfo();" value ="播放视频" style="display:none">
			<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
				<tr>
					<td height="20px">
						<a style="cursor:hand" onclick="selChannel('1');">通道1</a>&nbsp;
						<a style="cursor:hand" onclick="selChannel('2');">通道2</a>&nbsp;
						<a style="cursor:hand" onclick="selChannel('3');">通道3</a>
						
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<a href="<%=url_exe%>"><font color="red">控件下载</font></a>
						
					</td>
				</tr>
				<tr>
					<td style="width:100%;" id="tdObj" align="left" valign="top">
						<form id="Form1" method="post">
							<OBJECT id="dvrTest" data="data:application/x-oleobject;base64,KxvzI6tkz0aEGL73q69Nc1RQRjALVGZybU1QNFBsYXkKZnJtTVA0UGxheQRMZWZ0A9sAA1RvcAOXAAVXaWR0aAOgAgZIZWlnaHQD+AEFQ29sb3IEAP9AAAxGb250LkNoYXJzZXQHDkdCMjMxMl9DSEFSU0VUCkZvbnQuQ29sb3IHDGNsV2luZG93VGV4dAtGb250LkhlaWdodAL0CUZvbnQuTmFtZRICAAAAi1tTTwpGb250LlN0eWxlCwAOT2xkQ3JlYXRlT3JkZXIIDVBpeGVsc1BlckluY2gCYApUZXh0SGVpZ2h0AgwAAA=="
								classid="CLSID:23F31B2B-64AB-46CF-8418-BEF7ABAF4D73" style="width:627;height:407"
								VIEWASTEXT>
							</OBJECT>
							<input id="serverip" type=hidden value='<%=sp_ip%>' name="serverip">
							<input id="iChannel" type="hidden" name="iChannel" value="0">
							<input id="port" type=hidden value='<%=sp_port%>' name="port"> 
							<input id="userID" type=hidden value='<%=sp_user%>' name="userID">
							<input id="userPwd" type=hidden value='<%=sp_pwd%>' name="userPwd">
						</form>
					</td>
				</tr>
			</table>
		</div>
		<input type="hidden" id="tbxWinNumber" NAME="tbxWinNumber" value='1' />
		<script language="javascript">
			ChangeWindow(1);
			window.setTimeout(addplayinfo,3000);
		</script>
	</body>
</HTML>