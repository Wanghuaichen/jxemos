<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
       Connection cn = null;
       String sql = null;
       String stationTypeOption = null;
       String stationOption = null;
       String station_type,type_name = null;
       String station_id,infectant_id = null;
       String station_name,infectant_name = null;
       String option = null;
       String playOption = "";
       
       
       String ids = "";
       
       Map stationTypeMap,infectantMap,stationMap,typeMap,row = null;
       List list = null;
       int i,num=0;
       String v,t = null;
       
       
       
       
       
       
       try{
       
      
       cn = DBUtil.getConn();
       
       sql = "select a.station_id,b.parameter_name from t_cfg_station_info a,t_cfg_parameter b ";
      
       sql=sql+" where  a.station_type=b.parameter_value and b.parameter_type_id='monitor_type'";
      
      
       stationTypeMap = DBUtil.getMap(cn,sql);
       sql = "select infectant_id,infectant_name from t_cfg_infectant_base ";
       infectantMap = DBUtil.getMap(cn,sql);
       
       sql = "select station_id,station_desc from t_cfg_station_info ";
       stationMap = DBUtil.getMap(cn,sql);
      
       
       sql = "select station_id,infectant_id from t_play_list order by order_flag ";
       
       list = DBUtil.query(cn,sql,null);
       
       num = list.size();
       
       for(i=0;i<num;i++){
       
       row = (Map)list.get(i);
        station_id = (String)row.get("station_id");
       infectant_id = (String)row.get("infectant_id");
       if(StringUtil.isempty(station_id)){continue;}
       if(StringUtil.isempty(infectant_id)){continue;}
       
       station_name = (String)stationMap.get(station_id);
       infectant_name = (String)infectantMap.get(infectant_id);
       type_name = (String)stationTypeMap.get(station_id);
       
       
       
       
       v = station_id+","+station_name+","+type_name+","+infectant_id+","+infectant_name;
       t = station_name+"_"+infectant_name;
       
       playOption = playOption+"<option value='"+v+"'>"+t+"\n";
       
       
       
       
       }
       
       
       
       
       
    
       
       }catch(Exception e){
       //out.println(e+"");
       JspUtil.go2error(request,response,e);
       return;
       }finally{DBUtil.close(cn);}
       
       
       
          
%>
<style>
td{
vertical-align:top;
}

.ttt{
  border:0px;
  height=23px;
  font-size:20px;
  color:blue;
  font-weight:bold;
}

.ttt2{
  border:0px;
  
}

BODY {

padding-top: 0px;
 margin-top: 0px;
 margin-left: 0px;
 margin-right: 0px;
  margin-bottom: 0px;

 }


</style>
<img src="../../images/top.gif">
<form name=form1 method=post>
<table border=0 cellspacing=0>
<tr>
<td>
<select name=play_info size=36  onchange=f_v() style="width:200px">
<%=playOption%>
</select>

</td>

<td>
<div>
<img width=700px height=0>
</div>


<input type=hidden name=station_id>
<input type=hidden name=infectant_id>

站位名称
<input type=text name=station_name style="width:500px" class=ttt>
<br><br>
监测类型
<input type=text name=type_name  class=ttt>
监测因子
<input type=text name=infectant_name  class=ttt2>
   
   

<input type=checkbox name=auto_flag checked>自动切换







<br><br>
<!--2007-08-20-->
从
<input name="date1" type="text" value="2007-07-22" class=date onclick="new Calendar().show(this);">

   <select name=hour1>
                     <option value="0" selected>0</option>
<option value="1" >1</option>
<option value="2" >2</option>
<option value="3" >3</option>
<option value="4" >4</option>
<option value="5" >5</option>
<option value="6" >6</option>
<option value="7" >7</option>
<option value="8" >8</option>
<option value="9" >9</option>
<option value="10" >10</option>
<option value="11" >11</option>
<option value="12" >12</option>
<option value="13" >13</option>
<option value="14" >14</option>
<option value="15" >15</option>
<option value="16" >16</option>
<option value="17" >17</option>
<option value="18" >18</option>
<option value="19" >19</option>
<option value="20" >20</option>
<option value="21" >21</option>
<option value="22" >22</option>
<option value="23" >23</option>

</select>
   

 到

                  
<input name="date2" type="text" value="2007-08-20" class=date  onclick="new Calendar().show(this);">

<select name=hour2> 
<option value="0" >0</option>
<option value="1" >1</option>
<option value="2" >2</option>
<option value="3" >3</option>
<option value="4" >4</option>
<option value="5" >5</option>
<option value="6" >6</option>
<option value="7" >7</option>
<option value="8" >8</option>
<option value="9" >9</option>
<option value="10" >10</option>
<option value="11" >11</option>
<option value="12" >12</option>
<option value="13" >13</option>
<option value="14" >14</option>
<option value="15" >15</option>
<option value="16" >16</option>
<option value="17" >17</option>
<option value="18" >18</option>
<option value="19" >19</option>
<option value="20" >20</option>
<option value="21" >21</option>
<option value="22" >22</option>
<option value="23" selected>23</option>
              

</select>


每
              <select name="refresh_time">
                 <option>15</option>
                  <option selected>30</option>
                  <option>60</option>
                  </select>
              秒刷新
              
             <select name="date_axis_fix_flag">
           <option value="0">时间轴自动调整</option>
<option value="1">时间轴固定</option>

             </select>
             <!--
         <select name=infectant_id onchange=f_f()>
<%=option%>
</select>  
-->
   
<input type=button value=查看 onclick=f_v() class=btn>

<br><br>

<iframe name="chart"  width=100% height=96%  scrolling="auto" frameborder="0"  style="border:0px" allowtransparency="true">
</iframe>



</td>
</table>
</form>


<script>
var num = form1.play_info.options.length;


function f_v(){
 form1.target="chart";
 form1.action="../site/chart/chart.jsp";
 var obj = form1.play_info;
 var i = obj.selectedIndex;
 if(i<0){return;}
 //var t = obj.options[i].text;
 var v = obj.options[i].value;
 //station_id,station_name,type_name,infectant_id,infectant_name
 var arr=v.split(",");
 form1.station_id.value=arr[0];
 form1.station_name.value=arr[1];
 form1.type_name.value=arr[2];
 form1.infectant_id.value=arr[3];
 form1.infectant_name.value=arr[4];
 
 form1.submit();
}

function f_f(){
if(num<1){return;}
if(!form1.auto_flag.checked){return;}
var obj = form1.play_info;
  var i = obj.selectedIndex;
  if(i<0){i=-1;}
  i=i+1;
  if(i<num){}else{i=0;}
 obj.selectedIndex=i;
    f_v();
  }

f_f();
window.setInterval("f_f()", 5000); 


</script>