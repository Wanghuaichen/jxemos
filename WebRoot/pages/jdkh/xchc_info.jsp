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
   <caption style="font-size: 16px">国家重点监控企业污染源自动监测设备现场核查表(输入信息页面)</caption>
    <tr>
        <td style="text-align: center">核查单位</td>
        <td> <input type="text" name="hcdw"> </td>
        <td colspan="2" style="text-align: center">核查日期</td>
        <td colspan="2"> 
        
           <input type="text" name="hcrq" id="hcrq" value="<%=date1 %>" readonly="readonly"  onclick="new Calendar().show(this);"> 
           <input type="hidden" name="qyid" value="<%=station_id %>">
            <input type="hidden" name="flag" value="<%=flag %>">
        </td>
    </tr>
    <tr>
        <td style="text-align: center">企业名称</td>
        <td> <input type="text" name="qymc" value="<%=station_desc %>"> </td>
        <td colspan="2" style="text-align: center">组织机构代码</td>
        <td colspan="2"> <input type="text" name="zzjgdm"> </td>
    </tr>
    <tr>
        <td style="text-align: center">企业地址</td>
        <td colspan="3"> <input type="text" name="address"> </td>
        <td style="text-align: center">邮编</td>
        <td > <input type="text" name="youbian"> </td>
    </tr>
     <tr>
        <td style="text-align: center">法人代表</td>
        <td > <input type="text" name="frdb"> </td>
        <td style="text-align: center">环保负责人</td>
        <td > <input type="text" name="hbfzr"> </td>
        <td style="text-align: center">电话</td>
        <td > <input type="text" name="phone"> </td>
    </tr>
    <tr>
        <td rowspan="5">污染源自动监测设备基本情况</td>
        <td > 排污口名称</td>
        <td colspan="4"><input type="text" name="wr_pwkmc"></td>
    </tr>
    <tr>
        <td > 排污口编码</td>
        <td colspan="4"><input type="text" name="wr_pwkbm"></td>
    </tr>
    <tr>
        <td > 设备型号</td>
        <td colspan="4"><input type="text" name="wr_sbxh"></td>
    </tr>
    <tr>
        <td >生产厂家</td>
        <td colspan="4"><input type="text" name="wr_sccj"></td>
    </tr>
    <tr>
        <td >验收情况</td>
        <td colspan="4"><input type="text" name="wr_ysqk"></td>
    </tr>
    
    
    
    <tr>
        <td rowspan="5">制度执行情况</td>
        <td > 设备操作、使用维护保养记录</td>
        <td colspan="2">
            <select name="zd_sbyw">
               <option value="1">有</option>
               <option value="0">无</option>
            </select>
        </td>
        <td colspan="2">
            <select name="zd_sbws">
               <option value="1">完善</option>
               <option value="0">不完善</option>
            </select>
        </td>
    </tr>
    <tr>
        <td > 运行、巡检记录</td>
        <td colspan="2">
            <select name="zd_xjyw">
               <option value="1">有</option>
               <option value="0">无</option>
            </select>
        </td>
        <td colspan="2">
            <select name="zd_xjws">
               <option value="1">完善</option>
               <option value="0">不完善</option>
            </select>
        </td>
    </tr>
    <tr>
        <td > 定期校准校验记录</td>
        <td colspan="2">
            <select name="zd_xyyw">
               <option value="1">有</option>
               <option value="0">无</option>
            </select>
        </td>
        <td colspan="2">
            <select name="zd_xyws">
               <option value="1">完善</option>
               <option value="0">不完善</option>
            </select>
        </td>
    </tr>
    <tr>
       <td >标准物质易耗品定期更换记录</td>
        <td colspan="2">
            <select name="zd_ghyw">
               <option value="1">有</option>
               <option value="0">无</option>
            </select>
        </td>
        <td colspan="2">
            <select name="zd_ghws">
               <option value="1">完善</option>
               <option value="0">不完善</option>
            </select>
        </td>
    </tr>
    <tr>
        <td > 设备故障状况及处理记录</td>
        <td colspan="2">
            <select name="zd_clyw">
               <option value="1">有</option>
               <option value="0">无</option>
            </select>
        </td>
        <td colspan="2">
            <select name="zd_clws">
               <option value="1">完善</option>
               <option value="0">不完善</option>
            </select>
        </td>
    </tr>
    
    
    
   <tr>
        <td rowspan="19">设备运行情况</td>
        <td rowspan="4"> 仪器参数设置情况</td>
        <td colspan="2">
            二级门禁管理系统
        </td>
        <td colspan="2">
            <select name="sb_mjyw">
               <option value="1">有</option>
               <option value="0">无</option>
            </select>
        </td>
    </tr>
    <tr>
        <td colspan="2">
           氧量
        </td>
        <td colspan="2">
            <select name="sb_ylyw">
               <option value="1">有</option>
               <option value="0">无</option>
            </select>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            校准系数
        </td>
        <td colspan="2">
            <select name="sb_xsyw">
               <option value="1">有</option>
               <option value="0">无</option>
            </select>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            速度场系数
        </td>
        <td colspan="2">
            <select name="sb_scyw">
               <option value="1">有</option>
               <option value="0">无</option>
            </select>
        </td>
    </tr>
    
    
    <tr>
        <td> 仪器参数</td>
        <td colspan="2">
            设备设置值
        </td>
        <td colspan="2">
            现场核查值
        </td>
    </tr>
    <tr>
        <td> 排污口尺寸(米)</td>
        <td colspan="2">
             <input type="text" name="sb_cjsb"> 
        </td>
        <td colspan="2">
           <input type="text" name="sb_cjxc"> 
        </td>
    </tr>
    <tr>
        <td> 过剩空气系数</td>
        <td colspan="2">
              <input type="text" name="sb_kqsb"> 
        </td>
        <td colspan="2">
               <input type="text" name="sb_kqxc"> 
        </td>
    </tr>
    <tr>
        <td> 校准系数</td>
        <td colspan="2">
               <input type="text" name="sb_xzsb"> 
        </td>
        <td colspan="2">
              <input type="text" name="sb_xzxc"> 
        </td>
    </tr>
    <tr>
        <td> 速度场系数</td>
        <td colspan="2">
              <input type="text" name="sb_sdsb"> 
        </td>
        <td colspan="2">
              <input type="text" name="sb_sdxc"> 
        </td>
    </tr>
    <tr>
        <td rowspan="2"> 异常、缺失数据标记和处理</td>
        <td colspan="2">
             有无标记
        </td>
        <td colspan="2">
            <select name="sb_ycbjyw">
               <option value="1">有</option>
               <option value="0">无</option>
            </select>
        </td>
    </tr>
    <tr>
        <td colspan="2">
             有无处理
        </td>
        <td colspan="2">
            <select name="sb_ycclyw">
               <option value="1">有</option>
               <option value="0">无</option>
            </select>
        </td>
    </tr>
    <tr>
        <td> 数据运转率(%)</td>
        <td colspan="4">
             <input type="text" name="sb_sbyzl"> 
        </td>
    </tr>
    <tr>
        <td> 数据传输率(%)</td>
        <td colspan="4">
             <input type="text" name="sb_sjcsl"> 
        </td>
    </tr>
    
    <tr>
        <td rowspan="6"> 数据报表</td>
        <td colspan="2">
             污染物排放浓度
        </td>
        <td colspan="2">
            <select name="sb_bbnd">
               <option value="1">有</option>
               <option value="0">无</option>
            </select>
        </td>
    </tr>
    
    <tr>

        <td colspan="2">
             流量
        </td>
        <td colspan="2">
            <select name="sb_bbll">
               <option value="1">有</option>
               <option value="0">无</option>
            </select>
        </td>
    </tr>
    <tr>

        <td colspan="2">
            污染物排放总量
        </td>
        <td colspan="2">
            <select name="sb_bbzl">
               <option value="1">有</option>
               <option value="0">无</option>
            </select>
        </td>
    </tr>
    <tr>

        <td colspan="2">
             日报
        </td>
        <td colspan="2">
            <select name="sb_bbrb">
               <option value="1">有</option>
               <option value="0">无</option>
            </select>
        </td>
    </tr>
    <tr>

        <td colspan="2">
             月报
        </td>
        <td colspan="2">
            <select name="sb_bbyb">
               <option value="1">有</option>
               <option value="0">无</option>
            </select>
        </td>
    </tr>
    <tr>

        <td colspan="2">
             季报
        </td>
        <td colspan="2">
            <select name="sb_bbjb">
               <option value="1">有</option>
               <option value="0">无</option>
            </select>
        </td>
    </tr>
    
    
    <tr>

        <td >
             核查人员(签字)
        </td>
        <td colspan="2">
            <input type="text" name="hcry">
        </td>
        <td>
            签字日期
        </td>
        <td colspan="2">
            <input type="text" name="hcry_rq" readonly="readonly"  onclick="new Calendar().show(this);">
        </td>
    </tr>
    
    <tr>

        <td >
             企业人员(签字)
        </td>
        <td colspan="2">
            <input type="text" name="qyry" >
        </td>
        <td>
            签字日期
        </td>
        <td colspan="2">
            <input type="text" name="qyry_rq" readonly="readonly"  onclick="new Calendar().show(this);">
        </td>
    </tr>
    
    <tr>

        <td >
             备注
        </td>
        <td colspan="3">
            <input type="text" name="beizhu" style="width:350px">
        </td>
        <td>
            结论
        </td>
        <td>
            <select name="hcjl">
               <option value="1">合格</option>
               <option value="0">不合格</option>
            </select>
        </td>
    </tr>
    
    <% if(!"".equals(user_area_id) && user_area_id.equals("36") && !"".equals(flag) && flag.equals("1")){ %>
    <tr >
       <td colspan="6" style="text-align: center"><input type="button" onclick="check_form(this.form)" value="确定" class="btn">
           <input type="button" value="关闭" class="btn" onclick="window.parent.window.close();">
        </td>
    </tr>
    <%}else if(!"".equals(user_area_id) && !user_area_id.equals("36") && !"".equals(flag) && !flag.equals("1")){ %>
       <tr >
          <td colspan="6" style="text-align: center"><input type="button" onclick="check_form(this.form)" value="确定" class="btn">
           <input type="button" value="关闭" class="btn" onclick="window.parent.window.close();">
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
     alert("请把信息填写完整，谢谢!");
     return false;
   }
   
   form.submit();

}

</script>


