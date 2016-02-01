<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
     
     String sql = null;
     List list = null;
     RowSet rs = null;
     int i,num=0;
     
     
      try{
        sql = "select * from t_cfg_station_col order by col_id";
        list = f.query(sql,null);
        rs = new RowSet(list);


      }catch(Exception e){
      JspUtil.go2error(request,response,e);
      return;
      }finally{
      //DBUtil.close(cn);
      }

%>
<table border=0 cellspacing=1>
<tr class=title>
 <td>序号</td>
 <td>列名</td>
 <td>标题</td>
 <td></td>
</tr>

<%while(rs.next()){
  i = rs.getIndex()+1;
%>
<form name=form<%=i%> method=post action=col_update.jsp>
  <input type=hidden name=col_id value='<%=rs.get("col_id")%>'>
  <tr>
  
  <td><%=i%></td>
  <td>第<%=rs.get("col_id")%>列</td>
  <td><input type=text name=col_name value='<%=rs.get("col_name")%>' style="width:200px"></td>
  
  <td>
  <input type=button value='保存' onclick="f_save(<%=i%>)" class=btn>
  </td>
  </tr>
  </form>
<%}%>
</table>
<iframe name=frm_col_save width=0 height=0></iframe>
<script>
function f_save(formx){
  formx.target='frm_col_save';
  formx.submit();
}
</script>


