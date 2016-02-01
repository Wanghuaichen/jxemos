<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.util.Scape"%>

<%@page import="com.hoson.f,java.util.*,com.hoson.zdxupdate.*,com.hoson.XBean"%>
<%

    Map data;

    String id = "";
    String user_area_id = (String)request.getSession().getAttribute("area_id");
  String flag = request.getParameter("flag");
    try{
      id = request.getParameter("id");
      SwjUpdate.queryHgbzInfoByID(request);
    }catch(Exception e){
       w.error(e);
       return;
    }
    
    data = (Map)w.a("data");


	//String drop_css = "";
	String checked = "";


  	Map map = null;

%>

<form action="hgbz_updateaction.jsp" method="post">
<br>
<br>
<table border=0 cellspacing=1  style="width: 800px">
   <caption style="font-size: 16px">国家重点监控企业污染源自动监测设备监督考核合格标志核发信息报送内容(修改页面)</caption>
    <tr>
        <td  style="text-align: center">报送单位</td>
        <td > 
            <input type="text" name="bsdw" value="<%=data.get("bsdw") %>">
        </td>
        <td  style="text-align: center">报送日期</td>
        <td > 
            <input type="text" name="bsrq" value="<%=data.get("bsrq") %>" readonly="readonly"  onclick="new Calendar().show(this);">
            <input type="hidden" name="station_id" value="<%=data.get("qyid") %>">
            <input type="hidden" name="id" value="<%=data.get("id") %>">
            <input type="hidden" name="flag" value="<%=flag %>">
            
        </td>
    </tr>
    
    <tr>
        <td  style="text-align: center">报送人</td>
        <td > 
            <input type="text" name="bsr" value="<%=data.get("bsr") %>">
        </td>
        <td  style="text-align: center">电话</td>
        <td > 
            <input type="text" name="dh" value="<%=data.get("dh") %>">
        </td>
    </tr>
    
    <tr>
        <td  style="text-align: center">企业名称</td>
        <td > 
            <input type="text" name="qymc" value="<%=data.get("qymc") %>">
        </td>
        <td  style="text-align: center">考核单位</td>
        <td > 
            <input type="text" name="khdw" value="<%=data.get("khdw") %>">
        </td>
    </tr>
    
    <tr>
        <td  style="text-align: center">监测项目</td>
        <td > 
            <input type="text" name="jcxm" value="<%=data.get("jcxm") %>">
        </td>
        <td  style="text-align: center">设备生产厂家</td>
        <td > 
            <input type="text" name="sbsccj" value="<%=data.get("sbsccj") %>">
        </td>
    </tr>
    
    <tr>
        <td  style="text-align: center">排污口名称</td>
        <td > 
            <input type="text" name="pwkmc" value="<%=data.get("pwkmc") %>">
        </td>
        <td  style="text-align: center">排污口编号</td>
        <td > 
            <input type="text" name="pwkbh" value="<%=data.get("pwkbh") %>">
        </td>
    </tr>
    
    <tr>
        <td  style="text-align: center">设备型号</td>
        <td > 
            <input type="text" name="sbxh" value="<%=data.get("sbxh") %>">
        </td>
        <td  style="text-align: center">设备编号</td>
        <td > 
            <input type="text" name="sbbh" value="<%=data.get("sbbh") %>">
        </td>
    </tr>
    
    <tr>
        <td  style="text-align: center">标志编号</td>
        <td > 
            <input type="text" name="bzbh" value="<%=data.get("bzbh") %>">
        </td>
        <td  style="text-align: center">设备监督考核日期</td>
        <td > 
            <input type="text" name="sbjdkhrq" value="<%=data.get("sbjdkhrq") %>" readonly="readonly"  onclick="new Calendar().show(this);">
        </td>
    </tr>
    
    <tr>
        <td  style="text-align: center">标志核发日期</td>
        <td > 
            <input type="text" name="bzhfrq"  readonly="readonly" value="<%=data.get("bzhfrq") %>"  onclick="new Calendar().show(this);">
        </td>
        <td  style="text-align: center">标志有效期至</td>
        <td > 
            <input type="text" name="bzyxqz" readonly="readonly" value="<%=data.get("bzyxqz") %>"  onclick="new Calendar().show(this);">
        </td>
    </tr>
    
    
    <% if(!"".equals(user_area_id) && user_area_id.equals("36") && !"".equals(flag) && flag.equals("1")){ %>
    <tr >
       <td colspan="4" style="text-align: center"><input type="button" onclick="check_form(this.form)" value="确定" class="btn">
           <input type="button" value="关闭" class="btn" onclick="window.close();"> </td>
    </tr>
    <%}else if(!"".equals(user_area_id) && !user_area_id.equals("36") && !"".equals(flag) && !flag.equals("1")){ %>
   <tr >
       <td colspan="4" style="text-align: center"><input type="button" onclick="check_form(this.form)" value="确定" class="btn">
           <input type="button" value="关闭" class="btn" onclick="window.close();"> </td>
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



