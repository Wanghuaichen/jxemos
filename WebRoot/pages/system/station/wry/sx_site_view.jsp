<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

    Map m = null;
    XBean b = null;
    

     try{
           SwjUpdate.view(request);
           m = (Map)request.getAttribute("data");
           b = new XBean(m);
            
            
     }catch(Exception e){
      w.error(e);
      return;
     }

%>

<body scroll=no >

<table cellspacing=1 style='width:100%'>
   <tr>
   <td class='tdtitle' width=100px>���</td>
   <td><%=b.get("station_id")%></td>
   <td class='tdtitle' width=100px>����</td>
   <td><%=b.get("station_desc")%></td>
   <td class='tdtitle' width=100px>���</td>
   <td><%=b.get("station_no")%></td>
 
   
   </tr>
   
   
   <tr>
   
   <td class='tdtitle' width=100px>��ַ</td>
   <td><%=b.get("station_addr")%></td>
  
  
    <td class='tdtitle'>��ҵ</td>
    <td><select name='trade_id' disabled='true'><%=w.get("tradeOption")%></select></td>
    
    <td class='tdtitle'>����</td>
    <td>
    <select name=area_id disabled='true'>
    <option value=''>
    <%=w.get("areaOption")%>
    </select>
    </td>
    
   
  
   </tr>
   
   
   <tr>
   
    <td class='tdtitle'>����</td>
    <td>
    <select name=valley_id disabled='true'>
    <option value=''>
    <%=w.get("valleyOption")%>
    </select>
    </td>
    
    <td class='tdtitle'>�ŷ�ȥ��</td>
   <td><%=b.get("pfqx")%></td>
    
   
   
    <td class='tdtitle'>��ά��λ</td>
    <td><%=b.get("ywdw")%></td>
    
   </tr>
   
   <tr>
    <td class='tdtitle'>��ϵ��</td>
    <td><%=b.get("ywdw_man")%></td>
    
    <td class='tdtitle'>��ϵ��ʽ</td>
    <td><%=b.get("ywdw_man_phone")%></td>
    
    <td class='tdtitle'>���赥λ</td>    
    <td><%=b.get("jsdw")%></td>
    
   </tr>
   
   
   <tr>
    <td class='tdtitle'>��ʩ������Ա</td>
    <td><%=b.get("ssgl_man")%></td>
    
    <td class='tdtitle'>��ϵ��ʽ</td>
    <td><%=b.get("ssgl_man_phone")%></td>
    
    
    <td class='tdtitle'>�������</td>
    <td><%=b.get("scqk")%></td>
    
   
   </tr>
   
    <tr>
    
     <td class='tdtitle'>�Ƿ���ʾ</td>
    <td><select name='show_flag' disabled='true'><%=w.get("showOption")%></select></td>
    
    
    <td class='tdtitle'>�ص�Դ����</td>
    <td><select name='ctl_type' disabled='true'><%=w.get("ctlTypeOption")%></select></td>
    
    <td class='tdtitle'>��ע</td>
    <td><%=b.get("station_bz")%></td>
    
    
   </tr>
  
</table>


</body>





