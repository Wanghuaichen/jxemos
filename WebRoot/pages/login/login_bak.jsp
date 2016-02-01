<%@ page contentType="text/html;charset=gbk" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<link rel="stylesheet" href="reg-login-third.css">
<script type="text/javascript" src="jquery-1.8.3.min.js">

</script>
<script type="text/javascript">
    $(function () {
        $(".input-wrap input").focus(function () {

            var a = $(this).parent(".input-wrap");
            a.addClass("focus");
            a.find("label").hide();
        })
        $(".input-wrap input").blur(function () {
            var a = $(this).parent(".input-wrap");
            a.removeClass("focus");
            if (($(this).val()) == 0) {
                a.find("label").show();
            }
        })
    })
</script>

<script type="text/javascript">
	//回车登陆
    function fireFoxHandler(evt)  
    {   
        //alert("firefox");   
        if (evt.keyCode == 13)  
        {   
            document.form1.submit();   
        }   
    }   
    function ieHandler(evt)  
    {   
        //alert("IE");   
        if (evt.keyCode == 13)  
        {   
            document.form1.submit();   
        }   
    }
</script>
<title>丰城市污染源监控管理系统</title>
</head>
<body>
<div class="clearfix" id="startpage">
<div class="login-bg" id="startpage-wrap" style="margin-left: 0px;">
<h1 id="logo-startpage" style="padding-top: 74px;"> <span class="login-logo"> <a href="#"></a> </span> </h1>
<div id="login-wrap">
<div id="login-form-wrap">
<form method="post" action="login_action.jsp" class="clearfix" id="login-form" name="form1">
<div id="input-login-email" class="input-wrap"> <span class="input-icon"></span>
<label>账号</label>
<input type="text" value="admin" name="user_name" class="startpage-input-text">
</div>
<div id="input-login-pwd" class="input-wrap"> <span class="input-icon"></span>
<label>密码</label>
<input type="password" value="admin" name="user_pwd" class="startpage-input-text">
<div style="display:none" class="tip"></div>
</div>
<input type="hidden" value="" name="nextUrl">
<input type="hidden" value="" name="lcallback">
<input type="hidden" checked="checked" value="1" name="persistent">
<input type="submit" value="登录" class="input-button hidden-submit" name="login-submit">
<div cloud="" id="ctrlbuttonlogin-submit" data-control="login-submit"
class="ui-button skin-button-willblue" style="width:380px;"
onclick="form1.submit();">
	<span class="ui-button-bg-left skin-button-willblue-bg-left" onclick="form1.submit();"></span>
	<div class="ui-button-label skin-button-willblue-label"
		id="ctrlbuttonlogin-submitlabel" onclick="form1.submit();">
		<span class="ui-button-text skin-button-willblue-text"
			id="ctrlbuttonlogin-submittext" onclick="form1.submit();">登录</span>
	</div>
</div>
</form>

</div>
 
 
</div>
<div style=" margin:30px auto 0; width:108px;" >
<img src="images/LOGO2.png" />
</div>
</body>
</html>
