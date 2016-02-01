<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
     
     String sql = null;
     String col_id,col_name = null;
     String msg = null;
     
     
      try{
        col_id = w.p("col_id");
        col_name=w.p("col_name");
        
        if(f.empty(col_id)){throw new Exception("col_id为空");}
        if(f.empty(col_name)){col_name="";}
        
        sql = "update t_cfg_station_col set col_name=? where col_id=?";
        Object[]ps = new Object[2];
        ps[0] = col_name;
        ps[1] = col_id;
        f.update(sql,ps);
        msg = "已成功保存";

      }catch(Exception e){
      //JspUtil.go2error(request,response,e);
      //return;
      msg = "保存时发生错误,"+e;
      }finally{
      //DBUtil.close(cn);
      }

%>

<form name=form1>
<textarea name=msg><%=msg%></textarea>
</form>
<script>
alert(form1.msg.value);
</script>








