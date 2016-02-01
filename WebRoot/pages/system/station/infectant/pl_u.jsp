<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
  Map map = JspUtil.getRequestModel(request);
  
  Connection cn = null;
  
  String sql = "update T_CFG_MONITOR_PARAM set ";
  String msg = "";
  String standard_value = (String)map.get("standard_value");
    String lo = (String)map.get("lo");
    String hi = (String)map.get("hi");
    String lolo = (String)map.get("lolo");
    String hihi = (String)map.get("hihi");
    String lolololo = (String)map.get("lolololo");
    String hihihihi = (String)map.get("hihihihi");
  if(standard_value.equals("")&&lo.equals("")&&hi.equals("")&&lolo.equals("")&&hihi.equals("")&&lolololo.equals("")&&hihihihi.equals("")){
  	msg = "所有值都为空，没有要修改的数据！";
  }else{
  
   try{
      
    String infectant_id = (String)map.get("infectant_id");
    
    if(!standard_value.equals("")){
    	sql = sql +"standard_value="+standard_value+",";
    }
    if(!lo.equals("")){
    	sql = sql +"lo="+lo+",";
    }
    if(!hi.equals("")){
    	sql = sql +"hi="+hi+",";
    }
    if(!lolo.equals("")){
    	sql = sql +"lolo="+lolo+",";
    }
    if(!hihi.equals("")){
    	sql = sql +"hihi="+hihi+",";
    }
    if(!lolololo.equals("")){
    	sql = sql +"lolololo="+lolololo+",";
    }
    if(!hihihihi.equals("")){
    	sql = sql +"hihihihi="+hihihihi+",";
    }
    sql = sql.substring(0,sql.length()-1);
    sql = sql +" where infectant_id=?";
    if(StringUtil.isempty(infectant_id)){
    throw new Exception("infectant_id能为空");
    }
    cn = DBUtil.getConn();
    
    DBUtil.update(cn,sql,new Object[]{infectant_id});
    
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
  }
%>


<form name=form1>
<textarea name=msg style="display:none"><%=msg%></textarea>
</form>

<script>
alert(form1.msg.value);
</script>









