<%@ page contentType="text/html;charset=GBK" %>
<%@page import="java.sql.*,com.hoson.*,com.hoson.app.*,com.hoson.action.*,com.hoson.mvc.*,com.hoson.util.*,java.util.*"%>
<%!

       public static Map getData(Connection cn,String station_type
       ,Map dataMap)throws Exception{
       
       List list,dataList,titleList,idList = null;
       Map map = new HashMap();
       Map row,m = null;
       int i,num=0;
       String sql = null;
       String station_id = null;
       dataList = new ArrayList();
       
       
       sql = "select station_id,station_desc from t_cfg_station_info where station_type='"+station_type+"'";
       sql=sql+" order by area_id,station_desc";
       
       list = DBUtil.query(cn,sql,null);
       num = list.size();
       
       for(i=0;i<num;i++){
       row = (Map)list.get(i);
       station_id=(String)row.get("station_id");
       
       m = (Map)dataMap.get(station_id);
       if(m==null){continue;}
       
       m.put("station_name",row.get("station_desc"));
       
       dataList.add(m);
       
       }
       m = AppPage.getInfectantIdAndTitle(cn,station_type);
       
       m.put("data",dataList);
       
       return m;
       
       
       
       }
       
       
       
 public static String sub(String s,int start,int len){
        
        if(s==null){return "";}
        if(len<1){return "";}
        int max_index = s.length()-1;
        if(start>max_index){return "";}
        int end = start+len;
        if(end>max_index){return s.substring(start);}
        
        return s.substring(start,end);
        
        
        
        }
    
  
%>
<%
   Map dataMap = null;
   Map map = null;
   Connection cn = null;
   String sql = null;
   String[]types=new String[]{"1","2","5","6"};
   String[]names=new String[]{"污染源污水","污染源烟气","环境质量地表水","环境质量大气"};
   Map stationTypeDataMap = new HashMap();
   String station_type = null;
   List list,dataList,titleList,idList = null;
   String ids[] = null;
   RowSet rs = null;
   String s = null;
   
   
   
   
   int i,j,k,num,typeNum,idNum=0;

   
   
   try{
   dataMap = RealDataUtil.getRealDataListMap();
   typeNum = types.length;
   cn = DBUtil.getConn();
   for(i=0;i<typeNum;i++){
   station_type = types[i];
   map = getData(cn,station_type,dataMap);
    stationTypeDataMap.put(station_type,map); 
   }
   
   
   
   
   
   }catch(Exception e){
   JspUtil.go2error(request,response,e);
   return;
   }finally{DBUtil.close(cn);}
   
%>





<%
	for(i=0;i<typeNum;i++){
	 station_type = types[i];
	 map = (Map)stationTypeDataMap.get(station_type);
	 dataList = (List)map.get("data");
	 titleList = (List)map.get("title");
	 idList = (List)map.get("id");
	 idNum = idList.size();
	 ids = new String[idNum];
	 for(j=0;j<idNum;j++){
	 ids[j]=(String)idList.get(j);
	 }
	 
	 
	 rs = new RowSet(dataList);
	 
	
	%>


<style>
  
  BODY {
FONT-SIZE: 9pt;
padding-top: 0px;
 margin-top: 0px;
 margin-left: 0px;
 margin-right: 0px;
 text-align=center ;

 }
 table{
/*width:100%;*/

background-color:#999B98;
word-break:break-all;
word-wrap: break-word;
}

td{
FONT-SIZE: 9pt;
padding-left:5px;
height:20px;
text-align:left;
word-break:break-all;
}
tr{
background-color:#F7F7F7;
}  

    .title{
background-color:#CFDBF1;
font-weight:bold;
/*cursor:hand;*/

}          
           
 .center{text-align:center}
</style>

    <table border=0 cellspacing=0>
    <tr class=title>
    <td width=50px class=center>序号</td>
    <td width=120px class=center>站位名称</td>
    <td width=100px class=center>监测时间</td>
    
    <%for(j=0;j<idNum;j++){%>
    <td  width=120px  class=center><%=titleList.get(j)%></td>
    <%}%>
    
    </tr>
    </table>
    
    <MARQUEE DIRECTION=up HEIGHT=120 WIDTH=100%
ONMOUSEOUT=this.scrollDelay=5
ONMOUSEOVER=this.scrollDelay=600
SCROLLAMOUNT=1 SCROLLDELAY=5 > 
    
    <table border=0 cellspacing=1>
    
    <%while(rs.next()){%>
    
    <tr>
    <td width=50px><%=rs.getIndex()+1%></td>
    <td  width=120px><%=rs.get("station_name")%></td>
    <td  width=100px><%=sub(rs.get("m_time"),11,8)%></td>

    <%for(j=0;j<idNum;j++){
    s =rs.get(ids[j]);
    s=StringUtil.format(s,"#.######"); 
    %> 
    <td  width=120px><%=s%></td>
    <%}%>
    
    
    
    </tr>
    
    
    
    <%}%>
    
    </table>
    </MARQUEE> 



<%
	}//end for i typeNum
%>


<form name=form1 method=post action=r.jsp>

</form>

<script>
window.setInterval("form1.submit()", 300000); 
</script>





