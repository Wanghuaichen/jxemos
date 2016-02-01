<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
     String stationTypeOption,areaOption = null;
     Connection cn = null;
     String station_id = request.getParameter("station_id");
     Map map = null;
     XBean b = null;
     String sql = null;
      String show_btn_flag = request.getParameter("show_btn_flag");
     String jgzOption = null;
     String check_flag_0,check_flag_1 = null;
     String check_flag = null;
     String url = null;
     Map stationColMap = null;
     String station_type = null;
     String wry_ids = ",1,2,";
     String show_zb_flag = request.getParameter("show_zb_flag");
     try{
     
     if(f.eq(show_btn_flag,"0")){
      url = "../system/station/infectant/list.jsp";
     }else{
      url = "../system/station/infectant/q.jsp";
     }
     
     if(f.empty(show_zb_flag)){show_zb_flag="1";}
     
     if(StringUtil.isempty(station_id)){
     throw new Exception("请选择站位");
     }
     //stationColMap = FyReportUtil.getStationColMap();
     
     
     cn = DBUtil.getConn();
     sql = "select * from t_cfg_station_info where station_id='"+station_id+"'";
     map = DBUtil.queryOne(cn,sql,null);
     if(map==null){
     throw new Exception("站位不存在");
     }
     b = new XBean(map);
     /*
     station_type = b.get("station_type");
     if(wry_ids.indexOf(","+station_type+",")>=0){
       response.sendRedirect("./wry/site_view.jsp?station_id="+station_id);
       return;
     }
     */
     
     stationTypeOption = JspPageUtil.getStationTypeOption(cn,b.get("station_type"));
     //areaOption = JspPageUtil.getAreaOption(cn,b.get("area_id"));
     sql = "select area_id,area_name from t_cfg_area order by area_id";
     areaOption = JspUtil.getOption(cn,sql,b.get("area_id"));
     jgzOption = JspUtil.getOption(cn,sql,b.get("charge_area"));
     
     check_flag = b.get("check_flag");
     if(f.eq(check_flag,"1")){
       check_flag_1=" checked";
       check_flag_0=" ";
     }else{
      check_flag_0=" checked";
       check_flag_1=" ";
     }
     SwjUpdate.view(request);
     
     }catch(Exception e){
     
     JspUtil.go2error(request,response,e);
     return;
     
     }finally{DBUtil.close(cn);}
     
     Map m = (Map)request.getAttribute("data");
     XBean d = new XBean(m);

%>

<style>
td{
text-align:left;
}
</style>
<body scroll=no>
<form name=form1 method=post action=update.jsp>

<input type=hidden name=p_station_type value='<%=w.p("p_station_type")%>'>
<input type=hidden name=p_area_id value='<%=w.p("p_area_id")%>'>
<input type=hidden name=p_station_name value='<%=w.p("p_station_name")%>'>
<input type=hidden name=page value='<%=w.p("page")%>'>
<input type=hidden name=page_size value='<%=w.p("page_size")%>'>


<table border=0 cellspacing=0 style="width:100%;height:100%">

<tr>
<td class=top style="height:20%">

<table border=0 cellspacing=1>

<tr>
<td class=tdtitle>站位编号</td>
<td><%=b.get("station_id")%></td>

<td class=tdtitle>站位名称</td>
<td><%=b.get("station_desc")%></td>

</tr>

<tr>
<td class=tdtitle>监测类型</td>
<td>
<select name=station_type disabled="true">
<option value="">
<%=stationTypeOption%>
</select>

</td>

<td class=tdtitle>所属地区</td>
<td>
<select name=area_id disabled="true">
<option value="">
<%=jgzOption%>
</select>
</td>
</tr>
<tr>
<td class='tdtitle'>重点源属性</td>
    <td><select name='ctl_type' disabled="true"><%=w.get("ctlTypeOption")%></select></td>
    <td class='tdtitle'>排放去向</td>
   <td><%=b.get("pfqx")%></td>
</tr>


<tr>

<td class=tdtitle>
下游地表水断面
</td>
    
<td><%=b.get("xydbsdm")%></td>

<td class='tdtitle'>运维单位</td>
    <td><%=b.get("ywdw")%></td>
</tr>

<tr>
<td class=tdtitle>经度</td>
<td><%=b.get("longitude")%></td>

<td class=tdtitle>纬度</td>
<td><%=b.get("latitude")%></td>

</tr>



</table>



</form>

</td>
</tr>


<%if(f.eq(show_zb_flag,"1")){%>

<tr>
<td class=top>
<form name=form2 method=post target=q action=<%=url%>?station_id=<%=b.get("station_id")%>>

</form>
<iframe name="q" width=100% height=95%  scrolling="auto" frameborder="0"  style="border:0px" allowtransparency="true">
</iframe>
</td>
</tr>

<%}%>

</table>


<script>
form2.submit();
function f_del(){

var msg = "确认要删除吗?";
if(!confirm(msg)){return;}

  form1.action='del.jsp'
  form1.target='';
  form1.submit();

}

function f_update(){
   form1.action='update.jsp'
  form1.target='';
  form1.submit();
  

}

function f_col_name(){
   form1.action='col_list.jsp'
  form1.target='new';
  form1.submit();
  

}

function f_back(){
 history.back();
}
function f_f(){
 form2.submit();
}
</script>








