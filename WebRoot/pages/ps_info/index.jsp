<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%
	RowSet station, flist;

	String station_type = null;

	try {
		SwjUpdate.station_index(request);
		station_type = w.get("station_type");

	} catch (Exception e) {
		w.error(e);
		return;
	}
	station = w.rs("stationList");
	flist = w.rs("flist");
	boolean iswry = f.iswry(w.get("station_type"));
	String index = null;
	int td_width = 150;
	String station_id_0 = null;
	String wry_display = "yes";
	if (!iswry) {
		wry_display = "none";
	}

	String rpt_display = "none";

	if (f.eq(station_type, "1") || f.eq(station_type, "2")) {
		rpt_display = "yes";
	}
	//f.sop("station_type="+station_type+","+rpt_display);
%>
<style>
 .bgclick{
 background-color:#FDCC7E;
 border:solid 1px #E8A947;
  /*font-color:white;*/
 }
 
  .bg{
 /*background-color: white;*/
 background-color:;
 border:0;
 /*font-color:balck;*/
 }
 
</style>

<body scroll=no>
	<!--<%=w.get("sql")%>-->

	<form name=form1 method=post action='./ps_base_info.jsp'
		target='frm_station'>
		<input type=hidden name='w'>
		<input type=hidden name='h'>
		<input type=hidden name='show_zb_flag' value='1'>
		<input type=hidden name='show_btn_flag' value='0'>
		<input type=hidden name='station_id'>


		<input type=hidden name='w_cols'
			value='val01,val02,val03,val04,val05,val06,val07,val08,val16,val17'>
		<input type=hidden name='w_gross_cols'
			value='val01,val02,val05,val16,val17'>
		<input type=hidden name='w_q_col' value='val04'>

		<input type=hidden name='w_ph' value='val03'>
		<input type=hidden name='w_cod' value='val02'>
		<input type=hidden name='w_toc' value='val01'>
		<input type=hidden name='w_q' value='val04'>
		<input type=hidden name='w_q_lj' value='val08'>
		<input type=hidden name='w_nh3n' value='val05'>
		<input type=hidden name='w_tn' value='val17'>
		<input type=hidden name='w_tp' value='val16'>



		<input type=hidden name='g_cols'
			value='val05,val06,val07,val04,val09,val11'>
		<input type=hidden name='g_gross_cols' value='val05,val06,val07'>
		<input type=hidden name='g_q_col' value='val11'>

		<input type=hidden name='g_so2' value='val05'>
		<input type=hidden name='g_pm' value='val06'>
		<input type=hidden name='g_nox' value='val07'>
		<input type=hidden name='g_op' value='val04'>
		<input type=hidden name='g_t' value='val09'>
		<input type=hidden name='g_q' value='val11'>
		<input type=hidden name='g_q_lj' value='valxx'>




		<table border=0 style='width:100%;height=100%' cellspacing=0>
			<tr>
				<td style='width:<%=td_width%>px;height:20px' class='top'
					valign='top'>

					<select name=area_id onchange=f_r() class='sel'>
						<%=w.get("areaOption")%>
					</select>
					<select name=station_type onchange=f_r() class='sel'>
						<%=w.get("stationTypeOption")%>
					</select>

					<select name=ctl_type onchange=f_r() class='sel'>
						<option value=''>
							重点源属性
						</option>
						<%=w.get("ctlTypeOption")%>
					</select>


					<select name=valley_id onchange=f_r() class='sel'>
						<option value=''>
							请选择流域
						</option>
						<%=w.get("valleyOption")%>
					</select>

					<select name=trade_id onchange=f_r() class='sel'>
						<option value=''>
							请选择行业
							<%=w.get("tradeOption")%>
					</select>

					<input type=text name=p_station_name
						value='<%=w.get("p_station_name")%>' style='width:90px'>
					<input type=button value='查看' class=btn onclick='f_r()'>
				</td>
				<td rowspan=2>
					<table style='width:100%;height:100%;border:solid 0px red' border=0
						cellspacing=0>
						<tr>
							<td height=10px>

								<div class='menu_bg_div'>

									<font id='menu0' onclick="f_ps_base()" class='menu_click'>基本信息</font>
									<font id='menu1' onclick="f_dgi()">数据采集仪</font>
									<font id='menu2' onclick="f_pte()">治理设施</font>
									<font id='menu3' onclick="f_monitor()">监控仪器</font>
									<font id='menu4' onclick="f_water_input()">污水进水口</font>
									<font id='menu5' onclick="f_water_output()">废水排放口</font>
									<font id='menu6' onclick="f_gas_output()">废气排放口</font>

									<font id='menu7' onclick="f_zb()" style='display:none'>监测指标</font>
									<font id='menu8' onclick="f_zb()" style='display:none'>监测指标</font>
									<font id='menu9' onclick="f_zb()" style='display:none'>监测指标</font>

									<font style='font-weight:bold;font-size:15px;display:none'
										id='font_station_name'></font>

								</div>


							</td>
						</tr>

						<tr>
							<td style='height:100%;padding:0px'>
								<iframe id='frm_station_id' name='frm_station'
									src='../commons/empty.jsp' width=100% height=100% frameborder=0></iframe>
							</td>
						</tr>
					</table>
				</td>
			</tr>

			<tr>
				<td style='height:100%' class='top'>


					<div class='scrolldiv'>
						<table style="cursor:hand" border=0 cellspacing=0
							style='width:<%=td_width - 30%>px'>
							<%
								station.reset();
								while (station.next()) {
									index = station.getIndex() + "";
									if (f.empty(station_id_0)) {
										station_id_0 = station.get("station_id");
									}
							%>
							<tr>
								<td style='padding-top:5px' id='td<%=index%>'
									onclick=f_station_click(<%=index%>,'<%=station.get("station_id")%>') >
									<font id='station_desc_<%=index%>'><%=station.get("station_desc")%>
									</font>
								</td>
							</tr>
							<%
							}
							%>
						</table>
					</div>

				</td>
			</tr>


		</table>

	</form>
</body>
<script>

var station_sel_index = -1;
var flag_first = 0;
var menu_num=10;



<%if(!f.empty(station_id_0)){%>
  f_station_click(0,'<%=station_id_0%>');
<%}%>

  function f_station_click(index,station_id){
       form1.station_id.value=station_id;
       f_submit();
       var obj = null;
       if(station_sel_index>=0){
        obj = document.getElementById("td"+station_sel_index);
            obj.className="bg"; 
       }
       station_sel_index=index;
       obj = document.getElementById("td"+index);
    obj.className="bgclick";
     var obj1,obj2=null;
        obj1 = getobj("station_desc_"+index);
       obj2 = getobj("font_station_name");
       obj2.innerHTML=obj1.innerHTML
       
  }

   f_btn_avg(); 
   
function f_submit(){
f_get_wh();
  
if(flag_first<1){
  f_ps_base();
  flag_first=1;
  return;
}
 form1.target='frm_station';
 form1.submit();
}

 function f_r(){
   form1.action='index.jsp';
   form1.target='';
   form1.submit();
   form1.target='frm_station';
 }
 
  function f_ps_base(){
   form1.action='./ps_base_info.jsp';
  form1.submit();
  f_set_css(0);
  
 }
 
 function f_dgi(){
  f_get_wh();
  form1.action='./dgi_info.jsp';
  form1.target='frm_station';
  form1.submit();
  f_set_css(1);
 }
 
  function f_pte(){
  f_get_wh();
  form1.action='./pte_info.jsp';
  form1.target='frm_station';
  form1.submit();
  f_set_css(2);
 }
 
   function f_monitor(){
  f_get_wh();
  form1.action='./monitor_info.jsp';
  form1.target='frm_station';
  form1.submit();
  f_set_css(3);
 }
 
 function f_water_input(){
  form1.action='./water_input.jsp';
  form1.submit();
  f_set_css(4);
  
 }
 
  function f_water_output(){
  form1.action='./water_output.jsp';
  form1.submit();
  f_set_css(5);
  
 }
 
  function f_gas_output(){
  form1.action='./gas_output.jsp';
  form1.submit();
  f_set_css(6);
  
 }
 

 
 function f_get_wh(){
  var obj  = document.getElementById('frm_station_id');
        var w = obj.offsetWidth;
        var h = obj.offsetHeight;
 var x = 50;
         w = w-x;
         h = h-x;
         if(w<=0){w=w+x;}
         if(h<=0){h=h+x;}
        form1.w.value = w;
        form1.h.value = h;
 }
 
  function f_set_css(index){
    var i=0;
    var obj = null;
    
    for(i=0;i<menu_num;i++){
     obj = getobj("menu"+i);
     f_css(obj,"menu_click_no");
    }
    obj = getobj("menu"+index);
     f_css(obj,"menu_click");
    
 }
</script>


