<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      
Map model = w.model();
//out.println(model);
Connection cn = null;
List dataList = null;
int i,num=0;
String url = "water_day.jsp";
String station_type = request.getParameter("station_type");
String report_type = request.getParameter("report_type");

  try{
    cn = f.getConn();
    //AreaReport.gas_report(cn,model,request);
    AreaReport.rpt(request);
     dataList = (List)request.getAttribute("data");
     num = dataList.size();
     /*
     for(i=0;i<num;i++){
      out.println(dataList.get(i)+"<br>\n");
     }
     */
     
     //(request.getAttribute("sql1"));
     //System.out.println(request.getAttribute("sql2"));
     if(f.eq(station_type,"1") && f.eq(report_type,"day")){
     url = "water_day.jsp";
     }
     if(f.eq(station_type,"1") && f.eq(report_type,"month")){
     url = "water_month.jsp";
     }
     if(f.eq(station_type,"1") && f.eq(report_type,"year")){
     url = "water_year.jsp";
     }
     
     
     if(f.eq(station_type,"2") && f.eq(report_type,"day")){
     url = "gas_day.jsp";
     }
     if(f.eq(station_type,"2") && f.eq(report_type,"month")){
     url = "gas_month.jsp";
     }
     if(f.eq(station_type,"2") && f.eq(report_type,"year")){
     url = "gas_year.jsp";
     }
     
     if(2>1){

     request.getRequestDispatcher(url).forward(request, response);
      return;
   }
     
  }catch(Exception e){
    w.error(e);
    return;
  }finally{f.close(cn);}

%>