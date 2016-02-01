<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%!
       public static void i(Connection cn,String user_id,String station_id)
       throws Exception{
       
       if(StringUtil.isempty(user_id)){return;}
        if(StringUtil.isempty(station_id)){return;}
        String sql = "insert into t_sys_user_station(user_id,station_id) values(?,?)";
        Object[]p=new Object[]{user_id,station_id};
     
        DBUtil.update(cn,sql,p);
      
       }   
       
       public static void del(Connection cn,String user_id,String station_id)
       throws Exception{
       if(StringUtil.isempty(user_id)){return;}
        if(StringUtil.isempty(station_id)){return;}
        String sql = "delete from t_sys_user_station where user_id=? and station_id=?";
        Object[]p=new Object[]{user_id,station_id};
     
        DBUtil.update(cn,sql,p);
     
       }
       
       
       public static void save(Connection cn,String user_id,String ids,String[]station_ids)
       throws Exception{
       int i,num=0;
       String[]arr=null;
       
       if(!StringUtil.isempty(ids)){
       
       arr=ids.split(",");
       num=arr.length;
       for(i=0;i<num;i++){
       del(cn,user_id,arr[i]);
       }
       
       }
       
       if(station_ids==null){return;}
       num=station_ids.length;
       for(i=0;i<num;i++){
       i(cn,user_id,station_ids[i]);
       }
       
       
       
       }
       
%>
<%
  
  
  Connection cn = null;
  String user_id = request.getParameter("user_id");
  String id = null;
  String ids = request.getParameter("ids");
  String[]station_ids = request.getParameterValues("station_id");
  String sql = null;
  Map map = null;
  String[]arr=null;
  int i,num=0;
    String msg = null;
    
    
  
  
  
  
  try{
  //out.println(JspUtil.getRequestModel(request));
  //out.println(user_id+"/"+ids);
  cn = DBUtil.getConn();
  save(cn,user_id,ids,station_ids);
 msg = "保存成功";
  
  }catch(Exception e){
  
  //JspUtil.go2error(request,response,e);
 //return;
  msg = "保存失败\n"+e.getMessage();
           
          
  
  }finally{
  DBUtil.close(cn);
  }
  
    msg = StringUtil.encodeHtml(msg);
     
%>
<body onLoad="alert(msg.value)">
<input type=hidden name="msg" value="<%=msg%>">
</body>
