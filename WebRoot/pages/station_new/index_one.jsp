<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc_station.jsp"%>
<%
	RowSet flist;
	String station_type = null,station_desc=null;
	
	try {

		SwjUpdate.station_one_index(request);
		station_type = w.get("station_type");
		station_desc=w.get("station_desc");
	} catch (Exception e) {
		w.error(e);
		return;
	}
	flist = w.rs("flist");
	boolean iswry = f.iswry(w.get("station_type"));
	String wry_display = "yes";
	String rpt_display = "none";
	if (!iswry) {
		wry_display = "none";
	}
	if (f.eq(station_type, "1") || f.eq(station_type, "2")) {
		rpt_display = "yes";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title><%=w.get("station_desc")%></title>
<link href="../../styles/reset-min.css" rel="stylesheet" type="text/css" />
<link href="../../styles/base/jquery.ui.all.css" rel="stylesheet"
	type="text/css" />
<link href="../../styles/common/common.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript"
	src="../../scripts/core/jquery-1.4.2.min.js"></script>
<script type="text/javascript"
	src="../../scripts/core/jquery.ui.core.js"></script>
<script type="text/javascript"
	src="../../scripts/core/jquery.ui.widget.js"></script>
<script type="text/javascript"
	src="../../scripts/core/jquery.ui.tabs.js"></script>
<script type="text/javascript"
	src="../../scripts/core/jquery.ui.check.js"></script>
<script type="text/javascript" src="../../scripts/common.js"></script>
<script type="text/javascript" src="../../scripts/calendar.js"></script>
<style>
.search {
	font-family: "宋体";
	font-size: 12px;
	BEHAVIOR: url('<%=request.getContextPath()%>/styles/selectBox.htc');
	cursor: hand;
}

.input {
	border: #ccc 1px solid;
	font-family: "微软雅黑";
	font-size: 13px;
	width: 100px;
	background: expression(( this.readOnly && this.readOnly == true)?"#f9f9f9":""
		)
}

.btn1 {
	width: 80px;
	height: 23px;
	background: url(<%=request.getContextPath()%>/images/common/btn1.gif )
		no-repeat;
	border: none;
	text-align: center;
}
</style>

</head>

<body onload="f_data()" style="overflow-x:hidden;overflow-y:scroll">
	<form name=form1 method=post target="frm_station">
		<input type=hidden name='station_id' value="<%=w.get("station_id")%>"><input
			type=hidden name='station_type' value="<%=w.get("station_type")%>">

		<input type=hidden name='w'> <input type=hidden name='h'>
		<input type=hidden name='show_zb_flag' value='1'> <input
			type=hidden name='show_btn_flag' value='0'>
		<%--是否显示保存按钮--%>

		<input type=hidden name='sh_flag' value='0'> <input
			type=hidden name='w_cols'
			value='val01,val02,val03,val04,val05,val06,val07,val08,val16,val17'>
		<input type=hidden name='w_gross_cols'
			value='val01,val02,val05,val16,val17'> <input type=hidden
			name='w_q_col' value='val04'> <input type=hidden name='w_ph'
			value='val03'> <input type=hidden name='w_cod' value='val02'>
		<input type=hidden name='w_toc' value='val01'> <input
			type=hidden name='w_q' value='val04'> <input type=hidden
			name='w_q_lj' value='val08'> <input type=hidden name='w_nh3n'
			value='val05'> <input type=hidden name='w_tn' value='val17'>
		<input type=hidden name='w_tp' value='val16'> <input
			type=hidden name='g_cols' value='val05,val06,val07,val04,val09,val11'>
		<input type=hidden name='g_gross_cols' value='val05,val06,val07'>
		<input type=hidden name='g_q_col' value='val11'> <input
			type=hidden name='g_so2' value='val05'> <input type=hidden
			name='g_pm' value='val06'> <input type=hidden name='g_nox'
			value='val07'> <input type=hidden name='g_op' value='val04'>
		<input type=hidden name='g_t' value='val09'> <input
			type=hidden name='g_q' value='val11'> <input type=hidden
			name='g_q_lj' value='valxx'>




		<div class="rightCon">

			<div class="view1">
				<!--
         <input type='button' value='数据' onclick='f_data()' class=btn>
         <input type='button' value='曲线' onclick='f_chart()' class=btn>
                  
                   <input type='button' value='报表' onclick='f_report()' class=btn style='display:none'>
                   
                   <input type='button' value='视频' onclick='f_sp()' class=btn>
                   <input type='button' value='远程控制' onclick='f_ctl()' class=btn>
                   <input type='button' value='属性' onclick='f_info()' class=btn>
                   <%if (iswry) {%>
                   <input type='button' value='污染源信息' onclick='f_wry()' class=btn>
                   <%}%>
                   <input type='button' value='监测指标' onclick='f_zb()' class=btn>
                   <input type='button' value='备注' onclick='f_bz()' class=btn>
                   -->

				<ul>
					<li><a href="#" id='menu0' onclick="f_data()">数据</a>
					</li>
					<li style="display:<%=rpt_display%>;"><a href="#" id='menu2'
						onclick="f_rpt()">报表</a>
					</li>
					<li><a href="#" id='menu1' onclick="f_chart()">曲线</a>
					</li>

					<li><a href="#" id='menu3' onclick="f_sp()">视频</a>
					</li>
					<li style="display:none;"><a href="#" id='menu4'
						onclick="f_ctl()">远程控制</a>
					</li>
					<li><a href="#" id='menu5' onclick="f_info()">属性</a>
					</li>
					<li style="display:none;"><a href="#" id='menu6'
						onclick="f_wry()">污染源信息</a>
					</li>
					<!-- 
					<li><a href="#" id='menu7' onclick="f_bz()">备注</a>
					</li>
					 -->
				</ul>
			</div>

			<div class="view2">
				<div class="view2Con">
					<div class="item">
						<select name='data_table' id='data_table'
							onchange='f_btn();f_submit()'>
							<%
								if (!station_type.equals("5")) {
							%>
							<option value='t_monitor_real_minute'>实时数据</option>
							<option value='t_monitor_real_ten_minute'>十分钟数据</option>
							<option value='t_monitor_real_hour' selected>小时数据</option>
							<%
								}
								if (station_type.equals("5")) {
							%>
							<option value='t_monitor_real_minute' selected>实时数据</option>
							<option value='t_monitor_real_ten_minute'>十分钟数据</option>
							<option value='t_monitor_real_hour'>小时数据</option>
							<%
								}
							%>
							<option value='t_monitor_real_day'>日数据</option>
							<option value='t_monitor_real_month'>月汇总数据</option>
						</select>
					</div>

					<div class="item">
						<select name='rpt_data_table' id='rpt_data_table'
							onchange=f_submit()>

							<option value='t_monitor_real_hour' selected>小时数据</option>
							<%--<option value='t_monitor_real_ten_minute'>十分钟数据</option>--%>
							<option value='t_monitor_real_day'>日数据</option>
							<%--<option value='t_monitor_real_week'>周均值</option>
                         --%>
							<option value='t_monitor_real_month'>月汇总数据</option>
						</select> <input type=hidden name='data_type' id='data_type' value='normal' />
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
					</div>
					<div class="item">
						<input type='text' name='date1' id='date1'
							value='<%=w.get("date1")%>' onclick="new Calendar().show(this);" />
						<select name=hour1 id='hour1'>
							<%=w.get("hour1Option")%>
						</select>
					</div>
					<div class="item">
						<input type='text' name='date2' id='date2'
							value='<%=w.get("date2")%>' onclick="new Calendar().show(this);" />
						<select name=hour2 id='hour2'>
							<%=w.get("hour2Option")%>
						</select>
					</div>
					<div class="item">
						<input type='text' name='date3' id='date3' value='<%=f.today()%>'
							onclick="new Calendar().show(this);" /> <select name=hour3
							id='hour3'>
							<%=w.get("hour2Option")%>
						</select>
					</div>
					<div class="item">
						<select name="chart_form" id="chart_form" onchange="f_chart()">
							<option value="1">曲线图</option>
							<option value="0">柱状图</option>
						</select>
					</div>
					<div class="item">
						<input type="hidden" name="view_flag" id="view_flag" value="false" />
						<select name='sh_flag_select' id='sh_flag_select'
							onchange="sh_flag_check(this.value)">
							<option value="0">原始数据</option>
							<option value="1">审核数据</option>
						</select>
					</div>
					<div class="item">
						<input type='button' value="查看" class="btn1" id='btn_view'
							onclick='f_view()' />
					</div>
					<%--<div class="item">
      					        <input type='button' value='查看全部' class='btn1' onclick='f_all_view()' id='btn_view_all' />
      						</div>--%>
				</div>
			</div>
		<div style="margin-left:10px;">监测站位：<%=station_desc %></div>
			<iframe id='frm_station_id' name='frm_station' width=100% height=100%
				frameborder=0></iframe>

		</div>
	</form>
</body>
</html>
<script>
	var station_sel_index = -1;
	var flag_first = 0;
	var menu_num = 8;

	function f_station_click(index, station_id) {
		//alert(index+"_"+station_id);
		//alert(form1.station_id.value);
		form1.station_id.value = station_id;
		//alert(form1.station_id.value);

		//form1.submit();
		f_submit();
		var obj = null;
		if (station_sel_index >= 0) {
			obj = document.getElementById("td" + station_sel_index);
			obj.className = "bg";
		}
		station_sel_index = index;
		obj = document.getElementById("td" + index);
		obj.className = "bgclick";

	}

	function f_view() {
		form1.view_flag.value = "false";
		form1.target = 'frm_station';
		form1.submit();
	}

	f_btn_avg();

	function f_submit() {
		f_get_wh();

		if (flag_first < 1) {
			f_data();
			flag_first = 1;
			return;
		}
		form1.target = 'frm_station';
		form1.submit();
	}
	function infectant_submit() {
		form1.view_flag.value = "false";
		form1.submit();
	}
	function f_r() {
		form1.action = 'index.jsp';
		form1.target = '';
		form1.submit();
		form1.target = 'frm_station';
	}

	function f_chart() {
		//alert('chart');
		f_hide_all();
		f_ajf_show("data_table,infectant_id,date1,date2,btn_view,chart_form,sh_flag_select");
		f_btn();
		f_get_wh();

		f_ajf_show("infectant_id");
		form1.action = '../site/chart/chart.jsp';
		form1.target = 'frm_station';
		form1.submit();
		flag_first = 1;
		f_set_css(1);
	}

	function f_data() {
		f_hide_all();
		f_ajf_show("data_table,date1,date2,btn_view,sh_flag_select");
		f_btn();
		//alert('data');
		//f_ajf_hide("infectant_id");
		form1.action = './data/index.jsp';
		form1.submit();
		f_set_css(0);
	}

	function sh_flag_check(sh_flag_value) {
		//alert(sh_flag_value);
		var sh_flag = sh_flag_value;
		//alert(form1.action);
		var action = form1.action.split("?");
		//alert(action[0]);
		form1.action = action[0] + "?sh_flag=" + sh_flag;
		//alert(form1.action);
		form1.target = 'frm_station';
		form1.submit();
	}

	function f_rpt() {
		f_hide_all();
		f_ajf_show("rpt_data_table,date1,date2,btn_view,data_type,sh_flag_select");
		f_btn();
		//alert('data');
		//f_ajf_hide("infectant_id");
		//var obj = form1.rpt_data_table;
		//var i = obj.selectedIndex;
		//var v = obj.options[i].value;
		form1.action = '../report_sj/rpt.jsp';
		form1.submit();
		//f_submit();
		flag_first = 1;
		f_set_css(2);
	}

	function f_report() {
		f_hide_all();
		//alert('report');
		form1.action = '../site/report/report.jsp';
		form1.submit();
		f_set_css(2);
	}

	function f_sp() {
		//alert('sp');
		f_hide_all();
		//form1.action='../site/sp/sp_one.jsp';
		form1.action = '../sp/one.jsp';
		form1.submit();
		f_set_css(3);

	}

	function f_info() {
		//alert('info');
		f_hide_all();
		form1.action = '../system/station/sx_view.jsp';
		form1.submit();
		f_set_css(5);

	}

	function f_wry() {
		//alert('wry');
		f_hide_all();
		form1.action = '../system/station/wry/sx_site_view.jsp';
		form1.submit();
		f_set_css(6);
	}

	function f_zb() {
		//alert('zb');
		f_hide_all();
		form1.action = '../system/station/infectant/list.jsp';
		form1.submit();
		f_set_css(7);
	}
	function f_all_view() {
		form1.view_flag.value = "true";
		form1.action = '../site/chart/chart.jsp';
		form1.target = 'frm_station';
		form1.submit();
		f_set_css(1);
	}
	function f_bz() {
		//alert('zb');
		f_hide_all();
		form1.action = 'bz.jsp';
		form1.submit();
		f_set_css(7);
	}

	function f_ctl() {
		//alert('ctl');
		f_hide_all();
		form1.action = '../site/yckz.jsp';
		form1.submit();
		f_set_css(4);
	}

	function f_get_wh() {
		var obj = document.getElementById('frm_station_id');
		var w = obj.offsetWidth;
		var h = obj.offsetHeight;
		var x = 20;
		w = w - x;
		h = h - x;
		if (w <= 0) {
			w = w + x;
		}
		if (h <= 0) {
			h = h + x;
		}
		form1.w.value = w;
		form1.h.value = h;
	}

	function f_hide_all() {
		var ids = "infectant_id,data_table,date1,date2,date3,hour1,hour2,hour3,btn_view,rpt_data_table,data_type,chart_form,sh_flag_select";
		f_ajf_hide(ids);
	}

	function f_btn_real() {
		//f_hide_all();
		f_ajf_hide("date1,date2,hour1,hour2");
		f_ajf_show("date3,hour3");
	}
	function f_btn_avg() {
		// f_hide_all();
		f_ajf_hide("date3,hour3");
		f_ajf_show("date1,date2,hour1,hour2");
	}

	function f_btn() {

		var obj = form1.data_table;
		var i = obj.selectedIndex;
		if (i < 1) {
			f_btn_real();
		} else {
			f_btn_avg();
		}
	}
	/* 
	 function f_set_css(index){
	 var i=0;
	 var obj = null;
	
	 for(i=0;i<menu_num;i++){
	 obj = getobj("menu"+i);
	 f_css(obj,"menu_click_no");
	 ft = getobj("font"+i);
	 obj.style.background="";
	 f_css(obj,"menu_click_no");
	 ft.className="gray12_w_6";
	 obj.className="STYLE1";
	 }
	 obj = getobj("menu"+index);
	 f_css(obj,"menu_click");
	 ft = getobj("font"+index);
	 f_css(obj,"menu_click");
	 obj.style.background="url(index_em_02_2.jpg) no-repeat";
	 ft.className="white12_w";
	 obj.className="STYLE1";
	
	 }
	 */
</script>



