<%@ page contentType="text/html;charset=GBK" %>
<form name=form1 action=a.jsp target=qq>
<input type=text name=msg value='ÄãºÃ,tiger'>
<input type=button value='get' onclick=f_get()>
<input type=button value='post' onclick=f_post()>
</form>

<a href='a.jsp?msg=ÄãºÃ,tiger' target=qq  >url</a>
<iframe name=qq width=100% height=300px></iframe>

<script>
function f_get(){
   form1.method='get';
   form1.submit();
   
}

function f_post(){
   form1.method='post';
   form1.submit();
   
}
</script>