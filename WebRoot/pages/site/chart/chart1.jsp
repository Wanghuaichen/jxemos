<%@ page contentType="text/html;charset=GBK" %>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.hoson.*"%>
<%@page import="com.hoson.app.*"%>
<%

App.updateSessionValue(request);

String s = null;
String cols="station_id,station_name,chart_type,infectant_id,date1,date2,hour1,hour2,date3,hour3,refresh_time,real_flag,row_num,date_format,date_axis_fix_flag,bar,flag_3d,h,w,view_flag";
s = JspUtil.getHiddenHtml(cols,request);
Properties prop = JspUtil.getReqProp(request);
String action = null;
String type = null;
int flag = 0;
	String msg = null;
//int real_flag = JspUtil.getInt(request,"real_flag",0);

if(StringUtil.isempty(prop.getProperty("station_id"))){
	//out.println("请选择一个站位");
	msg = "请选择一个站位";
	JspUtil.go2error(request,response,msg);
	return;
	}
if(StringUtil.isempty(prop.getProperty("infectant_id"))){
	//out.println("请选择一个指标");
	msg = "请选择一个指标";
	JspUtil.go2error(request,response,msg);
	return;
	}

type = prop.getProperty("chart_type");
String data_table = prop.getProperty("data_table");
type = prop.getProperty("data_table");
type="hour";
if(f.eq(data_table,"t_monitor_real_minute")){type="real";}
if(f.eq(data_table,"t_monitor_real_hour")){type="hour";}
if(f.eq(data_table,"t_monitor_real_day")){type="day";}
if(f.eq(data_table,"t_monitor_real_month")){type="month";}
//f.sop(type);
if(type==null){type="";}
//if(real_flag>0){type="real";}
if(type.equals("minute")){action="chart_minute.jsp";flag=1;}
if(type.equals("hour")){action="chart_hour.jsp";flag=1;}
if(type.equals("day")){action="chart_day.jsp";flag=1;}
if(type.equals("week")){action="chart_week.jsp";flag=1;}
if(type.equals("month")){action="chart_month.jsp";flag=1;}
if(type.equals("real")){action="chart_real.jsp";flag=1;}
if(flag<1){action="chart_day.jsp";}
//f.sop(s);
%>
<body onload="form1.submit()">
<form name=form1 method=post action="<%=action%>">
<%=s%>
</body>