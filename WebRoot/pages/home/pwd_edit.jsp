<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc_empty.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<link rel="stylesheet" href="../../web/index.css" />
<title>���߼��ͼ�ع���ϵͳ</title>

</head>
<body style="overflow: hidden;">
	<form name=form1 method=post target="frm_home_main" action="pwd_update.jsp">
		<input type="hidden" name="advice_user"
			value="<%=session.getAttribute("user_name")%>" />
		<div class="frame-main-content" style="left:0; top:0;">
			<div class="fankui">
				<ul>
					<li><b>ԭ����</b> <span><input type=password name=pwd_old />
					</span>
					</li>
					<li><b>������</b> <span><input type=password name=pwd1 />
					</span>
					</li>
					<li><b>�ظ�����</b> <span><input type=password name=pwd2 />
					</span>
					</li>
					<li><input type="button" value="�ύ" class="tiaojianbutton tj"
						onclick="form1.submit();" />
					</li>
				</ul>
			</div>
		</div>
	</form>
</body>
</html>
