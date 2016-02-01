<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
     String table = "t_cfg_jsgs";
     String cols = "jsgs_id,jsgs_name,jsgs_desc";
     Map m = null;
     String jsgs_name,jsgs_desc;
     try{
        f.jsgs_check(session); 
      m = f.model(request);
      jsgs_name = (String)request.getParameter("jsgs_name");
      jsgs_desc = (String)request.getParameter("jsgs_desc");
      m.put("jsgs_name",(String)request.getParameter("jsgs_name"));
      m.put("jsgs_desc",(String)request.getParameter("jsgs_desc"));
      w.add(m);
      if(f.empty(jsgs_name)){f.error("计算公式名称不能为空");}
      if(f.empty(jsgs_desc)){f.error("计算公式描述不能为空");}
      f.insert(table,cols,1,m);
      response.sendRedirect("index.jsp");
     
     }catch(Exception e){
      w.input(e,"input.jsp");
      return;
     }

%>