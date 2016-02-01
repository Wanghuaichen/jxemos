<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

      BaseAction action = null;
      String now = StringUtil.getNowDate()+"";
      String date1 = request.getParameter("date1");
      String url = "water.jsp";
      String station_type  = request.getParameter("station_type");
      
      if(f.eq(station_type,"1")){url = "water.jsp";}
      if(f.eq(station_type,"2")){url = "gas.jsp";}
      
      if(f.empty(date1)){date1 = now;}
   try{
   
   
    action = new StdReportAction();
    action.run(request,response,"rpt");
   
   }catch(Exception e){
      w.error(e);
      return;
   }
 
   if(2>1){
   
  // out.println(url+","+date1);
    System.out.println(url+","+date1);
     request.getRequestDispatcher(url).forward(request, response);
      //System.out.println(url+","+date1);
      //JspUtil.fd(request,response,url);
      return;
   }
   

  
  
   RowSet rs = w.rs("data");
   List list = (List)request.getAttribute("data");
   int i,num = 0;
   num = list.size();
   
   
   
%>
111111111111111111
