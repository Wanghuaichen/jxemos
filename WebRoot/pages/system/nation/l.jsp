<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

   Connection cn = null;
   String sql = null;
   List list = null;
   int i,num=0;
   Map m = null;
   String id,name,id2 = null;
   String s="";
   Map m2 = null;
   
   try{
   
   
   cn = DBUtil.getConn();
  sql = "select station_id,station_desc from t_cfg_station_info ";
  sql=sql+" order by station_type,area_id,station_desc";
   list = DBUtil.query(cn,sql,null);
   sql = "select station_id,station_id_nation from t_cfg_station";
   num=list.size();
    sql = "select station_id,station_id_nation from t_cfg_station";
   m2 = DBUtil.getMap(cn,sql);
   
   for(i=0;i<num;i++){
    m = (Map)list.get(i);
    id=(String)m.get("station_id");
    //id2=(String)m.get("station_id_nation");
    id2 = (String)m2.get(id);
    
    name=(String)m.get("station_desc");
    s=s+"<tr>\n";
    s=s+"<td>"+(i+1)+"</td>\n";
    s=s+"<td>"+id+"</td>\n";
    s=s+"<td>"+id2+"</td>\n";
    s=s+"<td>"+name+"</td>\n";
    s=s+"</tr>\n";
   }
   }catch(Exception e){
   JspUtil.go2error(request,response,e);
   return;
   }finally{DBUtil.close(cn);}

%>

<table>
<%=s%>
</table>




