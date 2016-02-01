<%@ page contentType="text/html;charset=GBK" %>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.hoson.*"%>
<%@page import="com.hoson.app.*"%>
<%@page import="com.hoson.search.*" %> 
<%
 String station_id = null;
 Connection cn = null;
 String sql = null;
 String infectant_id = null;
 String img = null;
 Map chartStyleMap = new HashMap();
 Map map = null;
 String date1 = null;
 String date2 = null;
 String infectantCol = null;
 String title="";
 int hour1 = 0;
 int hour2 =0;
 int w = JspUtil.getInt(request,"w",750);
 int h = JspUtil.getInt(request,"h",300);
 List list = null;
 try{
  //f.sop("w="+w+",h="+h);
 infectant_id =request.getParameter("infectant_id");
 date1 = request.getParameter("date1");
 date2 = request.getParameter("date2");
 if(date1==null || date2==null){date1=date2=StringUtil.getNowDate()+"";}
 if(infectant_id==null){infectant_id="0";}

 //station_id=(String)session.getAttribute("station_id");
 station_id=request.getParameter("station_id");

 try{hour1 = Integer.parseInt(request.getParameter("hour1"));}catch(Exception e){hour1=StringUtil.getNowHour();}
 try{hour2 = Integer.parseInt(request.getParameter("hour2"));}catch(Exception e){hour2=StringUtil.getNowHour();}
 date1 = date1+" "+hour1+":0:0";
 date2 = date2+" "+hour2+":59:59";


 cn = DBUtil.getConn(request);
 infectantCol = App.getInfectantCol(cn,station_id,infectant_id);
 if(StringUtil.isempty(infectantCol)){
 //out.println("指标对应的数据列为空");
      JspUtil.go2error(request,response,"指标对应的数据列为空");
 return;
 }
 String chartTitle = NewChart.getChartTitle(infectant_id,request);
 	chartTitle = f.getChartTitle(chartTitle);
 	sql = "select  m_time,"+infectantCol+" as m_value,val01,val02,val03,val04,val05  from t_monitor_real_hour ";
 	sql = sql + "where station_id='"+station_id+"' ";
 	sql = sql + "and m_time>='"+date1+"' ";
 	sql = sql + "and m_time<='"+date2+"' order by m_time desc";
 	double[] arrDoubleVal = NewChart.getLimitValue(station_id,infectant_id,request);
 	
 	img = NewChart.getChart(sql,"yy-mm-dd-hh",chartTitle,arrDoubleVal,request);



 }catch(Exception e){
 //out.println(e+"<br><br>"+sql);
      JspUtil.go2error(request,response,e+","+sql);
 return;
 }finally{DBUtil.close(cn);}
 %>
<link href="/<%=JspUtil.getContextName(request)%>/styles/css1.css" rel="stylesheet" type="text/css">
<center>
<img src='<%=response.encodeURL("getchart.jsp?"+img)%>'>
<center>