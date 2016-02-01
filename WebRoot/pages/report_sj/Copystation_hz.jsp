<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.zdxupdate.*"%>
<%
	String staion_id,date1,date2,date;
	String lwv,yxsjhql;
          try{
            String format = "0.####";
			staion_id = request.getParameter("station_id");     
			date1 = request.getParameter("date1");    
			date2 = request.getParameter("date2");      
			date = "从"+date1+"到"+date2;     
            Map map = StyleUtil.getStationCount(staion_id,date1,date2);
            //有效数
            int yx_num = Integer.parseInt(map.get("yx_num").toString());
            //应得数
            int yd_num = Integer.parseInt(map.get("yd_num").toString());
            //实得数
            int sd_num = Integer.parseInt(map.get("sd_num").toString());
            //联网率=实得数/应得数
            lwv = f.format((double)sd_num/yd_num*100+"",format)+"%";
            //有效数据获取率=有效数/实得数
            yxsjhql = "0";
            if(sd_num!=0){
            	yxsjhql = f.format((double)yx_num/sd_num*100+"",format)+"%";
            }
          }catch(Exception e){
            w.error(e);
            return;
          }
          
          
          
%>

<table border=0 cellspacing=1><tbody id="div_excel_content">
  <tr class='title'>
   
   <td>监测时间</td>
   <td>联网率</td>
   <td>有效数据获取率</td>
  </tr>
  
    <tr>
   	  <td><%=date%></td>
      <td><%=lwv%></td>
      <td><%=yxsjhql%></td>
    </tr>
  
 
  </tbody>
</table>


