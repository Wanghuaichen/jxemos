<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc_empty.jsp"%>
<%
    BaseAction action = null;
			String cod_std = request.getParameter("cod_std");
			double d = 0;

			try {
				action = new FormAction();
				action.run(request, response, "form");
				d = f.getDouble(cod_std, 0);
				if (d <= 0) {
					d = 1000;
				}
				cod_std = d + "";
				cod_std = f.format(cod_std, "0");
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
		<input type=hidden name=q_col value='val04'>
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
					<input type=text class=c1 name=date1 value='<%=w.get("date1")%>'
						onclick="new Calendar().show(this);">
				</p>
				<input type=button value='²é¿´' onclick=form1.submit()
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
		form1.action = '05_form.jsp';
		form1.target = '';
		form1.submit();

	}

	function rpt() {
		form1.action = '05.jsp';
		form1.target = 'q';
		form1.submit();

	}
</script>