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
      
      try{
      
      station_type = JspUtil.getParameter(request,"p_station_type","1");
     area_id = JspUtil.getParameter(request,"p_area_id",f.cfg("default_area_id","3301"));
      //area_id = JspUtil.getParameter(request,"p_area_id",f.cfg("area_id","3301"));
      station_name = JspUtil.getParameter(request,"p_station_name","");
      
      if(f.empty(station_type)){station_type="1";}
      
      
      
      cn = DBUtil.getConn();
      
      stationTypeOption = JspPageUtil.getStationTypeOption(cn,station_type);
      areaOption = JspPageUtil.getAreaOption(cn,area_id);
      
      
      
      
      sql = "select * from t_cfg_station_info where 2>1 ";
      if(!StringUtil.isempty(station_type)){
      sql=sql+" and station_type='"+station_type+"' ";
      }
      if(!StringUtil.isempty(area_id)){
      sql=sql+" and area_id like '"+area_id+"%' ";
      }
      if(!StringUtil.isempty(station_name)){
      sql=sql+" and station_desc like '%"+station_name+"%' ";
      }
      
      sql = sql+" order by area_id,station_desc";
      
      //System.out.println(sql);
      
      map = PagedQuery.query(cn,sql,null,request);
      
      list = (List)map.get("data");
      bar = (String)map.get("bar");
      rs = new RowSet(list);
      
      
      }catch(Exception e){
      JspUtil.go2error(request,response,e);
      return;
      }finally{DBUtil.close(cn);}
      
      
      
%>

<style>
td{
text-align:left;
}
</style>

<form name=form1 action=q.jsp method=post>
<input type=hidden name=station_id>
<table border=0 cellspacing=0>
<tr>
<td class=left>
<select name=p_station_type onchange=form1.submit()>
<option value="">
<%=stationTypeOption%>
</select>
地区
<select name=p_area_id onchange=form1.submit()>
<option value="">
<%=areaOption%>
</select>
站位名称
<input type=text name=p_station_name value="<%=station_name%>">

<input type=submit value=查看 class=btn>
<a href=input.jsp>添加站位</a>


</td>
</tr>
</table>

<table border=0 cellspacing=1>

<tr class=pageBar>
<td colspan=10><%=bar%></td>
</tr>

<tr class=title>
<td>编号</td>
<td>名称</td>
<td width=200px>备注</td>
<%if(wry_station_types.indexOf(station_type)>=0){%>
 <td width=80px>污染源属性</td>
<%}%>
</tr>

<%
	while(rs.next()){
	 id = rs.get("station_id");

%>

<tr>
<td><a href="javascript:f_view('<%=id%>')"><%=id%></td>
<td><a target='new' href=./infectant/q.jsp?station_id=<%=id%>><%=rs.get("station_desc")%></a></td>
<td><%=rs.get("station_bz")%></td>

<%if(wry_station_types.indexOf(station_type)>=0){%>
 <td><a target=new href='./wry/view.jsp?station_id=<%=id%>'>污染源属性</a></td>
<%}%>
</tr>


<%}%>

</table>



</form>

<script>

function f_view(id){
 form1.station_id.value=id;
 form1.action='view.jsp';
 form1.submit();
}
</script>












