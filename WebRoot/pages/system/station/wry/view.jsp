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

<body scroll=no>
<form name=form1 method=post action='update.jsp' target='frm_wry'>
<table cellspacing=1 style='width:100%;height:100%'>
   <tr>
   <td class='tdtitle'>���</td>
   <td><input readonly type=text name='station_id' value='<%=b.get("station_id")%>'></td>
   <td class='tdtitle'>����</td>
   <td><input type=text name='station_desc' style='width:220px' value='<%=b.get("station_desc")%>'></td>
   <td class='tdtitle'>���</td>
   <td><input type=text name='station_no'  value='<%=b.get("station_no")%>'></td>
 
   
   <td class='tdtitle'>��ַ</td>
   <td><input type=text name='station_addr'  style='width:220px'  value='<%=b.get("station_addr")%>'></td>
   </tr>
   
   
   <tr>
    <td class='tdtitle'>��ҵ</td>
    <td><select name='trade_id'><%=w.get("tradeOption")%></select></td>
    <td class='tdtitle'>����</td>
    <td>
    <select name=area_id>
    <option value=''>
    <%=w.get("areaOption")%>
    </select>
    </td>
    <td class='tdtitle'>����</td>
    <td>
    <select name=valley_id>
    <option value=''>
    <%=w.get("valleyOption")%>
    </select>
    </td>
    <td class='tdtitle'>�ŷ�ȥ��</td>
    
    <td><input type=text name='pfqx' style='width:220px' value='<%=b.get("pfqx")%>'></td>
    
   </tr>
   
   
   <tr>
    <td class='tdtitle'>��ά��λ</td>
    <td><input type=text name='ywdw' value='<%=b.get("ywdw")%>'></td>
    <td class='tdtitle'>��ϵ��</td>
    <td><input type=text name='ywdw_man' value='<%=b.get("ywdw_man")%>'></td>
    <td class='tdtitle'>��ϵ��ʽ</td>
    <td><input type=text name='ywdw_man_phone' value='<%=b.get("ywdw_man_phone")%>'></td>
    <td class='tdtitle'>���赥λ</td>
    
    <td><input type=text name='jsdw' style='width:220px' value='<%=b.get("jsdw")%>'></td>
    
   </tr>
   
   <tr>
    <td class='tdtitle'>��ʩ������Ա</td>
    <td><input type=text name='ssgl_man' value='<%=b.get("ssgl_man")%>'></td>
    <td class='tdtitle'>��ϵ��ʽ</td>
    <td><input type=text name='ssgl_man_phone' value='<%=b.get("ssgl_man_phone")%>'></td>
    
    <td class='tdtitle'>�������</td>
    
    <td>
    <input type=text name='scqk'  value='<%=b.get("scqk")%>'>
   
    </td>
    
    <td class='tdtitle'>�Ƿ���ʾ</td>
    <td><select name='show_flag'><%=w.get("showOption")%></select></td>
    
   </tr>
   
    <tr>
    
    <td class='tdtitle'>�ص�Դ����</td>
    <td>
      <select name='ctl_type'><%=w.get("ctlTypeOption")%></select>
    </td>
    
    <td class='tdtitle'>��ע</td>
    <td><input type=text name='station_bz' value='<%=b.get("station_bz")%>'></td>
    
    
    
    <td class='tdtitle'>��ҵ״̬</td>
    <td>
    	<select name='qy_state'><%=w.get("qyStateOption")%></select>
    </td>
    
    <td class='tdtitle'></td>
    
    <td>
    
    </td>
    
   </tr>
   
   <tr>
    <td colspan=10>
    <!-- <input type=button value=�鿴���ָ��  class=btn onclick=f_f()> -->
    <input type=button value=���� class=btn onclick=f_update()>
    <input type=button value=�ر� onclick='window.close()'  class=btn>
   <!--<input type=button value=���� onclick=f_back()  class=btn>-->
    </td>
   </tr>
   
   
   
   <tr>
    <td colspan=10 style='height:80%'>
    <iframe name='frm_wry' width=100% height=100% frameborder=0></iframe>
    </td>
   </tr>
   
</table>

 

</form>
</body>

<script>
 function f_f(){
   form1.action='../infectant/q.jsp';
   form1.submit();
   
 }
 
  function f_update(){
   form1.action='update.jsp';
   form1.submit();
   
 }
</script>







