<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
      String msg = "";
   try{
    action = new WarnAction();
    action.run(request,response,"scshsj");
    msg = "���¼���ɹ���";
   }catch(Exception e){
      w.error(e);
      msg = "���¼���ʧ�ܣ��д���";
      return;
   }
   
   //RowSet rs1 = w.rs("data");
  // RowSet rs2 = w.rs("infectant");
   //String v,col = null;
   //String station_id,m_time = null;
   
%>
</br>
</br>
</br>
</br>
</br>
<p style="font-size=30px"><%=msg%></p>