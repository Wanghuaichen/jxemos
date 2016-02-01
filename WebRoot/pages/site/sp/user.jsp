<%
     String sp_user= request.getParameter("sp_user_in_use");
     com.hoson.util.SpUtil.update(sp_user);
    // System.out.println(com.hoson.util.SpUtil.info());
     
%>