<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.hoson.biz.*"%>
<%@ page import="com.hoson.*,com.hoson.util.*,java.sql.*,java.util.*,javax.servlet.http.*,com.hoson.app.*"%>
<%!

	  public static String list(Connection cn,String station_type,String area_id)throws Exception{
	        
	       String sql = null;
	           String sb_id = null;
	             String[]arr=null;
	             Map map = null;
	    
	             String sp_s = "";
	             int i,num=0;
	             int j,sb_num=0;
	              List stationList = null;
	             Map sbMap = null;
	             String station_id,station_name = null;
	             Map row = null;
	            String sss = "";
	             
	         

	               
	      sql = "select station_id,station_desc,sb_id from t_cfg_station_info where station_type='"+station_type+"' and area_id like '"+area_id+"%' ";
	             
	      
	     // sql=sql+ DataAclUtil.getStationIdInString(request,station_type,"station_id");
	      
	      sql=sql+" order by area_id,station_desc";
	             stationList = DBUtil.query(cn,sql,null);
	            
	            
	            
	             
	             //out.println(sbMap);
	             num = stationList.size();
	             for(i=0;i<num;i++){
	             row = (Map)stationList.get(i);
	             station_id = (String)row.get("station_id");             
	             station_name = (String)row.get("station_desc");
	             sb_id = (String)row.get("sb_id");
	           
	             if(f.empty(sb_id)){continue;}
	             arr=sb_id.split(",");
	             sb_num=arr.length;
	             
	             
	             for(j=0;j<sb_num;j++){
	             sb_id = arr[j];
	             if(f.empty(sb_id)){continue;}
	             //spOption =spOption+"<option value='"+sb_id+facode+"'>"+station_name+"_通道"+(j+1)+"</option>\n";
	             
	             sss=sss+station_name+"_通道"+(j+1)+"<br>";
	             }
	             
	             }
	             return sss;
	             }
	             
	
%>

<%
   			
             
         
      String area_id =null;
     String station_type=null;
     Connection cn = null;
     
      
           String sss="";  
             List list = null;
             int i,num = 0;
             String sql = null;
             Map m = null;
             String area_name = null;
             String s = null;
             
             try{
             
             
             sql = "select * from t_cfg_area where area_pid='33'";
              cn = DBUtil.getConn();
             list = DBUtil.query(cn,sql,null);
             
             num = list.size();
             
             
             
             
            station_type = f.p(request,"station_type",App.get("default_station_type","1"));
    
        area_id =     f.p(request,"area_id","33");
      station_type="1";
         
             for(i=0;i<num;i++){
             
               m = (Map)list.get(i);
               area_id = (String)m.get("area_id");
               area_name = (String)m.get("area_name");
               
               s = list(cn,station_type,area_id);
               
               sss = sss +area_name+"<br><br>"+s+"<br><br><br>";
             
             }
             
            
             
             sss=sss+list(cn,station_type,area_id);
             
         
             }catch(Exception e){
             JspUtil.go2error(request,response,e);
             
             return;
             }finally{DBUtil.close(cn);}
             
             
             
%>


								<form name="form3" action=dx_sp_list.jsp>
									
									
									
									
									
									
									
								</form>
							
							
							<%=sss%>
							
							
				<script>
				function r(){
				form3.submit();
				}
				</script>			
						
