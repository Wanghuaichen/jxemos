<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.hoson.biz.*"%>
<%@ page import="com.hoson.*,com.hoson.util.*,java.sql.*,java.util.*,javax.servlet.http.*,com.hoson.app.*"%>


<%
   			 String url_exe = "VideoSetupNew.exe";
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
        
             
             
             try{
             
              station_type = f.p(request,"station_type",App.get("default_station_type","1"));
    
         area_id =     f.p(request,"area_id",top_area_id);
      sp_type=f.p(request,"sp_type","1"); 
         
             
             
             cn = DBUtil.getConn();
            
 stationTypeOption = JspPageUtil.getStationTypeOption(cn,station_type);
      areaOption = JspPageUtil.getAreaOption(cn,area_id);
      spTypeOption = SpUtil.getSpTypeOption(cn,sp_type);
      


             
             sql = "select station_id,station_desc,sb_id from t_cfg_station_info where station_type='"+station_type+"' and area_id like '"+area_id+"%' order by area_id,station_desc";
             stationList = DBUtil.query(cn,sql,null);
            
            
            
             
             //out.println(sbMap);
             num = stationList.size();
             for(i=0;i<num;i++){
             row = (Map)stationList.get(i);
             station_id = (String)row.get("station_id");             
             station_name = (String)row.get("station_desc");
             sb_id = (String)row.get("sb_id");
           
             if(f.empty(sb_id)){continue;}
             arr=sb_id.split(",");
             sb_num=arr.length;
             
             
             for(j=0;j<sb_num;j++){
             sb_id = arr[j];
             if(f.empty(sb_id)){continue;}
             spOption =spOption+"<option value='"+sb_id+facode+"'>"+station_name+"_ͨ��"+(j+1)+"</option>\n";
             }
             
             
             
             
             }//end for j
             
             
             sp_user = SpUtil.getFreeUser(sp_user,10);
         
             }catch(Exception e){
             JspUtil.go2error(request,response,e);
             return;
             }finally{DBUtil.close(cn);}
             
             
             
%>


<HTML>
	<HEAD>
		<title>��Ƶ���</title>



	<OBJECT id="WebOcx" name="WebOcx" classid="clsid:A904F415-9B57-45A3-862F-B5C39775275E" width="0" height="0"  
class="style1" VIEWASTEXT codebase="webocx.cab#version=1,0,0,1" >
</OBJECT>



	<body leftmargin=0 topmargin=0 onUnload="destroyOcx();">
	
	<OBJECT id=VideoPanelOcx style="WIDTH:630px;  HEIGHT: 410px" classid="clsid:96BD6160-33B5-4516-A45A-E9800AFDBFDF" codebase="webocx.cab#Version=1,0,0,1" VIEWASTEXT>
							<PARAM NAME="_Version" VALUE="65536">
							<PARAM NAME="_ExtentX" VALUE="9313">
							<PARAM NAME="_ExtentY" VALUE="7620">
							<PARAM NAME="_StockProps" VALUE="0">
						</OBJECT>
			
				
							<!--
							<select id=IdSelect size=12 style="width:200px" onclick="selectchg()">
							-->
			<select id=IdSelect size=12 style="width:200px" onclick="sel_show(this)">
							
							
							
							<%=spOption%>
							</select>
						
						<!--
						<a href="javascript:show('2000000001000123850001 82')">ͨ��1</a>
<a href="javascript:show('2000000001000123870001 82')">ͨ��2</a>
<a href="javascript:show('2000000001000123880001 82')">ͨ��3</a>
<a href="javascript:show('2000000001000123620001 82')">ͨ��4</a>	
-->

	
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
    var PanelHandle="";//���д��ھ��
    var b_HasLogin=false;
    var b_Recording=false;
    var Array_IniFDID;
    //��ʼ��OCx�ؼ�
    lResult = WebOcx.CreateInstance();
    if(lResult != 0)
    {
        alert("��ʼ��ʧ��");
    }

    function load()
    {
        Login();
    }

    //��½����
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
                alert("Loginʧ��!");
            }
            b_HasLogin= true;
        }
    }

    //��������
    function IniArray(size)
    {
        for(var i = 0; i < size; i++)
        {
            this[i] = "";
        }
        this.length=size;
        return this;
    }

    //�ͷ�ocx�ؼ�
    function destroyOcx()
    {
        WebOcx.Destroy();	
    }

    //��ʼ��Ƶ����
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

    //ֹͣ��Ƶ����
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

    //��̨����ת
    function TurnLeft()
    {
        if(b_HasLogin)
        {
            preFDID=VideoPanelOcx.GetCameraID();
            WebOcx.SendPtzCommand(preFDID,2, 5);	
        }		
    }

    //��̨����ת
    function TurnRight()
    {
        if(b_HasLogin)
        {
            preFDID=VideoPanelOcx.GetCameraID();
            WebOcx.SendPtzCommand(preFDID,4, 5);
        }		
    }

    //��̨��ת
    function TurnUp()
    {
        if(b_HasLogin)
        {
            preFDID=VideoPanelOcx.GetCameraID();
            WebOcx.SendPtzCommand(preFDID,1, 5);
        }		
    }
    //��̨��ת
    function TurnDown()
    {
        if(b_HasLogin)
        {
            preFDID=VideoPanelOcx.GetCameraID();
            WebOcx.SendPtzCommand(preFDID,5, 5);
        }		
    }
    //ֹͣת��
    function StopTurn()
    {
        if(b_HasLogin)
        {
            preFDID=VideoPanelOcx.GetCameraID();
            WebOcx.SendPtzCommand(preFDID,13, 5);
        }		
    }
    //�ı������

    function changPanlNumber(Num)
    {
        VideoPanelOcx.SetVideoPanelNum(Num);
    }
    //�ı������ɫ
    function  changeBGColor()
    {
        VideoPanelOcx.ChangeBgColor(0);
    }
    //��Ƶѡ��
    function selectchg()
    {
    
        
        var index;
        index=IdSelect.selectedIndex;
        if(index<0){return;}
        var OldFDID = IniFDID;
        IniFDID=Array_FDID[index];
        IniFacode=Array_facode[index];	
        if(OldFDID != IniFDID)
        {
            PanelHandle=VideoPanelOcx.GetPanelHandle();//��ÿ��д��ھ��

            preFDID=VideoPanelOcx.GetCameraID();
            VideoPanelOcx.SetPanelInfo('', '', '', PanelHandle);
            WebOcx.StopLiveVideo(preFDID);

            WebOcx.StartLiveVideoEx(IniFDID,PanelHandle,IniFacode);
            WebOcx.EnableStream(IniFDID,2,true);
        }	
    }
    //�ı���Ƶ��С
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

    //�۽�
    function FocusIn()
    {
        if(b_HasLogin)
        {
            WebOcx.SendPtzCommand(IniFDID,0x07, 5);
        }		
    }
    //ɢ��
    function FocusOut()
    {
        if(b_HasLogin)
        {
            WebOcx.SendPtzCommand(IniFDID,0x09, 5);
        }	
    }
    
    //�Զ��Խ�
    function FocusAuto()
    {
        if(b_HasLogin)
        {
            WebOcx.SendPtzCommand(IniFDID,0x08, 5);
        }	
    }
    
    //��Զ��ͷ
    function LenFar()
    {
        if(b_HasLogin)
        {
            //VideoPanelOcx.RefreshBgOfvideo();
            preFDID=VideoPanelOcx.GetCameraID();
            WebOcx.SendPtzCommand(preFDID,0x06, 5);
        }	
    }
    
    //������ͷ
    function LenNear()
    {	
        preFDID=VideoPanelOcx.GetCameraID();			
        WebOcx.SendPtzCommand(preFDID,0x0A, 5);
    }

    //��ʼ¼��
    function BeginRec()
    {
        if(b_HasLogin)
        {
            var res = WebOcx.StartRecording(IniFDID,0,2);
            if(res != 0)
            alert("StartRecording result: "+res);
        }	
    }
    //ֹͣ¼��
    function EndRec()
    {
        var res = WebOcx.StopRecording(IniFDID);
        if(res != 0)
            alert("StopRecording result: "+res);
    }

    //��ѯ¼��״̬   0 ��ʾǰ��¼�� 1��ʾ����¼��
    function RecStat()
    {
        var recStat=WebOcx.QueryRecordStatus(IniFDID,1);
    }

    //��ѯ����¼����ϸ��Ϣ   
    function RecStatAll()
    {
        var recStat=WebOcx.GetRecordStatus();
        var recStat_array=recStat.split(",");	
        alert("���Ĵ洢���ÿռ䣺 "+recStat_array[1]+"MB");
        //���ݸ�ʽΪ��FDID,���ô洢�ռ�,ͨ����,ͨ������,��ʼʱ��,����ʱ��,�ļ�¼��ʱ�䳤��,¼��״̬
        alert("¼����ϸ��Ϣ"+recStat);
    }


    //��ѯ�û�״̬
    function QueryUser()
    {
        alert("����ѯ�û�: "+document.UserNameEdit.value);
        var userStatus = WebOcx.QueryUserStatus(document.UserNameEdit.value);
    }
    
    //��ѯͨ����Ϣ
    function QueryChanInfo()
    {
        if(IniFDID==""||IniFDID==null)
        {
            alert("��ѡ��һ����Ƶ���!");
        }
        var QreryChanInfoResult = WebOcx.QueryChanInfo(IniFDID,1);
    }

    //����������

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
                alert("�Բ���û���ҵ�ָ���豸");
            }
        }
        else
        {
            alert("���ȵ���");
        }
    }

    //�޸�����
    function ModifyPassWord()
    {
        if(b_HasLogin)
        { 
            if(opassword.value==""||npassword1.value==""||npassword2.value=="")
            {
                alert("�¾����������Ϊ��");
            }
            else
            {
                if(npassword1.value!=npassword2.value)
                {
                    alert("�����벻һ�£�����������");
                }
                else
                {
                    WebOcx.ModifyPassWord(opassword.value,npassword2.value);
                }
            }
        }
        else
        {
            alert("���ȵ���");
        }
    }
</script>


<!--��¼�ɹ��¼�--->
<script language="javascript" for="WebOcx" event="OnLogin(result);">
	if(result == 0)
	{
	b_HasLogin=true; 
	 //���豸��Ŷ�Ӧ�������������ҳ��� �����б�
		
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
            alert("�û���������!");
            return 0;
        }
        if(result == -2147221497)
        {
            alert("�û����������!");
            return 0;
        }
        alert("OnLoginʧ��");
	}
</script>
<!---��ѯ�û�״̬�¼�--->
<script language="javascript" for="WebOcx" event="OnUserStatusEx(username,result);">

if(result == 0)
	alert(document.UserNameEdit.value+"������");
	//return true;
if(result == 1)
	alert(document.UserNameEdit.value+"����");
	//return false;
</script>
<!---��ʼ��Ƶ�¼�--->
<script language="javascript" for="WebOcx" event="OnMonitorStartRes(result);">
	if(result==0)
	{
		//alert(IniFDID);
		VideoPanelOcx.SetPanelInfo(IniFDID, '', '',PanelHandle);
	}
	else
	{
		VideoPanelOcx.SetPanelInfo('', '', '',PanelHandle);
		alert("������Ƶʧ�ܣ�����ϵ����Ա��"+result);
	}
</script>



<script>

function sel_show(obj){
    
       var index=obj.selectedIndex;
        if(index<0){return;}
        var OldFDID = IniFDID;
        //IniFDID=Array_FDID[index];
        //IniFacode=Array_facode[index];
        var str = obj.options[index].value;
        show(str);
        /*
        IniFDID = str.substring(0,22);
	IniFacode = str.substring(str.length-3,str.length);
        	
        if(OldFDID != IniFDID)
        {
            PanelHandle=VideoPanelOcx.GetPanelHandle();//��ÿ��д��ھ��

            preFDID=VideoPanelOcx.GetCameraID();
            VideoPanelOcx.SetPanelInfo('', '', '', PanelHandle);
            WebOcx.StopLiveVideo(preFDID);

            WebOcx.StartLiveVideoEx(IniFDID,PanelHandle,IniFacode);
            WebOcx.EnableStream(IniFDID,2,true);
        }	
    */
    
    
    }
    


   function show(str){
    
       //var index=IdSelect.selectedIndex;
       // if(index<0){return;}
        var OldFDID = IniFDID;
        //IniFDID=Array_FDID[index];
        //IniFacode=Array_facode[index];
        
        IniFDID = str.substring(0,22);
	IniFacode = str.substring(str.length-3,str.length);
        	
        if(OldFDID != IniFDID)
        {
            PanelHandle=VideoPanelOcx.GetPanelHandle();//��ÿ��д��ھ��

            preFDID=VideoPanelOcx.GetCameraID();
            VideoPanelOcx.SetPanelInfo('', '', '', PanelHandle);
            WebOcx.StopLiveVideo(preFDID);

            WebOcx.StartLiveVideoEx(IniFDID,PanelHandle,IniFacode);
            WebOcx.EnableStream(IniFDID,2,true);
        }	
    
    }
    
    function show_first(){
     show('<%=sb_id_1%>');
    }
    


</script>



<script>
 Login();
//alert("11");
 window.setInterval("form2.submit()", 6000); 
</script>

