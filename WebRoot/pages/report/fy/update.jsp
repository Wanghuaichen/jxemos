<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
      String msg = null;
      
   try{
   
    action = new FyReport();
    action.run(request,response,"update");
    msg = "已成功保存";
   
   }catch(Exception e){
      //w.error(e);
      //return;
      msg = "保存时发生错误,"+e;
      msg = msg.replaceAll("java.lang.Exception:","");
   }
  
   

%>
<form name=form1>
 <textarea name=msg><%=msg%></textarea>
</form>
<script>
alert(form1.msg.value);
</script>
