<%@ page contentType="text/html;charset=GBK" %>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.hoson.*"%>
<%@page import="com.hoson.app.*"%>
<%@page import="com.hoson.search.*,com.hoson.ps.*" %> 
<%
  String station_id,station_name = null;
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
  String chart_form="";
  int w = JspUtil.getInt(request,"w",750);
  int h = JspUtil.getInt(request,"h",300);
  String view_flag = request.getParameter("view_flag");
  List list = null;
  String sh_flag = null;
  try{
  infectant_id =request.getParameter("infectant_id");
  date1 = request.getParameter("date1");
  date2 = request.getParameter("date2");
  chart_form = request.getParameter("chart_form");
  if(date1==null || date2==null){date1=date2=StringUtil.getNowDate()+"";}
  if(infectant_id==null){infectant_id="0";}

  //station_id=(String)session.getAttribute("station_id");
  station_id=request.getParameter("station_id");
   station_name=lshUpdate.getStationName(station_id,request);
   
   sh_flag = request.getParameter("sh_flag_select");
  		 
  		  String data_table="t_monitor_real_month";
         if(!"".equals(sh_flag) && sh_flag.equals("1")){
			 data_table = data_table + "_v";
          }

  try{hour1 = Integer.parseInt(request.getParameter("hour1"));}catch(Exception e){hour1=StringUtil.getNowHour();}
  try{hour2 = Integer.parseInt(request.getParameter("hour2"));}catch(Exception e){hour2=StringUtil.getNowHour();}
  date1 = date1+" "+hour1+":0:0";
  date2 = date2+" "+hour2+":0:0";


  cn = DBUtil.getConn(request);
  infectantCol = App.getInfectantCol(cn,station_id,infectant_id);
  if(StringUtil.isempty(infectantCol)){
  //out.println("指标对应的数据列为空");
       JspUtil.go2error(request,response,"指标对应的数据列为空");
  return;
  }
  String chartTitle = NewChart.getChartTitle(infectant_id,request);
  chartTitle = "("+station_name+")"+f.getChartTitle(chartTitle);
  if(view_flag.equals("false")){
  sql = "select  m_time,"+infectantCol+" as m_value,val01,val02,val03,val04,val05  from "+data_table+" ";
  sql = sql + "where station_id='"+station_id+"' ";
  sql = sql + "and m_time>='"+date1+"' ";
  sql = sql + "and m_time<='"+date2+"' order by m_time asc";

  double[] arrDoubleVal = NewChart.getLimitValue(station_id,infectant_id,request);
  if(chart_form.equals("1")){
  	img = NewChart.getChart(sql,"yy-mm-dd",chartTitle,arrDoubleVal,request);
  }else{
		chart chart = new chart();
		img = chart.getChart(sql,750,320,20,20,50,20,chartTitle,"yy-mm-dd-hh",request);
	}
  }else{
  	chart chart = new chart();
  	Map infectantMap = chart.getInfectant(station_id, request);
  	String s = "";
  	Iterator it = infectantMap.entrySet().iterator();
  	
  	while (it.hasNext()){
  		Map.Entry m=(Map.Entry)it.next();
  		String key=m.getKey().toString();
  		s += ","+key;
  	}

  sql = "select m_time"+s+" from "+data_table+" where station_id='" +station_id+
  	"' and m_time>='"+date1+"' and m_time<='"+date2+"' order by m_time asc";
  list = chart.getChartImg(sql,"yy-mm",chartTitle,request,station_id);
  	
  }
  }catch(Exception e){
  //out.println(e+"<br>"+sql);
       JspUtil.go2error(request,response,e+","+sql);
  return;
  }finally{DBUtil.close(cn);}
 %>
<link href="/<%=JspUtil.getContextName(request)%>/styles/css1.css" rel="stylesheet" type="text/css">
<center>
<%if(view_flag.equals("false")){ %>
<img src='<%=response.encodeURL("getchart.jsp?"+img)%>'>
<%}else{
	for(int i=0;i<list.size();i++){ %>
<img src='<%=response.encodeURL("getchart.jsp?"+list.get(i).toString())%>'>
<%}}%>
<center>