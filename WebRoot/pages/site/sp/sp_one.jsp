<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.hoson.*,com.hoson.util.*,java.sql.*,java.util.*,javax.servlet.http.*,com.hoson.app.*"%>

<%
      
        
             String station_id = request.getParameter("station_id");;
             String sb_id = null;
            
             Connection cn = null;
            
             Map map = null;
             String sql = null;
             String sp_ip = null;
             String url = null;
             String url_hk = "sp_hk_one_list_new.jsp";
             String url_dx = "sp_dx_one_list.jsp";
           
            // url_hk = "sp_hk_one.jsp";
            //url_dx = "sp_dx_one.jsp";
             
             try{
             
             if(f.empty(station_id)){
                throw new Exception("请选择站位");
             }
             
             //sql = "select * from t_sp_sb_station where station_id='"+station_id+"'";
            sql = "select * from t_cfg_station_info where station_id='"+station_id+"'";
            
            
             cn = DBUtil.getConn();
             map = DBUtil.queryOne(cn,sql,null);
             if(map==null){
               throw new Exception("站位不存在");
             }
            
             sp_ip = (String)map.get("station_ip");
             sb_id = (String)map.get("sb_id");
             if(StringUtil.isempty(sp_ip)&&StringUtil.isempty(sb_id)){
             throw new Exception("该站位没有视频");
             }
             
             if(!StringUtil.isempty(sp_ip)){
             url=url_hk;
             }else{
             url = url_dx;
             }
            
            
             //System.out.println(sp_ip+","+sb_id+","+url);
             
            url = url+"?station_id="+station_id;
            response.sendRedirect(url);
       
       
       
             }catch(Exception e){
             JspUtil.go2error(request,response,e);
             return;
             }finally{DBUtil.close(cn);}
             
             
             
%>