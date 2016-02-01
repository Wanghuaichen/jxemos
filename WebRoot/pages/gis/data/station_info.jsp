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
     throw new Exception("��ѡ��վλ");
     }
     //stationColMap = FyReportUtil.getStationColMap();
     
     
     cn = DBUtil.getConn();
     sql = "select * from t_cfg_station_info where station_id='"+station_id+"'";
     map = DBUtil.queryOne(cn,sql,null);
     if(map==null){
     throw new Exception("վλ������");
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
<body scroll=no>


<input type=hidden name=p_station_type value='<%=w.p("p_station_type")%>'>
<input type=hidden name=p_area_id value='<%=w.p("p_area_id")%>'>
<input type=hidden name=p_station_name value='<%=w.p("p_station_name")%>'>
<input type=hidden name=page value='<%=w.p("page")%>'>
<input type=hidden name=page_size value='<%=w.p("page_size")%>'>


<table border=0 cellspacing=0 style="width:100%;height:100%">

<tr>
<td class=top style="height:50%">

<table border=0 cellspacing=1>

<tr>
<td class=tdtitle>վλ���</td>
<td><input type=text name=station_id value="<%=b.get("station_id")%>" readonly></td>

<td class=tdtitle>վλ����</td>
<td><input style="width:200px" type=text name=station_desc  value="<%=b.get("station_desc")%>"></td>

<td class=tdtitle>�������</td>
<td>
<select name=station_type>
<option value="">
<%=stationTypeOption%>
</select>

</td>
</tr>


<tr>
<td class=tdtitle>���վ</td>
<td>
<!--
<input type=text name=charge_area value="<%=b.get("charge_area")%>"></td>
-->
<select name=charge_area>
<option value="">
<%=jgzOption%>
</select>


<td class=tdtitle>�������</td>
<td><input type=text name=link_surface  value="<%=b.get("link_surface")%>"></td>

<td class=tdtitle>��������</td>
<td>
<select name=area_id>
<option value="">
<%=areaOption%>
</select>

</td>
</tr>



<tr>
<td class=tdtitle>ͨѶ���</td>
<td><input type=text name=absoluteno value="<%=b.get("absoluteno")%>"></td>

<td class=tdtitle>ͨѶģʽ</td>
<td><input type=text name=comm_mode  value="<%=b.get("comm_mode")%>"></td>

<td class=tdtitle>ͨѶ��</td>
<td>
<input type=text name=comm_str  value="<%=b.get("comm_str")%>">
</td>
</tr>



<tr>
<td class=tdtitle>ͨѶ�˿�</td>
<td><input type=text name=comm_port value="<%=b.get("comm_port")%>"></td>

<td class=tdtitle>ͨѶ�û���</td>
<td><input type=text name=comm_user  value="<%=b.get("comm_user")%>"></td>

<td class=tdtitle>ͨѶ����</td>
<td>
<input type=text name=comm_passwd  value="<%=b.get("comm_passwd")%>">
</td>
</tr>


<tr>
<td class=tdtitle>վλ����</td>
<td><input type=text name=target_passwd value="<%=b.get("target_passwd")%>"></td>

<td class=tdtitle>վλ״̬</td>
<td><input type=text name=pick_eqpt_state  value="<%=b.get("pick_eqpt_state")%>"></td>

<td class=tdtitle>�Ƿ�ͬ��</td>
<td>
<!--
<input type=text name=check_flag  value="<%=b.get("check_flag")%>">
-->
<input type=radio name=check_flag value=0 <%=check_flag_0%>>��
<input type=radio name=check_flag value=1 <%=check_flag_1%>>��
</td>
</tr>


<tr>
<td class=tdtitle>��������</td>
<td><input type=text name=start_date value="<%=b.get("start_date")%>" readonly></td>

<td class=tdtitle>���ʹ��ʱ��</td>
<td><input type=text name=late_use_time  value="<%=b.get("late_use_time")%>" readonly></td>

<td class=tdtitle>��ע</td>
<td>
<input type=text name=station_bz  value="<%=b.get("station_bz")%>">
</td>
</tr>



<tr>
<td class=tdtitle>��ƵIP</td>
<td><input type=text name=station_ip value="<%=b.get("station_ip")%>"></td>

<td class=tdtitle>
<!--�Ƿ��ͱ�������Ϣ--></td>
<td>
<!--
<input type=text name=msg_send_fla  value="<%=b.get("msg_send_fla")%>">
-->
</td>

<td class=tdtitle></td>
<td>

</td>
</tr>



<tr>
<td class=tdtitle>������</td>
<td><input type=text name=charge_man value="<%=b.get("charge_man")%>"></td>

<td class=tdtitle>������email</td>
<td><input type=text name=charge_man_mail  value="<%=b.get("charge_man_mail")%>"></td>

<td class=tdtitle>�������ֻ�</td>
<td>
<input type=text name=charge_man_phone  value="<%=b.get("charge_man_phone")%>">
</td>
</tr>


<tr>
<td class=tdtitle>����</td>
<td><input type=text name=longitude value="<%=b.get("longitude")%>"></td>

<td class=tdtitle>γ��</td>
<td><input type=text name=latitude  value="<%=b.get("latitude")%>"></td>

<td class=tdtitle>X����</td>
<td>
<input type=text name=axisx  value="<%=b.get("axisx")%>">
</td>
</tr>



<tr>
<td class=tdtitle>�����ͺ�</td>
<td><input type=text name=pick_eqpt_model value="<%=b.get("pick_eqpt_model")%>"></td>

<td class=tdtitle>����������ҵ</td>
<td><input type=text name=produce_comp  value="<%=b.get("produce_comp")%>"></td>

<td class=tdtitle>Y����</td>
<td>
<input type=text name=axisy  value="<%=b.get("axisy")%>">
</td>
</tr>


</table>



</td>
</tr>


</table>







