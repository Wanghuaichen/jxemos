<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
String station_ids = null;

int idNum  =0;
String[]arr = null;
String siteTable = null;
String sqlInStr = null;
String sql = null;
String msg = null;

arr = App.getStationIdArr(request);

//out.println(StringUtil.arr2str(arr,","));

if(arr==null){
	//out.println("��ѡ��Ҫ�Ƚϵ�վλ������1��");
	msg = "��ѡ��Ҫ�Ƚϵ�վλ������1��";
	JspUtil.go2error(request,response,msg);
	return;}
idNum = arr.length;
if(idNum<1){
	//out.println("��ѡ��վλ������1��");
	JspUtil.go2error(request,response,msg);
	return;
	}
if(idNum>10){
	//out.println("�Ƚϵ�վλ���ܳ���10��");
	msg = "�Ƚϵ�վλ���ܳ���10��";
	JspUtil.go2error(request,response,msg);
	return;
	}

String infectant_id = null;
infectant_id = request.getParameter("infectant_id");
if(StringUtil.isempty(infectant_id)){
	//out.println("��ѡ��һ��ָ��");
	msg = "��ѡ��һ��ָ��";
	JspUtil.go2error(request,response,msg);
	return;
	}
String type = request.getParameter("chart_type");
if(StringUtil.isempty(type)){type="t_monitor_real_day";}
String table = "";
//�Ʊ����
		//table = App.getChartTypeTable(type);
		table = type;
		if (request.getParameter("sh_flag").equals("1")) {
			table = table + "_v";
		}
		///����

//String table = App.getChartTypeTable(type);
Properties prop = JspUtil.getReqProp(request);
List sqlList = null;
prop.setProperty("table",table);
Connection cn = null;
String img = null;
int chartw = 800;
int h = 360;
String col = null;
Map map = null;
String df = "yy-mm-dd";
try{

  chartw = JspUtil.getInt(request,"w",760);
h = JspUtil.getInt(request,"h",400);
//f.sop(w+","+h);
chartw = chartw-30;
h = h-30;
//f.sop(w+"----"+h);


cn = DBUtil.getConn(request);
sqlInStr = StringUtil.arr2str(arr,"','");
sql = "select station_id,station_desc from t_cfg_station_info where station_id in("+"'"+sqlInStr+"')";
map = App.getKeyValueMap(cn,sql);
sqlList = App.getCompareSqlList(cn,arr,infectant_id,map,prop);
//img = NewChart.getChart(sqlList,800,420,20,20,50,50,request);
String chartTitle = NewChart.getChartTitle(infectant_id,request);
if(StringUtil.equals(type,"hour")){
df = "yy-mm-dd-hh";
}
if(StringUtil.equals(type,"month")){
df = "yy-mm";
}
chartTitle = f.getChartTitle(chartTitle);
img = NewChart.getChart(sqlList,chartw,h,20,20,50,50,chartTitle,df,request);

}catch(Exception e){
//out.println(e);
JspUtil.go2error(request,response,e);
return;
}finally{
DBUtil.close(cn);
}
%>

<link rel="StyleSheet" href="/<%=JspUtil.getContextName(request)%>/styles/css.css" type="text/css" />
<!--<style>
body{background-color:#ffffff;}
</style>-->
<center>

<!--<img src="/<%=JspUtil.getContextName(request)%>/tmp/img/<%=img%>">-->

<img src='<%=response.encodeURL("getchart.jsp?"+img)%>'>

</center>


