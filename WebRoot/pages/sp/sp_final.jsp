<%@ page language="java" contentType="text/html; charset=GBK"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title></title>
</head>

<body onunload=f_stopall()>
<form name=Form1>

<INPUT id=tbxInitValue type=hidden name=tbxInitValue>
<INPUT id=tbxWinNumber type=hidden name=tbxWinNumber>
<!--
guid username playserver playport ptzserver ptzport
-->
<INPUT type=hidden name=guid value=''>
<INPUT type=hidden name=playserver value=''>
<INPUT type=hidden name=playport value=''>
<INPUT type=hidden name=ptzserver value=''>
<INPUT type=hidden name=ptzport value=''>
<INPUT type=hidden name=username value=''>

<INPUT type=hidden name=sp_pwd value=''>


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
        
        
      <table width=100% height=100%>
      <tr>
      <td width=80%>
      <!--sp control-->
      <div style="width:100%;height:300"></div>	
      </td>
      
      <td>
        <select size=8 style='width:100%;height:100%'></select>
      </td>
      </tr>
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
            <td><a href='setup/js.exe'>控件下载</a></td>
        <td width="7"><img src="images/sp_m_03.gif" width="36" height="68" alt="" /></td>
      </tr>
    </table></td>
  </tr>
</table>
</form>

<map name="Map" id="Map"> 


 <area shape="circle" coords="35,23,13" onclick="javascript:f_up()" />
  <area shape="circle" coords="162,20,13" onclick="javascript:f_right()" />
  <area shape="circle" coords="133,21,13" onclick="javascript:f_left()" />
  <area shape="circle" coords="64,22,13" onclick="javascript:f_down()" />
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
