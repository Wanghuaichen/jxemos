<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
  String sql = null;
  String msg_key,msg_value=null;
  String msg = null;
 
  try{
  
  msg_key = w.p("msg_key");
  msg_value = w.p("msg_value");
  sql = "update t_sys_msg_config set msg_value=? where msg_key=?";
  Object[]p=new Object[]{msg_value,msg_key};
  f.update(sql,p);
  
  msg = "�ѳɹ�����";
  
  }catch(Exception e){
    //w.error(e);
    //return;
    msg="����ʱ����,"+e.getMessage();
  }

%>

<form name=form1>
  <textarea style="display:none" name=msg><%=msg%></textarea>
 
</form>

<script>
alert(form1.msg.value);
</script>

