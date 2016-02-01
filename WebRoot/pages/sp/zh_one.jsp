<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="sp_inc.jsp" %>
<%
        String ip_center,ip,port,user,pwd,td;
        
        try{
                TianJin.one(request);
                ip_center = f.cfg("sp_ip_hk","");
                if(f.empty(ip_center)){ErrorMsg.sp_ip_center();}
        }catch(Exception e){
          w.error(e);
          return;
        }
        RowSet rs = null;
        rs = w.rs("list");
        String s = null;
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title></title>
</head>

<body onunload=f_stopall() scroll=no>



<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="12" height="31"><img src="images/sp_l_03.gif" width="12" height="31" alt="" /></td>
        <td height="31" align="left" background="images/sp_l_05.gif"><table width="100%" height="31" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="130" align="left"><img src="images/sp_l_04.gif" width="130" height="31" alt="" /></td>
            <td width="515">&nbsp;</td>
            <td width="207" valign="bottom">
          
             
               
</td>
          </tr>
        </table></td>
        <td width="7" height="31"><img src="images/sp_m_01.gif" width="14" height="31" alt="" /></td>
      </tr>
      <tr>
        <td background="images/sp_l_13.gif"></td>
        <td height="100%"> 
        <!--sp control-->
      <!--<div style="width:100%;height:300"></div>	-->
      <table width=100% height=100%>
      <tr>
      <td width=80%>
      <object id='hspobj' classid="clsid:882D37B0-3D9A-48F7-A5F3-D58FE081A90F" width=100% height=100></object>								
      </td>
      
      <td>
           <select size=8 id='sp_sb' onclick='f_play()' style='width:100%;height:100%'>
               <%while(rs.next()){
               ip = rs.get("ip");
               port = rs.get("port");
               user = rs.get("user");
               pwd = rs.get("pwd");
               td = rs.get("td");
               s = ip+","+user+","+pwd+","+port+","+td+","+ip_center;
               %>
                <option value='<%=s%>'>通道<%=td%>
                <%}%>
               </select>
      </td>
      </table>
        </td>
        <td width="7" background="images/sp_m_02.gif"></td>
      </tr>
      <tr>
        <td height="3"><img src="images/sp_l_27.gif" width="12" height="3" /></td>
        <td height="3" background="images/sp_l_29.gif"><img src="images/sp_l_28.gif" width="8" height="3" /></td>
        <td height="3"><img src="images/sp_m_04.gif" /></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="0" background="images/sp_l_3401.jpg">
      <tr>
            <td width="178" height="68"><img src="images/sp_l_32.gif" alt="" width="178" height="68" border="0" usemap="#Map" /></td>
            <td width="132"><img src="images/sp_l_33.gif" alt="" width="132" height="68" border="0" usemap="#Map3" /></td>
            <td width="221"><img src="images/sp_l_34.gif" alt="" width="221" height="68" border="0" usemap="#Map2" /></td>
            
        <td width="7"><img src="images/sp_m_03.gif" width="36" height="68" alt="" /></td>
      </tr>
    </table></td>
  </tr>
</table>


<map name="Map" id="Map"> 


 <area shape="circle" coords="35,23,13" onmousedown='f_up()' onmouseup='f_up_stop()' />
  <area shape="circle" coords="162,20,13" onmousedown='f_right()' onmouseup='f_right_stop()' />
  <area shape="circle" coords="133,21,13" onmousedown='f_left()' onmouseup='f_left_stop()'/>
  <area shape="circle" coords="64,22,13" onmousedown='f_down()' onmouseup='f_down_stop()' />
<area shape="circle" coords="98,35,16" onclick="javascript:f_stop()" />
</map>
<map name="Map2" id="Map2"> 
  <area shape="circle" coords="139,29,12" href="javascript:ChangeWindow(6)" alt="p6" title="p6" />
  <area shape="circle" coords="112,29,12" href="javascript:ChangeWindow(4)" alt="p4" title="p4" />
  <area shape="circle" coords="170,30,12" href="javascript:ChangeWindow(9)" alt="p9" title="p9" />
  <area shape="circle" coords="197,30,12" href="javascript:ChangeWindow(16)" alt="p16" title="p16" />
  <area shape="circle" coords="84,30,12" href="javascript:ChangeWindow(1)" alt="p1" title="p1" />

</map>
<map name="Map3" id="Map3"> 

  <area shape="circle" coords="112,31,13" onclick='javascript:f_lj()' alt="near" title="near" />
  <area shape="circle" coords="82,30,13"  onclick='javascript:f_ly()'  alt="far" title="far" />
</map></body>
</html>

<script>
//var ip_center ='<%=ip_center%>';
  function sp_obj(){
     return document.getElementById("hspobj");
  }
    function f_stop(){
      sp_obj().Stop();
    }
    
     function f_stopall(){
      sp_obj().StopAll();
    }
    
    function f_up(){
    //alert('up');
    }
    function f_down(){}
    
    function f_up_stop(){
    //alert('up stop');
    }
    function f_down_stop(){}
    
    function f_left(){
      sp_obj().Left();
    }
    function f_right(){
      sp_obj().Right();
    }
    
    function f_left_top(){
     sp_obj().LeftStop();
    }
    function f_right_stop(){
     sp_obj().RightStop();
    }
    
    function f_lj(){}
    function f_ly(){}
    
    function ChangeWindow(num){
      sp_obj().WindowNum(num);
    }
    
    function f_play(){
      var obj = document.getElementById('sp_sb');
      //alert(obj);
      var index = obj.selectedIndex;
      //alert(index);
      if(index<0){return;}
      var s = obj.options[index].value;
      //alert(s);
      var ip,port,user,pwd,td;
      var arr=s.split(",");
      ip=arr[0];
      user=arr[1];
      pwd=arr[2];
      port=arr[3];
      td=arr[4];
      ip_center = arr[5];
      
      sp_obj().AddActive(ip,user,pwd,port,td,ip_center);
      
      
      
    }
    sp_obj().WindowNum(1);
</script>


