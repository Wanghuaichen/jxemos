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
	<form name=form1 method=post target="frm_home_main">
		<input type="hidden" name="advice_user"
			value="<%=session.getAttribute("user_name")%>" />
		<div class="frame-main-content" style="left:0; top:0;">
			<div class="fankui">
				<ul>
					<li><b>�����û�</b> <span><%=session.getAttribute("user_name")%></span>
					</li>
					<li><b>��������</b> <span><input type="text" class="c1"
							id="advice_jg" name="advice_jg" /> </span>
					</li>
					<li><b>��ϵ��ʽ</b> <span><input type="text" class="c1"
							id="advice_lx" name="advice_lx" /> </span>
					</li>
					<li class="text"><b>��Ϣ����</b> <span><textarea rows="5" cols="60"
								id="advice_content" name="advice_content"
								class="textar"></textarea> </span>
					</li>
					<li><input type="button" value="�ύ" class="tiaojianbutton tj"
						onclick="submit_click(this.form)" />
					</li>
				</ul>
			</div>
		</div>
	</form>
	<script type="text/javascript">
		function submit_click(form) {
			var advice_jg = document.getElementById("advice_jg").value;
			var advice_lx = document.getElementById("advice_lx").value;
			var advice_content = document.getElementById("advice_content").value;

			//alert(advice_jg);

			if (advice_jg == "") {
				alert("����д��������!");
				return false;
			}

			if (advice_lx == "") {
				alert("����д��ϵ��ʽ!");
				return false;
			}

			if (advice_content == "") {
				alert("����д��Ϣ����!");
				return false;
			}

			//alert(form);

			form.action = "advice_add.jsp";

			form.submit();

		}
	</script>
</body>
</html>
