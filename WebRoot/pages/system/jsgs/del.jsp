<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
       
       String sql = "delete from t_cfg_jsgs where jsgs_id=";
     
       String jsgs_id = null;
       int id = 0;
       try{
          f.jsgs_check(session); 
        jsgs_id=w.p("jsgs_id");
        id =f.getInt(jsgs_id,0);
        
        sql=sql+id;
        f.update(sql,null);
          response.sendRedirect("index.jsp");
       
     }catch(Exception e){
     w.error(e);
     return;
    }
    
%>