<%@ page contentType="text/html;charset=GBK" import="java.util.*"%>
<%@ include file="/pages/commons/inc.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>在线检测和监控管理系统</title>
<link href="../../styles/reset-min.css" rel="stylesheet" type="text/css" />
<link href="../../styles/common/common.css" rel="stylesheet"
	type="text/css" />

<style type="text/css">
.search {
	font-family: "宋体";
	font-size: 12px;
	width: 200px;
	BEHAVIOR: url('<%=request.getContextPath()%>/styles/selectBox.htc');
	cursor: hand;
}

.input {
	border: #ccc 1px solid;
	font-family: "微软雅黑";
	font-size: 12px;
	padding-top: 2px;
	width: 80px;
	background: expression((this.readOnly &&this.readOnly == true)?"#f9f9f9":"");
}

.scrolldiv ul {
	margin: 10px 0px 0px 10px;
}

.scrolldiv ul li {
	height: 26px;
}

.scrolldiv ul li a {
	display: block;
	width: 189px;
	height: 23px;
	line-height: 23px;
	color: #000;
	text-indent: 4px;
}

.scrolldiv ul li a:hover {
	background: url(<%=   request.getContextPath ()%>/images/common/viewbar.gif) no-repeat;
	text-decoration: none;
}

.scrolldiv ul li a:visited {
	background-color: #f7f7f7;
	text-decoration: none;
}

.btn1 {
	background: url(<%=   request.getContextPath ()%>/images/common/btn1.gif) no-repeat;
	border: none;
	text-align: center;
}
</style>
</head>

<%
	ArrayList<String[]> al = new ArrayList<String[]>();
	//al.add(new String[]{"basename.jsp","title"});
	al.add(new String[]{"report_sj_water.jsp","污染源污水排放总量报表"});
	al.add(new String[]{"report_sj_gas.jsp","污染源烟气排放总量报表"});
	//al.add(new String[]{"test.jsp","污染源污水综合查询报表"});
	al.add(new String[]{"water_hz.jsp","污染源污水汇总报表"});
	al.add(new String[]{"huizong.jsp","污染源烟气汇总报表"});
%>

<body style="background-color: #ffffff;overflow: hidden;">
	<table border=0 style='width:100%' cellspacing=0>
		<tr>
			<td width="210" height="800" class="left">
				<div class='scrolldiv'
					style=" overflow: scroll;
scrollbar-base-color: #ecf2f9;
scrollbar-arrow-color: #336699;
scrollbar-track-color: #ecf2f9;
scrollbar-3dlight-color: #ecf2f9;
scrollbar-darkshadow-color: #ecf2f9;
scrollbar-highlight-color: #336699;
scrollbar-shadow-color: #336699;">
					<ul>
						<!-- 以下根据情况自行修改 -->
						<%
							for (String[] alStr : al) {
						%>
						<li style="cursor:hand">
						<a
							title="" href="<%="reports/"+alStr[0]%>"
							target='frm_station' >
							<%=alStr[1]%>
						</a>
						</li>
						<%
							}
						%>
						<!-- 以上根据情况自行修改 -->
					</ul>
				</div>
			</td>
			<td class="right">
				<iframe src='<%="reports/"+al.get(0)[0]%>' width=100%   name='frm_station'
					height="1400" frameborder=0 scrolling="no">
				</iframe>
			</td>
		</tr>
	</table>
</body>
</html>
