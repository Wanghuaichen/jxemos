<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.hoson.biz.*"%>
<%@ page import="com.hoson.*,com.hoson.util.*,java.sql.*,java.util.*,javax.servlet.http.*,com.hoson.app.*"%>


<%
   			 String url_exe = "webocx17.exe";
             String facode=" 82";
             String sb_id = null;
             String[]arr=null;
             Connection cn = null;
             
             String sp_user = App.get("sp_user","");
             String sp_pwd = App.get("sp_pwd","");
             String sp_ip = App.get("sp_ip","");
             String sp_port = App.get("sp_port","");
             
             
             Map map = null;
             String sql = null;
             String sp_s = "";
             int i,num=0;
             int j,sb_num=0;
             
             String sb_id_1 = null;
             String station_type = JspUtil.getParameter(request,"station_type",App.get("default_station_type","1"));
           
             String stationTypeOption = null;
             String spOption = "";
             List stationList = null;
             Map sbMap = null;
             String station_id,station_name = null;
             Map row = null;
             
         
      String area_id =null;
     
      String areaOption = null;
      String spTypeOption = null;
      String sp_type = null;
      String top_area_id=App.get("area_id","33");
          String sp_ctl_flag = "0";
            station_id = request.getParameter("station_id"); 
             
             try{
             
             if(StringUtil.isempty(station_id)){throw new Exception("请选择站位");}
             
             
              station_type = f.p(request,"station_type",App.get("default_station_type","1"));
    
         area_id =     f.p(request,"area_id",top_area_id);
      sp_type=f.p(request,"sp_type","1"); 
         
             
             
             cn = DBUtil.getConn();
             
             sp_ctl_flag = f.getSpCtlFlag(request,cn);
            
 stationTypeOption = JspPageUtil.getStationTypeOption(cn,station_type);
      areaOption = JspPageUtil.getAreaOption(cn,area_id);
      spTypeOption = SpUtil.getSpTypeOption(cn,sp_type);
      


             
      sql = "select station_id,station_desc,sb_id from t_cfg_station_info where station_type='"+station_type+"' and area_id like '"+area_id+"%' ";
             
      
      sql=sql+ DataAclUtil.getStationIdInString(request,station_type,"station_id");
      
      sql=sql+" order by area_id,station_desc";
             
             
             sql = "select * from t_cfg_station_info where station_id='"+station_id+"'";
             
             stationList = DBUtil.query(cn,sql,null);
            
            
            
             
             //out.println(sbMap);
             num = stationList.size();
             
             if(num<1){throw new Exception("站位不存在");}
             
             for(i=0;i<num;i++){
             row = (Map)stationList.get(i);
             station_id = (String)row.get("station_id");             
             station_name = (String)row.get("station_desc");
             sb_id = (String)row.get("sb_id");
             
           //System.out.println(sb_id);
           
             //if(f.empty(sb_id)){continue;}
             
             if(f.empty(sb_id)){throw new Exception("请配置视频设备号");}
             
             arr=sb_id.split(",");
             sb_num=arr.length;
             
             
             for(j=0;j<sb_num;j++){
             sb_id = arr[j];
             if(f.empty(sb_id)){continue;}
             spOption =spOption+"<option value='"+sb_id+facode+"'>"+station_name+"_通道"+(j+1)+"</option>\n";
             }
             
             
             
             
             }//end for j
             
             
             sp_user = SpUtil.getFreeUser(sp_user,20);
         
             }catch(Exception e){
             JspUtil.go2error(request,response,e);
             return;
             }finally{DBUtil.close(cn);}
             
             
             
%>


<HTML>
	<HEAD>
		<title>视频监控</title>


		<style>
			td{font-size:9pt}
		</style>
	<OBJECT id="WebOcx" name="WebOcx" classid="clsid:A904F415-9B57-45A3-862F-B5C39775275E" width="0" height="0"  
class="style1" VIEWASTEXT codebase="webocx.cab#version=1,0,0,1" >
</OBJECT>




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
	<body leftmargin=0 topmargin=0 onUnload="destroyOcx();">
	
	
		<div style="width:100%;height:100%;BACKGROUND-IMAGE: url(img/conral_bg_new.jpg)">
			<table cellspacing=0 cellpadding=0 border=0 width="100%" height="100%">
				<tr>
					<td style="width:70%;height:100%" id="tdObj" align="left" valign="top">
						<OBJECT id=VideoPanelOcx style="WIDTH:100%;  HEIGHT: 100%" classid="clsid:96BD6160-33B5-4516-A45A-E9800AFDBFDF" codebase="webocx.cab#Version=1,0,0,1" VIEWASTEXT>
							<PARAM NAME="_Version" VALUE="65536">
							<PARAM NAME="_ExtentX" VALUE="9313">
							<PARAM NAME="_ExtentY" VALUE="7620">
							<PARAM NAME="_StockProps" VALUE="0">
						</OBJECT>
					</td>
					
					
					
					
					<td style="width:30%;align:left;text-align:center" id="tdControl" valign="top">
						<div id="control1">
						
						
							<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td colspan="5">
										<img src="img/contral_bg_logo.jpg" border="0" height="0" style="WIDTH:163px;HEIGHT:25px">
									</td>
								</tr>
								<tr>
									<td> </td>
									<td></td>
									<td align="center"><img src="img/con_top.gif" style="WIDTH:44px;CURSOR:hand;HEIGHT:35px" border="0" id="btnUp" name="btnUp" onMouseDown="TurnUp()" title="向上" onMouseUp="StopTurn();" onmouseover="MM_swapImage('btnUp','','img/y_top2.gif',1)"
											onmouseout="MM_swapImgRestore()"></td>
									<td align="right" noWrap><img src="img/big2.gif" title="镜头拉近" onMouseDown="LenNear();" onMouseUp="StopTurn();" style="WIDTH:25px;CURSOR:hand;HEIGHT:24px" border="0"></td>
									<td align="right">    <img src="img/focusout2.gif" onclick="FocusIn()" style="WIDTH:41px;CURSOR:hand;HEIGHT:20px" border="0" alt="散焦"></td>
									<td> </td>
								</tr>
								
								
								<tr>
								
								
								
									<td> </td>
									<td noWrap align="right"><img src="img/con_left.gif" style="WIDTH:35px;CURSOR:hand;HEIGHT:43px" height="38" border="0" name="btnLeft" id="btnLeft" title="向左" onMouseDown="TurnLeft()" onMouseUp="StopTurn();" onmouseover="MM_swapImage('btnLeft','','img/con_left2.gif',1)"
											onmouseout="MM_swapImgRestore()"></td>
									<td align="center" noWrap><img src="img/con_middle.gif" style="WIDTH:44px;CURSOR:hand;HEIGHT:43px" id="btnStop" onclick="Stop()" title="断开"></td>
									<td align="left"><img src="img/con_right.gif" style="WIDTH:35px;CURSOR:hand;HEIGHT:43px" name="btnRight" border="0" id="btnRight" title="向右" onMouseDown="TurnRight()" onMouseUp="StopTurn();" onmouseover="MM_swapImage('btnRight','','img/con_right2.gif',1)"
											onmouseout="MM_swapImgRestore()"></td>
									<td align="right">    <img src="img/auto2.gif" style="WIDTH:41px;CURSOR:hand;HEIGHT:20px" onclick="FocusAuto()" height="35" border="0" alt="自动对焦"></td>
									<td> </td>
								</tr>
								
								
								<tr>
									<td> </td>
									<td></td>
									<td align="center"><img src="img/con_down.gif" style="WIDTH:44px;CURSOR:hand;HEIGHT:36px" border="0" name="btnDown" id="btnDown" onMouseDown="TurnDown()" onMouseUp="StopTurn();" onmouseover="MM_swapImage('btnDown','','img/con_down2.gif',1)" onmouseout="MM_swapImgRestore()"></td>
									<td align="right"><img src="img/small2.gif" title="镜头拉远" onMouseDown="LenFar();" onMouseUp="StopTurn();" style="WIDTH:25px;CURSOR:hand;HEIGHT:24px" border="0"></td>
									<td align="right">    <img src="img/focus2.gif" onclick="FocusIn()" style="cursor:hand;WIDTH:41px;HEIGHT:20px" border="0" alt="聚焦" width="37"></td>
									<td> </td>
								</tr>
							</table>
							
							
							
						</div>
						
						
						
						
						<div id="control2" style="TEXT-ALIGN:center">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td width="36">
										<img src="img/screen_one.gif" onMouseDown="changPanlNumber(1);" style="cursor:hand;WIDTH:35px;CURSOR:hand;HEIGHT:34px" border="0" alt="单屏">
									</td>
									<td width="36">
										<img src="img/screen_four.gif" onMouseDown="changPanlNumber(4);" style="cursor:hand;WIDTH:36px;CURSOR:hand;HEIGHT:34px" border="0" alt="四屏">
									</td>
									<td width="36">
										<img src="img/screen_six.gif" onMouseDown="changPanlNumber(6);" style="cursor:hand;WIDTH:36px;CURSOR:hand;HEIGHT:34px" border="0" alt="六屏">
									</td>
									<td width="36">
										<img src="img/screen_nine.gif" onMouseDown="changPanlNumber(9);" style="cursor:hand;WIDTH:36px;CURSOR:hand;HEIGHT:34px" border="0" alt="九屏">
									</td>
									<td width="36">
										<img src="img/scre_sixteenen.gif" onMouseDown="changPanlNumber(16);" style="cursor:hand;WIDTH:36px;CURSOR:hand;HEIGHT:34px" border="0" alt="十六屏">
									</td>
								</tr>
							</table>
						</div>
						<!--
						<div id="control33" style="valign:top">
							<div id="listhead" style="text-align:center;valign:middle">
								<table width=100% cellpadding="0" cellspacing="0" border="0" >
									<tr>
										<td align="left" width="30%"><img style="width:7px;height:26px;" src="img/List_Head_Left.JPG" border=0></td>
										<td align="center" valign="middle" width="30%"><img style="width:104px;height:16px;" src="img/listhead_logo.JPG" border=0></td>
										<td align="right" width="30%"><img style="width:7px;height:26px;" src="img/List_Head_Right.JPG" border=0></td>
									</tr>
								</table>
							</div>
							
							-->
							<!--
								<form name="form3">
									
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
							-->
							
							<br>
							
							<select id=IdSelect size=18 style="width:270px" onclick="selectchg()">
							<%=spOption%>
							</select>
							
							
							
						
							
							<div style="width:100%;text-align:center">
								<a href="<%=url_exe%>"><font color="red">控件下载</font></a>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<input type="hidden" id="sp_user" name="sp_user" value="<%=sp_user%>" />
		<input type="hidden" id="sp_pwd" name="sp_pwd" value="<%=sp_pwd%>" />
		<input type="hidden" id="sp_ip" name="sp_ip" value="<%=sp_ip%>" />
		<input type="hidden" id="sp_port" name="sp_port" value="<%=sp_port%>" />
		<input type="hidden" id="tbxFDID" name="tbxFDID" value="" />
		
		
		
<form name=form2 action=user.jsp target=q>
<input type=hidden name=sp_user_in_use value="<%=sp_user%>">
</form>
<iframe name=q width=0 height=0></iframe>
		
		
	</body>
	
</HTML>







<script language="javascript">
    var tmpStr_array;
    var Array_FDID;
    var lResult = 1;
    var OldSize=0;
    var IniFDID="";
    var PanelHandle="";//空闲窗口句柄
    var b_HasLogin=false;
    var b_Recording=false;
    var Array_IniFDID;
    //初始化OCx控件
    lResult = WebOcx.CreateInstance();
    if(lResult != 0)
    {
        alert("初始化失败");
    }

    function load()
    {
        Login();
    }

    //登陆方法
    function Login()
    {
        if(!b_HasLogin)
        {
            var	lResult = 1;
            //lResult = WebOcx.Login("60.191.58.158","5555","vpntest003@sxvpn.sx.zj.ge","1234");
            //lResult = WebOcx.Login("172.16.62.204","5555","zhaosf@nanwang.com","1234");
//lResult = WebOcx.Login("60.191.58.158","5555","hstest001@zjhb.zj.ge","1234");
           
           var sp_ip = document.getElementById("sp_ip").value;
           var sp_port = document.getElementById("sp_port").value;
           var sp_user = document.getElementById("sp_user").value;
           var sp_pwd = document.getElementById("sp_pwd").value;
           lResult = WebOcx.Login(sp_ip,sp_port,sp_user,sp_pwd);
    
            if(lResult != 0)
            {
                alert("Login失败!");
            }
            b_HasLogin= true;
        }
    }

    //创建数组
    function IniArray(size)
    {
        for(var i = 0; i < size; i++)
        {
            this[i] = "";
        }
        this.length=size;
        return this;
    }

    //释放ocx控件
    function destroyOcx()
    {
        WebOcx.Destroy();	
    }

    //开始视频方法
    function Start()
    {
        WebOcx.StopLiveVideo(IniFDID);

        PanelHandle=VideoPanelOcx.GetPanelHandle();
        preFDID=VideoPanelOcx.GetCameraID();
        VideoPanelOcx.SetPanelInfo('', '', '', PanelHandle);
        WebOcx.StopLiveVideo(preFDID);

        var index=IdSelect.selectedIndex;
        IniFacode=Array_facode[index];
        IniFDID=Array_FDID[index];
        WebOcx.StartLiveVideoEx(IniFDID,PanelHandle,IniFacode);
        WebOcx.EnableStream(IniFDID,2,1);
    }

    //停止视频方法
    function Stop()
    {
        preFDID=VideoPanelOcx.GetCameraID();
        PanelNo=VideoPanelOcx.GetPanelHandle();
        VideoPanelOcx.SetPanelInfo('', '', '', PanelNo);
        WebOcx.StopLiveVideo(preFDID);
    }
    function TurnOnAudio()
    {
        lResult = WebOcx.EnableStream(IniFDID,2,true);
        //alert(lResult);
    }

    //云台的左转
    function TurnLeft()
    {
    
    sp_ctl_check();
        if(b_HasLogin)
        {
            preFDID=VideoPanelOcx.GetCameraID();
            WebOcx.SendPtzCommand(preFDID,2, 5);	
        }		
    }

    //云台的右转
    function TurnRight()
    {
     sp_ctl_check();
        if(b_HasLogin)
        {
            preFDID=VideoPanelOcx.GetCameraID();
            WebOcx.SendPtzCommand(preFDID,4, 5);
        }		
    }

    //云台上转
    function TurnUp()
    {
     sp_ctl_check();
        if(b_HasLogin)
        {
            preFDID=VideoPanelOcx.GetCameraID();
            WebOcx.SendPtzCommand(preFDID,1, 5);
        }		
    }
    //云台下转
    function TurnDown()
    {
     sp_ctl_check();
        if(b_HasLogin)
        {
            preFDID=VideoPanelOcx.GetCameraID();
            WebOcx.SendPtzCommand(preFDID,5, 5);
        }		
    }
    //停止转动
    function StopTurn()
    {
        if(b_HasLogin)
        {
            preFDID=VideoPanelOcx.GetCameraID();
            WebOcx.SendPtzCommand(preFDID,13, 5);
        }		
    }
    //改变面板数

    function changPanlNumber(Num)
    {
        VideoPanelOcx.SetVideoPanelNum(Num);
    }
    //改变面板颜色
    function  changeBGColor()
    {
        VideoPanelOcx.ChangeBgColor(0);
    }
    //视频选择
    function selectchg()
    {
    
        
        var index;
        index=IdSelect.selectedIndex;
        if(index<0){return;}
        var OldFDID = IniFDID;
        //IniFDID=Array_FDID[index];
        //IniFacode=Array_facode[index];
        
         var str = IdSelect.options[index].value;
        IniFDID = str.substring(0,22);
	IniFacode = str.substring(str.length-3,str.length);
        
        	
        if(OldFDID != IniFDID)
        {
            PanelHandle=VideoPanelOcx.GetPanelHandle();//获得空闲窗口句柄

            preFDID=VideoPanelOcx.GetCameraID();
            VideoPanelOcx.SetPanelInfo('', '', '', PanelHandle);
            WebOcx.StopLiveVideo(preFDID);

            WebOcx.StartLiveVideoEx(IniFDID,PanelHandle,IniFacode);
            WebOcx.EnableStream(IniFDID,2,true);
        }	
    }
    //改变视频大小
    function changeVideoSize()
    {
        OldSize=OldSize+50;
        document.all.VideoPanelOcx.style.height=288+OldSize;
        document.all.VideoPanelOcx.style.width=352+OldSize;
    }

    function changeVideoSizesmall()
    {
        OldSize=OldSize-100;
        document.all.VideoPanelOcx.style.height=288+OldSize;
        document.all.VideoPanelOcx.style.width=352+OldSize;
    }	

    //聚焦
    function FocusIn()
    {
    
     sp_ctl_check();
        if(b_HasLogin)
        {
            WebOcx.SendPtzCommand(IniFDID,0x07, 5);
        }		
    }
    //散焦
    function FocusOut()
    {
     sp_ctl_check();
        if(b_HasLogin)
        {
            WebOcx.SendPtzCommand(IniFDID,0x09, 5);
        }	
    }
    
    //自动对焦
    function FocusAuto()
    {
     sp_ctl_check();
        if(b_HasLogin)
        {
            WebOcx.SendPtzCommand(IniFDID,0x08, 5);
        }	
    }
    
    //拉远镜头
    function LenFar()
    {
     sp_ctl_check();
        if(b_HasLogin)
        {
            //VideoPanelOcx.RefreshBgOfvideo();
            preFDID=VideoPanelOcx.GetCameraID();
            WebOcx.SendPtzCommand(preFDID,0x06, 5);
        }	
    }
    
    //拉近镜头
    function LenNear()
    {	
     sp_ctl_check();
        preFDID=VideoPanelOcx.GetCameraID();			
        WebOcx.SendPtzCommand(preFDID,0x0A, 5);
    }

    //开始录像
    function BeginRec()
    {
        if(b_HasLogin)
        {
            var res = WebOcx.StartRecording(IniFDID,0,2);
            if(res != 0)
            alert("StartRecording result: "+res);
        }	
    }
    //停止录像
    function EndRec()
    {
        var res = WebOcx.StopRecording(IniFDID);
        if(res != 0)
            alert("StopRecording result: "+res);
    }

    //查询录像状态   0 表示前端录像， 1表示中心录像
    function RecStat()
    {
        var recStat=WebOcx.QueryRecordStatus(IniFDID,1);
    }

    //查询正在录像详细信息   
    function RecStatAll()
    {
        var recStat=WebOcx.GetRecordStatus();
        var recStat_array=recStat.split(",");	
        alert("中心存储已用空间： "+recStat_array[1]+"MB");
        //数据格式为：FDID,已用存储空间,通道号,通道类型,开始时间,结束时间,文件录像时间长度,录像状态
        alert("录像详细信息"+recStat);
    }


    //查询用户状态
    function QueryUser()
    {
        alert("被查询用户: "+document.UserNameEdit.value);
        var userStatus = WebOcx.QueryUserStatus(document.UserNameEdit.value);
    }
    
    //查询通道信息
    function QueryChanInfo()
    {
        if(IniFDID==""||IniFDID==null)
        {
            alert("先选择一个视频编号!");
        }
        var QreryChanInfoResult = WebOcx.QueryChanInfo(IniFDID,1);
    }

    //下拉框搜索

    function selectSh()
    {
        if(b_HasLogin)
        {
            for(var k=0;k<Array_FDID.length;k++)
            {
                if(indexSh.value==IdSelect.options[k].text)
                {
                    IdSelect.selectedIndex=k; 
                    Start();
                    var f=1;
                    break;	
                }
            }	
            
            if(f!=1)
            {
                alert("对不起没有找到指定设备");
            }
        }
        else
        {
            alert("请先登入");
        }
    }

    //修改密码
    function ModifyPassWord()
    {
        if(b_HasLogin)
        { 
            if(opassword.value==""||npassword1.value==""||npassword2.value=="")
            {
                alert("新旧密码均不能为空");
            }
            else
            {
                if(npassword1.value!=npassword2.value)
                {
                    alert("新密码不一致，请重新输入");
                }
                else
                {
                    WebOcx.ModifyPassWord(opassword.value,npassword2.value);
                }
            }
        }
        else
        {
            alert("请先登入");
        }
    }
</script>


<!--登录成功事件--->
<script language="javascript" for="WebOcx" event="OnLogin(result);">
	if(result == 0)
	{
	b_HasLogin=true; 
	 //将设备编号对应的中文名添加入页面的 播放列表
		
	var FDListString11 =WebOcx.GetFDListStringEx();
	var oOption;
	var tmpStr_array =FDListString11.split(",");
	Array_FDID = new IniArray(tmpStr_array.length);
	Array_facode=new IniArray(tmpStr_array.length);
		for (loop=0; loop < tmpStr_array.length;loop++)
		{   
			oOption =document.createElement("OPTION");
			//IdSelect.options.add(oOption);
			oOption.innerText=tmpStr_array[loop].substring(26,tmpStr_array[loop].length-3);
			Array_FDID[loop] = tmpStr_array[loop].substring(0,22);
			Array_facode[loop] = tmpStr_array[loop].substring(tmpStr_array[loop].length-3,tmpStr_array[loop].length);
		}
	}
	else
	{
        if(result == -2147221489 )
        {
            alert("用户名不存在!");
            return 0;
        }
        if(result == -2147221497)
        {
            alert("用户名密码错误!");
            return 0;
        }
        alert("OnLogin失败");
	}
</script>
<!---查询用户状态事件--->
<script language="javascript" for="WebOcx" event="OnUserStatusEx(username,result);">

if(result == 0)
	alert(document.UserNameEdit.value+"不在线");
	//return true;
if(result == 1)
	alert(document.UserNameEdit.value+"在线");
	//return false;
</script>
<!---开始视频事件--->
<script language="javascript" for="WebOcx" event="OnMonitorStartRes(result);">
	if(result==0)
	{
		//alert(IniFDID);
		VideoPanelOcx.SetPanelInfo(IniFDID, '', '',PanelHandle);
	}
	else
	{
		VideoPanelOcx.SetPanelInfo('', '', '',PanelHandle);
		alert("连接视频失败：请联系管理员！"+result);
	}
</script>










<script>
 Login();
//alert("11");
//changPanlNumber(4);
//changPanlNumber(4)
 window.setInterval("form2.submit()", 6000); 
</script>


<script>
function r(){
//Logout();
form3.target="";
form3.action="sp_list.jsp";
form3.submit();
}


function sp_ctl_check(){
var flag = "<%=sp_ctl_flag%>";
if(flag=="1"){return;}
alert("没有视频控制权限");
var s = null;
s.x;

}

</script>

