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
			date = "��"+date1+"��"+date2;     
            Map map = StyleUtil.getStationCount(staion_id,date1,date2);
            //��Ч��
            int yx_num = Integer.parseInt(map.get("yx_num").toString());
            //Ӧ����
            int yd_num = Integer.parseInt(map.get("yd_num").toString());
            //ʵ����
            int sd_num = Integer.parseInt(map.get("sd_num").toString());
            //������=ʵ����/Ӧ����
            lwv = f.format((double)sd_num/yd_num*100+"",format)+"%";
            //��Ч���ݻ�ȡ��=��Ч��/ʵ����
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
   
   <td>���ʱ��</td>
   <td>������</td>
   <td>��Ч���ݻ�ȡ��</td>
  </tr>
  
    <tr>
   	  <td><%=date%></td>
      <td><%=lwv%></td>
      <td><%=yxsjhql%></td>
    </tr>
  
 
  </tbody>
</table>


