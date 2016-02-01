<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
   String stationTypeOption = null;
   String station_type = null;
   String station_name = null;
   Connection cn = null;
   String sql = null;
   List list = null;
   int i,num=0;
   Map map = null;
   String id,name,id2 = null;
   Map m2 = null;
   try{
   station_type = JspUtil.getParameter(request,"station_type");
   station_name = JspUtil.getParameter(request,"station_name");
   
   if(StringUtil.isempty(station_type)){
    station_type = "1";
   }
   
     if(StringUtil.isempty(station_name)){
    station_name = "";
   }
   
   cn = DBUtil.getConn();
   stationTypeOption = JspPageUtil.getStationTypeOption(cn,station_type);
   sql = "select station_id,station_desc from t_cfg_station_info ";
   sql=sql+" where station_type='"+station_type+"' ";
   if(!StringUtil.isempty(station_name)){
   sql=sql+" and station_desc like '%"+station_name+"%'";
   }
   list = DBUtil.query(cn,sql,null);
   num=list.size();
     sql = "select station_id,station_id_nation from t_cfg_station";
   m2 = DBUtil.getMap(cn,sql);
   
   }catch(Exception e){
   JspUtil.go2error(request,response,e);
   return;
   }finally{DBUtil.close(cn);}

%>
<table border=0 cellspacing=0>
<tr><td class=left>
<form name=form1 method=post action=q.jsp>
  监测类型 <select name=station_type onchange=form1.submit()><%=stationTypeOption%></select>
  监测点名称  <input type=text name=station_name value="<%=station_name%>">
  <input type=submit value=查看> 
</form>
</td>
</tr>
</table>

<form name=form2 action=u.jsp method=post target=q>
<input type=hidden name=station_id>


<table border=0 cellspacing=1>

<tr class=title>
<td>序号</td>
<td>站位编号</td>
<td>名称</td>
<td>国控站位编号</td>
<td></td>
</tr>

<%
  for(i=0;i<num;i++){
    map=(Map)list.get(i);
    id=(String)map.get("station_id");
    //id2=(String)map.get("station_id_nation");
     id2 = (String)m2.get(id);
    name = (String)map.get("station_desc");
    if(id2==null){id2="";}
    
%>
  <tr>
  <td><%=i+1%></td>
  <td><%=id%></td>
  <td><%=name%></td>
  <td><input  style="width:200px" type=text name='x<%=id%>' value='<%=id2%>'></td>
 <td><input type=button onclick="f_u(<%=id%>)" value=保存></td>
 </tr>
<%}%>

</table>

<iframe name=q width=0 height=0></iframe>

<script>
function f_u(id){
    // alert(id);
    form2.station_id.value=id;
    form2.submit();
}
</script>





