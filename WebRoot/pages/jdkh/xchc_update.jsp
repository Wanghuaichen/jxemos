<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.f,java.util.*,com.hoson.zdxupdate.*,com.hoson.XBean"%>
<%

    Map data;

    String id = "";

   String user_area_id = (String)request.getSession().getAttribute("area_id");
   String flag = request.getParameter("flag");
    try{
      id = request.getParameter("id");
      SwjUpdate.queryXchcInfoByID(request);
    }catch(Exception e){
       w.error(e);
       return;
    }
    
    data = (Map)w.a("data");


	//String drop_css = "";
	String checked = "";


  	Map map = null;

%>

<form action="xchc_updateaction.jsp" method="post">
<br>
<br>
<table border=0 cellspacing=1  style="width: 800px">
   <caption style="font-size: 16px">�����ص�����ҵ��ȾԴ�Զ�����豸�ֳ��˲��(�޸���Ϣҳ��)</caption>
    <tr>
        <td style="text-align: center">�˲鵥λ</td>
        <td> <input type="text" name="hcdw" value="<%=data.get("hcdw") %>"> </td>
        <td colspan="2" style="text-align: center">�˲�����</td>
        <td colspan="2"> 
        
           <input type="text" name="hcrq" id="hcrq"  value="<%=data.get("hcrq") %>" readonly="readonly"  onclick="new Calendar().show(this);"> 
           <input type="hidden" name="id" value="<%=id %>">
           <input type="hidden" name="qyid" value="<%=data.get("qyid") %>">
            <input type="hidden" name="flag" value="<%=flag %>">
        </td>
    </tr>
    <tr>
        <td style="text-align: center">��ҵ����</td>
        <td> <input type="text" name="qymc" value="<%=data.get("qymc") %>"> </td>
        <td colspan="2" style="text-align: center">��֯��������</td>
        <td colspan="2"> <input type="text" name="zzjgdm" value="<%=data.get("zzjgdm") %>"> </td>
    </tr>
    <tr>
        <td style="text-align: center">��ҵ��ַ</td>
        <td colspan="3"> <input type="text" name="address" value="<%=data.get("address") %>"> </td>
        <td style="text-align: center">�ʱ�</td>
        <td > <input type="text" name="youbian" value="<%=data.get("youbian") %>"> </td>
    </tr>
     <tr>
        <td style="text-align: center">���˴���</td>
        <td > <input type="text" name="frdb" value="<%=data.get("frdb") %>"> </td>
        <td style="text-align: center">����������</td>
        <td > <input type="text" name="hbfzr" value="<%=data.get("hbfzr") %>"> </td>
        <td style="text-align: center">�绰</td>
        <td > <input type="text" name="phone" value="<%=data.get("phone") %>"> </td>
    </tr>
    <tr>
        <td rowspan="5">��ȾԴ�Զ�����豸�������</td>
        <td > ���ۿ�����</td>
        <td colspan="4"><input type="text" name="wr_pwkmc" value="<%=data.get("wr_pwkmc") %>"></td>
    </tr>
    <tr>
        <td > ���ۿڱ���</td>
        <td colspan="4"><input type="text" name="wr_pwkbm" value="<%=data.get("wr_pwkbm") %>"></td>
    </tr>
    <tr>
        <td > �豸�ͺ�</td>
        <td colspan="4"><input type="text" name="wr_sbxh" value="<%=data.get("wr_sbxh") %>"></td>
    </tr>
    <tr>
        <td >��������</td>
        <td colspan="4"><input type="text" name="wr_sccj" value="<%=data.get("wr_sccj") %>"></td>
    </tr>
    <tr>
        <td >�������</td>
        <td colspan="4"><input type="text" name="wr_ysqk" value="<%=data.get("wr_ysqk") %>"></td>
    </tr>
    
    
    
    <tr>
        <td rowspan="5">�ƶ�ִ�����</td>
        <td > �豸������ʹ��ά��������¼</td>
        <td colspan="2">
            <select name="zd_sbyw" >
               <%=f.getOption("1,0","��,��",(String)data.get("zd_sbyw")) %>
            </select>
        </td>
        <td colspan="2">
            <select name="zd_sbws">
               <%=f.getOption("1,0","����,������",(String)data.get("zd_sbws")) %>
            </select>
        </td>
    </tr>
    <tr>
        <td > ���С�Ѳ���¼</td>
        <td colspan="2">
            <select name="zd_xjyw">
               <%=f.getOption("1,0","��,��",(String)data.get("zd_xjyw")) %>
            </select>
        </td>
        <td colspan="2">
            <select name="zd_xjws">
               <%=f.getOption("1,0","����,������",(String)data.get("zd_xjws")) %>
            </select>
        </td>
    </tr>
    <tr>
        <td > ����У׼У���¼</td>
        <td colspan="2">
            <select name="zd_xyyw">
               <%=f.getOption("1,0","��,��",(String)data.get("zd_xyyw")) %>
            </select>
        </td>
        <td colspan="2">
            <select name="zd_xyws">
               <%=f.getOption("1,0","����,������",(String)data.get("zd_xyws")) %>
            </select>
        </td>
    </tr>
    <tr>
       <td >��׼�����׺�Ʒ���ڸ�����¼</td>
        <td colspan="2">
            <select name="zd_ghyw">
               <%=f.getOption("1,0","��,��",(String)data.get("zd_ghyw")) %>
            </select>
        </td>
        <td colspan="2">
            <select name="zd_ghws">
               <%=f.getOption("1,0","����,������",(String)data.get("zd_ghws")) %>
            </select>
        </td>
    </tr>
    <tr>
        <td > �豸����״���������¼</td>
        <td colspan="2">
            <select name="zd_clyw">
               <%=f.getOption("1,0","��,��",(String)data.get("zd_clyw")) %>
            </select>
        </td>
        <td colspan="2">
            <select name="zd_clws">
               <%=f.getOption("1,0","����,������",(String)data.get("zd_clws")) %>
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
              <%=f.getOption("1,0","��,��",(String)data.get("sb_mjyw")) %>
            </select>
        </td>
    </tr>
    <tr>
        <td colspan="2">
           ����
        </td>
        <td colspan="2">
            <select name="sb_ylyw">
               <%=f.getOption("1,0","��,��",(String)data.get("sb_ylyw")) %>
            </select>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            У׼ϵ��
        </td>
        <td colspan="2">
            <select name="sb_xsyw">
               <%=f.getOption("1,0","��,��",(String)data.get("sb_xsyw")) %>
            </select>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            �ٶȳ�ϵ��
        </td>
        <td colspan="2">
            <select name="sb_scyw">
               <%=f.getOption("1,0","��,��",(String)data.get("sb_scyw")) %>
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
             <input type="text" name="sb_cjsb" value="<%=data.get("sb_cjsb") %>"> 
        </td>
        <td colspan="2">
           <input type="text" name="sb_cjxc" value="<%=data.get("sb_cjxc") %>"> 
        </td>
    </tr>
    <tr>
        <td> ��ʣ����ϵ��</td>
        <td colspan="2">
              <input type="text" name="sb_kqsb" value="<%=data.get("sb_kqsb") %>"> 
        </td>
        <td colspan="2">
               <input type="text" name="sb_kqxc" value="<%=data.get("sb_kqxc") %>"> 
        </td>
    </tr>
    <tr>
        <td> У׼ϵ��</td>
        <td colspan="2">
               <input type="text" name="sb_xzsb" value="<%=data.get("sb_xzsb") %>"> 
        </td>
        <td colspan="2">
              <input type="text" name="sb_xzxc" value="<%=data.get("sb_xzxc") %>"> 
        </td>
    </tr>
    <tr>
        <td> �ٶȳ�ϵ��</td>
        <td colspan="2">
              <input type="text" name="sb_sdsb" value="<%=data.get("sb_sdsb") %>"> 
        </td>
        <td colspan="2">
              <input type="text" name="sb_sdxc" value="<%=data.get("sb_sdxc") %>"> 
        </td>
    </tr>
    <tr>
        <td rowspan="2"> �쳣��ȱʧ���ݱ�Ǻʹ���</td>
        <td colspan="2">
             ���ޱ��
        </td>
        <td colspan="2">
            <select name="sb_ycbjyw">
               <%=f.getOption("1,0","��,��",(String)data.get("sb_ycbjyw")) %>
            </select>
        </td>
    </tr>
    <tr>
        <td colspan="2">
             ���޴���
        </td>
        <td colspan="2">
            <select name="sb_ycclyw">
               <%=f.getOption("1,0","��,��",(String)data.get("sb_ycclyw")) %>
            </select>
        </td>
    </tr>
    <tr>
        <td> ������ת��(%)</td>
        <td colspan="4">
             <input type="text" name="sb_sbyzl" value="<%=data.get("sb_sbyzl") %>"> 
        </td>
    </tr>
    <tr>
        <td> ���ݴ�����(%)</td>
        <td colspan="4">
             <input type="text" name="sb_sjcsl" value="<%=data.get("sb_sjcsl") %>"> 
        </td>
    </tr>
    
    <tr>
        <td rowspan="6"> ���ݱ���</td>
        <td colspan="2">
             ��Ⱦ���ŷ�Ũ��
        </td>
        <td colspan="2">
            <select name="sb_bbnd">
               <%=f.getOption("1,0","��,��",(String)data.get("sb_bbnd")) %>
            </select>
        </td>
    </tr>
    
    <tr>

        <td colspan="2">
             ����
        </td>
        <td colspan="2">
            <select name="sb_bbll">
               <%=f.getOption("1,0","��,��",(String)data.get("sb_bbll")) %>
            </select>
        </td>
    </tr>
    <tr>

        <td colspan="2">
            ��Ⱦ���ŷ�����
        </td>
        <td colspan="2">
            <select name="sb_bbzl">
               <%=f.getOption("1,0","��,��",(String)data.get("sb_bbzl")) %>
            </select>
        </td>
    </tr>
    <tr>

        <td colspan="2">
             �ձ�
        </td>
        <td colspan="2">
            <select name="sb_bbrb">
              <%=f.getOption("1,0","��,��",(String)data.get("sb_bbrb")) %>
            </select>
        </td>
    </tr>
    <tr>

        <td colspan="2">
             �±�
        </td>
        <td colspan="2">
            <select name="sb_bbyb">
               <%=f.getOption("1,0","��,��",(String)data.get("sb_bbyb")) %>
            </select>
        </td>
    </tr>
    <tr>

        <td colspan="2">
             ����
        </td>
        <td colspan="2">
            <select name="sb_bbjb">
               <%=f.getOption("1,0","��,��",(String)data.get("sb_bbjb")) %>
            </select>
        </td>
    </tr>
    
    <tr>

        <td >
             �˲���Ա(ǩ��)
        </td>
        <td colspan="2">
            <input type="text" name="hcry" value="<%=data.get("hcry") %>">
        </td>
        <td>
            ǩ������
        </td>
        <td colspan="2">
            <input type="text" name="hcry_rq" value="<%=data.get("hcry_rq") %>" readonly="readonly"  onclick="new Calendar().show(this);">
        </td>
    </tr>
    
    <tr>

        <td >
             ��ҵ��Ա(ǩ��)
        </td>
        <td colspan="2">
            <input type="text" name="qyry" value="<%=data.get("qyry") %>">
        </td>
        <td>
            ǩ������
        </td>
        <td colspan="2">
            <input type="text" name="qyry_rq" value="<%=data.get("qyry_rq") %>" readonly="readonly"  onclick="new Calendar().show(this);">
        </td>
    </tr>
    
    <tr>

        <td >
             ��ע
        </td>
        <td colspan="3">
            <input type="text" name="beizhu" style="width:350px"  value="<%=data.get("beizhu") %>">
        </td>
        <td>
            ����
        </td>
        <td>
            <select name="hcjl">
               <%=f.getOption("1,0","�ϸ�,���ϸ�",(String)data.get("hcjl")) %>
            </select>
        </td>
    </tr>
    
    <% if(!"".equals(user_area_id) && user_area_id.equals("36") && !"".equals(flag) && flag.equals("1")){ %>
	    <tr >
	       <td colspan="6" style="text-align: center"><input type="button" onclick="check_form(this.form)" value="�޸�" class="btn">
	           <input type="button" value="�ر�" class="btn" onclick="window.close();">&nbsp;&nbsp;&nbsp; &nbsp;<input type="button" value="������Ϣ" class="btn" onclick="export_info('<%=id %>','export_XchcInfo')">
	        </td>
	    </tr>
	<%}else if(!"".equals(user_area_id) && !user_area_id.equals("36") && !"".equals(flag) && !flag.equals("1")){ %>
	    <tr >
	       <td colspan="6" style="text-align: center"><input type="button" onclick="check_form(this.form)" value="�޸�" class="btn">
	           <input type="button" value="�ر�" class="btn" onclick="window.close();">  &nbsp;&nbsp;&nbsp; &nbsp;<input type="button" value="������Ϣ" class="btn" onclick="export_info('<%=id %>','export_XchcInfo')">
	        </td>
	    </tr>
    <%} %>
    
     <tr>
      <td style='height:100%' colspan="6">
         <iframe name='frm_zw_list' id='frm_zw_list' width=100% height=100% frameborder=0 allowtransparency="true"></iframe>
     <br></td>
  </tr>
    
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

function export_info(id,method){
   window.open("export_page.jsp?id="+id+"&method="+method,"frm_zw_list");
   
}

</script>


