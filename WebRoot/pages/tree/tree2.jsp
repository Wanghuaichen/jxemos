<%@ page contentType="text/html;charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="com.hoson.*"%>
<%@page import="com.hoson.util.*"%>
<%@page import="com.hoson.app.*"%>
<%
         String area_id = App.get("area_id","33");
         String areaOption = null;
         String stationTypeOption = null;
         Connection cn = null;
         String sql = null;
         String station_type = null;
       
         List list = null;
         int i,num=0;
         String s = "";
         
         Map map = null;
         String id,name = null;
         String ctl_type,trade_id,valley_id = null;

         String ctlTypeOption,tradeOption,valleyOption = null;
         
         try {
         
         station_type = request.getParameter("station_type");
         area_id = request.getParameter("area_id");
         
         ctl_type = request.getParameter("ctl_type");
         trade_id = request.getParameter("trade_id");
         valley_id = request.getParameter("valley_id");
         
         ctlTypeOption = SwjUpdate.getCtlTypeOption(ctl_type);
         tradeOption = SwjUpdate.getTradeOption(trade_id);
         valleyOption = SwjUpdate.getValleyOption(valley_id);
         
         
         
         if(StringUtil.isempty(station_type)){station_type=App.get("default_station_type","1");}
                  if(StringUtil.isempty(area_id)){area_id=App.get("area_id","33");}
                  
           cn = DBUtil.getConn();
              areaOption = JspPageUtil.getAreaOption(cn,area_id);
               stationTypeOption = JspPageUtil.getStationTypeOption(cn,station_type);
             
             
             
             
           sql = "select station_id,station_desc from t_cfg_station_info where ";
           sql=sql+" station_type='"+station_type+"' ";
           sql=sql+" and area_id like '"+area_id+"%' ";
           if(!f.empty(ctl_type)){
            sql=sql+" and ctl_type='"+ctl_type+"' ";
           }
           
           if(!f.empty(trade_id)){
            sql=sql+" and trade_id='"+trade_id+"' ";
           }
           
           if(!f.empty(valley_id)){
            sql=sql+" and valley_id like '"+valley_id+"%' ";
           }
           
           sql = sql+DataAclUtil.getStationIdInString(request,station_type,"station_id");
           sql=sql+" order by area_id,station_desc";
           
           list = DBUtil.query(cn,sql,null);
           num = list.size();
           
           for(i=0;i<num;i++){
           map=(Map)list.get(i);
           id = (String)map.get("station_id");
           name = (String)map.get("station_desc");
           //s=s+"<div><a href=../site/zw.jsp?station_id="+id+"&flag=1 target=zw_right>"+name+"</a></div>";
           //s=s+"<option value="+id+">"+name+"\n";
           s=s+"<tr><td id=td"+i+" onclick=ff('"+id+"','"+i+"')>"+name+"</td></tr>\n";
           }
             
             
         
         } catch (Exception e) {
				//out.println(e);
			JspUtil.go2error(request,response,e);
				return;
			}finally{DBUtil.close(cn);}
         
%>
<style>
body{
font-size:13px;
padding:0px;
/*border:1px solid red;*/
}
a{font-color:black;}
td{
cursor:hand;
font-size:13px;
}
 .bgclick{
 background-color:red;
 /*background-color:silver;*/
  /*font-color:white;*/
 }
 
  .bg{
 background-color: white;
 /*font-color:balck;*/
 }
 
 .sel{width:100%;}
 
 .scrolldiv {
	overflow: auto;
	height: 100%;
	width: 100%;
	scrollbar-base-color: #ecf2f9;
	scrollbar-arrow-color: #336699;
	scrollbar-track-color: #ecf2f9;
	scrollbar-3dlight-color: #ecf2f9;
	scrollbar-darkshadow-color: #ecf2f9;
	scrollbar-highlight-color: #336699;
	scrollbar-shadow-color: #336699;
}



 
 
</style>
<body style='padding:2px;margin:0px;' scroll=no>
<form name=tree_form method=post>

<table style='width:100%;height:100%' border=0>
<tr>
<td height=10px>


<select name=area_id onchange=f_submit() class='sel'>
<%=areaOption%>
</select>
<select name=station_type  onchange=f_submit()  class='sel'>
<%=stationTypeOption%>
</select>

<select name=ctl_type onchange=f_submit()  class='sel'>
<option value=''>重点源属性</option>
<%=ctlTypeOption%>
</select>


<select name=valley_id onchange=f_submit() class='sel'>
<option value=''>请选择流域</option>
<%=valleyOption%>
</select>

<select name=trade_id onchange=f_submit() class='sel' >
<option value=''>请选择行业
<%=tradeOption%>
</select>


</td>
</tr>

<tr>
<td height=100%>

<div class='scrolldiv'>
<table border=0 width=100%>
<%=s%>
</table>
</div>

</td>
</tr>
</table>

</form>

<form name=form2 action="../site/zw.jsp" target=zw_right>
<input type=hidden name=flag>
<input type=hidden name=station_id>
<input type=hidden name=selindex value="-1">
<!--
<select style="width:180px" name=station_id size=25 onchange=f_submit2() >
</select>
-->

</form>
</body>

<script>
var num=<%=num%>;
function ff(id,seq){
//alert(id);
 var i=0;
 var obj = null;
 var selindex = form2.selindex.value;
 if(selindex==seq){return;}
 /*
 for(i=0;i<num;i++){
    obj = document.getElementById("td"+i);
   obj.className="bg";
 }
 */
 if(selindex>=0){
  obj = document.getElementById("td"+selindex);
  obj.className="bg";
 }
 obj = document.getElementById("td"+seq);
 //alert(obj);
    obj.className="bgclick";
    form2.selindex.value=seq;
    form2.station_id.value=id;
    form2.submit();
    
    
}

function f_submit(){
tree_form.target="";
tree_form.action="tree2.jsp";
tree_form.submit();
}


function f_submit2(){
form2.target="zw_right";
form2.action="../site/zw.jsp";
form2.submit();
}

</script>


