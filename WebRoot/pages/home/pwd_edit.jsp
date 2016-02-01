<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc_empty.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<link rel="stylesheet" href="../../web/index.css" />
<title>在线检测和监控管理系统</title>

</head>
<body style="overflow: hidden;">
	<form name=form1 method=post target="frm_home_main" action="pwd_update.jsp">
		<input type="hidden" name="advice_user"
			value="<%=session.getAttribute("user_name")%>" />
		<div class="frame-main-content" style="left:0; top:0;">
			<div class="fankui">
				<ul>
					<li><b>原密码</b> <span><input type=password name=pwd_old />
					</span>
					</li>
					<li><b>新密码</b> <span><input type=password name=pwd1 />
					</span>
					</li>
					<li><b>重复密码</b> <span><input type=password name=pwd2 />
					</span>
					</li>
					<li><input type="button" value="提交" class="tiaojianbutton tj"
						onclick="form1.submit();" />
					</li>
				</ul>
			</div>
		</div>
	</form>
</body>
</html>
