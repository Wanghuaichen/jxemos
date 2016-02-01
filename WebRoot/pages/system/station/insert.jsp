<%@ page contentType="text/html;charset=GBK" %>
<%@page import="java.util.*"%>
<%@page import="java.util.regex.*"%>
<%@page import="com.hoson.*"%>
<%@page import="com.hoson.app.*"%>


<%!
    public boolean checkStationId(String id){
    boolean b = false;
    String p = "[0-9]{1,14}";
    b = Pattern.matches(p,id);
    if(!b){
    return false;
    }
    if(id==null){return false;}
    id=id.replaceAll("-","");
    if(id.length()>15){return false;}
    //System.out.println(id.length());
    //System.out.println(id.length()>15);
    //long iid = StringUtil.getLong(id,-1);
   
    //if(iid<0){return false;} 
    //System.out.println(iid);   
    return true;
    }
    
%>


<%

	Properties prop = null;
	String station_id = null;
	String station_desc = null;
	String station_type = null;
	String show_flag = null;
	
	String t = "t_cfg_station_info";
	String cols = "station_id,station_desc,station_type,trade_id,area_id,show_flag";
	String msg = null;
	String sql = null;
	Map map = null;
	

	try{
    prop = JspUtil.getReqProp(request);
    station_id = prop.getProperty("station_id");
    station_desc = prop.getProperty("station_desc");
    station_type = prop.getProperty("station_type");
   
    
    if(StringUtil.isempty(station_id)){
    msg = "编号不能为空";
    JspUtil.go2error(request,response,msg);
    return;
    }
    
      if(!checkStationId(station_id)){
        msg = "编号只能为数字且不能超过14个字符";
    JspUtil.go2error(request,response,msg);
    return;
    }
    
    
    if(StringUtil.isempty(station_desc)){
    msg = "名称不能为空";
    JspUtil.go2error(request,response,msg);
    return;
    }
   
    station_desc=station_desc.replaceAll("'","");
    station_desc=station_desc.replaceAll("\"","");
     station_desc=station_desc.replaceAll("\\\\","");
    prop.setProperty("station_desc",station_desc);
    if(StringUtil.isempty(station_type)){
    msg = "监测类别不能为空";
    JspUtil.go2error(request,response,msg);
    return;
    }
    
    
    sql= "select station_id from t_cfg_station_info where station_id=? ";
   
    map = DBUtil.queryOne(sql,new Object[]{station_id},request);
    if(map!=null){
    JspUtil.go2error(request,response,"指定的编号已经存在");
    return;
    }
    
    
    sql= "select station_id from t_cfg_station_info where station_desc=? ";
    
    map = DBUtil.queryOne(sql,new Object[]{station_desc},request);
    if(map!=null){
    JspUtil.go2error(request,response,"指定的名称已经存在");
    return;
    }
    
    
    DBUtil.insert(t,cols,0,prop,request);
    
    
    
    }catch(Exception e){
    //out.println(e);
    JspUtil.go2error(request,response,e);
    return;
    }
    
    

%>

<script>
window.location.href="q.jsp";
</script>

