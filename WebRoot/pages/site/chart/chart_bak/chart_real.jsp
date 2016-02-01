<%@ page contentType="text/html;charset=GBK" %>
<%@page import="com.hoson.*"%>
<%@page import="com.hoson.app.*,com.hoson.ps.*" %> 
<%
	String option = null;
	String img = null;
        int w = 0;
        int h =0;
        int refresh_time = JspUtil.getInt(request,"refresh_time",30);
         String infectant_id=request.getParameter("infectant_id");
         String station_id = request.getParameter("station_id");
         String station_name=lshUpdate.getStationName(station_id,request);
        int row_num = JspUtil.getInt(request,"row_num",100);
        row_num=1500;
        String date3 = request.getParameter("date3");
        String hour3 = request.getParameter("hour3");
        w = JspUtil.getInt(request,"w",750);
        h = JspUtil.getInt(request,"h",280);
        String chart_form = request.getParameter("chart_form");
	try{
	
		if(StringUtil.isempty(infectant_id)){
	throw new Exception("请选择监测指标");
	}
	
		option = App.getInfectantOption(request);

		String chartTitle = NewChart.getChartTitle(infectant_id,request);
chartTitle = "("+station_name+")"+f.getChartTitle(chartTitle);
//img = NewChart.getRealChart(row_num,w,h,20,20,50,20, chartTitle,request);
	img = NewChart.getRealChart_new(row_num,w,h,20,20,50,20, chartTitle,request,chart_form);
	
	
	}catch(Exception e){
	
                //out.println(e);
                     JspUtil.go2error(request,response,e);
                return;
	}
%>
<%-- 
<meta http-equiv="Refresh" content="<%=refresh_time%>;url=chart_real.jsp?infectant_id=<%=infectant_id%>&station_id=<%=station_id%>&row_num=<%=row_num%>&w=<%=w%>&h=<%=h%>&date3=<%=date3%>&hour3=<%=hour3%>">
--%>
<link href="/<%=JspUtil.getContextName(request)%>/styles/css1.css" rel="stylesheet" type="text/css">
<title>实时曲线</title>
<!--<img src="../../../tmp/img/<%=img%>">-->
<img src='<%=response.encodeURL("getchart.jsp?"+img)%>'>



