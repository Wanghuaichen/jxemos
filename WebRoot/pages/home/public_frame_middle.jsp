<%@ page contentType="text/html;charset=GBK" %>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.hoson.*"%>
<%@page import="com.hoson.app.*"%>


<%
int flag = JspUtil.getInt(request,"flag",0);
String js = null;
if(flag>0){js=" onload='f_submit()'";}else{js="";}

%>


<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="0">

<link href="/<%=JspUtil.getContextName(request)%>/styles/css1.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	FONT-SIZE: 9pt;
}

TR {FONT-SIZE: 9pt}
TD {FONT-SIZE: 9pt; LINE-HEIGHT: 12px;height:20px;text-align: left; vertical-align: middle}
-->
</style>



<body bgcolor="DFEBF9" <%=js%>>

<table border=0 cellspacing=0   style="width:100%;height:100%">
<tr>
<td class="left">


<%
String station_id = null;
String station_name = null;
String sql = null;
String s = null;

Map map = null;
String action_type = null;
String comm_state = null;
String comm_state_desc = null;
flag  =0;


try{
station_id = request.getParameter("station_id");
//if(StringUtil.isempty(station_id)){out.println("参数station_id不能为空");return;}
if(StringUtil.isempty(station_id)){out.println("");return;}
sql = "select station_id,station_desc,comm_state from t_cfg_station_info where station_id='"+station_id+"'";

map=DBUtil.queryOne(sql,null,request);
if(map==null){out.println("站位["+station_id+"]不存在");return;}

station_name = (String)map.get("station_desc");
comm_state = (String)map.get("comm_state");

if(StringUtil.equals(comm_state,"0")){
comm_state_desc = "脱机";
flag =1;
}
if(StringUtil.equals(comm_state,"1")){
comm_state_desc = "联机";
flag =1;
}

if(flag<1){
comm_state_desc = "脱机";
}



action_type = (String)session.getAttribute("action_type");
if(action_type==null){
action_type = "site_qx";
session.setAttribute("action_type",action_type);
}
session.setAttribute("station_id",station_id);
session.setAttribute("station_name",station_name);

comm_state_desc = SiteCompute.getSiteState(station_id,request);


}catch(Exception e){out.println(e+"\n"+sql);}

%>



&nbsp;&nbsp;&nbsp;<!--站位ID <%=station_id%>--> 站位名称 <%=station_name%>
&nbsp;&nbsp;
通讯状态 <%=comm_state_desc%>
</td>
</tr>
</table>


<form name=form1 target="zw_top" method=post>
<input type=hidden name="station_id" value="<%=station_id%>">
<input type=hidden name="station_name" value="<%=station_name%>">


</form>
</body>

<script>
function f_submit(){
form1.action="../site/zw.jsp";
form1.target="zw_right";
form1.submit();
}
</script>




