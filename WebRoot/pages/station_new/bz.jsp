<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
   String station_id = w.p("station_id");
    String user_name = (String)session.getAttribute("user_name");
   
   String sql = "select station_id,station_desc,station_bz from t_cfg_station_info where station_id=?";
   Map m = null;
   XBean b = null;
   String flag = null;
   try{
    if(f.empty(station_id)){f.error("��ѡ��վλ");}
    m = f.queryOne(sql,new Object[]{station_id});
    if(m==null){f.error("��¼������");}
    
    flag = SwjUpdate.getStationFocusFlag(station_id,session);
    
    
    }catch(Exception e){
     w.error(e);
     return;
    }
    b = new XBean(m);

%>
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css" />

<body style="background-color: #f7f7f7">

<div class="tableSty1 view3">
<form name=form1 method=post action='bz_update.jsp' target='frm_station_bz'>
  <input type=hidden name='focus_flag'>
  
<table width="98%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
    <%--<td class=tdtitle style='width:200px'>վλ���</td>--%>
     <td style="display: none;">
      <input type=hidden readonly name='station_id' value='<%=b.get("station_id")%>'>
      </td>
    </tr>
    
    <tr> 
    <td class=tdtitle>վλ����</td>
     <td>
      <%=b.get("station_desc")%>
      </td>
    </tr>
    
     <tr> 
    <td class=tdtitle>վλ��ע��Ϣ</td>
     <td>
      <input type=text  name='station_bz' value='<%=b.get("station_bz")%>' style='width:300'>
      </td>
    </tr> 
    <tr> 
    <td class=tdtitle></td>
     <td>
      <% if(!"".equals(user_name) && user_name.equals("admin")){ %>
         <input type=submit  value=' �� �� ' class=btn >
      <%} %>
      <%if(f.eq(flag,"0")){%>
      <input type=button  value='�����ղؼ�' class=btn onclick='focus_add()'>
      <%}%>
      
      <%if(f.eq(flag,"1")){%>
      <input type=button  value='���ղؼ���ɾ��' class=btn  onclick='focus_del()'>
      <%}%>
      
      </td>
    </tr> 
    
    
    
</table>



</form>
</div>
<script>
  function focus_add(){
     form1.action='focus_add.jsp';
     form1.submit();
  }
  
   function focus_del(){
          form1.action='focus_del.jsp';
     form1.submit();
  }
</script>