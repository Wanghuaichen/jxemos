<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
     String table = "t_cfg_jsgs";
     String cols = "jsgs_id,jsgs_name,jsgs_desc";
     Map m = null;
     String jsgs_id,jsgs_name,jsgs_desc;
     try{
          f.jsgs_check(session); 
      m = f.model(request);
      jsgs_id = (String)m.get("jsgs_id");
      jsgs_name = (String)m.get("jsgs_name");
      jsgs_desc = (String)m.get("jsgs_desc");
      w.add(m);
      if(f.empty(jsgs_id)){f.error("���㹫ʽ��Ų���Ϊ��");}
      if(f.empty(jsgs_name)){f.error("���㹫ʽ���Ʋ���Ϊ��");}
      if(f.empty(jsgs_desc)){f.error("���㹫ʽ��������Ϊ��");}
      
      f.save(table,cols,1,m);
      response.sendRedirect("index.jsp");
     
     }catch(Exception e){
      //w.input(e,"view.jsp");
      w.error(e);
      return;
     }

%>