<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
  Map map = JspUtil.getRequestModel(request);
  
  Connection cn = null;
  
  String sql = "update t_cfg_infectant_base set lo_min=?,hi_max=? where infectant_id=?";
  String msg = "";
  
  
  
   try{
      
    String infectant_id = (String)map.get("infectant_id");
    String lo_min = (String)map.get("lo_min");
    String hi_max = (String)map.get("hi_max");
    
    if(StringUtil.isempty(infectant_id)){
    throw new Exception("infectant_id能为空");
    }
    cn = DBUtil.getConn();
    
    DBUtil.update(cn,sql,new Object[]{lo_min,hi_max,infectant_id});
    
    msg = "保存成功";
      
      
      }catch(Exception e){
      //JspUtil.go2error(request,response,e);
      //return;
      msg = "保存失败,"+e;
      }finally{DBUtil.close(cn);}
    if(msg==null){msg="";}
    msg = msg.replaceAll("java.lang.Exception:","");  
  msg = StringUtil.encodeHtml(msg);
  //out.println(msg);
  
%>


<form name=form1>
<textarea name=msg style="display:none"><%=msg%></textarea>
</form>

<script>
alert(form1.msg.value);
</script>









