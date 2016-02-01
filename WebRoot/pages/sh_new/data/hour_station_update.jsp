<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.search.*" %>
<%!
       WarnAction action = new WarnAction();
       
       public static void update(Connection cn,String station_id,String m_time,String v_desc,String flag ,HttpServletRequest request,List infectant)
       throws Exception{
       
       String user_name = (String)request.getSession().getAttribute("user_name");
       
       if(StringUtil.isempty(station_id)){return;}
       if(StringUtil.isempty(m_time)){return;}
        Object[]p = null;
        String sql = "";
        if(flag.equals("6")){
        	   sql = "update T_MONITOR_REAL_HOUR_V set v_flag=?,v_desc=?,operator=? where station_id=? and m_time=?";
               p=new Object[]{flag,v_desc,user_name,station_id,m_time};
        }else{
               sql = "update T_MONITOR_REAL_HOUR_V set v_flag=?,v_desc=?,operator=? where station_id=? and m_time=?";
               p=new Object[]{flag,v_desc,user_name,station_id,m_time};
        }
        
     
        DBUtil.update(cn,sql,p);
        
        try{
	      WarnAction action = new WarnAction();
	      action.js(station_id,m_time,m_time,infectant);
		}catch(Exception e){
		   e.printStackTrace();
		}
        String wx = "无效";
        if(flag.equals("6")){
        	wx = "有效";
        }
      Log.insertLog("编号为："+station_id+"的站位，"+m_time+"时间的数据被设置为"+wx+"。无效原因为："+v_desc, request);
      
       }   
       
       
       
       public static void save(Connection cn,String station_id,String[] m_times,String v_desc,String flag,HttpServletRequest request,List infectant)
       throws Exception{
       int i,num=0;
       String[]arr=null;
       
       
       if(m_times==null){return;}
       num=m_times.length;
       for(i=0;i<num;i++){
          update(cn,station_id,m_times[i],v_desc,flag,request,infectant);
       }
       
       
       
       }
       
%>
<%
  
  
  Connection cn = null;
  //String user_id = request.getParameter("user_id");
  String id = null;
  String station_id = request.getParameter("station_id");
  String check = request.getParameter("check");
  String no_check = request.getParameter("no_check");
  String v_desc = java.net.URLDecoder.decode(request.getParameter("v_desc"),"UTF-8");
  //System.out.println(v_desc);
  String[] check_times = check.split(",");
  String[] no_check_times = no_check.split(",");
  String sql = null;
  Map map = null;
  String[]arr=null;
  int i,num=0;
  String msg = null;
  
  String station_type = request.getParameter("station_type");
  sql = "select * from t_cfg_infectant_base where station_type='"+station_type+"' and (infectant_type='1' or infectant_type='2')";
  List infectant = f.query(sql,null);
    
 try{
 
 
	  cn = DBUtil.getConn();
	  save(cn,station_id,check_times,v_desc,"5",request,infectant);
	  save(cn,station_id,no_check_times,v_desc,"6",request,infectant);
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
<body onLoad="msg()">
<input type=hidden name="msg" id="msg" value="<%=msg%>">
</body>
<script>
function msg(){
	alert(document.getElementById("msg").value);
	//self.parent.location.href = self.parent.location.href; 
	window.close();
}
</script>