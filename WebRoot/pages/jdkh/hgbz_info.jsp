<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.util.Scape"%>
<%
  String station_id  = request.getParameter("id");
  String station_desc = request.getParameter("station_desc");
  if(!"".equals(station_desc) && station_desc != null){
	   station_desc= Scape.unescape(station_desc);
	   //station_desc = new String(station_desc.getBytes("ISO-8859-1"), "gbk"); 
  }
  String user_area_id = (String)request.getSession().getAttribute("area_id");
  String flag = request.getParameter("flag");
  
  String now = StringUtil.getNowDate() + "";
   String date1=null;
   date1 = now;
%>

<form action="hgbz_action.jsp" method="post">
<br>
<br>
<table border=0 cellspacing=1  style="width: 800px">
   <caption style="font-size: 16px">国家重点监控企业污染源自动监测设备监督考核合格标志核发信息报送内容</caption>
    <tr>
        <td  style="text-align: center">报送单位</td>
        <td > 
            <input type="text" name="bsdw">
        </td>
        <td  style="text-align: center">报送日期</td>
        <td > 
            <input type="text" name="bsrq" value="<%=date1 %>" readonly="readonly"  onclick="new Calendar().show(this);">
            <input type="hidden" name="station_id" value="<%=station_id %>">
            <input type="hidden" name="flag" value="<%=flag %>">
        </td>
    </tr>
    
    <tr>
        <td  style="text-align: center">报送人</td>
        <td > 
            <input type="text" name="bsr">
        </td>
        <td  style="text-align: center">电话</td>
        <td > 
            <input type="text" name="dh">
        </td>
    </tr>
    
    <tr>
        <td  style="text-align: center">企业名称</td>
        <td > 
            <input type="text" name="qymc" value="<%=station_desc %>">
        </td>
        <td  style="text-align: center">考核单位</td>
        <td > 
            <input type="text" name="khdw">
        </td>
    </tr>
    
    <tr>
        <td  style="text-align: center">监测项目</td>
        
        <td > 
            <input type="text" name="jcxm">
        </td>
        <td  style="text-align: center">设备生产厂家</td>
        <td > 
            <input type="text" name="sbsccj">
        </td>
    </tr>
    
    <tr>
        <td  style="text-align: center">排污口名称</td>
        <td > 
            <input type="text" name="pwkmc">
        </td>
        <td  style="text-align: center">排污口编号</td>
        <td > 
            <input type="text" name="pwkbh">
        </td>
    </tr>
    
    <tr>
        <td  style="text-align: center">设备型号</td>
        <td > 
            <input type="text" name="sbxh">
        </td>
        <td  style="text-align: center">设备编号</td>
        <td > 
            <input type="text" name="sbbh">
        </td>
    </tr>
    
    <tr>
        <td  style="text-align: center">标志编号</td>
        <td > 
            <input type="text" name="bzbh">
        </td>
        <td  style="text-align: center">设备监督考核日期</td>
        <td > 
            <input type="text" name="sbjdkhrq" readonly="readonly"  onclick="new Calendar().show(this);">
        </td>
    </tr>
    
    <tr>
        <td  style="text-align: center">标志核发日期</td>
        <td > 
            <input type="text" name="bzhfrq" readonly="readonly" value="<%=now %>"  onclick="new Calendar().show(this);">
        </td>
        <td  style="text-align: center">标志有效期至</td>
        <td > 
            <input type="text" name="bzyxqz" readonly="readonly" value="<%=now %>"  onclick="new Calendar().show(this);">
        </td>
    </tr>
    
    
    <% if(!"".equals(user_area_id) && user_area_id.equals("36") && !"".equals(flag) && flag.equals("1")){ %>
	    <tr >
	       <td colspan="4" style="text-align: center"><input type="button" onclick="check_form(this.form)" value="确定" class="btn">
	           <input type="button" value="关闭" class="btn" onclick="window.parent.window.close();"> </td>
	    </tr>
    <%}else if(!"".equals(user_area_id) && !user_area_id.equals("36") && !"".equals(flag) && !flag.equals("1")){ %>
        <tr >
	       <td colspan="4" style="text-align: center"><input type="button" onclick="check_form(this.form)" value="确定" class="btn">
	           <input type="button" value="关闭" class="btn" onclick="window.parent.window.close();"> </td>
	    </tr>
	<%} %>
    
</table>

</form>

<script type="text/javascript">

function check_form(form){
   var input_cart=document.getElementsByTagName("INPUT");
   var input_all=0;
      for(var i=0;i<input_cart.length;i++)   {   
          if(input_cart[i].type=="text" && input_cart[i].value!="") {
    
              input_all=input_all+1;   
          }   
      }
   if (input_all<16)
   {
     alert("请把信息填写完整，谢谢!");
     return false;
   }
   
   form.submit();

  
}

</script>



