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
   <td class='tdtitle' width=100px>编号</td>
   <td><input readonly type=text name='station_id' value='<%=b.get("station_id")%>'></td>
   <td class='tdtitle' width=100px>名称</td>
   <td><input type=text name='station_desc' style='width:220px' value='<%=b.get("station_desc")%>'></td>
   <td class='tdtitle' width=100px>序号</td>
   <td><input type=text name='station_no'  value='<%=b.get("station_no")%>'></td>
 
   
   </tr>
   
   
   <tr>
   
   <td class='tdtitle' width=100px>地址</td>
   <td><input type=text name='station_addr'  style='width:220px'  value='<%=b.get("station_addr")%>'></td>
  
  
    <td class='tdtitle'>行业</td>
    <td><select name='trade_id'><%=w.get("tradeOption")%></select></td>
    
    <td class='tdtitle'>地区</td>
    <td>
    <select name=area_id>
    <option value=''>
    <%=w.get("areaOption")%>
    </select>
    </td>
    
   
  
   </tr>
   
   
   <tr>
   
    <td class='tdtitle'>流域</td>
    <td>
    <select name=valley_id>
    <option value=''>
    <%=w.get("valleyOption")%>
    </select>
    </td>
    
    <td class='tdtitle'>排放去向</td>
   <td><input type=text name='pfqx' style='width:220px' value='<%=b.get("pfqx")%>'></td>
    
   
   
    <td class='tdtitle'>运维单位</td>
    <td><input type=text name='ywdw' value='<%=b.get("ywdw")%>'></td>
    
   </tr>
   
   <tr>
    <td class='tdtitle'>联系人</td>
    <td><input type=text name='ywdw_man' value='<%=b.get("ywdw_man")%>'></td>
    
    <td class='tdtitle'>联系方式</td>
    <td><input type=text name='ywdw_man_phone' value='<%=b.get("ywdw_man_phone")%>'></td>
    
    <td class='tdtitle'>建设单位</td>    
    <td><input type=text name='jsdw' style='width:220px' value='<%=b.get("jsdw")%>'></td>
    
   </tr>
   
   
   <tr>
    <td class='tdtitle'>设施管理人员</td>
    <td><input type=text name='ssgl_man' value='<%=b.get("ssgl_man")%>'></td>
    
    <td class='tdtitle'>联系方式</td>
    <td><input type=text name='ssgl_man_phone' value='<%=b.get("ssgl_man_phone")%>'></td>
    
    
    <td class='tdtitle'>生产情况</td>
    <td><input type=text name='scqk'  value='<%=b.get("scqk")%>'></td>
    
   
   </tr>
   
    <tr>
    
     <td class='tdtitle'>是否显示</td>
    <td><select name='show_flag'><%=w.get("showOption")%></select></td>
    
    
    <td class='tdtitle'>重点源属性</td>
    <td><select name='ctl_type'><%=w.get("ctlTypeOption")%></select></td>
    
    <td class='tdtitle'>备注</td>
    <td><input type=text name='station_bz' value='<%=b.get("station_bz")%>'></td>
    
    
   </tr>
  
</table>


</body>





