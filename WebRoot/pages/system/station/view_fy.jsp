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
     
     try{
     
     if(f.eq(show_btn_flag,"0")){
      url = "./infectant/list.jsp";
     }else{
      url = "./infectant/q.jsp";
     }
     
     
     if(StringUtil.isempty(station_id)){
     throw new Exception("��ѡ��վλ");
     }
     stationColMap = FyReportUtil.getStationColMap();
     
     
     cn = DBUtil.getConn();
     sql = "select * from t_cfg_station_info where station_id='"+station_id+"'";
     map = DBUtil.queryOne(cn,sql,null);
     if(map==null){
     throw new Exception("վλ������");
     }
     b = new XBean(map);
     
     
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
<form name=form1 method=post action=update.jsp>

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
<td>վλ���</td>
<td><input type=text name=station_id value="<%=b.get("station_id")%>" readonly></td>

<td>վλ����</td>
<td><input style="width:200px" type=text name=station_desc  value="<%=b.get("station_desc")%>"></td>

<td>�������</td>
<td>
<select name=station_type>
<option value="">
<%=stationTypeOption%>
</select>

</td>
</tr>


<tr>
<td>���վ</td>
<td>
<!--
<input type=text name=charge_area value="<%=b.get("charge_area")%>"></td>
-->
<select name=charge_area>
<option value="">
<%=jgzOption%>
</select>


<td>�������</td>
<td><input type=text name=link_surface  value="<%=b.get("link_surface")%>"></td>

<td>��������</td>
<td>
<select name=area_id>
<option value="">
<%=areaOption%>
</select>

</td>
</tr>



<tr>
<td>ͨѶ���</td>
<td><input type=text name=absoluteno value="<%=b.get("absoluteno")%>"></td>

<td>ͨѶģʽ</td>
<td><input type=text name=comm_mode  value="<%=b.get("comm_mode")%>"></td>

<td>ͨѶ��</td>
<td>
<input type=text name=comm_str  value="<%=b.get("comm_str")%>">
</td>
</tr>



<tr>
<td>ͨѶ�˿�</td>
<td><input type=text name=comm_port value="<%=b.get("comm_port")%>"></td>

<td>ͨѶ�û���</td>
<td><input type=text name=comm_user  value="<%=b.get("comm_user")%>"></td>

<td>ͨѶ����</td>
<td>
<input type=text name=comm_passwd  value="<%=b.get("comm_passwd")%>">
</td>
</tr>


<tr>
<td>վλ����</td>
<td><input type=text name=target_passwd value="<%=b.get("target_passwd")%>"></td>

<td>վλ״̬</td>
<td><input type=text name=pick_eqpt_state  value="<%=b.get("pick_eqpt_state")%>"></td>

<td>�Ƿ�ͬ��</td>
<td>
<!--
<input type=text name=check_flag  value="<%=b.get("check_flag")%>">
-->
<input type=radio name=check_flag value=0 <%=check_flag_0%>>��
<input type=radio name=check_flag value=1 <%=check_flag_1%>>��
</td>
</tr>


<tr>
<td>��������</td>
<td><input type=text name=start_date value="<%=b.get("start_date")%>" readonly></td>

<td>���ʹ��ʱ��</td>
<td><input type=text name=late_use_time  value="<%=b.get("late_use_time")%>" readonly></td>

<td>��ע</td>
<td>
<input type=text name=station_bz  value="<%=b.get("station_bz")%>">
</td>
</tr>



<tr>
<td>��ƵIP</td>
<td><input type=text name=station_ip value="<%=b.get("station_ip")%>"></td>

<td>
<!--�Ƿ��ͱ�������Ϣ--></td>
<td>
<!--
<input type=text name=msg_send_fla  value="<%=b.get("msg_send_fla")%>">
-->
</td>

<td></td>
<td>

</td>
</tr>



<tr>
<td>������</td>
<td><input type=text name=charge_man value="<%=b.get("charge_man")%>"></td>

<td>������email</td>
<td><input type=text name=charge_man_mail  value="<%=b.get("charge_man_mail")%>"></td>

<td>�������ֻ�</td>
<td>
<input type=text name=charge_man_phone  value="<%=b.get("charge_man_phone")%>">
</td>
</tr>


<tr>
<td>����</td>
<td><input type=text name=longitude value="<%=b.get("longitude")%>"></td>

<td>γ��</td>
<td><input type=text name=latitude  value="<%=b.get("latitude")%>"></td>

<td>X����</td>
<td>
<input type=text name=axisx  value="<%=b.get("axisx")%>">
</td>
</tr>



<tr>
<td>�����ͺ�</td>
<td><input type=text name=pick_eqpt_model value="<%=b.get("pick_eqpt_model")%>"></td>

<td>����������ҵ</td>
<td><input type=text name=produce_comp  value="<%=b.get("produce_comp")%>"></td>

<td>Y����</td>
<td>
<input type=text name=axisy  value="<%=b.get("axisy")%>">
</td>
</tr>

<tr>
<td><%=FyReportUtil.getStationColName(stationColMap,"1")%></td>
<td><input type=text name=val1 value='<%=b.get("val1")%>'></td>
<td><%=FyReportUtil.getStationColName(stationColMap,"2")%></td>
<td><input type=text name=val2 value='<%=b.get("val2")%>'></td>
<td><%=FyReportUtil.getStationColName(stationColMap,"3")%></td>
<td><input type=text name=val3 value='<%=b.get("val3")%>'></td>
</tr>


<tr>
<td><%=FyReportUtil.getStationColName(stationColMap,"4")%></td>
<td><input type=text name=val4 value='<%=b.get("val4")%>'></td>
<td><%=FyReportUtil.getStationColName(stationColMap,"5")%></td>
<td><input type=text name=val5 value='<%=b.get("val5")%>'></td>
<td><%=FyReportUtil.getStationColName(stationColMap,"6")%></td>
<td><input type=text name=val6 value='<%=b.get("val6")%>'></td>
</tr>


<tr>
<td><%=FyReportUtil.getStationColName(stationColMap,"7")%></td>
<td><input type=text name=val7 value='<%=b.get("val7")%>'></td>
<td><%=FyReportUtil.getStationColName(stationColMap,"8")%></td>
<td><input type=text name=val8 value='<%=b.get("val8")%>'></td>
<td><%=FyReportUtil.getStationColName(stationColMap,"9")%></td>
<td><input type=text name=val9 value='<%=b.get("val9")%>'></td>
</tr>


</table>


<%if(!StringUtil.equals(show_btn_flag,"0")){%>

<table border=0 cellspacing=0 >
<tr>
<td>
 <input type=button value=�鿴���ָ��  class=btn onclick=f_f()>
 <input type=button value=���� class=btn onclick=f_update()>
<input type=button value=�������� onclick=f_col_name()  class=btn>
 
 
  

   <input type=button value=���� onclick=f_back()  class=btn>
  <input type=button value=ɾ��  class=btn onclick=f_del()>
</td>
</tr>
</table>

<%}%>

</form>

</td>
</tr>

<tr>
<td class=top>
<form name=form2 method=post target=q action=<%=url%>?station_id=<%=b.get("station_id")%>>

</form>
<br>
<iframe name="q" width=100% height=95%  scrolling="auto" frameborder="0"  style="border:0px" allowtransparency="true">
</iframe>
</td>
</tr>
</table>


<script>
form2.submit();
function f_del(){

var msg = "ȷ��Ҫɾ����?";
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








