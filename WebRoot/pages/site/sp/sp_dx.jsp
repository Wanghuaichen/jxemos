<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.hoson.biz.*"%>
<%@ page import="com.hoson.*,java.sql.*,java.util.*,javax.servlet.http.*,com.hoson.app.*"%>

<%!
                   
public class NewVideo_biz2
{

	private String strIP = "";

	private String strPort = "";

	private String strAccount = "";

	private String strPwd = "";

	private String strFDID = "";

	private String strStationID = "";

	private HttpServletRequest request = null;

	private HttpServletResponse response = null;

	public HttpServletResponse getResponse()
	{
		return response;
	}

	public void setResponse(HttpServletResponse response)
	{
		this.response = response;
	}

	public HttpServletRequest getRequest()
	{
		return request;
	}

	public void setRequest(HttpServletRequest request)
	{
		this.request = request;
	}

	public String getStrAccount()
	{
		return strAccount;
	}

	public void setStrAccount(String strAccount)
	{
		this.strAccount = strAccount;
	}

	public String getStrFDID()
	{
		return strFDID;
	}

	public void setStrFDID(String strFDID)
	{
		this.strFDID = strFDID;
	}

	public String getStrIP()
	{
		return strIP;
	}

	public void setStrIP(String strIP)
	{
		this.strIP = strIP;
	}

	public String getStrPort()
	{
		return strPort;
	}

	public void setStrPort(String strPort)
	{
		this.strPort = strPort;
	}

	public String getStrPwd()
	{
		return strPwd;
	}

	public void setStrPwd(String strPwd)
	{
		this.strPwd = strPwd;
	}

	public String getStrStationID()
	{
		return strStationID;
	}

	public void setStrStationID(String strStationID)
	{
		this.strStationID = strStationID;
	}

	public NewVideo_biz2(HttpServletRequest request) throws Exception
	{
		try
		{
			this.request = request;
			if (JspUtil.getParameter(request, "station_id") != null)
			{
				String strTempStationID = JspUtil.getParameter(request, "station_id");
				this.setStrStationID(strTempStationID);
			}
		}
		catch (Exception en)
		{
			throw en;
		}
	}

	public void Page_Load() throws Exception
	{
		String strUserName2 =  (String) request.getSession().getAttribute(
		"user_name");

		String strUserName = (String) request.getSession().getAttribute(
				"user_id");
		String strSql = "";
		if(strUserName2.compareTo("admin") == 0)
		{

			 strSql = "select * from t_sp_user where user_id='" + strUserName
				+ "'";
		}
		else
		{
			 strSql = "select * from t_sp_user where user_id='" + strUserName
				+ "'";
		}
		Connection cn = null;
		try
		{
			cn = DBUtil.getConn(request);// 获取数据库连接
			Map lstRealData = DBUtil.queryOne(cn, strSql, null);
			if (lstRealData != null)
			{
				this.strAccount = lstRealData.get("sp_user_name").toString();
				this.strPwd = lstRealData.get("sp_user_pwd").toString();
			}
			this.strIP = PropUtil.getResProp("/app.properties").getProperty(
					"VideoIP");
			this.strPort = PropUtil.getResProp("/app.properties").getProperty(
					"VideoPort");
		}
		finally
		{
			DBUtil.close(cn);
		}
	}

	public String GetOptions(String strStationType) throws Exception
	{
		String strResult = "";
		String sql = App.getTreeSql(request);

		strResult = JspUtil.getOption(sql, strStationType, request);
		return strResult;
	}

	public String GetStationTree() throws Exception
	{
		String strResult = "";
		String strRootCode = com.hoson.app.App.get("area_id", "33");
		if (strRootCode.compareTo("33") == 0)
		{
			strResult = "d = new TreeView('d','node0','根目录','0');\n";
			strResult += "d.add('node33','node0','浙江省','','','','js_tree/image/close.gif','js_tree/image/open.gif','false');\n";
		}
		else
		{
			strResult = "d = new TreeView('d','node33','浙江省','33');\n";
		}

		String strUserName = (String) request.getSession().getAttribute(
				"user_id");
		String strUserName2 =  (String) request.getSession().getAttribute(
				"user_name");
		
		
		
		String strSqlStation = "";
		if (this.getStrStationID() != null
				&& this.getStrStationID().compareTo("") != 0)
		{
			if(strUserName2.compareTo("admin") == 0)
			{
				strSqlStation = "select a.station_id,a.sb_id,b.user_id,c.station_type,c.station_desc,c.area_id "
					+ " from t_sp_sb_station a join t_sys_user_station b on a.station_id = b.station_ids "
					+ " join t_cfg_station_info c on a.station_id = c.station_id where  a.station_id='"
					+ this.getStrStationID() + "' order by area_id asc";
			}
			else
			{
				strSqlStation = "select a.station_id,a.sb_id,b.user_id,c.station_type,c.station_desc,c.area_id "
					+ " from t_sp_sb_station a join t_sys_user_station b on a.station_id = b.station_ids "
					+ " join t_cfg_station_info c on a.station_id = c.station_id where b.user_id =  '"
					+ strUserName
					+ "' and a.station_id='"
					+ this.getStrStationID() + "' order by area_id asc";
			}
		}
		else
		{

			if(strUserName2.compareTo("admin") == 0)
			{
			strSqlStation = "select a.station_id,a.sb_id,b.user_id,c.station_type,c.station_desc,c.area_id "
					+ " from t_sp_sb_station a join t_sys_user_station b on a.station_id = b.station_ids "
					+ " join t_cfg_station_info c on a.station_id = c.station_id  order by area_id asc";
			
			}
			else
			{
			strSqlStation = "select a.station_id,a.sb_id,b.user_id,c.station_type,c.station_desc,c.area_id "
					+ " from t_sp_sb_station a join t_sys_user_station b on a.station_id = b.station_ids "
					+ " join t_cfg_station_info c on a.station_id = c.station_id where b.user_id =  '"
					+ strUserName + "' order by area_id asc";
			}
		}

		Connection cn = null;
		try
		{
			this.strIP = PropUtil.getResProp("/app.properties").getProperty(
					"VideoIP");
			this.strPort = PropUtil.getResProp("/app.properties").getProperty(
					"VideoPort");
			String[] strCity = new String[50];
			int iCity = 0;
			int iProvince = 0;
			String[] strProvince = new String[20];

			// 站位ID
			List lstStation = new ArrayList();
			cn = DBUtil.getConn(request);// 获取数据库连接
			//lstStation = DBUtil.query(cn, strSqlStation, null);
			if(StringUtil.isempty(this.getStrStationID()))
			{
				lstStation = getstationList(cn, strUserName);
			}
			else
			{
				lstStation = getstationList(cn, strUserName,this.getStrStationID());
			}
			for (int i = 0; i < lstStation.size(); i++)
			{
				String strAreaID = JspUtil.get((Map) (lstStation.get(i)),
						"area_id", "");

				if (strAreaID.length() == 2)
				{

				}
				else if (strAreaID.length() == 4)
				{
					boolean bFlag = true;
					for (int k = 0; k < strCity.length; k++)
					{
						if (strCity[k] == null)
						{
							bFlag = true;
							break;
						}
						else if (strAreaID.compareTo(strCity[k]) == 0)
						{
							bFlag = false;
							break;
						}
					}

					if (bFlag == true)
					{
						String strSqlCity = "select * from t_cfg_area where Area_ID='"
								+ strAreaID + "'";
						Map lstTempData = DBUtil.queryOne(cn, strSqlCity, null);
						if (lstTempData != null)
						{

							String strTempParID = lstTempData.get("area_pid")
									.toString();
							String strTempSelID = lstTempData.get("area_id")
									.toString();
							String strTempName = lstTempData.get("area_name")
									.toString();
							strResult += "d.add('node"
									+ strTempSelID
									+ "','node"
									+ strTempParID
									+ "','"
									+ strTempName
									+ "',"
									+ "'','"
									+ strTempSelID
									+ "','','js_tree/image/close.gif','js_tree/image/open.gif','false');\n";

							strCity[iCity] = strTempSelID;
							iCity++;
						}
					}
				}
				else if (strAreaID.length() == 6)
				{
					// 添加市级节点
					boolean bTFlag = true;
					for (int k = 0; k < strProvince.length; k++)
					{
						if (strProvince[k] == null)
						{
							bTFlag = true;
							break;
						}
						else if (strAreaID.substring(0, 4).compareTo(
								strProvince[k]) == 0)
						{
							bTFlag = false;
							break;
						}
					}

					if (bTFlag == true)
					{
						String strSqlStreet = "select * from t_cfg_area where Area_ID='"
								+ strAreaID.substring(0, 4) + "'";
						Map lstTempStrData = DBUtil.queryOne(cn, strSqlStreet,
								null);
						if (lstTempStrData != null)
						{

							String strTempParID = lstTempStrData
									.get("area_pid").toString();
							String strTempSelID = lstTempStrData.get("area_id")
									.toString();
							String strTempName = lstTempStrData
									.get("area_name").toString();
							strResult += "d.add('node"
									+ strTempSelID
									+ "','node"
									+ strTempParID
									+ "','"
									+ strTempName
									+ "',"
									+ "'','"
									+ strTempSelID
									+ "','','js_tree/image/close.gif','js_tree/image/open.gif','false');\n";

							strProvince[iCity] = strTempSelID;
							iProvince++;
						}
					}

					// 添加区县级节点
					boolean bFlag = true;
					for (int k = 0; k < strCity.length; k++)
					{
						if (strCity[k] == null)
						{
							bFlag = true;
							break;
						}
						else if (strAreaID.substring(0, 6)
								.compareTo(strCity[k]) == 0)
						{
							bFlag = false;
							break;
						}
					}

					if (bFlag == true)
					{
						String strSqlCity = "select * from t_cfg_area where Area_ID='"
								+ strAreaID.substring(0, 6) + "'";
						Map lstTempData = DBUtil.queryOne(cn, strSqlCity, null);
						if (lstTempData != null)
						{

							String strTempParID = lstTempData.get("area_pid")
									.toString();
							String strTempSelID = lstTempData.get("area_id")
									.toString();
							String strTempName = lstTempData.get("area_name")
									.toString();
							strResult += "d.add('node"
									+ strTempSelID
									+ "','node"
									+ strTempParID
									+ "','"
									+ strTempName
									+ "',"
									+ "'','"
									+ strTempSelID
									+ "','','js_tree/image/close.gif','js_tree/image/open.gif','false');\n";

							strCity[iCity] = strTempSelID;
							iCity++;
						}
					}
				}

				String strStationName = JspUtil.get((Map) (lstStation.get(i)),
						"station_desc", "");
				String strStationID = JspUtil.get((Map) (lstStation.get(i)),
						"station_id", "");
				String strSPID = JspUtil.get((Map) (lstStation.get(i)),
						"sb_id", "");
				if (strSPID != null && strSPID.length() > 10)
				{
					// 添加站位节点
					strResult += "d.add('node" + strStationID + "','node"
							+ strAreaID + "','" + strStationName + "',"
							+ "'','" + strStationID
							+ "','','js_tree/image/close.gif','js_tree/image/open.gif','false');\n";
					// 添加视频节点
					if (strSPID.indexOf(",") != -1)
					{
						String[] arySPID = strSPID.split(",");
						for (int iCount = 0; iCount < arySPID.length; iCount++)
						{
							strResult += "d.add('node"
									+ arySPID[iCount]
									+ "','node"
									+ strStationID
									+ "','<a style=\"cursor:hand\" onclick=SelectFDID(\""
									+ arySPID[iCount]
									+ "\")>通道"
									+ String.valueOf(iCount + 1)
									+ "</a>',"
									+ "'','["
									+ arySPID[iCount]
									+ "]','','js_tree/image/file.png','','true');\n";
						}
					}
					else
					{
						strResult += "d.add('node"
								+ strSPID
								+ "','node"
								+ strStationID
								+ "','<a style=\"cursor:hand\" onclick=SelectFDID(\""
								+ strSPID
								+ "\")>通道</a>',"
								+ "'','["
								+ strSPID
								+ "]','','js_tree/image/file.png','','true');\n";
					}
				}
			}

		}
		finally
		{
			DBUtil.close(cn);
		}
		strResult += "document.write(d);";
		return strResult;
	}
	
	// --------

	
    public List getstationList(Connection cn,String user_id)
	throws Exception{
		List list = new ArrayList();
		String sql = "";
		List userStationList = null;
		List idList = new ArrayList();
		String[]arr = null;
		String station_ids = null;
		int i,num=0;
		Map map = null;
		String ids = "";
		String id = null;
		Map stationMap = new HashMap();
		List stationList = null;
		Map stationSbMap = null;
		
		String strUserName2 =  (String) request.getSession().getAttribute(
			"user_name");
		if(strUserName2.compareTo("admin") == 0)
		{
			//sql = "select * from t_sys_user_station where user_id in (select user_id from t_sys_user where user_name='admin')";
		           sql = "select station_id as station_ids from t_cfg_station_info ";

}
		else
		{
			sql = "select * from t_sys_user_station where user_id='"+user_id+"' ";
		}
		userStationList = DBUtil.query(cn,sql,null);
		num = userStationList.size();
		for(i=0;i<num;i++){
			map = (Map)userStationList.get(i);
			station_ids = (String)map.get("station_ids");
			if(StringUtil.isempty(station_ids)){continue;}
			ids=ids+","+station_ids;
			
		}
		//System.out.println(sql+","+ids);
		
		arr = ids.split(",");
		num=arr.length;
		
		for(i=0;i<num;i++){
			id=arr[i];
			if(StringUtil.isempty(id)){continue;}
			idList.add(id);
		}
		//System.out.println(idList.size());
		
		sql = "select station_id,station_type,station_desc,area_id from t_cfg_station_info ";
		stationList = DBUtil.query(cn,sql,null);
		
		num = stationList.size();
		//System.out.println(num);
		
		for(i=0;i<num;i++){
			map = (Map)stationList.get(i);
			stationMap.put(map.get("station_id"),map); 
		}
		
		sql = "select station_id,sb_id from t_sp_sb_station";
		stationSbMap  = DBUtil.getMap(cn,sql);
		//System.out.println(stationSbMap);
		num = idList.size();
		String sb_id = null;
		
		for(i=0;i<num;i++){
			id = (String)idList.get(i);
			map = (Map)stationMap.get(id);
			if(map==null){continue;}
			sb_id = (String)stationSbMap.get(id);
			//System.out.println(map+","+sb_id+","+id);
			if(StringUtil.isempty(sb_id)){continue;}
			map.put("sb_id",sb_id);
			list.add(map);
			
			
		}
		
		
		
		
		
		return list;
	}
    public List getstationList(String user_id)
	throws Exception{
    	Connection cn = null;
    	try{
    	cn = DBUtil.getConn();
    	return getstationList( cn,user_id);
    	}catch(Exception e){
    		throw e;
    		}finally{DBUtil.close(cn);}
    	
    }
    
    public List getstationList(Connection cn,String user_id,String station_id)
	throws Exception{
    	List list = new ArrayList();
    	String sql = null;
    	List list2 = null;
    	Map map = null;
    	int i,num =0;
    	String ids = "";
    	String station_ids = null;

		String strUserName2 =  (String) request.getSession().getAttribute(
			"user_name");
		if(strUserName2.compareTo("admin") == 0)
		{
			sql = "select station_ids from t_sys_user_station ";
		}
		else
		{
			sql = "select station_ids from t_sys_user_station where user_id='"+user_id+"' ";
		}
    	list2 = DBUtil.query(cn,sql,null);
    	num = list2.size();
    	for(i=0;i<num;i++){
    		map=(Map)list2.get(i);
    		
    		station_ids = (String)map.get("station_ids");
    		if(StringUtil.isempty(station_ids)){continue;}
    		ids=ids+","+station_ids;
    		
    	}
    	if(StringUtil.isempty(ids)){return list;}
    	ids=","+ids+",";
    	if(ids.indexOf(","+station_id+",")<0){return list;}
    	sql = "select station_id,station_type,station_desc,area_id from t_cfg_station_info where station_id='"+station_id+"'";
    	map = DBUtil.queryOne(cn,sql,null);
    	if(map==null){return list;}
    	sql = "select sb_id from t_sp_sb_station where station_id='"+station_id+"'";
    	Map map2 = DBUtil.queryOne(cn,sql,null);
    	if(map2==null){return list;}
    	String sb_id = (String)map2.get("sb_id");
    	if(StringUtil.isempty(sb_id)){return list;}
    	map.put("sb_id",sb_id);
    	list.add(map);
    	return list;
    }
    
	
  
}
	
	
      

%>


<%
   //out.println(StringUtil.getNowTime());

   String user_id = (String)session.getAttribute("user_id");
   if(StringUtil.isempty(user_id)){
   JspUtil.rd(request,response,"/pages/commons/nologin.jsp");
   return;
   }
   NewVideo_biz2 nvb = null;
   try{
    nvb = new NewVideo_biz2(request);
			nvb.Page_Load();
   }catch(Exception e){
   JspUtil.go2error(request,response,e);
   return;
   }
   
%>
<HTML>
	<HEAD>
		<title>视频监控</title>
		<script language="javascript" src="dtree.js"></script>
		<script language="javascript" src="js_tree/treeview.js"></script>
		<LINK href="dtree.css" type="text/css" rel="stylesheet">
		<LINK href="js_tree/treeview.css" type="text/css" rel="stylesheet">
		<LINK rel="stylesheet" href="/web/pages/site/sp/images/css.css" type="text/css"></LINK>
		<style>
			td{font-size:9pt}
		</style>
		<script language='javascript'>
			var oldFDID = null;
			var lResult = null;
			var b_HasLogin = false;
			var OldSize=0;
			var PanelHandle='';//空闲窗口句柄
			var aryView = new Array();
			
			function InitObjSize()
			{
				var objWidth = document.getElementById("tdObj").offsetWidth;
				var objHeight = window.document.body.offsetHeight;
				var objBodyWidth = window.document.body.offsetWidth;
				var NewHeight = parseInt(objWidth * 3 / 4);
				var NewWidth = parseInt(objHeight * 4 / 3);
				if(NewHeight > objHeight)
				{
					document.getElementById("VideoPanelOcx").style.width = NewWidth+"px";
					document.getElementById("VideoPanelOcx").style.height = (objHeight-4)+"px";
				}
				else
				{ 
					document.getElementById("VideoPanelOcx").style.height = (NewHeight-4)+"px";
				}
				
				var control1Height = document.getElementById("control1").offsetHeight;
				var control2Height = document.getElementById("control2").offsetHeight;
				var listheadHeight = document.getElementById("listhead").offsetHeight;
				var control3Height = objHeight - control1Height - control2Height - listheadHeight - 25;
				
				document.getElementById("list").style.height = control3Height+"px";
				
				if(document.getElementById("VideoPanelOcx").style.width.indexOf("px") != -1)
				{
					var VideoPanelOcxWidth = document.getElementById("VideoPanelOcx").style.width.substring(0,document.getElementById("VideoPanelOcx").style.width.length-2);
					document.getElementById("tdObj").style.width = VideoPanelOcxWidth+"px";
					document.getElementById("tdControl").style.width = (objBodyWidth - parseInt(VideoPanelOcxWidth) - 2)+"px";
				}
			}
			//选择视频
			function SelectFDID(IniFDID)
			{
				document.getElementById("tbxFDID").value = IniFDID;
				var bFlag = false;
				for(var i = 0; i < aryView.length; i ++)
				{
					if(aryView[i] == IniFDID)
					{
						bFlag = true;
						break;
					}
				}
				if(oldFDID != IniFDID && bFlag == false)
				{
					if(document.getElementById("VideoPanelOcx").GetCameraID().length == 0)
						PanelHandle=document.getElementById("VideoPanelOcx").GetPaneHandleString();//获得空闲窗口名柄
					else
					{
						PanelHandle = document.getElementById("VideoPanelOcx").GetSelectedWndHandle();//获得已有窗口名柄
						Stop();
					}
					
			  		document.getElementById("WebOcx").StartLiveVideo(IniFDID,PanelHandle);
			  		document.getElementById("WebOcx").EnableStream(IniFDID,2,true);
			  		
					oldFDID = IniFDID;
					aryView[aryView.length + 1] = IniFDID;
				}
				else
				{
					alert('该视频已显示在窗口中');
				}
			}
			//视频登陆
			function Login()
			{
				var objIP = document.getElementById("tbxIP").value;
				var objPort = document.getElementById("tbxPort").value;
				var objAccount = document.getElementById("tbxAccount").value;
				var objPwd = document.getElementById("tbxPwd").value;
				lResult = document.getElementById("WebOcx").Login(objIP,objPort,objAccount,objPwd);
				if(lResult != 0)
					alert('该站位没有视频');
				else
				{
					b_HasLogin = true;
				}
			}
			//停止视频方法
			function Stop()
			{
				//关闭视频以后显示视频容器颜色
				var tempFDID = document.getElementById("VideoPanelOcx").GetCameraID();
				var j = -1;
				for(var i = 0; i < aryView.length; i ++)
				{
					if(aryView[i] == tempFDID)
					{
						j =i;
					}
					
					if(j != -1 &&  i >= j && j != aryView.length - 1)
					{
						aryView[i] = aryView[i + 1];
					}
				}
				
				if(j != -1)
				{
					aryView.length = aryView.length - 1;
				}
				
				document.getElementById("WebOcx").StopLiveVideo(tempFDID);
				document.getElementById("VideoPanelOcx").SetPaneInfo('', '', '',document.getElementById("VideoPanelOcx").GetSelectedWndHandle());
			}
			//释放ocx控件
			function destroyOcx()
			{
				document.getElementById("WebOcx").Destroy();	
			}
			//
			function TurnOnAudio()
			{
				lResult = document.getElementById("WebOcx").EnableStream(document.getElementById("VideoPanelOcx").GetCameraID(),2,true);
				alert(lResult);
			}
			//云台的左转
			function TurnLeft()
			{
				if(b_HasLogin)
				{
					document.getElementById("WebOcx").SendPtzCommand(document.getElementById("VideoPanelOcx").GetCameraID(),2, 5);
					window.setTimeout(StopTurn,500);
				}	
			}
			//云台的右转
			function TurnRight()
			{
				if(b_HasLogin)
				{
					document.getElementById("WebOcx").SendPtzCommand(document.getElementById("VideoPanelOcx").GetCameraID(),4, 5);
					window.setTimeout(StopTurn,500);
				}		
			}
			//云台上转
			function TurnUp()
			{
				if(b_HasLogin)
				{
					document.getElementById("WebOcx").SendPtzCommand(document.getElementById("VideoPanelOcx").GetCameraID(),1, 5);
					window.setTimeout(StopTurn,500);
				}		
			}
			//云台下转
			function TurnDown()
			{
				if(b_HasLogin)
				{
					document.getElementById("WebOcx").SendPtzCommand(document.getElementById("VideoPanelOcx").GetCameraID(),5, 5);
					window.setTimeout(StopTurn,500);
				}		
			}
			//停止转动
			function StopTurn()
			{
				if(b_HasLogin)
				{
					document.getElementById("WebOcx").SendPtzCommand(document.getElementById("VideoPanelOcx").GetCameraID(),13, 5);
				}		
			}
			//改变面板数
			function changPanlNumber(Num)
			{
				document.getElementById("VideoPanelOcx").OnShowVideoPanes(Num);
			}
			//改变面板颜色
			function  changeBGColor()
			{
				if(b_HasLogin)
				{
					document.getElementById("VideoPanelOcx").ChangeBgColor(0);
				}
			}
			//聚焦
			function FocusIn()
			{
				if(b_HasLogin)
				{
					document.getElementById("WebOcx").SendPtzCommand(document.getElementById("VideoPanelOcx").GetCameraID(),0x07, 5);
			  	}		
			}
			//散焦
			function FocusOut()
			{
				if(b_HasLogin)
				{
					document.getElementById("WebOcx").SendPtzCommand(document.getElementById("VideoPanelOcx").GetCameraID(),0x09, 5);
			  	}	
			}
			//自动对焦
			function FocusAuto()
			{
				if(b_HasLogin)
				{
					document.getElementById("WebOcx").SendPtzCommand(document.getElementById("VideoPanelOcx").GetCameraID(),0x08, 5);
			 	}	
			}
			//查询用户状态
			function QueryUser()
			{
			  	alert("被查询用户: "+document.getElementById("tbxAccount").value);
				var userStatus = document.getElementById("WebOcx").QueryUserStatus(document.getElementById("tbxAccount").value);
			}
			//拉近镜头
			function LenNear()
			{
				if(b_HasLogin)
				{
					document.getElementById("WebOcx").SendPtzCommand(document.getElementById("VideoPanelOcx").GetCameraID(),0x0A, 5);
					window.setTimeout(StopTurn,500);
				}
			}
			//拉远镜头
			function LenFar()
			{
				if(b_HasLogin)
				{
					document.getElementById("WebOcx").SendPtzCommand(document.getElementById("VideoPanelOcx").GetCameraID(),0x06, 5);
					window.setTimeout(StopTurn,500);
	  			}
			}
			//开始录像
			function BeginRec()
			{
				if(b_HasLogin)
				{
					var res = document.getElementById("WebOcx").StartRecording(document.getElementById("VideoPanelOcx").GetCameraID(),0,2);
					if(res != 0)
						alert("StartRecording result: "+res);
			  	}	
			}
			//停止录像
			function EndRec()
			{
				if(b_HasLogin)
				{
					var res = document.getElementById("WebOcx").StopRecording(document.getElementById("VideoPanelOcx").GetCameraID());
					if(res != 0)
						alert("StopRecording result: "+res);
				}
			}
			//改变视频大小
			function changeVideoSize()
			{
				OldSize=OldSize+50;
				document.getElementById("VideoPanelOcx").style.height=288+OldSize;
				document.getElementById("VideoPanelOcx").style.width=352+OldSize;
			}
			//改变视频大小
			function changeVideoSizesmall()
			{
				OldSize=OldSize-100;
				document.getElementById("VideoPanelOcx").style.height=288+OldSize;
				document.getElementById("VideoPanelOcx").style.width=352+OldSize;
			}
		</script>
		<!---开始视频事件--->
		<script language="javascript" for="WebOcx" event="OnMonitorStartRes(result);">
			if(result==0)
			{
				document.getElementById("VideoPanelOcx").SetPaneInfo(oldFDID, '', '',PanelHandle);
			}
			if(result != 0)
			{
    			document.getElementById("VideoPanelOcx").SetPaneInfo('', '', '',PanelHandle);
				alert("连接视频失败："+result);
			}
		</script>
		<script language="javascript" for="WebOcx" event="OnStartRecording(result);">
			if(result == 0)
			{
				var StartRectime=document.getElementById("WebOcx").GetStartRecordTime();
			}
			else
				alert("录像失败, 返回值为: "+result);
			</script>
		<!--停止录像事件响应-->
		<script language="javascript" for="WebOcx" event="OnStopRecording(result);">
			if(result == 0)
			{
				var EndRecTime=document.getElementById("WebOcx").GetStopRecordTime();
			}
			else
				alert("停止录像失败, 返回值为: "+result);
		</script>
		<!---查询用户状态事件--->
		<script language="javascript" for="WebOcx" event="OnUserStatusEx(username,result);">
			if(result == 0)
				alert(document.getElementById("tbxAccount").value+"不在线");
			if(result == 1)
				alert(document.getElementById("tbxAccount").value+"在线");
		</script>
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
		<OBJECT id="WebOcx" name="WebOcx" classid="clsid:A904F415-9B57-45A3-862F-B5C39775275E" codebase="webocx.cab#Version=1,0,1,1" width="0" height="0" class="style1" VIEWASTEXT>
		</OBJECT>
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
					<td style="width:30%;align:left;text-align:center" id="tdControl">
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
									<td align="center"><img src="img/con_top.gif" style="WIDTH:44px;CURSOR:hand;HEIGHT:35px" border="0" id="btnUp" name="btnUp" onclick="TurnUp()" title="向上" onMouseUp="StopTurn();" onmouseover="MM_swapImage('btnUp','','img/y_top2.gif',1)"
											onmouseout="MM_swapImgRestore()"></td>
									<td align="right" noWrap><img src="img/big2.gif" title="镜头拉近" onMouseDown="LenNear();" onMouseUp="StopTurn();" style="WIDTH:25px;CURSOR:hand;HEIGHT:24px" border="0"></td>
									<td align="right">    <img src="img/focusout2.gif" onclick="FocusIn()" style="WIDTH:41px;CURSOR:hand;HEIGHT:20px" border="0" alt="散焦"></td>
									<td> </td>
								</tr>
								<tr>
									<td> </td>
									<td noWrap align="right"><img src="img/con_left.gif" style="WIDTH:35px;CURSOR:hand;HEIGHT:43px" height="38" border="0" name="btnLeft" id="btnLeft" title="向左" onclick="TurnLeft()" onMouseUp="StopTurn();" onmouseover="MM_swapImage('btnLeft','','img/con_left2.gif',1)"
											onmouseout="MM_swapImgRestore()"></td>
									<td align="center" noWrap><img src="img/con_middle.gif" style="WIDTH:44px;CURSOR:hand;HEIGHT:43px" id="btnStop" onclick="Stop()" title="断开"></td>
									<td align="left"><img src="img/con_right.gif" style="WIDTH:35px;CURSOR:hand;HEIGHT:43px" name="btnRight" border="0" id="btnRight" title="向右" onclick="TurnRight()" onMouseUp="StopTurn();" onmouseover="MM_swapImage('btnRight','','img/con_right2.gif',1)"
											onmouseout="MM_swapImgRestore()"></td>
									<td align="right">    <img src="img/auto2.gif" style="WIDTH:41px;CURSOR:hand;HEIGHT:20px" onclick="FocusAuto()" height="35" border="0" alt="自动对焦"></td>
									<td> </td>
								</tr>
								<tr>
									<td> </td>
									<td></td>
									<td align="center"><img src="img/con_down.gif" style="WIDTH:44px;CURSOR:hand;HEIGHT:36px" border="0" name="btnDown" id="btnDown" onclick="TurnDown()" onMouseUp="StopTurn();" onmouseover="MM_swapImage('btnDown','','img/con_down2.gif',1)" onmouseout="MM_swapImgRestore()"></td>
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
							<div style="width;100%;height:300px;OVERFLOW:auto;text-align:left;valign:top" id="list" onresize = "InitObjSize();">
								<script type="text/javascript">										
									<%=nvb.GetStationTree()%>
								</script>
							</div>
							
							<div style="width:100%;text-align:center">
								<a href="VideoSetupNew.exe"><font color="red">控件下载</font></a>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<input type="hidden" id="tbxAccount" name="tbxAccount" value="<%=nvb.getStrAccount()%>" />
		<input type="hidden" id="tbxPwd" name="tbxPwd" value="<%=nvb.getStrPwd()%>" />
		<input type="hidden" id="tbxIP" name="tbxIP" value="<%=nvb.getStrIP()%>" />
		<input type="hidden" id="tbxPort" name="tbxPort" value="<%=nvb.getStrPort()%>" />
		<input type="hidden" id="tbxFDID" name="tbxFDID" value="<%=nvb.getStrFDID()%>" />
		<script language='javascript'>
		
		    try{
			lResult = document.getElementById("WebOcx").CreateInstance();
			}catch(e)
			{
			}
			if(lResult != 0)
			{
				alert("初始化失败");
			}
			InitObjSize();
			try{
			Login();
			}catch(e)
			{
			}
			function ShowVideo()
			{	
				var tempFDID = document.getElementById("tbxFDID").value;
				SelectFDID(tempFDID);
			}
			//window.setTimeout(ShowVideo,2000);
		</script>
	</body>
</HTML>