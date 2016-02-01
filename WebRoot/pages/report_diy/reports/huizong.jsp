<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>在线检测和监控管理系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<script type="text/javascript" src="../../../scripts/calendar.js"></script>
<link rel="stylesheet" href="../../../web/index.css" />
<%
	try {
		SwjUpdate.report_cm_index(request);
	} catch (Exception e) {
		w.error(e);
		return;
	}

	//TODO 默认时间 修改的话huizong_Rpt.jsp内SQL语句也得修改
	String date1 = StringUtil.getNowDate().toString();
	String date2 = StringUtil.getNowDate().toString();
	//String now = StringUtil.getNowDate() + "";
	//date1 = JspUtil.getParameter(request, "date1", now);
	//date2 = JspUtil.getParameter(request, "date2", now);
%>
</head>
<body>
	<form name=form1 method=post action='huizong_Rpt.jsp' target='rpt'>
		<div class="frame-main-content"
			style="left:0; top:0;position: static;">
			<div class="nt">
				<ul class="">
					<li><label> 地区: <select name=area_id id="area"
							onchange="form1.submit();" class="selectoption">
								<%=w.get("areaOption")%>
						</select> </label>
					</li>
					<li><label> 行业: <select name=trade_id id="trade"
							onchange="form1.submit();" class="selectoption">
								<option value='root'>请选择行业</option>
								<%=w.get("tradeOption")%>
						</select> </label>
					</li>
				</ul>
				<p class="tiaojiao-p">
					从: <input type='text' class="c1" name='date1' id='date1'
						value='<%=date1%>' readonly="readonly"
						onclick="new Calendar().show(this);" /> 到: <input type='text'
						class="c1" name='date2' id='date2' value='<%=date2%>'
						readonly="readonly" onclick="new Calendar().show(this);" />
				</p>
				<input type="submit" value='查看' title="查看" class="tiaojianbutton"
					id='btn_view' />
			</div>
		</div>
	</form>
	<div>
		<iframe src='huizong_Rpt.jsp' name="rpt" width=100% height="1400"
			frameborder=0 scrolling="auto"></iframe>
	</div>
</body>
</html>
