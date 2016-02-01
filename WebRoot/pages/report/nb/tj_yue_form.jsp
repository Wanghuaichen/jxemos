<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc_empty.jsp"%>
<%
    BaseAction action = null;
			try {
				action = new FormAction();
				action.run(request, response, "form");
				//System.out.println("tableName====="+request.getParameter("tableName"));
			} catch (Exception e) {
				w.error(e);
				return;
			}
			String now = StringUtil.getNowDate() + "";
			int year = f.getYear(now);
			String month = f.getStringMonth(now);
%>

<link rel="stylesheet" href="../../../web/index.css" />
<body onload=rpt() scroll=no>
	<form name=form1 method=post>
		<input type=hidden name=no_data_string value="--">
		<input type=hidden name=not_config_string value="△">
		<input type=hidden name=offline_string value="×">
		<input type=hidden name=online_string value="√">
		<input type=hidden name='tableName'
			value='<%=request.getParameter("tableName")%>'>

		<div class="frame-main-content"
			style="left: 0; top: 0; position: static;">
			<div class="nt">
				<p class="tiaojiao-p">
					<select name=station_type onchange=r() class="selectoption">
						<%=w.get("stationTypeOption")%>
					</select>
				</p>
				<p class="tiaojiao-p">
					<select name=area_id onchange=r() class="selectoption">
						<%=w.get("areaOption")%>
					</select>
				</p>
				<p class="tiaojiao-p">
					<select name=trade_id onchange=r() class="selectoption">
						<option value=''>
							行业
							<%=w.get("tradeOption")%>
					</select>
				</p>
				<p class="tiaojiao-p">
					<select name=station_id onchange=rpt() class="selectoption">
						<option value=''>
							企业
							<%=w.get("stationOption")%>
					</select>
				</p>
				<p class="tiaojiao-p">

					年份:
					<select name=year onchange=rpt() class="selectoption">
						<%=f
					.getOption(
							"2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030",
							"2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030",
							String.valueOf(year))%>
					</select>
				</p>
				<p class="tiaojiao-p">
					月份:
					<select name=month onchange=rpt() class="selectoption">
						<%=f.getOption("01,02,03,04,05,06,07,08,09,10,11,12",
					"1月,2月,3月,4月,5月,6月,7月,8月,9月,10月,11月,12月", month)%>
					</select>
				</p>
				<input type=button value='查看' onclick=form1.submit()
					class="tiaojianbutton">
			</div>
		</div>

		<iframe name=q frameborder=0 width=100% height=400px frameborder=0
			allowtransparency="true"></iframe>
	</form>


	<script>
function f_save(){
    var obj = window.frames["q"].window.document.getElementById('div_excel_content');
   //alert(obj);
    form2.txt_excel_content.value=obj.innerHTML;
    
    form2.action='/<%=ctx%>/pages/commons/save2excel.jsp';
		form2.submit();
	}

	function r() {
		form1.action = 'tj_yue_form.jsp';
		form1.target = '';
		form1.submit();

	}

	function rpt() {
		form1.action = 'tj_yue.jsp';
		form1.target = 'q';
		form1.submit();

	}
</script>
</body>