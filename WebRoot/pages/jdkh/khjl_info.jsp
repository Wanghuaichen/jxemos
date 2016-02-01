<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.util.Scape"%>

<%
  String station_id  = request.getParameter("id");
  String station_desc  = request.getParameter("station_desc");
  String user_area_id = (String)request.getSession().getAttribute("area_id");
  String flag = request.getParameter("flag");
  
  if(!"".equals(station_desc) && station_desc != null){
	   station_desc= Scape.unescape(station_desc);
	   //station_desc = new String(station_desc.getBytes("ISO-8859-1"), "gbk"); 
  }
  String now = StringUtil.getNowDate() + "";
   String date1=null;
   date1 = now;
%>

<form action="khjl_action.jsp" method="post">
<br>
<br>
<table border=0 cellspacing=1  style="width: 800px">
   <caption style="font-size: 16px">���λ������żල���˽���</caption>
    <tr>
        <td colspan="4" style="text-align: right">
              ����[<input type="text" name="jd_zhi">]<input type="text" name="jd_hao">��
           <input type="hidden" name="qy_id" value="<%=station_id %>">
           <input type="hidden" name="qy_mc" value="<%=station_desc %>">
           <input type="hidden" name="flag" value="<%=flag %>">
        </td>
    </tr>
    
    <tr>
        <td style="text-align: center">����</td>
        <td >
            <select name="jd_jg">
                  <option value="1">�ϸ�</option>
                  <option value="0">���ϸ�</option>
            </select>
        </td>
        <td style="text-align: center">����</td>
        <td ><input type="text" name="jd_rq" readonly="readonly" value="<%=date1 %>"  onclick="new Calendar().show(this);"></td>
    </tr>
    
    <tr>
        <td style="text-align: center">������</td>
        <td >
            <input type="text" name="jbr" > 
        </td>
        <td style="text-align: center">�����</td>
        <td ><input type="text" name="spr" ></td>
    </tr>
    
    <tr>
        <td>��ע </td>
        <td colspan="3">
             <textarea rows="20" cols="100%" name="jd_jl"></textarea>
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
   
   var jd_zhi = form.jd_zhi.value;
   var jd_hao = form.jd_hao.value;
   var jd_rq = form.jd_rq.value;
   var jd_jl = form.jd_jl.value;
   var jbr = form.jbr.value;
   var spr = form.spr.value;
   //alert("=="+jd_jl+"==");
   if(jd_zhi == "" || jd_hao == "" || jd_rq == "" || jd_jl == "" || jbr=="" || spr==""){
      alert("�����Ϣ��д����!");
      return false;
   }
   
   if(jd_jl.length>399){
      alert("��ע��Ϣ���Ȳ��ܴ���400");
      return false;
   }
   
   form.submit();

}

</script>



