<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
  String sql = null;

  String areaOption,phoneOption = null;
  String area_id = null;
  Connection cn = null;
  
  try{
    
    area_id = f.cfg("area_id","3301");
    sql = "select area_id,area_name from t_cfg_area where area_pid like '"+area_id+"%' or area_id='"+area_id+"' order by area_id,area_name";
    
    cn = f.getConn();
    areaOption = f.getOption(cn,sql,null);
    sql="select phone_no,user_name from t_sys_msg_phone";
    phoneOption = f.getOption(cn,sql,null);
    
  }catch(Exception e){
    w.error(e);
    return;
  }finally{f.close(cn);}

%>


<form name=form1 method=post action=add.jsp>
 <table border=0 cellspacing=1>
  <tr>
  <td  class='tdtitle'>地区</td>
  <td><select name=area_id><%=areaOption%></select></td>
  </tr>
  
   <tr>
  <td class='tdtitle'>联系人</td>
  <td><select name=phone_no><%=phoneOption%></select></td>
  </tr>
  
  
   <tr>
  <td class='tdtitle'></td>
  <td>
  <input type=button value='添加' onclick='form1.submit()'  class='btn'>
  <input type=button value='返回' onclick='history.back()'  class='btn'>
  
  </td>
  </tr>
  
  
 </table>
</form>