<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
      String msg = null;
   try{
   /*
     String mobile = f.p(request,"mobile");
	   String content = f.p(request,"content");
	   if(f.empty(mobile)){throw new Exception("请填写手机号");}
	   mobile=mobile.trim();
	   if(mobile.length()<11){throw new Exception("请填写正确的手机号");}
	   
	   String sql = "insert into sms_send(id,mobile,content)values(sms_seq.nextval,?,?)";
	   
	   f.update(sql,new Object[]{mobile,content});
	   */
	   action = new WarnAction();
	   action.run(request,response,"send_msg");
    msg = "短消息已成功发送";
    
   }catch(Exception e){
      //System.out.println(e);
      //w.error(e);
      //return;
      //System.out.println(e);
      msg = "发送短消息时发生错误,"+e;
      
   }
   
   msg = msg.replaceAll("java.lang.Exception:","");
   
%>
<form name=form1>
<textarea name=msg style="display:none"><%=msg%></textarea>
</form>
<script>
alert(form1.msg.value);
</script>