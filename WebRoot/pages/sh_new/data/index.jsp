<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
    String cols = "station_id,data_table,date1,date2,date3,hour1,hour2,hour3,infectant_id,flag";
    String s = null;
    //这个能获得站位的名称，从pages/sh_new/index.jsp 的onclick=f_station_click方法中
    try{
    
      SwjUpdate.data(request);
      s = f.hide(cols,request);
      //f.sop(s);
    }catch(Exception e){
     w.error(e);
     return;
    }
   
%>
<body onload='form1.submit()'><br>

</body>