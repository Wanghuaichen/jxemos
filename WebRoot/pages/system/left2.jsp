 <%@ page contentType="text/html;charset=GBK" %>
<%@page import="java.sql.*"%>
<%@page import="com.hoson.*"%> 
<%@page import="com.hoson.app.*"%> 
<%
	String ctx = JspUtil.getCtx(request);
	
%>
  
  <link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css">

<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}

A {
	COLOR: black; TEXT-DECORATION: none
}

-->



</style>
<body bgcolor="DFEBF9" onload="f_swap_img(0)">


  <table width="190" border="0" cellpadding="0">
  
          <tr>
            <td id="img0" height="40" background="/<%=ctx%>/images/qy_button_bg.gif"><table width="130" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td width="47"><div align="center"><img src="/<%=ctx%>/images/ico1.gif"></div></td>
                <td width="83">
                <a href="./tab_dept/tab_dept_query.jsp" target="system_right" onclick="f_swap_img(0)">
                部门管理
                </a>
                
                </td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td id="img1" height="40" background="/<%=ctx%>/images/qy_button_bg.gif"><table width="130" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td width="47"><div align="center"><img src="/<%=ctx%>/images/ico2.gif"></div></td>
                <td width="83">
                <a href="./area/area_query.jsp" target="system_right" onclick="f_swap_img(1)">
               地区管理
                </a>
                </td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td  id="img2" height="40" background="/<%=ctx%>/images/qy_button_bg.gif"><table width="130" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td width="47"><div align="center"><img src="/<%=ctx%>/images/ico3.gif"></div></td>
                <td width="83">
                <a onclick="f_swap_img(2)" href="./user/user_query.jsp" target="system_right" >
                用户管理
                
                </td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td  id="img3" height="40" background="/<%=ctx%>/images/qy_button_bg.gif"><table width="130" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td width="47"><div align="center"><img src="/<%=ctx%>/images/ico4.gif"></div></td>
                <td width="83">
                <a onclick="f_swap_img(3)" href="./valley/valley_query.jsp" target="system_right">
              流域管理
                </a>
                </td>
              </tr>
            </table></td>
          </tr>
          
          
          <tr>
            <td  id="img4" height="40" background="/<%=ctx%>/images/qy_button_bg.gif"><table width="130" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td width="47"><div align="center"><img src="/<%=ctx%>/images/ico5.gif"></div></td>
                <td width="83">
                <a onclick="f_swap_img(4)" href="./param/param_query.jsp" target="system_right" >
                系统参数
                </a>
                </td>
              </tr>                                       
            </table></td>
          </tr>
          
          
          <tr>
            <td  id="img5" height="40" background="/<%=ctx%>/images/qy_button_bg.gif"><table width="130" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td width="47"><div align="center"><img src="/<%=ctx%>/images/ico6.gif"></div></td>
                <td width="83">
                <a onclick="f_swap_img(5)" href="./t_cfg_station_info/t_cfg_station_info_query.jsp" target="system_right" >
                站位管理
                </a>
                </td>
              </tr>                                       
            </table></td>
          </tr>
          
          
          
          
          <tr>
            <td  id="img6" height="40" background="/<%=ctx%>/images/qy_button_bg.gif"><table width="130" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td width="47"><div align="center"><img src="/<%=ctx%>/images/ico7.gif"></div></td>
                <td width="83">
                <a onclick="f_swap_img(6)" href="./trade/trade_query.jsp" target="system_right" >
                行业管理
                </a>
                </td>
              </tr>                                       
            </table></td>
          </tr>
          
          
        </table>
        
        
        
        
        </body>
        
        <script>
        
        //---------------
        
        function f_hide_right(){
var obj = parent.document.getElementById("system_main");
obj.cols="190,8,*,8,0";
}
//----------


function f_swap_img(inum){

	var i =0;
	var num =0;
	var obj = null;
         var imgPath = "/<%=JspUtil.getCtx(request)%>/images/";

	var obj_ids = "img0,img1,img2,img3,img4,img5,img6,img7,img8";
	var click_res01 = "zh_sjfx01.gif,zh_jcsjcx01.gif,zh_cbbjgl01.gif,zh_zwztcx01.gif,zh_qylytj01.gif";
	var unclick_res01 = "zh_sjfx.gif,zh_jcsjcx.gif,zh_cbbjgl.gif,zh_zwztcx.gif,zh_qylytj.gif";

    var click_bg = "qy_button_bg0.gif";
    var unclick_bg = "qy_button_bg.gif";
    
	var arr_obj_ids = obj_ids.split(",");
	var arr_click_res01 = click_res01.split(",");
	var arr_unclick_res01 = unclick_res01.split(",");
	num = arr_obj_ids.length;

	if(inum>=num)
	{
		alert("索引超出对象数");
		return;
	}
	/*
	if(arr_click_res01.length!=num || arr_unclick_res01.length!=num){
		alert("资源数量不匹配");
		return;
	}
	*/
	for(i=0;i<num;i++){
		obj = document.getElementById(arr_obj_ids[i]);
		if(inum==i){
			obj.background=imgPath+click_bg;
		}else{
			obj.background=imgPath+unclick_bg;
		}
	}
	
	
}
//----------------------------
        </script>
        
        