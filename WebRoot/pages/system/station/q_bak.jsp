<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      String station_type,area_id,station_name,sql=null;
      Connection cn = null;
      String stationTypeOption,areaOption = null;
      Map map = null;
      List list = null;
      RowSet rs = null;
      String bar = null;
      String id = null;
      String wry_station_types = ",1,2,";
      Map params = new HashMap();
      
      try{
      
      station_type = JspUtil.getParameter(request,"p_station_type","1");
     area_id = JspUtil.getParameter(request,"p_area_id",f.cfg("default_area_id","3301"));
      //area_id = JspUtil.getParameter(request,"p_area_id",f.cfg("area_id","3301"));
      station_name = JspUtil.getParameter(request,"p_station_name","");
      
      if(f.empty(station_type)){station_type="1";}
      
      params.put("cols","*");
      params.put("station_type",station_type);
      params.put("area_id",area_id);
      params.put("station_desc",station_name);
      params.put("order_cols","station_no,area_id,station_desc");
      
      sql = f.getStationQuerySql(params,request);
      
      map = f.query(sql,null,request);
      
      list = (List)map.get("data");
      bar = (String)map.get("bar");
      rs = new RowSet(list);
      
      
      }catch(Exception e){
      w.error(e);
      return;
      }
      
      
      
%>

<style>
td{
text-align:left;
}
</style>

<form name=form1 action=q.jsp method=post>
<input type=hidden name=station_id>
<input type=hidden name='p_station_type' value='<%=w.p("p_station_type")%>'>
<input type=hidden name='p_area_id' value='<%=w.p("p_area_id")%>'>
<input type=hidden name='p_station_name' value='<%=w.p("p_station_name")%>'>

<div class='page_bar'><%=bar%></div>


<table border=0 cellspacing=1>



<tr class=title>
<td>编号</td>
<td>名称</td>
<td width=200px>备注</td>
<%-- 
<%if(wry_station_types.indexOf(station_type)>=0){%>
 <td width=80px>污染源属性</td>
<%}%>
--%>
</tr>

<%
	while(rs.next()){
	 id = rs.get("station_id");

%>

<tr>
<td><%=id%></td>
<td><a href="javascript:f_view_info('<%=id%>')"><%=rs.get("station_desc")%></a></td>
<td><%=rs.get("station_bz")%></td>
<%-- 
<%if(wry_station_types.indexOf(station_type)>=0){%>
 <td>
 
 <a href="javascript:f_view('<%=id%>')">污染源属性</a>
 </td>
<%}%>
--%>
</tr>


<%}%>

</table>



</form>

<script>

function f_view_info(id){
 form1.station_id.value=id;
 form1.action='view.jsp';
 form1.submit();
}

function f_view(station_id){
	var url = "./wry/view.jsp";
	url = url+"?station_id="+station_id;
	var width = 1224;
	var height = 468;
	window.open(url,"","scrollbars=yes,resizable=yes"+",height="+height+",width="+width+",left="+(window.screen.width-width)/2+",top="+(window.screen.height-height)/2);
	
}
</script>












