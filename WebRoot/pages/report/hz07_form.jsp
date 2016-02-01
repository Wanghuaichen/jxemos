<%@ page contentType="text/html;charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.hoson.*"%>
<%@page import="com.hoson.app.*"%>
<%@page import="com.hoson.util.*"%>
<%
    String sql = null;

    String option = null;
    String date1 = null;
    String date2 = null;

    sql = "select station_id,station_desc from t_cfg_station_info where station_type='6'";
    try {
        //option = JspUtil.getOption(sql,"",request);
        option = JspPageUtil.getAreaOption("");
    } catch (Exception e) {
        //out.println(e);
        JspUtil.go2error(request, response, e);
        return;
    }

    date1 = date2 = StringUtil.getNowDate() + "";
%>

<link rel="stylesheet" href="../../web/index.css" />

<script type="text/javascript"
	src="/<%=JspUtil.getCtx(request)%>/scripts/01.js"></script>
<script type="text/javascript"
	src="/<%=JspUtil.getCtx(request)%>/scripts/newdate.js"></script>
<body onload=form1.submit()>

	<form name="form1" method=post action="./hz07.jsp" target="q">
		<div class="frame-main-content"
			style="left: 0; top: 0; position: static;">
			<div class="nt">
				<p class="tiaojiao-p">
					<select name=area_id onchange=form1.submit() class="selectoption"><%=option%></select>

				</p>
				<input type=button value='²éÑ¯' onclick=form1.submit()
					class="tiaojianbutton">
				<p class="tiaojiao-p">
					<input type=hidden name='tableName'
						value='<%=request.getParameter("tableName")%>'>

				</p>
			</div>
		</div>
	</form>

	<iframe name="q" width=100% height=100% frameborder="0">
	</iframe>
</body>