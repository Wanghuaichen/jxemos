<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.util.Scape"%>
<%
  String station_id  = request.getParameter("id");
  String station_desc = request.getParameter("station_desc");
  if(!"".equals(station_desc) && station_desc != null){
	   station_desc= Scape.unescape(station_desc);
	  // station_desc = new String(station_desc.getBytes("ISO-8859-1"), "UTF-8"); 
	 // station_desc = java.net.URLDecoder.decode(station_desc);
  }
  String user_area_id = (String)request.getSession().getAttribute("area_id");
  String flag = request.getParameter("flag");
   String now = StringUtil.getNowDate() + "";
   String date1=null;
   date1 = now;

%>

<form action="xchc_action.jsp" method="post">
<br>
<br>
<table border=0 cellspacing=1  style="width: 800px">
   <caption style="font-size: 16px">�����ص�����ҵ��ȾԴ�Զ�����豸�ֳ��˲��(������Ϣҳ��)</caption>
    <tr>
        <td style="text-align: center">�˲鵥λ</td>
        <td> <input type="text" name="hcdw"> </td>
        <td colspan="2" style="text-align: center">�˲�����</td>
        <td colspan="2"> 
        
           <input type="text" name="hcrq" id="hcrq" value="<%=date1 %>" readonly="readonly"  onclick="new Calendar().show(this);"> 
           <input type="hidden" name="qyid" value="<%=station_id %>">
            <input type="hidden" name="flag" value="<%=flag %>">
        </td>
    </tr>
    <tr>
        <td style="text-align: center">��ҵ����</td>
        <td> <input type="text" name="qymc" value="<%=station_desc %>"> </td>
        <td colspan="2" style="text-align: center">��֯��������</td>
        <td colspan="2"> <input type="text" name="zzjgdm"> </td>
    </tr>
    <tr>
        <td style="text-align: center">��ҵ��ַ</td>
        <td colspan="3"> <input type="text" name="address"> </td>
        <td style="text-align: center">�ʱ�</td>
        <td > <input type="text" name="youbian"> </td>
    </tr>
     <tr>
        <td style="text-align: center">���˴���</td>
        <td > <input type="text" name="frdb"> </td>
        <td style="text-align: center">����������</td>
        <td > <input type="text" name="hbfzr"> </td>
        <td style="text-align: center">�绰</td>
        <td > <input type="text" name="phone"> </td>
    </tr>
    <tr>
        <td rowspan="5">��ȾԴ�Զ�����豸�������</td>
        <td > ���ۿ�����</td>
        <td colspan="4"><input type="text" name="wr_pwkmc"></td>
    </tr>
    <tr>
        <td > ���ۿڱ���</td>
        <td colspan="4"><input type="text" name="wr_pwkbm"></td>
    </tr>
    <tr>
        <td > �豸�ͺ�</td>
        <td colspan="4"><input type="text" name="wr_sbxh"></td>
    </tr>
    <tr>
        <td >��������</td>
        <td colspan="4"><input type="text" name="wr_sccj"></td>
    </tr>
    <tr>
        <td >�������</td>
        <td colspan="4"><input type="text" name="wr_ysqk"></td>
    </tr>
    
    
    
    <tr>
        <td rowspan="5">�ƶ�ִ�����</td>
        <td > �豸������ʹ��ά��������¼</td>
        <td colspan="2">
            <select name="zd_sbyw">
               <option value="1">��</option>
               <option value="0">��</option>
            </select>
        </td>
        <td colspan="2">
            <select name="zd_sbws">
               <option value="1">����</option>
               <option value="0">������</option>
            </select>
        </td>
    </tr>
    <tr>
        <td > ���С�Ѳ���¼</td>
        <td colspan="2">
            <select name="zd_xjyw">
               <option value="1">��</option>
               <option value="0">��</option>
            </select>
        </td>
        <td colspan="2">
            <select name="zd_xjws">
               <option value="1">����</option>
               <option value="0">������</option>
            </select>
        </td>
    </tr>
    <tr>
        <td > ����У׼У���¼</td>
        <td colspan="2">
            <select name="zd_xyyw">
               <option value="1">��</option>
               <option value="0">��</option>
            </select>
        </td>
        <td colspan="2">
            <select name="zd_xyws">
               <option value="1">����</option>
               <option value="0">������</option>
            </select>
        </td>
    </tr>
    <tr>
       <td >��׼�����׺�Ʒ���ڸ�����¼</td>
        <td colspan="2">
            <select name="zd_ghyw">
               <option value="1">��</option>
               <option value="0">��</option>
            </select>
        </td>
        <td colspan="2">
            <select name="zd_ghws">
               <option value="1">����</option>
               <option value="0">������</option>
            </select>
        </td>
    </tr>
    <tr>
        <td > �豸����״���������¼</td>
        <td colspan="2">
            <select name="zd_clyw">
               <option value="1">��</option>
               <option value="0">��</option>
            </select>
        </td>
        <td colspan="2">
            <select name="zd_clws">
               <option value="1">����</option>
               <option value="0">������</option>
            </select>
        </td>
    </tr>
    
    
    
   <tr>
        <td rowspan="19">�豸�������</td>
        <td rowspan="4"> ���������������</td>
        <td colspan="2">
            �����Ž�����ϵͳ
        </td>
        <td colspan="2">
            <select name="sb_mjyw">
               <option value="1">��</option>
               <option value="0">��</option>
            </select>
        </td>
    </tr>
    <tr>
        <td colspan="2">
           ����
        </td>
        <td colspan="2">
            <select name="sb_ylyw">
               <option value="1">��</option>
               <option value="0">��</option>
            </select>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            У׼ϵ��
        </td>
        <td colspan="2">
            <select name="sb_xsyw">
               <option value="1">��</option>
               <option value="0">��</option>
            </select>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            �ٶȳ�ϵ��
        </td>
        <td colspan="2">
            <select name="sb_scyw">
               <option value="1">��</option>
               <option value="0">��</option>
            </select>
        </td>
    </tr>
    
    
    <tr>
        <td> ��������</td>
        <td colspan="2">
            �豸����ֵ
        </td>
        <td colspan="2">
            �ֳ��˲�ֵ
        </td>
    </tr>
    <tr>
        <td> ���ۿڳߴ�(��)</td>
        <td colspan="2">
             <input type="text" name="sb_cjsb"> 
        </td>
        <td colspan="2">
           <input type="text" name="sb_cjxc"> 
        </td>
    </tr>
    <tr>
        <td> ��ʣ����ϵ��</td>
        <td colspan="2">
              <input type="text" name="sb_kqsb"> 
        </td>
        <td colspan="2">
               <input type="text" name="sb_kqxc"> 
        </td>
    </tr>
    <tr>
        <td> У׼ϵ��</td>
        <td colspan="2">
               <input type="text" name="sb_xzsb"> 
        </td>
        <td colspan="2">
              <input type="text" name="sb_xzxc"> 
        </td>
    </tr>
    <tr>
        <td> �ٶȳ�ϵ��</td>
        <td colspan="2">
              <input type="text" name="sb_sdsb"> 
        </td>
        <td colspan="2">
              <input type="text" name="sb_sdxc"> 
        </td>
    </tr>
    <tr>
        <td rowspan="2"> �쳣��ȱʧ���ݱ�Ǻʹ���</td>
        <td colspan="2">
             ���ޱ��
        </td>
        <td colspan="2">
            <select name="sb_ycbjyw">
               <option value="1">��</option>
               <option value="0">��</option>
            </select>
        </td>
    </tr>
    <tr>
        <td colspan="2">
             ���޴���
        </td>
        <td colspan="2">
            <select name="sb_ycclyw">
               <option value="1">��</option>
               <option value="0">��</option>
            </select>
        </td>
    </tr>
    <tr>
        <td> ������ת��(%)</td>
        <td colspan="4">
             <input type="text" name="sb_sbyzl"> 
        </td>
    </tr>
    <tr>
        <td> ���ݴ�����(%)</td>
        <td colspan="4">
             <input type="text" name="sb_sjcsl"> 
        </td>
    </tr>
    
    <tr>
        <td rowspan="6"> ���ݱ���</td>
        <td colspan="2">
             ��Ⱦ���ŷ�Ũ��
        </td>
        <td colspan="2">
            <select name="sb_bbnd">
               <option value="1">��</option>
               <option value="0">��</option>
            </select>
        </td>
    </tr>
    
    <tr>

        <td colspan="2">
             ����
        </td>
        <td colspan="2">
            <select name="sb_bbll">
               <option value="1">��</option>
               <option value="0">��</option>
            </select>
        </td>
    </tr>
    <tr>

        <td colspan="2">
            ��Ⱦ���ŷ�����
        </td>
        <td colspan="2">
            <select name="sb_bbzl">
               <option value="1">��</option>
               <option value="0">��</option>
            </select>
        </td>
    </tr>
    <tr>

        <td colspan="2">
             �ձ�
        </td>
        <td colspan="2">
            <select name="sb_bbrb">
               <option value="1">��</option>
               <option value="0">��</option>
            </select>
        </td>
    </tr>
    <tr>

        <td colspan="2">
             �±�
        </td>
        <td colspan="2">
            <select name="sb_bbyb">
               <option value="1">��</option>
               <option value="0">��</option>
            </select>
        </td>
    </tr>
    <tr>

        <td colspan="2">
             ����
        </td>
        <td colspan="2">
            <select name="sb_bbjb">
               <option value="1">��</option>
               <option value="0">��</option>
            </select>
        </td>
    </tr>
    
    
    <tr>

        <td >
             �˲���Ա(ǩ��)
        </td>
        <td colspan="2">
            <input type="text" name="hcry">
        </td>
        <td>
            ǩ������
        </td>
        <td colspan="2">
            <input type="text" name="hcry_rq" readonly="readonly"  onclick="new Calendar().show(this);">
        </td>
    </tr>
    
    <tr>

        <td >
             ��ҵ��Ա(ǩ��)
        </td>
        <td colspan="2">
            <input type="text" name="qyry" >
        </td>
        <td>
            ǩ������
        </td>
        <td colspan="2">
            <input type="text" name="qyry_rq" readonly="readonly"  onclick="new Calendar().show(this);">
        </td>
    </tr>
    
    <tr>

        <td >
             ��ע
        </td>
        <td colspan="3">
            <input type="text" name="beizhu" style="width:350px">
        </td>
        <td>
            ����
        </td>
        <td>
            <select name="hcjl">
               <option value="1">�ϸ�</option>
               <option value="0">���ϸ�</option>
            </select>
        </td>
    </tr>
    
    <% if(!"".equals(user_area_id) && user_area_id.equals("36") && !"".equals(flag) && flag.equals("1")){ %>
    <tr >
       <td colspan="6" style="text-align: center"><input type="button" onclick="check_form(this.form)" value="ȷ��" class="btn">
           <input type="button" value="�ر�" class="btn" onclick="window.parent.window.close();">
        </td>
    </tr>
    <%}else if(!"".equals(user_area_id) && !user_area_id.equals("36") && !"".equals(flag) && !flag.equals("1")){ %>
       <tr >
          <td colspan="6" style="text-align: center"><input type="button" onclick="check_form(this.form)" value="ȷ��" class="btn">
           <input type="button" value="�ر�" class="btn" onclick="window.parent.window.close();">
          </td>
       </tr>
    <%} %>
    
</table>

</form>
<br>
<br>

<script type="text/javascript">

function check_form(form){
   var input_cart=document.getElementsByTagName("INPUT");
   var input_all=0;
      for(var i=0;i<input_cart.length;i++)   {   
          if(input_cart[i].type=="text" && input_cart[i].value!="") {
    
              input_all=input_all+1;   
          }   
      }
   if (input_all<29)
   {
     alert("�����Ϣ��д������лл!");
     return false;
   }
   
   form.submit();

}

</script>


