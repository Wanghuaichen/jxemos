<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%@page import="java.util.Date"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>���߼��ͼ�ع���ϵͳ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<script type="text/javascript" src="../../../scripts/calendar.js"></script>
<link rel="stylesheet" href="../../../web/index.css" />

<%
	String sql = null;
	Connection cn = null;
	String stationOption = null;
	try {
		cn = DBUtil.getConn(request);
		sql = "select station_id,station_desc from t_cfg_station_info where station_type=1 and SHOW_FLAG<>1 order by station_desc ";
		stationOption = JspUtil.getOption(cn, sql, null);
	} catch (Exception e) {
		//out.println(e);
		JspUtil.go2error(request, response, e);
		return;
	} finally {
		DBUtil.close(cn);
	}
	//TODO Ĭ��ʱ�� �޸ĵĻ�test_Rpt.jsp��SQL���Ҳ���޸�
	String date1 = StringUtil.getNowDate().toString();
	String date2 = StringUtil.getNowDate().toString();
	//String now = StringUtil.getNowDate() + "";
	//date1 = JspUtil.getParameter(request, "date1", now);
	//date2 = JspUtil.getParameter(request, "date2", now);
%>
</head>
<body>
	<form name=form1 method=post action='test_Rpt.jsp' target='rpt'>
		<div class="frame-main-content"
			style="left:0; top:0;position: static;">
			<div class="nt">
				<p class="tiaojiao-p">
					<select name="station_id" onchange="form1.submit();" style="width: 222px;"
						class="selectoption">
						<option value="">��ѡ��һ��վλ</option>
						<%=stationOption%>
					</select>
				</p>
				<p class="tiaojiao-p">
					��: <input type='text' class="c1" name='date1' id='date1'
						value='<%=date1%>' readonly="readonly"
						onclick="new Calendar().show(this);" />
					��: <input type='text' class="c1" name='date2' id='date2'
						value='<%=date2%>' readonly="readonly"
						onclick="new Calendar().show(this);" />
				</p>
				<input type="submit" value='�鿴' title="�鿴" class="tiaojianbutton"
					id='btn_view' />
			</div>
		</div>
	</form>
	<div>
		<iframe src='test_Rpt.jsp' name="rpt" width=100% height="1400"
			frameborder=0 scrolling="auto"></iframe>
	</div>
</body>
</html>
