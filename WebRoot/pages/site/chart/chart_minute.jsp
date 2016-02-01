<%@page import="com.hoson.search.chart"%>
<%@ page contentType="text/html;charset=GBK" %>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.hoson.*"%>
<%@page import="com.hoson.app.*,com.hoson.ps.*" %> 
<%
String station_id,station_name = null;
Connection cn = null;
String sql = null;
String option = null;
String infectant_id = null;
String img = null;
List list = null;
String infectantCol=null;
Map chartStyleMap = new HashMap();
//String title="实时曲线";
String title="";
int hour1 = 0;
int hour2 =0;
String date1 = null;
String date2 = null;
int rowNum =0;
int maxRowNum = 10000;
String sh_flag="";
int w = JspUtil.getInt(request,"w",750);
int h = JspUtil.getInt(request,"h",300);
String f = null;
 String view_flag =null;
try{
f=request.getParameter("f");
if(StringUtil.isempty(f)){
f="yy-mm-dd-hh-nn";
}
infectant_id = JspUtil.getParameter(request,"infectant_id");
view_flag = request.getParameter("view_flag");
   String chart_form = request.getParameter("chart_form");
if(infectant_id==null){infectant_id="0";}
date1 = request.getParameter("date1");
date2 = request.getParameter("date2");
if(date1==null || date2==null){date1=date2=StringUtil.getNowDate()+"";}

//station_id=(String)session.getAttribute("station_id");
station_id=request.getParameter("station_id");
 station_name=lshUpdate.getStationName(station_id,request);

try{hour1 = Integer.parseInt(request.getParameter("hour1"));}catch(Exception e){hour1=StringUtil.getNowHour();}
try{hour2 = Integer.parseInt(request.getParameter("hour2"));}catch(Exception e){hour2=StringUtil.getNowHour();}
date1 = date1+" "+hour1+":0:0";
date2 = date2+" "+hour2+":59:59";


cn = DBUtil.getConn(request);
  sh_flag = request.getParameter("sh_flag_select");
  String data_table="t_monitor_real_ten_minute";
  if(!"".equals(sh_flag) && sh_flag.equals("1")){
			 data_table = data_table + "_v";
  }

 infectantCol = App.getInfectantCol(cn,station_id,infectant_id);
  if(StringUtil.isempty(infectantCol)){
  //out.println("指标对应的数据列为空");
       JspUtil.go2error(request,response,"指标对应的数据列为空");
  return;
  }
  String chartTitle = NewChart.getChartTitle(infectant_id,request);
  	chartTitle = "("+station_name+")" +com.hoson.f.getChartTitle(chartTitle);
  if(view_flag.equals("false")){
  	sql = "select  m_time,"+infectantCol+" as m_value,val01,val02,val03,val04,val05  from "+data_table+" ";
  	sql = sql + "where station_id='"+station_id+"' ";
  	sql = sql + "and m_time>='"+date1+"' ";
  	sql = sql + "and m_time<='"+date2+"' order by m_time desc";
  	double[] arrDoubleVal = NewChart.getLimitValue(station_id,infectant_id,request);
  	//double[] arrDoubleVal = {0.0,1500.0};
  	String url = "";
			String fileName = "";
			if (chart_form.equals("1")) {
				//img = NewChart.getChart(sql,"yy-mm-dd",chartTitle,arrDoubleVal,request);

				url = NewChart.getLineAnyChart(sql, "yy-mm-dd-hh",
						chartTitle, arrDoubleVal, request, data_table);
				
			}

			if (chart_form.equals("0")) {
				//chart chart = new chart();
				//img = chart.getChart(sql,750,320,20,20,50,20,chartTitle,"yy-mm-dd-hh",request);
				url = NewChart.getBarAnyChart(sql, "yy-mm-dd-hh",
						chartTitle, arrDoubleVal, request, data_table);
				
			}
			fileName = request.getSession().getServletContext()
						.getRealPath("")
						+ "/pages/site/chart/chart.xml";
			File file = new File(fileName);
			BufferedWriter output = new BufferedWriter(
					new OutputStreamWriter(new FileOutputStream(file),
							"UTF-8"));
			output.write(url);
			output.flush();
			output.close();
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
  list = chart.getChartImg(sql,"yy-mm-dd-hh",station_name,request,station_id);
  	
  }



  }catch(Exception e){
  //out.println(e+"<br><br>"+sql);
       JspUtil.go2error(request,response,e+","+sql);
  return;
  }finally{DBUtil.close(cn);}
 %>
<link href="/<%=JspUtil.getContextName(request)%>/styles/css1.css" rel="stylesheet" type="text/css">

<script type="text/javascript" language="javascript"
	src="../../flashmap/js/AnyChart.js" >
</script>
<script type="text/javascript" language="javascript">
			//         
			var chart = new AnyChart('../../flashmap/swf/AnyChart.swf');
			chart.width = 1225;
			chart.height = 557;
			chart.setXMLFile('./chart.xml');
			chart.write();
			//
		</script>