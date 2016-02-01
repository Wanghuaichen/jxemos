<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.search.*" %>
<%
     String stationTypeOption,areaOption = null;
     Connection cn = null;
     String station_id = request.getParameter("station_id");
     Map map = null;
     XBean b = null;
     String sql = null;
      String show_btn_flag = request.getParameter("show_btn_flag");//标识是否显示保存按钮
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
     Station_Info.view(request);//查询站位的基本信息
     
     
     }catch(Exception e){
     
     JspUtil.go2error(request,response,e);
     return;
     
     }finally{DBUtil.close(cn);}
     Map tradeInfo = (Map) request.getAttribute("tradeInfo");
     XBean xb = new XBean(tradeInfo);
     
     Map m = (Map)request.getAttribute("data");
     XBean d = new XBean(m);

%>
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css" />
<form name=form1 method=post action=update.jsp>

<input type=hidden name=p_station_type value='<%=w.p("p_station_type")%>'>
<input type=hidden name=p_area_id value='<%=w.p("p_area_id")%>'>
<input type=hidden name=p_station_name value='<%=w.p("p_station_name")%>'>
<input type=hidden name=page value='<%=w.p("page")%>'>
<input type=hidden name=page_size value='<%=w.p("page_size")%>'>
<input type=hidden name=area_id value=''>

<table border=0 cellspacing=0 >

<tr>
<td class=top style="height:50%">

<table border=0 cellspacing=1>

<tr>
<%--<td class=tdtitle>测点编号编号</td>
<td><%=b.get("station_id")%></td>--%>

<td class=tdtitle>测点名称</td>
<td colspan="1"><%=b.get("station_desc")%></td>

<td class=tdtitle>监测类型</td>
<td  colspan="3">
<select name=station_type disabled='true'>
<option value="">
<%=stationTypeOption%>
</select>

</td>
</tr>


<tr>
<td class=tdtitle>法人代码</td>
<td><%=b.get("uni_com_id")%></td>
<td class=tdtitle>企业名称</td>
<td colspan="3"><%=b.get("ent_name")%></td>

</tr>

<tr>

<td class=tdtitle>所属流域</td>
<td><select name='trade_id' disabled='true'><%=w.get("valleyOption")%></select></td>

<%-- 
<td class=tdtitle>地址</td>
<td><%=b.get("station_addr")%></td>
--%>
<td class=tdtitle>交界断面</td>
<td colspan="3"><%=b.get("link_surface")%></td>
</tr>

<tr>
<td class=tdtitle>所属地区</td>
<td>
<select name=charge_area disabled='true'>
<option value="">
<%=jgzOption%>
</select>
</td>
<td class=tdtitle>监管站</td>
<td>
<select name=charge_area disabled='true'>
<option value="">
<%=jgzOption%>
</select>
</td>
 <td class='tdtitle'>所属行业</td>
    <td><select name='trade_id' disabled='true'>
     
          <%=f.getOption(xb.get("industrytypecode"),xb.get("industrytypename"),xb.get("industrytypecode")) %>
           <%--<%=w.get("tradeOption")%>--%>
         </select>
   </td>
    
</tr>
<tr>
 <td class='tdtitle'>重点源属性</td>
    <td><select name='ctl_type' disabled='true'><%=w.get("ctlTypeOption")%></select></td>
     <td class='tdtitle' >建设类型</td>
     <td colspan="3"><%=b.get("build_flag")%></td>
</tr>
<tr>
<td class=tdtitle>经度</td>
<td><%=b.get("x_d")%>度：<%=b.get("x_m")%>分<%=b.get("x_s")%>秒</td>

<td class=tdtitle>纬度</td>
<td colspan="3"><%=b.get("y_d")%>度：<%=b.get("y_m")%>分<%=b.get("y_s")%>秒</td>


</tr>
<tr>
<td class=tdtitle>测点说明</td>
<td colspan="5">
<%=b.get("station_bz")%>
</td>
</tr>
<tr>
<td class=tdtitle>通讯编号</td>
<td>###</td>
<%-- 
<td><%=b.get("absoluteno")%></td>
--%>
<td class=tdtitle>测点IP</td>
<%-- 
<td><%=b.get("comm_str")%></td>
--%>
<td>###</td>
<td class=tdtitle>采集仪</td>
<td>
<%=b.get("produce_comp")%>
</td>
</tr>



<tr>

<td class=tdtitle>通讯用户</td>
<td><%=b.get("comm_user")%></td>

<td class=tdtitle>通讯密码</td>
<td>
<%=b.get("comm_passwd")%>
</td>
<td class=tdtitle>型号</td>
<td>
<%=b.get("pick_eqpt_model")%>
</td>
</tr>



<tr>
<td class=tdtitle>编号(PUID)</td>
<td><%=b.get("sb_id")%></td>

<td class=tdtitle>IP地址</td>
<td><%=b.get("sp_ip")%></td>

<td class=tdtitle>端口</td>
<td><%=b.get("sp_port")%></td>
</tr>


<tr>
<td class=tdtitle>用户</td>
<td><%=b.get("sp_user")%></td>

<td class=tdtitle>密码</td>
<td><%=b.get("sp_pwd")%></td>

<td class=tdtitle>通道号</td>
<td>
<%=b.get("sp_channel")%>
</td>
</tr>

<tr>
     <td class='tdtitle'>IP规则</td>
    <td colspan="5"><%=b.get("ip_plan")%></td>
</tr>

<tr>
<td class='tdtitle'>运维单位</td>
    <td><%=b.get("ywdw")%></td>
 <td class='tdtitle'>联系人</td>
    <td><%=b.get("ywdw_man")%></td>
    <td class='tdtitle'>联系电话</td>
    <td><%=b.get("ywdw_man_phone")%></td>
    
</tr>


<tr>
 <td class='tdtitle'>建设单位</td>    
    <td><%=b.get("jsdw")%></td>
    <td class='tdtitle'>设施管理人</td>
    <td><%=b.get("ssgl_man")%></td>
    
 <td class='tdtitle'>管理电话</td>
    <td><%=b.get("ssgl_man_phone")%></td>
    
</tr>

<tr>
<td class=tdtitle>负责人</td>
<td><%=b.get("charge_man")%></td>
<td class=tdtitle>负责人手机</td>
<td>
<%=b.get("charge_man_phone")%>
</td>
    <td class='tdtitle'>生产情况</td>
    <td><%=b.get("scqk")%></td>
   
    
</tr>
<tr>

     <%--<td class='tdtitle'>是否显示</td>
    <td colspan="5"><select name='show_flag' disabled='true'><%=w.get("showOption")%></select></td>
--%>
   <td class='tdtitle'>企业地址</td>
    <td colspan="5"><%=w.get("ent_addr")%></td>
</tr>
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

</form>

</td>
</tr>


<%if(f.eq(show_zb_flag,"1")){%>

<tr >
<td  >
<form name=form2 method=post target=q action=<%=url%>?station_id=<%=b.get("station_id")%>>
</form>
<iframe name="q" id="q" frameborder="0" marginheight="0" marginwidth="0" frameborder="0" scrolling="auto" onload="javascript:dyniframesize('q');" width="100%"></iframe>
</td>
</tr>

<%}%>

</table>


<script>
//Iframe 自适应高度
function dyniframesize(ifm) {
	var pTar = null;
	if (document.getElementById){
		pTar = document.getElementById(ifm);
	}else{
		eval('pTar = ' + down + ';');
	}
	if (pTar && !window.opera){
		//begin resizing iframe
		pTar.style.display="block"
		if (pTar.contentDocument && pTar.contentDocument.body.offsetHeight){
			//ns6 syntax
			pTar.height = pTar.contentDocument.body.offsetHeight +20;
			pTar.width = pTar.contentDocument.body.scrollWidth+20;
		}else if (pTar.Document && pTar.Document.body.scrollHeight){
			//ie5+ syntax
			pTar.height = pTar.Document.body.scrollHeight;
			pTar.width = pTar.Document.body.scrollWidth;
		}
	}
} 

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








