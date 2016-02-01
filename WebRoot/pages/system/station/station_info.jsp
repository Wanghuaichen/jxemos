<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String station_type, area_id, station_name, sql = null;
Connection cn = null;
cn = DBUtil.getConn();
String stationTypeOption, areaOption = null;
Map<?, ?> map = null;
List<?> list = null;
RowSet rs = null;
String bar = null;
String id = null;
String wry_station_types = ",1,2,";
Map<String, String> params = new HashMap<String, String>();
try 
{
	//站点类型
	station_type = JspUtil.getParameter(request, "p_station_type","1");
	//地区编号
	area_id = JspUtil.getParameter(request, "p_area_id",f.cfg("default_area_id", "3301"));
	//站位名称
	station_name=request.getParameter("p_station_name");
	if(station_name == null ){
		station_name="";
	}else{
	//回显乱码
		station_name = new String(station_name.getBytes("ISO-8859-1"), "UTF-8");
	} 
	//站点类型下拉列表
	stationTypeOption = JspPageUtil.getStationTypeOption(cn,station_type);
	//地区下拉列表
	areaOption = JspPageUtil.getAreaOption(cn, area_id);
	
	params.put("cols", "*");
		if (!f.empty(station_type)) {
			params.put("station_type", station_type);
		}
		params.put("area_id", area_id);
		params.put("station_desc", station_name);
		params.put("order_cols", "station_no,area_id,station_desc");

		sql = f.getStationQuerySql(params, request);
		
		//System.out.println(sql);
		map = f.query(sql, null, request);

		list = (List<?>) map.get("data");
		bar = (String) map.get("bar");
		rs = new RowSet(list);
} catch (Exception e) {
	w.error(e);
	System.out.println(e);
	return;
} finally {
	f.close(cn);
}	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>站点管理</title>
  </head>
<link rel="stylesheet" href="<%=path %>/web/index.css" />
<style>
td {
	text-align: left;
}
* {
font-size: 12px;
}
</style> 
  <body>
   	<form name=form1 action="station_info.jsp"  method=post >
		<input type=hidden name="station_id">
		<input type="hidden" name="area_id">
		<table border="0" cellspacing="0">
			<tr>
				<td>
					<div style="margin: 10px 10px 10px 10px;">
						<select name=p_station_type onchange="form1.submit()">
							<option value="">
								全部类型
								<%=stationTypeOption%>
						</select> 地区: <select name=p_area_id onchange="form1.submit()">
							<!--  <option value="36">全部地区-->
							<%=areaOption %>
						</select> 站位名称: <input type=text name=p_station_name
							value="<%=station_name%>"> <input type=button
							value='查找站位' onclick="f_q()" class=tiaojianbutton> <input
							type=button value='添加站位' onclick="f_input()" class=tiaojianbutton>
						<input type=button value='站位序号' onclick="f_no()"
							class=tiaojianbutton>
					</div>
				</td>
			</tr>
		</table>
		<table border=0 cellspacing=1 class="nui-table-inner">
			<thead class="nui-table-head">
				<tr>
					<td class="nui-table-cell">编号</td>
					<td class="nui-table-cell">名称</td>
					<td class="nui-table-cell" width=200px>备注</td>
					<%
						if(wry_station_types.indexOf(station_type)>=0){
					%>
					<td class="nui-table-cell" width=80px>站点信息</td>
					<%
						}
					%>
				</tr>
			</thead>


			<%
				while(rs.next()){
								 id = rs.get("station_id");
			%>
			<tr>
				<td class="nui-table-cell"><%=id%></td>
				<td class="nui-table-cell"> <%=rs.get("station_desc")%>
<!-- 					<a href="javascript:f_view_info('<%=id%>')"><%=rs.get("station_desc")%></a> -->
				</td>
				<td class="nui-table-cell"><%=rs.get("station_bz")%></td>

				<%
					if(wry_station_types.indexOf(station_type)>=0){
				%>
				<td class="nui-table-cell"><a href="javascript:f_view('<%=id%>')">站点信息</a>
				</td>
				<%
					}
				%>
			</tr>
			<%
				}
			%>

			<%
				int colspan = 3;
				if (wry_station_types.indexOf(station_type) >= 0) {
					colspan += 1;
			%>
			<tr class="nui-table-row">
				<th class="nui-table-cell" colspan="<%=colspan%>"><%=bar%></th>
			</tr>
			<%
				}
			%>
		</table>		
	</form>
  </body>
  <script type="text/javascript">
		function f_view(id) {
			form1.station_id.value = id;
			form1.action = 'wry/station_view.jsp';
			form1.submit();
		}
		
		function f_q() {
			form1.action = 'station_info.jsp';
			form1.submit();
		}
		function f_no() {
			form1.action = 'no.jsp';
			form1.submit();
		}

		function f_input() {
			form1.action = 'input.jsp';
			form1.submit();
		}
  </script>
</html>
