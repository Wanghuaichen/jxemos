<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
  
  
  String station_type=request.getParameter("station_type");
  String area_id=request.getParameter("area_id");
  String user_id=request.getParameter("user_id");
  String sql = null;
  Connection cn = null;
  List stationList = null;
  int i,num=0;
  Map userStationMap = null;
  Map map = null;
  RowSet rs = null;
  String v = null;
  String station_id = null;
  String flag = null;
  String stationTypeOption = null;
  String areaOption = null;
  String ids = "";
  String top_area_id=App.get("area_id","33");
  int line_num=4;
  int mod = 0;
  i=0;
  
  
  
  
  try{
  
 if(StringUtil.isempty(user_id)){
 throw new Exception("请选择用户");
 }
  
  if(StringUtil.isempty(station_type)){
  station_type=App.get("default_station_type","1");
  
  }
  if(StringUtil.isempty(area_id)){
  area_id=App.get("area_id","33");
  
  }
 
   cn = DBUtil.getConn();
   
   stationTypeOption = JspPageUtil.getStationTypeOption(cn,station_type);
   
   sql = "select area_id,area_name from t_cfg_area where area_id like '"+top_area_id+"%' order by area_id";
		areaOption = JspUtil.getOption(cn,sql,area_id);
  // areaOption = JspPageUtil.getAreaOption(cn,area_id);
    sql = "select station_id,station_desc from t_cfg_station_info "
  + " where station_type='"+station_type+"' "
  +" and area_id like '"+area_id+"%'"
  +" order by area_id "
  ; 
  stationList = DBUtil.query(cn,sql,null);
  
  sql = "select station_id,user_id from t_sys_user_station where user_id='"+user_id+"'";
  userStationMap = DBUtil.getMap(cn,sql);
  rs = new RowSet(stationList);
  
  
  
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


<form name=form1 action=update.jsp method=post>
<input type=hidden name=user_id value="<%=user_id%>">
<input type=hidden name=objectid value="<%=user_id%>">

<table border=0 cellspacing=0>

<tr class=left>
<td>

<select name=station_type onchange=r()>
<%=stationTypeOption%>
</select>

<select name=area_id onchange=r()>
<option value=<%=App.get("area_id","33")%>>全部</option>
<%=areaOption%>
</select>
<input type=button value="全选" class=btn onclick="setCheckboxes('station_id',true)">
<input type=button value="全不选" class=btn onclick="setCheckboxes('station_id',false)">
<input type=button value=保存 class=btn onclick=u()>
<input type=button value=返回 class=btn onclick=b()>
</td>
</tr>
</table>

<table border=0 cellspacing=1>
<%
	while(rs.next()){
	i = rs.getIndex()+1;
	 mod = i%line_num;
	 
	station_id = rs.get("station_id");
	ids=ids+station_id+",";
	v = (String)userStationMap.get(station_id);
	if(StringUtil.isempty(v)){
	flag="";
	}else{
	flag="checked";
	}
	%>
<%if(mod==1){out.println("<tr>");}%> 
   <td>
   <input type=checkbox name=station_id value="<%=rs.get("station_id")%>" <%=flag%>><%=rs.get("station_desc")%>
   </td>
<%
     
      if(mod<1){out.println("</tr>");}
%>
<%}%>
      <%
          if(mod>0){
             for(i=mod;i<line_num;i++){ out.println("<td></td>");}
             out.println("</tr>");
          }
      %>

</table>

<input type=hidden name=ids value="<%=ids%>">
</form>

<iframe name="q"  width=96% height=60%  scrolling="auto" frameborder="0"  style="border:0px" allowtransparency="true">

</iframe>

<script>
function r(){
form1.target="";
form1.action="user_station_view.jsp";
form1.submit();
}
function b(){
form1.target="";
form1.action="user_edit.jsp";
form1.submit();
}
function u(){
form1.target="q";
form1.action="user_station_update.jsp?acl_alert_flag=1";
form1.submit();
}

</script>











