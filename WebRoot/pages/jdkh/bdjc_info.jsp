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

<form action="bdjc_action.jsp" method="post">
<br>
<br>
<table border=0 cellspacing=1  style="width: 800px">
   <caption style="font-size: 16px">������ҵ��ȾԴ�Զ�����豸�ȶԼ������</caption>
    <tr>
        <td colspan="2" style="text-align: center">��ҵ����</td>
        <td colspan="4"> 
            <input type="text" name="qymc" value="<%=station_desc %>">
            <input type="hidden" name="qyid" value="<%=station_id %>">
            <input type="hidden" name="flag" value="<%=flag %>">
        </td>
    </tr>
    <tr>
        <td colspan="2" style="text-align: center">�ȶԼ�ⵥλ</td>
        <td colspan="2"> <input type="text" name="bddw"> </td>
        <td style="text-align: center">�������</td>
        <td > <input type="text" name="bdrq" readonly="readonly" value="<%=date1 %>"  onclick="new Calendar().show(this);"> </td>
    </tr>
    
    <tr>
        <td colspan="2" style="text-align: center">��λ����</td>
        <td colspan="4">
          <input type="text" name="zwmc">
        </td>
    </tr>
    <tr>
        <td colspan="2" style="text-align: center">�Զ�����豸���� </td>
        <td colspan="4"><input type="text" name="sbmc"></td>
    </tr>
    <tr>
        <td colspan="2" style="text-align: center"> ���쵥λ</td>
        <td colspan="4"><input type="text" name="zzdw"></td>
    </tr>
    <tr>
        <td colspan="2" style="text-align: center">�ͺż����</td>
        <td colspan="4"><input type="text" name="xhbh"></td>
    </tr>

    
    <tr>
        <td rowspan="2" colspan="2">�����Ŀ</td>
        <td colspan="4"> �����ȶԷ���</td>
    </tr>
    
    <tr>
        <td colspan="2"> �ȶԷ���</td>
        <td colspan="2">
              �Զ���ⷽ��
              <input type=button value="����" class="btn" onclick="jc_clickmore('tr_jc',7)"><><input type=button value="����" class="btn" onclick="jc_clickless('tr_jc',7)">
        </td>
        
    </tr>
    
    <tr id="tr_jc_0">
        <td colspan="2"><input type="text" name="jcxm_name_0"> </td>
        <td colspan="2">
            <input type="text" name="jcxm_bdff_0" id="jcxm_bdff_0">
        </td>
        <td colspan="2">
            <input type="text" name="jcxm_jcff_0" id="jcxm_jcff_0">
        </td>
    </tr>
    
 <% for (int i=1;i<=6;i++){ %>
    
    <tr id="tr_jc_<%=i %>" style="display:none";>
        <td colspan="2"><input type="text" name="jcxm_name_<%=i %>"> </td>
        <td colspan="2">
            <input type="text" name="jcxm_bdff_<%=i %>" id="jcxm_bdff_<%=i %>">
        </td>
        <td colspan="2">
            <input type="text" name="jcxm_jcff_<%=i %>" id="jcxm_jcff_<%=i %>">
        </td>
    </tr>
  <% } %>  
    
    
    <tr>
        <td>��Ŀ</td>
        <td>�ȶԼ������</td>
        <td>�Զ��������</td>
        <td>��׼��ֵ</td>
        <td>�ȶԽ��</td>
        <td>  
               ������
               <br>
            <input type=button value="����" class="btn" onclick="xm_clickmore('tr_xm',7)"><><input type=button value="����" class="btn" onclick="xm_clickless('tr_xm',7)">
        </td>
    </tr>
    
    <tr id="tr_xm_0">
        <td><input type="text" name="xm_name_0"  name="xm_name_0"></td>
        <td><input type="text" name="xm_bdsj_0" name="xm_bdsj_0"></td>
        <td><input type="text" name="xm_zdsj_0" name="xm_zdsj_0"></td>
        <td><input type="text" name="xm_bzxz_0" name="xm_bzxz_0"></td>
        <td><input type="text" name="xm_bdjg_0" name="xm_bdjg_0"></td>
        <td><input type="text" name="xm_dbqk_0" name="xm_dbqk_0"></td>
    </tr>
    
  <% for (int i=1;i<=6;i++){ %>
    
    <tr id="tr_xm_<%=i %>" style="display:none";>
        <td><input type="text" name="xm_name_<%=i %>" name="xm_name_<%=i %>"></td>
        <td><input type="text" name="xm_bdsj_<%=i %>" name="xm_bdsj_<%=i %>"></td>
        <td><input type="text" name="xm_zdsj_<%=i %>" name="xm_zdsj_<%=i %>"></td>
        <td><input type="text" name="xm_bzxz_<%=i %>" name="xm_bzxz_<%=i %>"></td>
        <td><input type="text" name="xm_bdjg_<%=i %>" name="xm_bdjg_<%=i %>"></td>
        <td><input type="text" name="xm_dbqk_<%=i %>" name="xm_dbqk_<%=i %>"></td>
    </tr>
  <% } %>  
    
    <tr>
        <td style="text-align: center">������</td>
        <td colspan="2">
            <input type="text" name="jbr" > 
        </td>
        <td style="text-align: center">�����</td>
        <td colspan="2"><input type="text" name="spr" ></td>
    </tr>
    
    <tr>
        <td>�ȶԼ�����</td>
        <td >
             <select name="bdjg">
                  <option value="1">�ϸ�</option>
                  <option value="0">���ϸ�</option>
             </select>
         
        </td>
        <td>��ע</td>
        <td colspan="3"><input type="text" name="bdjcjl" style="width:350px;"></td>
    </tr>

    <% if(!"".equals(user_area_id) && user_area_id.equals("36") && !"".equals(flag) && flag.equals("1")){ %>
    <tr >
       <td colspan="6" style="text-align: center"><input type="button" onclick="check_form(this.form)" value="ȷ��" class="btn">
           <input type="button" value="�ر�" class="btn" onclick="window.parent.window.close();"> </td>
    </tr>
    <%}else if(!"".equals(user_area_id) && !user_area_id.equals("36") && !"".equals(flag) && !flag.equals("1")) {%>
    <tr >
       <td colspan="6" style="text-align: center"><input type="button" onclick="check_form(this.form)" value="ȷ��" class="btn">
           <input type="button" value="�ر�" class="btn" onclick="window.parent.window.close();"> </td>
    </tr>
    <%} %>
   
    
</table>

</form>

<script type="text/javascript">

var tr_jc_Show=0;
var tr_xm_show=0;
function jc_clickmore(m_id,count){
    if (0<=tr_jc_Show && tr_jc_Show<count-1){
         tr_jc_Show++;
         document.all(m_id+"_"+tr_jc_Show).style.display="";
    }else {
         alert("�����"+count+"������!");
    }
}

function jc_clickless(m_id,count){
   if (0<tr_jc_Show && tr_jc_Show<=count-1){
         document.all(m_id +"_"+ tr_jc_Show).style.display="none";
         tr_jc_Show--;
   }else{
         alert("������һ�����ڣ�");
   }
}


function xm_clickmore(m_id,count){
    if (0<=tr_xm_show && tr_xm_show<count-1){
         tr_xm_show++;
         document.all(m_id+"_"+tr_xm_show).style.display="";
    }else {
         alert("�����"+count+"������!");
    }
}

function xm_clickless(m_id,count){
   if (0<tr_xm_show && tr_xm_show<=count-1){
         document.all(m_id +"_"+ tr_xm_show).style.display="none";
         tr_xm_show--;
   }else{
         alert("������һ�����ڣ�");
   }
}

function check_form(form){
   if(form.qymc.value == ""){
      alert("����д��ҵ����!");
      return false;
   }
   
   if(form.bddw.value == ""){
      alert("����д�ȶԼ�ⵥλ!");
      return false;
   }
   
   if(form.bdrq.value == ""){
      alert("����д�������!");
      return false;
   }
   
   if(form.zwmc.value == ""){
      alert("����д��λ����!");
      return false;
   }
   
   if(form.sbmc.value == ""){
      alert("����д�Զ�����豸����!");
      return false;
   }
   
   if(form.zzdw.value == ""){
      alert("����д���쵥λ!");
      return false;
   }
   
   if(form.xhbh.value == ""){
      alert("����д�ͺż����!");
      return false;
   }
   

   var jcxm_name = document.getElementById("jcxm_name_0").value;
   var jcxm_bdff = document.getElementById("jcxm_bdff_0").value;
   var jcxm_jcff = document.getElementById("jcxm_jcff_0").value;
   
   
   if(jcxm_name =="" || jcxm_bdff =="" || jcxm_jcff==""){
      alert("������дһ�������Ŀ!");
      return false;
   }
   

   for(var i=1;i<7;i++){
      jcxm_name = document.getElementById("jcxm_name_"+i).value;
      jcxm_bdff = document.getElementById("jcxm_bdff_"+i).value;
      jcxm_jcff = document.getElementById("jcxm_jcff_"+i).value;
      
      if(jcxm_name !="" && (jcxm_bdff =="" || jcxm_jcff=="")){
         alert("��Ѽ����Ŀ��Ϣ��д����!");
         return false;
      }
   }
   
   
  var  xm_name = document.getElementById("xm_name_0").value;
  var  xm_bdsj = document.getElementById("xm_bdsj_0").value;
  var  xm_zdsj = document.getElementById("xm_zdsj_0").value;
  var  xm_bzxz = document.getElementById("xm_bzxz_0").value;
  var  xm_bdjg = document.getElementById("xm_bdjg_0").value;
  var  xm_dbqk = document.getElementById("xm_dbqk_0").value;
   
   
   if(xm_name =="" || xm_bdsj =="" || xm_zdsj=="" || xm_bzxz=="" || xm_bdjg=="" || xm_dbqk==""){
      alert("������дһ����Ŀ��Ϣ!");
      return false;
   }
   

   for(var i=1;i<7;i++){
       xm_name = document.getElementById("xm_name_"+i).value;
       xm_bdsj = document.getElementById("xm_bdsj_"+i).value;
       xm_zdsj = document.getElementById("xm_zdsj_"+i).value;
       xm_bzxz = document.getElementById("xm_bzxz_"+i).value;
       xm_bdjg = document.getElementById("xm_bdjg_"+i).value;
       xm_dbqk = document.getElementById("xm_dbqk_"+i).value;
      
      if(xm_name !="" && (xm_bdsj =="" || xm_zdsj=="" || xm_bzxz=="" || xm_bdjg=="" || xm_dbqk=="")){
         alert("�����Ŀ��Ϣ��д����!");
         return false;
      }
   }
   
   if(form.jbr.value == ""){
      alert("����д������!");
      return false;
   }
    if(form.spr.value == ""){
      alert("����д������!");
      return false;
   }
   
   form.submit();
  
}

</script>



