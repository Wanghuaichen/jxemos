<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/pages/commons/inc_empty.jsp"%>
<%
        String station_name= null;
        String sql = null;
        List list = null;
        RowSet rs = null;
        int i,num=0;
 
        
        try{
     
        //station_name = request.getParameter("station_name");
        station_name=w.p("station_name");
        if(station_name==null){station_name="";}
        //station_name = Util.iso2gbk(station_name);
        sql = "select station_id,station_desc from t_cfg_station_info where station_desc like '%"+station_name+"%'";
        
        //System.out.println(sql);
        list = f.query(sql,null);
        num = list.size();
        if(num<1){throw new Exception("没有匹配的数据");}
        rs = new RowSet(list);
        
        }catch(Exception e){
          w.error(e);
          return;
        }
   
        
%>
<form name=form1 method=post target=q action='../gis/data/index.jsp'>
<table border=0 width=100% height=100%>
<tr>
<td width=200px valign=top>
   <select name=station_id size=30 onchange=form1.submit() style="width:200px;border:solid 0px white">
   <%while(rs.next()){%>
   <option value='<%=rs.get("station_id")%>'><%=rs.get("station_desc")%>
   <%}%>
   </select>
</td>
<td>
<iframe frameborder=0 name=q width=100% height=100%>

</iframe>

</td>
</tr>
</table>
</form>