<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

  Map model = null;
  String t = "t_sys_msg_phone";
  String cols = "phone_no,user_name,user_desc";
  String phone_no,user_name = null;
  try{
   
   model = w.model();
   
   phone_no = w.p("phone_no");
   user_name = w.p("user_name");
   
   if(f.empty(phone_no)){throw new Exception("�ֻ��Ų���Ϊ��");}
   if(f.empty(user_name)){throw new Exception("�û�������Ϊ��");}
   
   
   f.insert(t,cols,0,model);
   response.sendRedirect("q.jsp");
   
  }catch(Exception e){
    w.error(e);
    return;
  }

%>