<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
  Map map = JspUtil.getRequestModel(request);
  
  //out.println(map);
  
  String table,cols=null;
  Connection cn = null;
  String station_id,infectant_id,infectant_column = null;
  int i,num=0;
  String flag = null;
  String msg = null;
  String sql = "delete from t_cfg_monitor_param where station_id=? and infectant_id=?";
  
  
  table="t_cfg_monitor_param";
  cols="station_id,infectant_id,infectant_column,standard_value,lolo,lo,hi,hihi,lolololo,hihihihi,report_flag,show_order,group_id";
  
  
  
  
   try{
      
    flag = (String)map.get("flag");
    station_id=(String)map.get("station_id");
    infectant_id = (String)map.get("infectant_id");
    infectant_column = (String)map.get("infectant_column");
    
    if(StringUtil.isempty(station_id)){
    throw new Exception("station_id能为空");
    }
    if(StringUtil.isempty(infectant_id)){
    throw new Exception("infectant_id能为空");
    }
    
    if(StringUtil.isempty(infectant_column)){
    throw new Exception("infectant_column能为空");
    }
    
    
    cn = DBUtil.getConn();
    
    
    if(flag==null){
    
    DBUtil.update(cn,sql,new Object[]{station_id,infectant_id});
    }else{
    
    num = PBean.save(cn,table,cols,2,map);
    if(num<1){
    PBean.insert(cn,table,cols,0,map);
    }
    
    
    
    }
    
    
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


<form name="form1" method="post" action="../station_info.jsp">
<textarea name=msg style="display:none"><%=msg%></textarea>
</form>

<script>
alert(form1.msg.value);
	form1.submit();
</script>









