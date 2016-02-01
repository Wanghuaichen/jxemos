<%@ page contentType="text/html;charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.hoson.*"%>
<%@page import="com.hoson.app.*"%>
<%@page import="com.hoson.util.*"%>
<%
String sql = null;

String option = null;
String date1 = null;
String date2 = null;


sql="select station_id,station_desc from t_cfg_station_info where station_type='6'";
try{
String area_id=App.getAreaId();
option = JspPageUtil.getAreaOption(area_id);

}catch(Exception e){
//out.println(e);
        JspUtil.go2error(request,response,e);
return;
}

date1=date2=StringUtil.getNowDate()+"";



%>

<link rel="StyleSheet" href="/<%=JspUtil.getCtx(request)%>/styles/css1.css" type="text/css" />
<script type="text/javascript" src="/<%=JspUtil.getCtx(request)%>/scripts/01.js"></script>
<script type="text/javascript" src="/<%=JspUtil.getCtx(request)%>/scripts/newdate.js"></script>

<body onload=f_submit()>

<form name="form1" method=post action="./air_rpt.jsp" target="air_rpt">
<table border=0 cellspacing=0>
<tr>
<td class=left>


<!--
站位<select name="station_id">
<%=option%>
</select>

从 <input name="date1" type="text" value="2006-08-16" class=date onclick="new Calendar().show(this);">

到 <input name="date2" type="text" value="2006-08-16" class=date onclick="new Calendar().show(this);">
-->
<select name=rpt_type onchange=f_submit()>

<option value="6">空气质量日报</option>
<option value="5">水质日报</option>

</select>
<select name=area_id onchange=f_submit()>
<option value="<%=App.get("area_id","33")%>">全部</option>
<%=option%>

</select>
<input type=input name=m_time value="<%=date1%>" class=date onclick="new Calendar().show(this);">



<input type="button" value="查看" class="btn" onclick=f_submit()>
</td>
</tr>
</table>
</form>

<iframe name="air_rpt"  width=100% height=100%  scrolling="auto" frameborder="0"  style="border:0px" allowtransparency="true">
</iframe>
</body>
<script>
function f_submit(){
  var type = form1.rpt_type.value;
  var url = "air_rpt.jsp";
  if(type=='5'){url = "water_rpt.jsp";}
  if(type=='6'){url = "air_rpt.jsp";}
  //alert(type+","+url);
  form1.action=url;
  form1.submit();
  
  
  

}


</script>



