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

	<form name=form1 method=post action='./data/index.jsp'
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

					<select name=area_id id="area_id" onchange=f_r() class='sel'>
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

									
	                 <font id='menu0' onclick="f_data()" class='menu_click'>数据</font>
	                 <font id='menu1' onclick="f_chart()">曲线</font>
	                 
	                <font id='menu9' onclick="f_rpt()" style='display:<%=rpt_display%>'>报表</font>
	                
	                 <font id='menu3' onclick="f_sp()">视频</font>
	                 <font id='menu4' onclick="f_ctl()">远程控制</font>
	                 <font id='menu5' onclick="f_info()">属性</font>
	                 <font id='menu6' onclick="f_wry()" style='display:<%=wry_display%>'>污染源信息</font>
	                  
	                  <font id='menu8' onclick="f_bz()"  style='display:none'>备注</font>  
	                  
	                   <font id='menu2' onclick="f_rpt()" style='display:none'>报表</font>
	                 <font id='menu7' onclick="f_zb()"  style='display:none'>监测指标</font> 

									<font style='font-weight:bold;font-size:15px;display:none'
										id='font_station_name'></font>

								</div>

								<div style='padding-top:8px'>
									<select name='data_table' id='data_table'
										onchange='f_btn();f_submit()'>
										<option value='t_monitor_real_minute'>
											实时数据
										<option value='t_monitor_real_minute_sh'>
											10分钟数据
										<option value='t_monitor_real_hour' selected>
											小时数据
										<option value='t_monitor_real_day'>
											日数据
										<option value='t_monitor_real_month'>
											月汇总数据
									</select>

									<select name='rpt_data_table' id='rpt_data_table'
										onchange=f_submit()>

										<option value='rendom_time'>
											任意时间段均值
										<option value='t_monitor_real_hour' selected>
											小时数据
										<option value='t_monitor_real_day'>
											日数据
										<option value='t_monitor_real_week'>
											周均值
										<option value='t_monitor_real_month'>
											月汇总数据
									</select>
									
									<select name='data_type' id='data_type'
										onchange=f_submit()>

										<option value='normal' selected>
											全部数据
										<option value='warning'>
											报警数据
										<option value='exception'>
											异常数据
									</select>

									<select name='infectant_id' id='infectant_id'
										onchange='infectant_submit()'>
										<%
										while (flist.next()) {
										%>
										<option value='<%=flist.get("infectant_id")%>'>
											<%=flist.get("infectant_name")%>
											<%=flist.get("infectant_unit")%>
											<%
											}
											%>
										
									</select>

									<input type='text' class='date' name='date1' id='date1'
										value='<%=w.get("date1")%>' onclick="new Calendar().show(this);">
									<select name=hour1 id='hour1'>
										<%=w.get("hour1Option")%>
									</select>

									<input type='text' class='date' name='date2' id='date2'
										value='<%=w.get("date2")%>' onclick="new Calendar().show(this);">
									<select name=hour2 id='hour2'>
										<%=w.get("hour2Option")%>
									</select>

									<input type='text' class='date' name='date3' id='date3'
										value='<%=f.today()%>' onclick="new Calendar().show(this);">
									<select name=hour3 id='hour3'>
										<%=w.get("hour2Option")%>
									</select>

									<input type="hidden" name="view_flag" id="view_flag"
										value="false">

									<input type='button' value='查看' class='btn'
										onclick='f_view()' id='btn_view'>
									
                       <input type='button' value='查看全部' class='btn' onclick='f_all_view()' id='btn_view_all'>
                       
								</div>
								<div style='height:10px;width:100%'></div>
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
     //alert(index+"_"+station_id);
      //alert(form1.station_id.value);
       form1.station_id.value=station_id;
       //alert(form1.station_id.value);
       
       //form1.submit();
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
  f_data();
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
 
 function infectant_submit(){
 	form1.view_flag.value="false";
 	f_submit();
 }
 
 function f_chart(){
  //alert('chart');
 f_hide_all();
 f_ajf_show("data_table,infectant_id,date1,date2,btn_view,btn_view_all");
  f_btn();
  f_get_wh();
  f_ajf_show("infectant_id");
  form1.action='../site/chart/chart.jsp';
  form1.target='frm_station';
  form1.submit();
  f_set_css(1);
 }
 function f_all_view(){
 	form1.view_flag.value="true";
 	f_submit();
 }
 function f_view(){
 	form1.view_flag.value="false";
 	f_submit();
 }
 
 function f_data(){
 f_hide_all();
 f_ajf_show("data_table,date1,date2,btn_view");
 f_btn();
  //alert('data');
  //f_ajf_hide("infectant_id");
   form1.action='./data/index.jsp';
  form1.submit();
  f_set_css(0);
  
 }
 
 
 function f_rpt(){
 f_hide_all();
 f_ajf_show("rpt_data_table,date1,date2,btn_view,data_type");
 f_btn();
  //alert('data');
  //f_ajf_hide("infectant_id");
   //var obj = form1.rpt_data_table;
   //var i = obj.selectedIndex;
   //var v = obj.options[i].value;
   form1.action='../report_sj/rpt.jsp';
  form1.submit();
   first_flag=1;
   f_set_css(9);
 }
 
 
 function f_report(){
 f_hide_all();
  //alert('report');
  form1.action='../site/report/report.jsp';
  form1.submit();
 }
 
 function f_sp(){
  //alert('sp');
 f_hide_all();
  //form1.action='../site/sp/sp_one.jsp';
  form1.action='../sp/one.jsp';
  form1.submit();
  f_set_css(3);
  
 }
 
 function f_info(){
  //alert('info');
f_hide_all();
  form1.action='../system/station/view.jsp';
  form1.submit();
  f_set_css(5);
  
 }
 
 
 function f_zb(){
  //alert('zb');
   f_hide_all();
   form1.action='../system/station/infectant/list.jsp';
   form1.submit();
   f_set_css(7);
 }
 
  function f_ctl(){
  //alert('ctl');
   f_hide_all();
  form1.action='../site/yckz.jsp';
   form1.submit();
   f_set_css(4);
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
 
 
 
 
 function f_hide_all(){
  var ids="infectant_id,data_table,date1,date2,date3,hour1,hour2,hour3,btn_view,btn_view_all,rpt_data_table,data_type";
  f_ajf_hide(ids);
 }
 
 function f_btn_real(){
        //f_hide_all();
        f_ajf_hide("date1,date2");
      f_ajf_show("date3,hour3");
 }
 function f_btn_avg(){
   // f_hide_all();
   f_ajf_hide("date3,hour3");
    f_ajf_show("date1,date2");
 }
 
 function f_btn(){
 form1.view_flag.value="false";
  var obj = form1.data_table;
   var i = obj.selectedIndex;
   if(i<2){
   f_btn_real();
   }else{
   f_btn_avg()
   }
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


