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
   <caption style="font-size: 16px">�����ص�����ҵ��ȾԴ�Զ�����豸�ල���˺ϸ��־�˷���Ϣ��������</caption>
    <tr>
        <td  style="text-align: center">���͵�λ</td>
        <td > 
            <input type="text" name="bsdw">
        </td>
        <td  style="text-align: center">��������</td>
        <td > 
            <input type="text" name="bsrq" value="<%=date1 %>" readonly="readonly"  onclick="new Calendar().show(this);">
            <input type="hidden" name="station_id" value="<%=station_id %>">
            <input type="hidden" name="flag" value="<%=flag %>">
        </td>
    </tr>
    
    <tr>
        <td  style="text-align: center">������</td>
        <td > 
            <input type="text" name="bsr">
        </td>
        <td  style="text-align: center">�绰</td>
        <td > 
            <input type="text" name="dh">
        </td>
    </tr>
    
    <tr>
        <td  style="text-align: center">��ҵ����</td>
        <td > 
            <input type="text" name="qymc" value="<%=station_desc %>">
        </td>
        <td  style="text-align: center">���˵�λ</td>
        <td > 
            <input type="text" name="khdw">
        </td>
    </tr>
    
    <tr>
        <td  style="text-align: center">�����Ŀ</td>
        
        <td > 
            <input type="text" name="jcxm">
        </td>
        <td  style="text-align: center">�豸��������</td>
        <td > 
            <input type="text" name="sbsccj">
        </td>
    </tr>
    
    <tr>
        <td  style="text-align: center">���ۿ�����</td>
        <td > 
            <input type="text" name="pwkmc">
        </td>
        <td  style="text-align: center">���ۿڱ��</td>
        <td > 
            <input type="text" name="pwkbh">
        </td>
    </tr>
    
    <tr>
        <td  style="text-align: center">�豸�ͺ�</td>
        <td > 
            <input type="text" name="sbxh">
        </td>
        <td  style="text-align: center">�豸���</td>
        <td > 
            <input type="text" name="sbbh">
        </td>
    </tr>
    
    <tr>
        <td  style="text-align: center">��־���</td>
        <td > 
            <input type="text" name="bzbh">
        </td>
        <td  style="text-align: center">�豸�ල��������</td>
        <td > 
            <input type="text" name="sbjdkhrq" readonly="readonly"  onclick="new Calendar().show(this);">
        </td>
    </tr>
    
    <tr>
        <td  style="text-align: center">��־�˷�����</td>
        <td > 
            <input type="text" name="bzhfrq" readonly="readonly" value="<%=now %>"  onclick="new Calendar().show(this);">
        </td>
        <td  style="text-align: center">��־��Ч����</td>
        <td > 
            <input type="text" name="bzyxqz" readonly="readonly" value="<%=now %>"  onclick="new Calendar().show(this);">
        </td>
    </tr>
    
    
    <% if(!"".equals(user_area_id) && user_area_id.equals("36") && !"".equals(flag) && flag.equals("1")){ %>
	    <tr >
	       <td colspan="4" style="text-align: center"><input type="button" onclick="check_form(this.form)" value="ȷ��" class="btn">
	           <input type="button" value="�ر�" class="btn" onclick="window.parent.window.close();"> </td>
	    </tr>
    <%}else if(!"".equals(user_area_id) && !user_area_id.equals("36") && !"".equals(flag) && !flag.equals("1")){ %>
        <tr >
	       <td colspan="4" style="text-align: center"><input type="button" onclick="check_form(this.form)" value="ȷ��" class="btn">
	           <input type="button" value="�ر�" class="btn" onclick="window.parent.window.close();"> </td>
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
     alert("�����Ϣ��д������лл!");
     return false;
   }
   
   form.submit();

  
}

</script>



