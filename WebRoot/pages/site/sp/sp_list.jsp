<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.hoson.*,com.hoson.util.*,java.sql.*,java.util.*,javax.servlet.http.*,com.hoson.app.*"%>

<%
      String station_type = request.getParameter("station_type");
      String area_id = request.getParameter("area_id");
      String sp_type = request.getParameter("sp_type");
      String url = null;
      String url_pre = "http://127.0.0.1:8080/swj/pages/site/sp/";
      url_pre="";
      url = url_pre+"sp_hk_list.jsp";
      String url_hk =  url_pre+"sp_hk_list_new.jsp";
      String url_dx =  url_pre+"sp_dx_list.jsp";
      
      
      
      //if(sp_type==null){sp_type="";}
      if(f.empty(sp_type)){sp_type="2";}
      
      if(station_type==null){station_type="";}
      if(area_id==null){area_id="";}
      
      url="sp_hk_list.jsp";
      if(sp_type.equals("1")){url=url_hk;}
      if(sp_type.equals("2")){url=url_dx;}
      
      url=url+"?station_type="+station_type+"&area_id="+area_id+"&sp_type="+sp_type;
     // System.out.println(url);
    //  response.sendRedirect(url);
      
      
      
%>

<script>
window.location.href='<%=url%>';
</script>