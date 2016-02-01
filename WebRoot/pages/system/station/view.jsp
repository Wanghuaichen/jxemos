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
      url = "./infectant/list.jsp";
     }else{
      url = "./infectant/q.jsp";
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
<input type=hidden name=area_id value=''>

<table border=0 cellspacing=0 style="width:100%;height:100%">
<%-- 
<tr>
<td class=top style="height:100%">

<table border=0 cellspacing=1>

<tr>
<td class=tdtitle>站位编号</td>
<td><input type=text name=station_id value="<%=b.get("station_id")%>" readonly></td>

<td class=tdtitle>站位名称</td>
<td><input style="width:200px" type=text name=station_desc  value="<%=b.get("station_desc")%>"></td>

<td class=tdtitle>监测类型</td>
<td>
<select name=station_type>
<option value="">
<%=stationTypeOption%>
</select>

</td>
</tr>


<tr>
<td class=tdtitle>所属区域</td>
<td>
<!--
<input type=text name=charge_area value="<%=b.get("charge_area")%>"></td>
-->
<select name=charge_area>
<option value="">
<%=jgzOption%>
</select>

<td class=tdtitle>地址</td>
<td><input type=text name=station_addr  value="<%=b.get("station_addr")%>"></td>

<td class=tdtitle>交界断面</td>
<td><input type=text name=link_surface  value="<%=b.get("link_surface")%>"></td>
</tr>



<tr>
<td class=tdtitle>通讯编号</td>
<td><input type=text name=absoluteno value="<%=b.get("absoluteno")%>"></td>

<td class=tdtitle>通讯模式</td>
<td><input type=text name=comm_mode  value="<%=b.get("comm_mode")%>"></td>

<td class=tdtitle>通讯串</td>
<td>
<input type=text name=comm_str  value="<%=b.get("comm_str")%>">
</td>
</tr>



<tr>
<td class=tdtitle>通讯端口</td>
<td><input type=text name=comm_port value="<%=b.get("comm_port")%>"></td>

<td class=tdtitle>通讯用户名</td>
<td><input type=text name=comm_user  value="<%=b.get("comm_user")%>"></td>

<td class=tdtitle>通讯密码</td>
<td>
<input type=text name=comm_passwd  value="<%=b.get("comm_passwd")%>">
</td>
</tr>


<tr>
<td class=tdtitle>站位密码</td>
<td><input type=text name=target_passwd value="<%=b.get("target_passwd")%>"></td>

<td class=tdtitle>站位状态</td>
<td><input type=text name=pick_eqpt_state  value="<%=b.get("pick_eqpt_state")%>"></td>

<td class=tdtitle>是否同步</td>
<td>
<!--
<input type=text name=check_flag  value="<%=b.get("check_flag")%>">
-->
<input type=radio name=check_flag value=0 <%=check_flag_0%>>否
<input type=radio name=check_flag value=1 <%=check_flag_1%>>是
</td>
</tr>


<tr>
<td class=tdtitle>启用日期</td>
<td><input type=text name=start_date value="<%=b.get("start_date")%>" readonly></td>

<td class=tdtitle>最后使用时间</td>
<td><input type=text name=late_use_time  value="<%=b.get("late_use_time")%>" readonly></td>

<td class=tdtitle>备注</td>
<td>
<input type=text name=station_bz  value="<%=b.get("station_bz")%>">
</td>
</tr>



<tr>
<td class=tdtitle>视频IP</td>
<td><input type=text name=station_ip value="<%=b.get("station_ip")%>"></td>

<td class=tdtitle>
下游地表水断面
</td>
<td><input type=text name=xydbsdm value="<%=b.get("xydbsdm")%>"></td>
<td class=tdtitle></td>
<td>

</td>
</tr>



<tr>
<td class=tdtitle>负责人</td>
<td><input type=text name=charge_man value="<%=b.get("charge_man")%>"></td>

<td class=tdtitle>负责人email</td>
<td><input type=text name=charge_man_mail  value="<%=b.get("charge_man_mail")%>"></td>

<td class=tdtitle>负责人手机</td>
<td>
<input type=text name=charge_man_phone  value="<%=b.get("charge_man_phone")%>">
</td>
</tr>


<tr>
<td class=tdtitle>经度</td>
<td><input type=text name=longitude value="<%=b.get("longitude")%>"></td>

<td class=tdtitle>纬度</td>
<td><input type=text name=latitude  value="<%=b.get("latitude")%>"></td>

<td class=tdtitle>X坐标</td>
<td>
<input type=text name=axisx  value="<%=b.get("axisx")%>">
</td>
</tr>



<tr>
<td class=tdtitle>数采型号</td>
<td><input type=text name=pick_eqpt_model value="<%=b.get("pick_eqpt_model")%>"></td>

<td class=tdtitle>数采生产企业</td>
<td><input type=text name=produce_comp  value="<%=b.get("produce_comp")%>"></td>

<td class=tdtitle>Y坐标</td>
<td>
<input type=text name=axisy  value="<%=b.get("axisy")%>">
</td>
</tr>
<!--
<tr>
<td class=tdtitle>总量控制指标</td>
<td colspan=5>
累计流量 <input type=text name=gross_q value='<%=b.get("gross_q")%>'>
COD <input type=text name=gross_cod value='<%=b.get("gross_cod")%>'>
SO<sub>2</sub> <input type=text name=gross_so2  value='<%=b.get("gross_so2")%>'>
NO<sub>x</sub> <input type=text name=gross_nox  value='<%=b.get("gross_nox")%>'>

</td>

</tr>
-->


</table>


<%if(!StringUtil.equals(show_btn_flag,"0")){%>

<table border=0 cellspacing=0 >
<tr>
<td>
 <input type=button value=查看监测指标  class=btn onclick=f_f()>
 <input type=button value=保存 class=btn onclick=f_update()>
<!--
<input type=button value=列名设置 onclick=f_col_name()  class=btn>
 -->
 
 
  

   <input type=button value=返回 onclick=f_back()  class=btn>
  <input type=button value=删除  class=btn onclick=f_del()>
</td>
</tr>
</table>

<%}%>
--%>
</form>

</td>
</tr>


<%if(f.eq(show_zb_flag,"1")){%>

<tr>
<td class=top>
<form name=form2 method=post target=q action=<%=url%>?station_id=<%=b.get("station_id")%>>

</form>
<br>
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
	var charge_area = document.all["charge_area"].options[document.all["charge_area"].selectedIndex].value;
	form1.area_id.value = charge_area;
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








