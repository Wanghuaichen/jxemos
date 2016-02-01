<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      
      Connection cn = null;
   
      Map map,row = null;
      List list = null;
      RowSet rs = null;
      String bar = null;
      String station_id,sql,station_type,infectant_id = null;
      List infectantList = null;
      List stationInfectantList = null;
      int i,j,num=0;
      XBean b = null;
      map = new HashMap();
      String flag = "0";
      String rpt_flag = "0";
      String form = null;
      String show_btn_flag = request.getParameter("show_btn_flag");
      String station_desc = null;
      try{
      show_btn_flag="1";
      station_id = request.getParameter("station_id");
       if(StringUtil.isempty(station_id)){
     throw new Exception("请选择站位");
     }
      cn = DBUtil.getConn();
     sql = "select station_type,station_desc from t_cfg_station_info where station_id='"+station_id+"'";
     map = DBUtil.queryOne(cn,sql,null);
     if(map==null){
     throw new Exception("站位不存在");
     }
      station_type = (String)map.get("station_type");
      station_desc = (String)map.get("station_desc");
         if(StringUtil.isempty(station_type)){
     throw new Exception("请配置监测类型");
     }
      
      sql = "select infectant_id,infectant_name,infectant_column from t_cfg_infectant_base ";
      sql=sql+" where station_type='"+station_type+"' and infectant_type!='0'";
      sql=sql+" order by infectant_order";
      
      infectantList = DBUtil.query(cn,sql,null);
      
      sql="select * from t_cfg_monitor_param where station_id='"+station_id+"'";
      
      stationInfectantList = DBUtil.query(cn,sql,null);
      
      num = stationInfectantList.size();
      for(i=0;i<num;i++){
      
       row = (Map)stationInfectantList.get(i);
       map.put(row.get("infectant_id"),row);
       
       
      
      }
      
      rs = new RowSet(infectantList);
      
      
      
      }catch(Exception e){
      JspUtil.go2error(request,response,e);
      return;
      }finally{DBUtil.close(cn);}
      
      
      
%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<style>
td{
text-align:left;
}
.v{
width:50px;
}
</style>
<link rel="stylesheet" href="<%=path%>/web/index.css" />
<title><%=station_desc%></title>
<table border=0 cellspacing=1 class="nui-table-inner">
	<thead class="nui-table-head">
		<tr>
			<td class="nui-table-cell">序号</td>
			<td class="nui-table-cell">是否监测</td>
			<td class="nui-table-cell">名称</td>
			<td class="nui-table-cell">标准值</td>
			<td class="nui-table-cell">预警下限</td>
			<td class="nui-table-cell">预警上限</td>
			<td class="nui-table-cell">报警下限</td>
			<td class="nui-table-cell">报警上限</td>
			<td class="nui-table-cell">量程下限</td>
			<td class="nui-table-cell">量程上限</td>
			<td class="nui-table-cell">报表是否打印</td>
			<td class="nui-table-cell">显示顺序</td>
			<td class="nui-table-cell">保存</td>
<!-- 		<%if(StringUtil.equals(show_btn_flag,"1")){%> -->
<!-- 		<td></td> -->
<!-- 		<%}%> -->
		</tr>
	</thead>
<%
	while(rs.next())
	{
		infectant_id=rs.get("infectant_id");
		form="form_"+rs.getIndex();
		row = (Map)map.get(infectant_id);
		if(row==null){flag=" ";}else{flag=" checked";}
	
		b= new XBean(row);
		if(StringUtil.equals(b.get("report_flag"),"1")){
		rpt_flag=" checked";
		}else{
		rpt_flag=" ";
		}
%>

  <tr>
  	<form name="<%=form%>"  method="post">
  		<input type=hidden name=station_id value="<%=station_id%>">
  		<input type=hidden name=infectant_id value=<%=infectant_id%>>
  		<input type=hidden name=infectant_column value=<%=rs.get("infectant_column")%>>
  		<input type=hidden name=group_id value="01">
		<td align="center"><%=rs.getIndex()+1%></td>
  		<td><input type=checkbox name=flag value="1" <%=flag%>></td>
  		<td><%=rs.get("infectant_name")%></td>
  		<td><input class=v type=text name=standard_value value='<%=b.get("standard_value")%>'></td>
  		<td><input  class=v type=text name=lo value='<%=b.get("lo")%>'></td>
  		<td><input class=v  type=text name=hi value='<%=b.get("hi")%>'></td>
  		<td><input  class=v type=text name=lolo value='<%=b.get("lolo")%>'></td>
    	<td><input  class=v type=text name=hihi value='<%=b.get("hihi")%>'></td>
   		<td><input  class=v type=text name=lolololo value='<%=b.get("lolololo")%>'></td>
  		<td><input class=v  type=text name=hihihihi value='<%=b.get("hihihihi")%>'></td>
  		<td><input type=checkbox name=report_flag value="1" <%=rpt_flag%>></td>
   		<td><input class=v  type=text name=show_order value='<%=b.get("show_order")%>'></td>
  		<%if(StringUtil.equals(show_btn_flag,"1"))
  		{%>
  		<td><input type=button value=保存 onclick="f_save(<%=form%>)" class=btn>	</td>
 	 <%}%>
  	</form>
  </tr>
<%}%>
</table>
<iframe name="u"  width=500 height=100  scrolling="auto" frameborder="0"  style="border:0px" allowtransparency="true">
</iframe>

<script>
function f_save(f){
//alert(f);
	f.action="u.jsp";
	f.target="u";
	f.submit();
}
</script>
