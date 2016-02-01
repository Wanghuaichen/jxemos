<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%!
    public static String getOption(Connection cn,String sql,String s)
    throws Exception{
    
    if(s==null){s="";}
    List list = null;
    int i,num=0;
    Map map = null;
    String v,t = null;
    String ss = "";
    String flag=null;
    
    list = DBUtil.query(cn,sql,null);
    
    num = list.size();
    
    for(i=0;i<num;i++){
    map=(Map)list.get(i);
    v = (String)map.get("v");
    t = (String)map.get("t");
    if(StringUtil.isempty(v)){continue;}
    
    if(s.indexOf(","+v+",")>=0){flag=" selected";}else{flag="";}
    
    ss=ss+"<option value='"+v+"' "+flag+">"+t+"\n";
    
    
    
    
    
    
    }
    
    
    
    
    
    return ss;
    
    }
%>
<%
       Connection cn = null;
       String sql = null;
       String stationTypeOption = null;
       String stationOption = null;
       String station_type = null;
       String station_id = null;
       String station_name = null;
       String option = null;
       
       String ids = "";
       
       try{
       
       station_type = request.getParameter("station_type");
       if(StringUtil.isempty(station_type)){
       station_type="1";
       }
       
       
       cn = DBUtil.getConn();
       
       
       //stationTypeOption = JspPageUtil.getStationTypeOption(cn,station_type);
       
       sql = "select parameter_value,parameter_name from t_cfg_parameter where ";
       sql=sql+" parameter_type_id='monitor_type' ";
       sql=sql+" and parameter_value in('1','2','5','6') ";
       sql=sql+" order by parameter_value";
       
       stationTypeOption = JspUtil.getOption(cn,sql,station_type);
       
       sql = "select station_id,station_desc from t_cfg_station_info where station_type='"+station_type+"' ";
       sql=sql+DataAclUtil.getStationIdInString(request,station_type,"station_id");
       
       sql=sql+" order by area_id,station_desc ";
       
       
       
       stationOption = JspUtil.getOption(cn,sql,null);
       
       //option = JspPageUtil.getInfectantOption(cn,station_type);
       sql = "select infectant_id,infectant_name from t_cfg_infectant_base where ";
       sql=sql+" station_type='"+station_type+"'";
       sql=sql+" and (infectant_type='1' or infectant_type='2')";
       sql=sql+" order by infectant_order";
       
       option = JspUtil.getOption(cn,sql,null);
       
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
</style>
<img src="../../images/top.gif">
<form name=form1 method=post>
<table border=0 cellspacing=0>
<tr>
<td>
<select name=station_type onchange=r()>
<%=stationTypeOption%>
</select>
<br>
<select name=station_id size=36  onchange=f_v() style="width:200px">
<%=stationOption%>
</select>

</td>

<td>
<div>
<img width=700px height=0>
</div>

<input type=text name=tt style="width:500px" class=ttt>


<!--
<b><div id='tt'></div></b>
-->


<br><br>
<input type="radio" name="chart_type" value="minute" onclick=f_v()>分均值   
<input type="radio" name="chart_type" value="hour"  onclick=f_v()>时均值
<input type="radio" name="chart_type" value="day" checked  onclick=f_v()>日均值   
<input type="radio" name="chart_type" value="week"  onclick=f_v()>周均值 
<input type="radio" name="chart_type" value="month"  onclick=f_v()>月均值  
<!--
<input type="radio" name="chart_type" value="real" onclick="f_submit('real')"  checked >实时数据 
-->
   
   

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
         <select name=infectant_id onchange=f_f()>
<%=option%>
</select>     
<input type=button value=查看 onclick=f_v()class=btn>

<br><br>

<iframe name="chart"  width=100% height=96%  scrolling="auto" frameborder="0"  style="border:0px" allowtransparency="true">
</iframe>



</td>
</table>
</form>


<script>
var num = form1.station_id.options.length;
var type_num = form1.station_type.options.length;

function r(){
 form1.target="";
 form1.action="index.jsp";
 form1.submit();
}
function f_v(){
 form1.target="chart";
 form1.action="../site/chart/chart.jsp";
var i = form1.station_id.selectedIndex;
  form1.tt.value = form1.station_id.options[i].text;
 //document.getElementById('id').innerText = form1.station_id.options[i].text;

 form1.submit();
}

function f_f(){
if(num<1){
//return;
f_type();
return;
}
if(!form1.auto_flag.checked){return;}
var obj = form1.station_id;
  var i = form1.station_id.selectedIndex;
  if(i<0){i=-1;}
  i=i+1;
  if(i<num){
  
  form1.station_id.selectedIndex=i;
    f_v();
  
  }else{
   
   f_type();
     
  }
 
  
}

function f_type(){
    var i = form1.station_type.selectedIndex;
  if(i<0){i=-1;}
  i=i+1;
  if(i<type_num){
  
  }else{
  i=0;
  }
  form1.station_type.selectedIndex=i;
    r();
  
  
}
f_f();
window.setInterval("f_f()", 5000); 


</script>