<%@ page contentType="text/html;charset=GBK"%>
<%@page import="com.hoson.app.*"%>
<%@page import="com.hoson.*"%>
<HTML>
<HEAD>
<TITLE>丰城市污染源监控管理系统</TITLE>

<STYLE type=text/css>
TD {
	FONT-SIZE: 10pt
}
#submit {
	width: 89px;
	height: 28px;
	background-image: url("../../../images/yhdl_jrxt.jpg");
	background-repeat: no-repeat;
	border: 0px;
	cursor: pointer;
}
</STYLE>
</HEAD>
<BODY bottomMargin=0 leftMargin=0 rightMargin=0 topMargin=0
	bgColor=#ecf2f9>
	<!--
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="502" background="/<%=JspUtil.getCtx(request)%>/images/top_logobg.gif"><img src="/<%=JspUtil.getCtx(request)%>/images/top_<%=App.getSysType(request)%>.gif" width="480" height="60"></td>
            <td width="147" background="/<%=JspUtil.getCtx(request)%>/images/top_logobg.gif">&nbsp;</td>
            <td width="344" background="/<%=JspUtil.getCtx(request)%>/images/top_logobg.gif"><img src="/<%=JspUtil.getCtx(request)%>/images/top_pc.gif" width="450" height="60"></td>
          </tr>
        </table>
     -->
	<table border=0 cellPadding=0 cellSpacing=0 width=100% height=100%
		bgColor=#ecf2f9>
		<tr>
			<td align="center" valign="middle" height="100%">
				<table height=310 width=557>
					<tr>
						<td background="/<%=JspUtil.getCtx(request)%>/images/loginbg.jpg"
							align="center" valign="middle"><br> <br> <br>
							<br> <br>
							<form name="form1" action="./login_action.jsp" method=post>
								<table border=0 align=center cellspacing=0>

									<tr>
										<td align=center>用户帐号</td>
										<td>&nbsp;&nbsp;<input type="text" name="user_name"
											style="width:150px"></td>
									</tr>
									<tr>
										<td align=center>用户密码</td>
										<td>&nbsp;&nbsp;<input type="password" name="user_pwd"
											style="width:150px"></td>
									</tr>
									<tr>
										<td></td>
										<td height=50px>&nbsp;&nbsp;<input type="submit" id="submit" value=""></td>
									</tr>
								</table>

							</form>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>
