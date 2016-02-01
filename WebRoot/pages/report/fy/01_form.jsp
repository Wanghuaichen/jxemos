<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc_empty.jsp"%>
<%
    BaseAction action = null;
			String cod_std = request.getParameter("cod_std");
			String cod_std2 = request.getParameter("cod_std2");
			double d = 0;
			double d2 = 0;

			try {
				action = new FormAction();
				action.run(request, response, "form");
				d = f.getDouble(cod_std, 0);
				d2 = f.getDouble(cod_std2, 0);
				if (d <= 0) {
					d = 10;
				}
				if (d2 <= 0) {
					d2 = 1000;
				}
				cod_std = d + "";
				cod_std2 = d2 + "";
				cod_std = f.format(cod_std, "0");
				cod_std2 = f.format(cod_std2, "0");
			} catch (Exception e) {
				w.error(e);
				return;
			}
%>
<link rel="stylesheet" href="../../../web/index.css" />
<script type="text/javascript" src="../../../scripts/calendar.js"></script>
<body onload=rpt() style="overflow: hidden;">
	<form name=form1 method=post>

		<input type=hidden name=station_type value='1'>
		<input type=hidden name=cod_col value='val02'>

		<input type=hidden name='tableName'
			value='<%=request.getParameter("tableName")%>'>

		<div class="frame-main-content"
			style="left: 0; top: 0; position: static;">
			<div class="nt">
				<p class="tiaojiao-p">
					<select name=area_id onchange=r() class="selectoption">
						<%=w.get("areaOption")%>
					</select>
				</p>
				<p class="tiaojiao-p">
					<select name=station_id onchange=rpt() class="selectoption">

						<%=w.get("stationOption")%>
					</select>
				</p>
				<p class="tiaojiao-p">
					<input type=text class=c1 name=date1 value='<%=w.get("date1")%>'
						onclick="new Calendar().show(this);">
				</p>
				<p class="tiaojiao-p">
					<input type=text class=c1 name=cod_std value='<%=cod_std%>'
						style="width: 50px" onkeyup="value=value.replace(/[^\d\.]/g,'')">
				</p>
				<p class="tiaojiao-p">
					&lt=COD标准值&lt=
					<input type=text class=c1 name=cod_std2 value='<%=cod_std2%>'
						style="width: 50px" onkeyup="value=value.replace(/[^\d\.]/g,'')">
				</p>
				<input type=button value='查看' onclick=form1.submit()
					class="tiaojianbutton">
			</div>
		</div>
		<iframe name=q frameborder=0 width=100% height=90%></iframe>
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
		form1.action = '01_form.jsp';
		form1.target = '';
		form1.submit();

	}

	function rpt() {
		form1.action = '01.jsp';
		form1.target = 'q';
		form1.submit();

	}
</script>